// Phoenix glue for the Game Boy / Game Boy Color core.
//
// Clocks:
//
//  - clk25: the 640x480 HDMI pixel clock.
//  - clk_i: 33.75MHz (25MHz x 27/20), a little faster than the Game Boy's
//    8 x 4.194304MHz = 33.554MHz, so one Game Boy frame (154 lines of 456
//    dots, 561792 clocks) takes a bit less than one HDMI frame.
//  - clk_g: clk_i through a BUFGCE whose enable is run.  Everything of the
//    Game Boy and the SRAM runs from clk_g.  At the top of each Game Boy
//    frame the frame lock stops clk_g until the HDMI frame reaches
//    RELEASE_LINE (59.52 instead of 59.73 frames per second).
//
// Picture: 160 x 144, each Game Boy pixel 10/3 HDMI pixels wide and high
// (3, 3 or 4): 533 x 480, centered.  The HDMI side shows a line 3.33 HDMI
// lines after the Game Boy drew it, so an 8-line buffer is enough.
//
// Loader mode: at power-on the Game Boy's own CPU runs the menu and loader
// (loader/, SDCC) in CGB mode without a boot ROM.  The cartridge bus then
// reads the loader ROM (16K block RAM) at $0000-$7FFF, and $A000-$BFFF is
// this I/O window (address bits 7:0):
//
//  $00 R  SPI received byte
//      W  SPI transfer byte
//  $01 R  bit7 busy (SPI, forward engine or SRAM write), bit6 card present
//      W  bit0 SD select (1 = CS asserted), bit1 slow SPI clock,
//         bit2 forward engine discards the bytes
//  $02 W  byte to the SRAM at the load address, which then increments
//  $03 W  reset the CRC
//  $04 W  start the game
//  $05 W  bit0 error LED
//  $06 W  forward count, low byte
//  $07 W  forward count, high byte, and start: clock in that many SPI bytes
//         (sending $FF), write each to the SRAM and add it to the CRC
//  $08-$0A W  load address, bits 7:0, 15:8, 18:16; $0A bit 3 loads the
//         cartridge RAM block RAM instead of the SRAM (bits 12:0)
//  $0B W  mapper: 0 none, 1 MBC1, 2 MBC2, 3 MBC3, 4 MBC5
//  $0C W  ROM bank mask, bits 7:0 (16K banks - 1)
//  $0D W  bit0 ROM bank mask bit 8
//  $0E W  bits 3:0 RAM bank mask (8K banks - 1), bit6 the cartridge RAM
//         is the 8K block RAM, bit7 the cartridge has RAM
//  $0F W  bit0 GBC hardware for the game, bit1 fast boot, bits 3:2 DMG
//         palette (0 grey, 1 green, 2 pocket, 3 light)
//  $10 R  keypad key held on either ColecoVision controller: 0-9, 10 *,
//         11 #, $FF none; also the keyboard's digits, SNES L = 1, R = 2
//  $11-$14 R  CRC-32 (zlib) of the bytes since $03 (forwarded to the SRAM,
//         not discarded, or read from $16), bits 7:0 first
//  $15 R  SPI received byte, and start the next transfer (sending $FF)
//  $16 R  byte at the load address (the SRAM, or the cartridge RAM block
//         RAM with $0A bit 3), which then increments; added to the CRC
//  $17 W  ROM cache: SRAM pages (8K) for the ROM, 1-64
//  $18 W  ROM cache: ROM page (8K) for $1A-$1D, bits 7:0
//  $19 W  bits 1:0: its bits 9:8
//  $1A-$1D W  the SD read argument of that page's first sector (block
//         number, or byte offset on an SD v1 card), bits 7:0 first; $1D
//         writes it to the page table
//  $1E W  bits 3:0: SRAM address bits 18:15 of the work RAM
//  $1F W  bits 5:0: SRAM address bits 18:13 of the cartridge RAM (when it
//         is in the SRAM: over 8K)
//  $80-$FF R/W  128 bytes that resets keep (only power-on clears them):
//         the loader's note of the game's save file
//
// Memory: work RAM banks 0 and 1 (all of the original Game Boy's) and up to
// 8K of cartridge RAM are block RAM.  The loader places the rest in the
// SRAM from the top: more cartridge RAM (aligned to its size), then the
// GBC's work RAM banks 2-7 (a 32K block, its first 8K unused), and the
// ROM gets the 8K pages below them (c_slots, 45-64).
//
// ROM cache: the ROM can be up to 8M.  A table maps each 8K ROM page to its
// SRAM page, if it has one.  A game starts with ROM pages 0 to c_slots-1 in
// the same SRAM pages, so a ROM that fits is all there and never waits.
// When the Game Boy reads a ROM page that is not there, the cache reads it
// from the SD card (at the argument the loader gave for the page) into an
// SRAM page not used lately (clock algorithm), then maps it.  Meanwhile a
// CPU read holds the CPU (as the GBC's HDMA does: video, sound and timers
// go on); a DMA's read freezes the whole Game Boy (its clock enables), and
// the HDMI side shows the lines it then misses black.

`timescale 1ns / 1ps

module gb_phoenix
  #( parameter LOADER_FILE = "gb_loader.hex"
   )
   ( input             clk25
   , input             clk_i       // 33.75MHz
   , input             clk_g       // clk_i, stopped while run is low
   , output reg        run         // enable of clk_g (clk_i domain)

   , input             reset       // power-on or hold-reset (clk25): back to the menu
   , input             game_reset  // reset the game (clk25)

   // Controllers (clk25), 1 = pressed
   , input       [9:0] cv1         // ColecoVision port 1 (cv_pads_ga format)
   , input       [9:0] cv2         // ColecoVision port 2
   , input      [11:0] snes        // 0 A 1 B 2 X 3 Y 4 start 5 select 6 L 7 R 8 up 9 down 10 left 11 right
   , input      [15:0] kb_keys     // colecoKeyboard keys
   , input       [4:0] kb_joy      // colecoKeyboard arrows + Z

   // External SRAM.  The data bus tri-state is done at the top level.
   , output reg [18:0] sram_addr
   , output reg  [7:0] sram_dout
   , input       [7:0] sram_din
   , output reg        sram_doe
   , output reg        sram_we_n
   , output reg        sram_oe_n

   // SD card SPI
   , output            sd_cs_n
   , output            sd_sclk
   , output            sd_mosi
   , input             sd_miso
   , input             sd_cd_n

   // 640x480 video (clk25)
   , output reg  [7:0] vid_r
   , output reg  [7:0] vid_g
   , output reg  [7:0] vid_b
   , output reg        vid_hsync_n
   , output reg        vid_vsync_n
   , output reg        vid_blank

   // Audio (clk25), signed
   , output reg [15:0] audio_l
   , output reg [15:0] audio_r

   , output reg        boot_mode
   , output reg        led_err
   , output     [31:0] dbg         // the ROM cache's state (simulation)
   );

// HDMI line on which a waiting Game Boy starts its next frame: twelve
// lines before HDMI line 0.  A Game Boy line takes 3.38 HDMI lines and is
// shown for 3.33, so the Game Boy loses 6.5 HDMI lines over a frame; it
// still finishes each line before the HDMI side shows it.
localparam RELEASE_LINE = 10'd513;

// ---------------------------------------------------------------------------
// HDMI timing (clk25)

reg [9:0] hc = 0, vc = 0;

always @(posedge clk25) begin
  if (hc == 10'd799) begin
    hc <= 0;
    vc <= (vc == 10'd524) ? 10'd0 : vc + 1;
  end else
    hc <= hc + 1;
end

reg release_tog = 0;
always @(posedge clk25)
  if (vc == RELEASE_LINE && hc == 0)
    release_tog <= !release_tog;

// ---------------------------------------------------------------------------
// Frame lock (clk_i)

reg        frame_top = 0;    // clk_g: the Game Boy is at the top of a frame
reg  [2:0] rel_sync = 0;
reg        waiting = 0;
wire       rel_event = rel_sync[2] ^ rel_sync[1];

initial run = 1;

always @(posedge clk_i) begin
  rel_sync <= {rel_sync[1:0], release_tog};
  if (!waiting) begin
    if (frame_top) begin
      waiting <= 1;
      run     <= 0;
    end
  end else if (rel_event) begin
    waiting <= 0;
    run     <= 1;
  end
end

// ---------------------------------------------------------------------------
// Resets (clk_g)

reg [2:0] reset_s = 3'b111, game_reset_s = 0;
always @(posedge clk_g) begin
  reset_s      <= {reset_s[1:0], reset};
  game_reset_s <= {game_reset_s[1:0], game_reset};
end
wire g_reset = reset_s[2];

reg       start_game = 0;
reg [7:0] gb_rst_cnt = 8'hff;
reg       c_init = 0;          // the cache table is being set up
wire      gb_reset = (gb_rst_cnt != 0) || c_init;

initial boot_mode = 1;

always @(posedge clk_g) begin
  if (g_reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (g_reset || start_game || (game_reset_s[2] && !boot_mode))
    gb_rst_cnt <= 8'hff;
  else if (gb_rst_cnt != 0)
    gb_rst_cnt <= gb_rst_cnt - 1;
end

// Clock enables (the MiSTer core's speedcontrol): ce at 4MHz, ce_n half a
// period later, ce_2x at 8MHz for the GBC's double speed.  The ROM cache
// stops them all (freeze) while a DMA waits for a ROM page, as the MiSTer
// core's speedcontrol does while it waits for its SDRAM.
reg [2:0] clkdiv = 0;
reg       ce = 0, ce_n = 0, ce_2x = 0;
reg       freeze = 0;
always @(posedge clk_g) begin
  if (!freeze)
    clkdiv <= clkdiv + 1;
  ce     <= !freeze && (clkdiv == 3'd0);
  ce_n   <= !freeze && (clkdiv == 3'd4);
  ce_2x  <= !freeze && (clkdiv[1:0] == 2'd0);
end

// ---------------------------------------------------------------------------
// Controllers

// ColecoVision key codes (pins 4..1, active low)
localparam [3:0] CV_STAR = 4'b0101, CV_HASH = 4'b1010;

function [7:0] cv_pad(input [9:0] p);
  // {start, select, B, A, down, up, left, right}: left fire A, right fire
  // B, # start, * select
  cv_pad = { p[9:6] == CV_HASH, p[9:6] == CV_STAR, p[5], p[4], p[1], p[0], p[2], p[3] };
endfunction

reg [7:0] joy = 0;
reg [7:0] menu_key = 8'hff;

// ColecoVision key code (pins 4..1) to the key number for the menu
function [7:0] cv_num(input [3:0] k);
  case (k)
  4'b1100: cv_num = 0;  4'b0111: cv_num = 1;  4'b1011: cv_num = 2;
  4'b0110: cv_num = 3;  4'b1000: cv_num = 4;  4'b1001: cv_num = 5;
  4'b1110: cv_num = 6;  4'b0011: cv_num = 7;  4'b0001: cv_num = 8;
  4'b1101: cv_num = 9;  4'b0101: cv_num = 10; 4'b1010: cv_num = 11;
  default: cv_num = 8'hff;
  endcase
endfunction

always @(posedge clk25) begin
  // SNES: A A, B B, X A, Y B; keyboard: arrows, X A, Z B, Q start, W select
  joy <= cv_pad(cv1) | cv_pad(cv2) |
         { snes[4], snes[5], snes[1] | snes[3], snes[0] | snes[2],
           snes[9], snes[8], snes[10], snes[11] } |
         { kb_keys[6], kb_keys[9], kb_joy[4], kb_keys[0],
           kb_joy[1], kb_joy[0], kb_joy[2], kb_joy[3] };
  menu_key <= (cv1[9:6] != 4'b1111) ? cv_num(cv1[9:6]) :
              (cv2[9:6] != 4'b1111) ? cv_num(cv2[9:6]) :
              snes[6] ? 8'd1 : snes[7] ? 8'd2 :
              kb_keys[10] ? 8'd0 : kb_keys[13] ? 8'd1 : kb_keys[7] ? 8'd2 :
              kb_keys[12] ? 8'd3 : 8'hff;
end

// To clk_g: take a value once it has been the same for two clocks.
reg [7:0] joy_m, joy_s, joy_g = 0;
reg [7:0] mkey_m, mkey_s, mkey_g = 8'hff;
always @(posedge clk_g) begin
  joy_m  <= joy;      joy_s  <= joy_m;  if (joy_s == joy_m) joy_g <= joy_s;
  mkey_m <= menu_key; mkey_s <= mkey_m; if (mkey_s == mkey_m) mkey_g <= mkey_s;
end

wire [1:0] joy_p54;
wire [3:0] joy_dir     = ~joy_g[3:0] | {4{joy_p54[0]}};      // down, up, left, right
wire [3:0] joy_buttons = ~joy_g[7:4] | {4{joy_p54[1]}};      // start, select, B, A
wire [3:0] joy_din     = joy_dir & joy_buttons;

// ---------------------------------------------------------------------------
// The Game Boy

reg         game_gbc = 0;      // the game's settings ($0B-$0F)
reg         fast_boot = 0;
reg   [1:0] dmg_pal = 0;
reg   [2:0] mapper = 0;
reg   [8:0] rom_mask = 0;
reg   [3:0] ram_mask = 0;
reg         has_ram = 0;
reg         cram_bram = 0;     // the cartridge RAM is the 8K block RAM
reg   [5:0] cram_base = 6'h30; // SRAM address bits 18:13 of the cartridge RAM ($1F)
reg   [3:0] wram_base = 4'h8;  // SRAM address bits 18:15 of the work RAM ($1E)
reg   [6:0] c_slots = 7'd64;   // ROM cache: SRAM pages for the ROM ($17)

wire        is_gbc = boot_mode | game_gbc;

wire [14:0] ext_bus_addr;
wire        ext_bus_a15;
wire        cart_rd, cart_wr;
wire  [7:0] cart_di;
reg   [7:0] cart_do;
wire        cart_oe;
wire        nCS;
wire [14:0] wram_addr;
wire        wram_we;
wire  [7:0] wram_wdata;
reg   [7:0] wram_q = 8'hff, cart_q = 8'hff;
wire  [7:0] wram_data;
wire [15:0] gb_audio_l, gb_audio_r;
wire        lcd_clkena, lcd_on, lcd_vsync;
wire [14:0] lcd_data;
wire  [1:0] lcd_data_gb, lcd_mode;
wire        speed, dma_on, ext_dma;
reg         cpu_hold = 0;

gb gb
  ( .reset        (gb_reset)
  , .clk_sys      (clk_g)
  , .ce           (ce)
  , .ce_n         (ce_n)
  , .ce_2x        (ce_2x)
  , .isGBC        (is_gbc)
  , .boot_rom_off (boot_mode)
  , .fast_boot_en (fast_boot)
  , .ext_bus_addr (ext_bus_addr)
  , .ext_bus_a15  (ext_bus_a15)
  , .cart_rd      (cart_rd)
  , .cart_wr      (cart_wr)
  , .cart_do      (cart_do)
  , .cart_di      (cart_di)
  , .cart_oe      (cart_oe)
  , .nCS          (nCS)
  , .wram_addr    (wram_addr)
  , .wram_we      (wram_we)
  , .wram_wdata   (wram_wdata)
  , .wram_rdata   (wram_data)
  , .audio_l      (gb_audio_l)
  , .audio_r      (gb_audio_r)
  , .lcd_clkena   (lcd_clkena)
  , .lcd_data     (lcd_data)
  , .lcd_data_gb  (lcd_data_gb)
  , .lcd_mode     (lcd_mode)
  , .lcd_on       (lcd_on)
  , .lcd_vsync    (lcd_vsync)
  , .joy_p54      (joy_p54)
  , .joy_din      (joy_din)
  , .speed        (speed)
  , .DMA_on       (dma_on)
  , .cpu_hold     (cpu_hold)
  , .ext_dma      (ext_dma)
  );

wire ce_cpu = speed ? ce_2x : ce;

// The game's cartridge
wire [18:0] cart_sram_addr;
wire  [9:0] rom_page;
wire        game_oe, cram_wr, rtc_sel, mbc2_ram, is_ram;

gb_cart cart
  ( .clk       (clk_g)
  , .ce_cpu    (ce_cpu)
  , .reset     (gb_reset || boot_mode)
  , .mapper    (mapper)
  , .rom_mask  (rom_mask)
  , .ram_mask  (ram_mask)
  , .has_ram   (has_ram)
  , .ram_base  (cram_base)
  , .addr      (ext_bus_addr)
  , .a15       (ext_bus_a15)
  , .cart_rd   (cart_rd)
  , .cart_wr   (cart_wr)
  , .cart_di   (cart_di)
  , .nCS       (nCS)
  , .sram_addr (cart_sram_addr)
  , .rom_page  (rom_page)
  , .is_ram    (is_ram)
  , .cart_oe   (game_oe)
  , .ram_wr    (cram_wr)
  , .rtc_sel   (rtc_sel)
  , .mbc2_ram  (mbc2_ram)
  );

// ---------------------------------------------------------------------------
// ROM cache (see the top)

reg  [6:0] c_map [0:1023];      // ROM page -> {in the SRAM, SRAM page}
reg  [9:0] c_rev [0:63];        // SRAM page -> ROM page
reg [63:0] c_ref = 0;           // SRAM page used lately (clock algorithm)
reg [31:0] c_lba [0:1023];      // ROM page -> SD argument of its first sector
wire [6:0] c_map_q = c_map[rom_page];
wire       c_hit   = c_map_q[6];
wire [5:0] c_line  = c_map_q[5:0];
reg  [2:0] c_settle = 0;        // clocks for the SRAM's data, after a page is mapped

// A ROM read, by the CPU or a DMA, that has to wait for its page: the CPU
// is held (the core's HDMA stop), a DMA freezes the whole Game Boy.  The
// CPU and the DMAs take their data a few clocks after the address, so the
// registered hold is in time.
wire rom_rd   = !boot_mode && !c_init && cart_rd && !ext_bus_a15;
wire rom_wait = rom_rd && (!c_hit || c_settle != 0);

always @(posedge clk_g) begin
  cpu_hold <= rom_wait && !ext_dma;
  freeze   <= rom_wait && ext_dma;
end

// Loader ROM, 16K at $0000-$3FFF (mirrored at $4000)
reg [7:0] loader_rom [0:16383];
reg [7:0] loader_q;
initial $readmemh(LOADER_FILE, loader_rom);
always @(posedge clk_g)
  loader_q <= loader_rom[ext_bus_addr[13:0]];

reg [7:0] io_q;
wire      io_sel = ext_bus_a15 && !nCS && !ext_bus_addr[14];   // $A000-$BFFF

// Cartridge RAM up to 8K: written by the game, or by the loader (.SAV)
reg  [7:0] cram_m [0:8191];
reg  [7:0] cram_q;
reg        cram_wr_d = 0;
reg        ld_bram = 0;      // the loader's bytes go here ($0A bit 3)
reg        ld_pend = 0;      // a byte waits for the SRAM
reg  [7:0] ld_data;
reg [18:0] ld_addr = 0;
reg        ld_bram_done = 0;
wire       cram_bram_we = !boot_mode && cram_bram && cram_wr && !cram_wr_d;
wire       ld_bram_we = boot_mode && ld_bram && ld_pend && !ld_bram_done;
wire [12:0] cram_a = boot_mode ? ld_addr[12:0] : cart_sram_addr[12:0];

always @(posedge clk_g) begin
  cram_wr_d    <= cram_wr;
  ld_bram_done <= ld_bram_we;
  if (cram_bram_we || ld_bram_we)
    cram_m[cram_a] <= boot_mode ? ld_data : cart_di;
  cram_q <= cram_m[cram_a];
end

wire [7:0] cart_data = (is_ram && cram_bram) ? cram_q : cart_q;

always @* begin
  if (boot_mode)
    cart_do = ext_bus_a15 ? io_q : loader_q;
  else if (rtc_sel && ext_bus_a15)
    cart_do = 8'h00;
  else if (mbc2_ram && ext_bus_a15)
    cart_do = {4'hF, cart_data[3:0]};
  else
    cart_do = cart_data;
end

assign cart_oe = boot_mode ? (cart_rd && (!ext_bus_a15 || io_sel)) : game_oe;

// ---------------------------------------------------------------------------
// Loader I/O: SD card SPI, forward engine, SRAM loader

reg        spi_sel = 0;
reg        spi_slow = 1;
reg        spi_busy = 0;
reg  [7:0] spi_tx = 8'hff, spi_rx = 8'hff;
reg  [7:0] spi_txd;
reg  [2:0] spi_bit;
reg  [6:0] spi_div = 0;
reg        spi_sclk_r = 0;
reg        spi_start = 0;
reg        f_cs = 0;         // the cache's SD select (in a game)
reg [15:0] fwd_count = 0;
reg  [7:0] fwd_lo;
reg        fwd_active = 0;
reg        fwd_discard = 0;
reg        fwd_feed = 0;
reg        fwd_feed_wait = 0;

reg        ld_done = 0;      // SRAM write finished (from the controller)
reg [31:0] crc = 32'hffffffff;

assign sd_cs_n = !(boot_mode ? spi_sel : f_cs);
assign sd_sclk = spi_sclk_r;
assign sd_mosi = spi_tx[7];

// SPI half period: 2 clocks fast (8.4MHz SCLK), 64 clocks slow (264kHz);
// always fast in a game (the cache).
wire spi_tick = (spi_slow && boot_mode) ? (spi_div == 7'd63) : (spi_div[0] == 1'b1);

always @(posedge clk_g) begin
  spi_div <= spi_tick ? 7'd0 : spi_div + 1;

  if (spi_start) begin
    spi_tx     <= spi_txd;
    spi_busy   <= 1;
    spi_bit    <= 0;
    spi_sclk_r <= 0;
    spi_div    <= 0;
  end else if (spi_busy && spi_tick) begin
    if (!spi_sclk_r) begin                // rising edge: sample MISO
      spi_sclk_r <= 1;
      spi_rx     <= {spi_rx[6:0], sd_miso};
    end else begin                        // falling edge: shift MOSI
      spi_sclk_r <= 0;
      spi_tx     <= {spi_tx[6:0], 1'b1};
      spi_bit    <= spi_bit + 1;
      if (spi_bit == 3'd7)
        spi_busy <= 0;
    end
  end

  if (g_reset) begin
    spi_busy   <= 0;
    spi_sclk_r <= 0;
    spi_tx     <= 8'hff;
  end
end

// CRC-32, reflected, polynomial EDB88320 (zlib)
function [31:0] crc32_byte(input [31:0] c, input [7:0] d);
  integer i;
  reg [31:0] r;
  begin
    r = c ^ {24'd0, d};
    for (i = 0; i < 8; i = i + 1)
      r = r[0] ? (r >> 1) ^ 32'hEDB88320 : (r >> 1);
    crc32_byte = r;
  end
endfunction

// I/O accesses: one per CPU access, at its end (cart_rd or cart_wr
// falling), with the address and data of the clock before.
reg  cart_rd_d = 0, cart_wr_d = 0;
reg  [7:0] io_a, io_d;
reg        io_s;
always @(posedge clk_g) begin
  cart_rd_d <= cart_rd;
  cart_wr_d <= cart_wr;
  if (cart_rd || cart_wr) begin
    io_a <= ext_bus_addr[7:0];
    io_d <= cart_di;
    io_s <= io_sel;
  end
end
wire io_wr     = boot_mode && io_s && cart_wr_d && !cart_wr;
wire io_rd     = boot_mode && io_s && cart_rd_d && !cart_rd;
wire io_rd_end = io_rd && (io_a == 8'h15);
wire mem_rd    = io_rd && (io_a == 8'h16);
wire [7:0] mem_q = ld_bram ? cram_q : cart_q;   // byte at ld_addr

// Kept across resets: the loader's note of the game's save file
reg  [7:0] keep [0:127];
integer ki;
initial for (ki = 0; ki < 128; ki = ki + 1) keep[ki] = 8'd0;
always @(posedge clk_g)
  if (io_wr && io_a[7])
    keep[io_a[6:0]] <= io_d;

wire fwd_byte_ready = fwd_feed_wait && !spi_busy;

// The cache's page reader: one 8K page, 16 sectors with one CMD18 (then
// CMD12), each sector's CRC16 checked; a page with a bad sector is read
// again (and the LED blinks).
localparam F_IDLE = 5'd0,  F_VICT = 5'd1,  F_EVICT = 5'd2, F_CMD = 5'd3,
           F_R1 = 5'd4,    F_R1C = 5'd5,   F_TOK = 5'd6,   F_TOKC = 5'd7,
           F_DATA = 5'd8,  F_DATAC = 5'd9, F_CRC = 5'd10,  F_STOP = 5'd11,
           F_STUFF = 5'd12, F_SR1 = 5'd13, F_SR1C = 5'd14, F_BUSY = 5'd15,
           F_BUSYC = 5'd16, F_END = 5'd17, F_MAP = 5'd18,  F_WAIT = 5'd19,
           F_ERR = 5'd20,  F_MAPW = 5'd21, F_CRCC = 5'd22;
reg  [4:0] f_state = F_IDLE, f_next;
reg  [9:0] f_page;
reg  [5:0] f_line, f_hand = 0;
reg [15:0] f_cnt;
reg  [3:0] f_blk;
reg  [8:0] f_byte;
reg  [2:0] f_ci;              // command byte
reg        f_stop;            // sending CMD12 (else CMD18)
reg [31:0] f_arg;             // the page's first sector
reg [23:0] led_time = 0;      // the LED blinks for an SD error
reg [15:0] f_crc;             // CRC16 (CCITT, 0 start) of a block's data
reg        f_bad;             // a block of the page had a bad CRC
reg        f_retry = 0;       // an error's CMD12 has been sent

function [15:0] crc16_byte(input [15:0] c, input [7:0] d);
  integer i;
  reg [15:0] r;
  begin
    r = c ^ {d, 8'd0};
    for (i = 0; i < 8; i = i + 1)
      r = r[15] ? (r << 1) ^ 16'h1021 : (r << 1);
    crc16_byte = r;
  end
endfunction

// One registered write port for each cache table (XST drops a second one)
reg [10:0] c_init_i;
reg        cm_we = 0;
reg  [9:0] cm_a;
reg  [6:0] cm_d;
reg        cr_we = 0;
reg  [5:0] cr_a;
reg  [9:0] cr_d;

always @(posedge clk_g) begin
  if (cm_we)
    c_map[cm_a] <= cm_d;
  if (cr_we)
    c_rev[cr_a] <= cr_d;
end

reg  [7:0] lba_page_lo;
reg  [1:0] lba_page_hi;
reg [23:0] lba_lo;

always @(posedge clk_g)
  f_arg <= c_lba[f_page];

assign dbg = {f_state, cpu_hold, freeze, rom_rd, c_hit, ext_dma, cart_rd, ext_bus_a15,
              c_init, f_cs, spi_busy, rom_page, 7'd0};   // 5+10+10+7

wire [7:0] f_cmd_byte = f_ci == 3'd0 ? (f_stop ? 8'h4C : 8'h52) :   // CMD12, CMD18
                        f_ci == 3'd5 ? 8'hFF : f_stop ? 8'h00 :
                        f_ci == 3'd1 ? f_arg[31:24] : f_ci == 3'd2 ? f_arg[23:16] :
                        f_ci == 3'd3 ? f_arg[15:8]  : f_arg[7:0];

always @(posedge clk_g) begin
  spi_start  <= 0;
  start_game <= 0;
  fwd_feed   <= 0;

  if (fwd_feed)
    fwd_feed_wait <= 1;
  else if (fwd_byte_ready)
    fwd_feed_wait <= 0;

  if (ld_done || ld_bram_done) begin
    ld_pend <= 0;
    ld_addr <= ld_addr + 1;
  end
  if (mem_rd) begin
    ld_addr <= ld_addr + 1;
    crc     <= crc32_byte(crc, mem_q);
  end

  // The cache's error blink (0.4s)
  if (!boot_mode && led_time != 0) begin
    led_time <= led_time - 1;
    if (led_time == 1)
      led_err <= 0;
  end

  // Cache tables: set up at the start of a game (ROM pages 0 to c_slots-1
  // in SRAM pages 0 to c_slots-1, where the loader put them)
  cm_we <= 0;
  cr_we <= 0;
  if (c_settle != 0)
    c_settle <= c_settle - 1;
  if (start_game) begin
    c_init   <= 1;
    c_init_i <= 0;
  end else if (c_init) begin
    cm_we <= 1;
    cm_a  <= c_init_i[9:0];
    cm_d  <= (c_init_i < {4'd0, c_slots}) ? {1'b1, c_init_i[5:0]} : 7'd0;
    cr_we <= (c_init_i < 11'd64);
    cr_a  <= c_init_i[5:0];
    cr_d  <= c_init_i[9:0];
    c_ref    <= 0;
    f_hand   <= 0;
    c_init_i <= c_init_i + 1;
    if (c_init_i == 11'd1023)
      c_init <= 0;
  end

  // ROM reads mark their SRAM page used
  if (rom_rd && c_hit)
    c_ref[c_line] <= 1;

  if (boot_mode || c_init) begin
    f_state <= F_IDLE;
    f_cs    <= 0;
  end else case (f_state)
  F_IDLE:
    if (rom_rd && !c_hit) begin
      f_page  <= rom_page;
      f_state <= F_VICT;
    end
  F_VICT:                            // clock hand: the first page not used lately
    if (c_ref[f_hand]) begin
      c_ref[f_hand] <= 0;
      f_hand <= ({1'b0, f_hand} == c_slots - 7'd1) ? 6'd0 : f_hand + 6'd1;
    end else begin
      f_line  <= f_hand;
      f_hand  <= ({1'b0, f_hand} == c_slots - 7'd1) ? 6'd0 : f_hand + 6'd1;
      f_state <= F_EVICT;
    end
  F_EVICT: begin
      cm_we <= 1;                    // unmap the page it had
      cm_a  <= c_rev[f_line];
      cm_d  <= 7'd0;
      cr_we <= 1;
      cr_a  <= f_line;
      cr_d  <= f_page;
      ld_addr <= {f_line, 13'd0};
      f_cnt   <= 0;
      f_blk   <= 0;
      f_ci    <= 0;
      f_stop  <= 0;
      f_bad   <= 0;
      f_cs    <= 1;
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_CMD;
    end
  F_CMD: begin                       // CMD18 or CMD12, 6 bytes
      spi_txd <= f_cmd_byte; spi_start <= 1; f_state <= F_WAIT;
      f_ci <= f_ci + 1;
      f_next <= (f_ci != 3'd5) ? F_CMD : f_stop ? F_STUFF : F_R1;
      f_cnt <= 0;
    end
  F_R1: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_R1C;
      f_cnt <= f_cnt + 1;
    end
  F_R1C:
    if (spi_rx == 8'hFF)
      f_state <= (f_cnt == 16) ? F_ERR : F_R1;
    else
      f_state <= (spi_rx == 8'h00) ? F_TOK : F_ERR;
  F_TOK: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_TOKC;
      f_cnt <= f_cnt + 1;
    end
  F_TOKC:
    if (spi_rx == 8'hFE) begin
      f_byte  <= 0;
      f_crc   <= 0;
      f_state <= F_DATA;
    end else
      f_state <= (spi_rx != 8'hFF || f_cnt == 16'hFFFF) ? F_ERR : F_TOK;
  F_DATA:
    if (!ld_pend) begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_DATAC;
    end
  F_DATAC: if (!ld_pend) begin       // (the SRAM has the last byte)
      ld_data <= spi_rx;
      ld_pend <= 1;
      f_crc   <= crc16_byte(f_crc, spi_rx);
      f_byte  <= f_byte + 1;
      f_cnt   <= 0;
      f_state <= (f_byte == 9'd511) ? F_CRC : F_DATA;
    end
  F_CRC: begin                       // two CRC bytes (checked in F_CRCC)
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT;
      f_cnt <= f_cnt + 1;
      f_next <= F_CRCC;
    end
  F_CRCC: begin                      // the CRC byte just read
      if (spi_rx != (f_cnt == 1 ? f_crc[15:8] : f_crc[7:0]))
        f_bad <= 1;
      if (f_cnt == 2) begin
        f_blk   <= f_blk + 1;
        f_cnt   <= 0;
        f_state <= (f_blk == 4'd15) ? F_STOP : F_TOK;
      end else
        f_state <= F_CRC;
    end
  F_STOP: begin                      // 16 sectors: CMD12
      f_ci    <= 0;
      f_stop  <= 1;
      f_state <= F_CMD;
    end
  F_STUFF: begin                     // the byte after CMD12 (discarded)
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_SR1;
      f_cnt <= 0;
    end
  F_SR1: begin                       // CMD12's response
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_SR1C;
      f_cnt <= f_cnt + 1;
    end
  F_SR1C:
    if (spi_rx == 8'hFF && f_cnt != 16)
      f_state <= F_SR1;
    else begin
      f_cnt   <= 0;
      f_state <= F_BUSY;
    end
  F_BUSY: begin                      // the card is busy while it sends 0
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_BUSYC;
      f_cnt <= f_cnt + 1;
    end
  F_BUSYC:
    if (spi_rx == 8'hFF)
      f_state <= F_END;
    else
      f_state <= (f_cnt == 16'hFFFF) ? F_ERR : F_BUSY;
  F_END:
    if (!ld_pend) begin
      f_cs <= 0;
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT;
      f_next  <= f_bad ? F_ERR : F_MAP;    // a bad block: read the page again
    end
  F_MAP: begin
      cm_we <= 1;
      cm_a  <= f_page;
      cm_d  <= {1'b1, f_line};
      c_ref[f_line] <= 1;
      f_state <= F_MAPW;
    end
  F_MAPW: begin                      // the table write lands; the data follows
      c_settle <= 3'd7;
      f_state  <= F_IDLE;
    end
  F_WAIT:                            // an SPI byte
    if (!spi_start && !spi_busy)
      f_state <= f_next;
  F_ERR: begin                       // stop the read (CMD12), then start the page again
      led_err  <= 1;
      led_time <= 24'hFFFFFF;
      if (!f_retry) begin
        f_retry <= 1;
        f_bad   <= 1;
        f_state <= F_STOP;
      end else if (!ld_pend) begin
        f_retry <= 0;
        f_cs    <= 0;
        spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_EVICT;
      end
    end
  default: f_state <= F_IDLE;
  endcase

  if (io_wr) begin
    case (io_a)
    8'h00: begin spi_txd <= io_d; spi_start <= 1; end
    8'h01: begin spi_sel <= io_d[0]; spi_slow <= io_d[1]; fwd_discard <= io_d[2]; end
    8'h02: begin ld_data <= io_d; ld_pend <= 1; end
    8'h03: crc        <= 32'hffffffff;
    8'h04: begin start_game <= 1; ld_bram <= 0; end
    8'h05: led_err    <= io_d[0];
    8'h06: fwd_lo     <= io_d;
    8'h07: begin fwd_count <= {io_d, fwd_lo}; fwd_active <= 1; end
    8'h08: ld_addr[7:0]   <= io_d;
    8'h09: ld_addr[15:8]  <= io_d;
    8'h0A: begin ld_addr[18:16] <= io_d[2:0]; ld_bram <= io_d[3]; end
    8'h0B: mapper        <= io_d[2:0];
    8'h0C: rom_mask[7:0] <= io_d;
    8'h0D: rom_mask[8]   <= io_d[0];
    8'h0E: begin ram_mask <= io_d[3:0]; cram_bram <= io_d[6]; has_ram <= io_d[7]; end
    8'h0F: begin game_gbc <= io_d[0]; fast_boot <= io_d[1]; dmg_pal <= io_d[3:2]; end
    8'h17: c_slots       <= io_d[6:0];
    8'h18: lba_page_lo   <= io_d;
    8'h19: lba_page_hi   <= io_d[1:0];
    8'h1A: lba_lo[7:0]   <= io_d;
    8'h1B: lba_lo[15:8]  <= io_d;
    8'h1C: lba_lo[23:16] <= io_d;
    8'h1D: c_lba[{lba_page_hi, lba_page_lo}] <= {io_d, lba_lo};
    8'h1E: wram_base     <= io_d[3:0];
    8'h1F: cram_base     <= io_d[5:0];
    default: ;
    endcase
  end

  if (io_rd_end) begin
    spi_txd   <= 8'hff;
    spi_start <= 1;
  end

  // Forward engine: one byte at a time, each to the SRAM and the CRC.  The
  // next transfer starts once the SRAM has taken the previous byte.
  if (fwd_active && !spi_busy && !spi_start && !fwd_feed && !fwd_feed_wait && !ld_pend) begin
    if (fwd_count == 0) begin
      fwd_active <= 0;
    end else begin
      spi_txd   <= 8'hff;
      spi_start <= 1;
      fwd_feed  <= 1;
      fwd_count <= fwd_count - 1;
    end
  end

  if (fwd_byte_ready) begin
    if (!fwd_discard) begin
      crc     <= crc32_byte(crc, spi_rx);
      ld_data <= spi_rx;
      ld_pend <= 1;
    end
  end

  if (g_reset) begin
    spi_sel       <= 0;
    spi_slow      <= 1;
    fwd_discard   <= 0;
    fwd_active    <= 0;
    fwd_feed_wait <= 0;
    ld_pend       <= 0;
    led_err       <= 0;
    game_gbc      <= 0;
    fast_boot     <= 0;
    mapper        <= 0;
    ld_bram       <= 0;
  end
end

wire [31:0] crc_out = ~crc;

always @(posedge clk_g) begin
  case (ext_bus_addr[7:0])
  8'h00,
  8'h15:   io_q <= spi_rx;
  8'h01:   io_q <= {spi_busy || spi_start || fwd_active || fwd_feed || fwd_feed_wait || ld_pend,
                    !sd_cd_n, 6'd0};
  8'h10:   io_q <= mkey_g;
  8'h11:   io_q <= crc_out[7:0];
  8'h12:   io_q <= crc_out[15:8];
  8'h13:   io_q <= crc_out[23:16];
  8'h14:   io_q <= crc_out[31:24];
  8'h16:   io_q <= mem_q;
  default: io_q <= ext_bus_addr[7] ? keep[ext_bus_addr[6:0]] : 8'hff;
  endcase
end

// ---------------------------------------------------------------------------
// SRAM controller (clk_g, 29.6ns).  Reads take one clock each and alternate
// between the cartridge and the work RAM, so each port's data follows its
// address within a few clocks.  A write takes four clocks (address and data,
// WE low, WE high, release the bus); the work RAM goes first, then the
// cartridge RAM, then the loader.


reg  [2:0] ws = 0;           // 0 reads, 1-3 write
reg        rp = 0;           // port of the read being issued: 0 cartridge, 1 work RAM
reg        rd_valid = 0, rd_port = 0;
reg        wram_pend = 0, cram_pend = 0;
reg [14:0] wram_wa;
reg  [7:0] wram_wd;
reg [18:0] cram_wa;
reg  [7:0] cram_wd;
reg  [1:0] w_src;            // 0 work RAM, 1 cartridge RAM, 2 loader

// The cartridge's read: the loader's ($16), the cartridge RAM, or the ROM
// byte in its cache page
wire [18:0] cart_rd_addr = boot_mode ? ld_addr : is_ram ? cart_sram_addr :
                           {c_line, ext_bus_addr[12:0]};

initial begin
  sram_we_n = 1;
  sram_oe_n = 0;
  sram_doe  = 0;
end

// Work RAM banks 0 and 1: block RAM
reg  [7:0] wram_lo [0:8191];
reg  [7:0] wram_lo_q;
reg        wram_lo_sel = 0;
wire       wram_is_lo = (wram_addr[14:13] == 2'd0);

always @(posedge clk_g) begin
  if (wram_we && wram_is_lo)
    wram_lo[wram_addr[12:0]] <= wram_wdata;
  wram_lo_q   <= wram_lo[wram_addr[12:0]];
  wram_lo_sel <= wram_is_lo;
end

assign wram_data = wram_lo_sel ? wram_lo_q : wram_q;

always @(posedge clk_g) begin
  ld_done   <= 0;

  if (wram_we && !wram_is_lo) begin
    wram_pend <= 1;
    wram_wa   <= wram_addr;
    wram_wd   <= wram_wdata;
  end
  if (cram_wr && !cram_wr_d && !boot_mode && !cram_bram) begin
    cram_pend <= 1;
    cram_wa   <= cart_sram_addr;
    cram_wd   <= cart_di;
  end

  // Read data of the previous clock
  if (rd_valid) begin
    if (rd_port) wram_q <= sram_din;
    else         cart_q <= sram_din;
  end
  rd_valid <= 0;

  case (ws)
  3'd0:
    if (wram_pend || cram_pend || (ld_pend && !ld_done && !ld_bram)) begin
      sram_doe  <= 1;
      sram_oe_n <= 1;
      if (wram_pend) begin
        sram_addr <= {wram_base, wram_wa};
        sram_dout <= wram_wd;
        w_src     <= 2'd0;
        wram_pend <= wram_we && !wram_is_lo;   // a new write in this clock stays pending
      end else if (cram_pend) begin
        sram_addr <= cram_wa;
        sram_dout <= cram_wd;
        w_src     <= 2'd1;
        cram_pend <= 0;
      end else begin
        sram_addr <= ld_addr;
        sram_dout <= ld_data;
        w_src     <= 2'd2;
      end
      ws <= 3'd1;
    end else begin
      sram_addr <= rp ? {wram_base, wram_addr} : cart_rd_addr;
      rd_valid  <= 1;
      rd_port   <= rp;
      rp        <= !rp;
    end
  3'd1: begin sram_we_n <= 0; ws <= 3'd2; end
  3'd2: begin sram_we_n <= 1; ws <= 3'd3; end
  3'd3: begin
      sram_doe  <= 0;
      sram_oe_n <= 0;
      ld_done   <= (w_src == 2'd2);
      ws <= 3'd0;
    end
  default: ws <= 3'd0;
  endcase

  if (g_reset) begin
    wram_pend <= 0;
    cram_pend <= 0;
  end
end

// ---------------------------------------------------------------------------
// Line buffer: 8 lines of 256 pixels (160 used), written at clk_g, read at
// clk25.  GBC hardware stores the 15-bit colour, DMG hardware the 2-bit
// shade.

reg  [7:0] px = 0;
reg  [7:0] py = 0;
reg        lcd_off_d = 1;
wire       lcd_off = !lcd_on || (lcd_mode == 2'd1);
wire       pix_wr = ce && lcd_clkena;

reg [14:0] linebuf [0:2047];

always @(posedge clk_g) begin
  lcd_off_d <= lcd_off;
  if (lcd_off != lcd_off_d) begin
    px <= 0;
    py <= 0;
  end else if (pix_wr) begin
    if (px == 8'd159) begin
      px <= 0;
      py <= py + 1;
    end else
      px <= px + 1;
  end
end

// Each buffer line's Game Boy line number: a line the Game Boy has not
// drawn in time (a cache freeze, or the LCD just switched on) shows black.
reg [7:0] lb_tag [0:7];

always @(posedge clk_g)
  if (pix_wr && py < 8'd144) begin
    linebuf[{py[2:0], px}] <= is_gbc ? lcd_data : {13'd0, lcd_data_gb};
    if (px == 8'd0)
      lb_tag[py[2:0]] <= py;
  end

// Frame top: the LCD's vertical sync, or with the LCD off a frame time
// (70224 dots) and a line after the last one.
reg [16:0] fcnt = 0;
reg        vsync_d = 0;

always @(posedge clk_g) begin
  frame_top <= 0;
  vsync_d   <= lcd_vsync;
  if ((lcd_on && lcd_vsync && !vsync_d) || fcnt == 17'd70680) begin
    frame_top <= 1;
    fcnt      <= 0;
  end else if (ce)
    fcnt <= fcnt + 1;
end

// ---------------------------------------------------------------------------
// Video (clk25)

reg [2:0] gbc_s = 0, on_s = 0;
reg [3:0] pal_s0, pal_s1;
always @(posedge clk25) begin
  gbc_s  <= {gbc_s[1:0], is_gbc};
  on_s   <= {on_s[1:0], lcd_on};
  pal_s0 <= {dmg_pal, dmg_pal};
  pal_s1 <= pal_s0;
end
wire show_gbc = gbc_s[2];
wire show_on  = on_s[2];

// Game picture: x 53..585.  gx/gy step 3/10 of a Game Boy pixel per HDMI
// pixel / line.
reg [7:0] gx = 0, gy = 0;
reg [3:0] hacc = 0, vacc = 0;
wire      g_in = (hc >= 10'd53) && (hc < 10'd586) && (vc < 10'd480);

always @(posedge clk25) begin
  if (hc == 10'd52) begin
    gx   <= 0;
    hacc <= 0;
  end else if (hacc >= 4'd7) begin
    hacc <= hacc - 4'd7;
    gx   <= gx + 1;
  end else
    hacc <= hacc + 4'd3;

  if (hc == 10'd799) begin
    if (vc == 10'd524) begin
      gy   <= 0;
      vacc <= 0;
    end else if (vacc >= 4'd7) begin
      vacc <= vacc - 4'd7;
      gy   <= gy + 1;
    end else
      vacc <= vacc + 4'd3;
  end
end

reg [14:0] lb_q;
reg        lb_ok;
always @(posedge clk25) begin
  lb_q  <= linebuf[{gy[2:0], gx}];
  lb_ok <= (lb_tag[gy[2:0]] == gy);
end

function [23:0] dmg_rgb(input [1:0] pal, input [1:0] shade);
  case ({pal, shade})
  // grey
  4'b0000: dmg_rgb = 24'hFFFFFF;  4'b0001: dmg_rgb = 24'hAAAAAA;
  4'b0010: dmg_rgb = 24'h555555;  4'b0011: dmg_rgb = 24'h000000;
  // green (DMG)
  4'b0100: dmg_rgb = 24'h9BBC0F;  4'b0101: dmg_rgb = 24'h8BAC0F;
  4'b0110: dmg_rgb = 24'h306230;  4'b0111: dmg_rgb = 24'h0F380F;
  // pocket
  4'b1000: dmg_rgb = 24'hC4CFA1;  4'b1001: dmg_rgb = 24'h8B956D;
  4'b1010: dmg_rgb = 24'h4D533C;  4'b1011: dmg_rgb = 24'h1F1F1F;
  // light
  4'b1100: dmg_rgb = 24'h00B2A0;  4'b1101: dmg_rgb = 24'h00968A;
  4'b1110: dmg_rgb = 24'h006B60;  default: dmg_rgb = 24'h004A40;
  endcase
endfunction

reg [2:0] g_in_d, blank_d, hs_d, vs_d;
reg [23:0] g_rgb;

always @(posedge clk25) begin
  // stage 2: colour
  if (!show_on)
    g_rgb <= show_gbc ? 24'hFFFFFF : dmg_rgb(pal_s1[1:0], 2'd0);
  else if (!lb_ok)
    g_rgb <= 24'h000000;
  else if (show_gbc)
    g_rgb <= { lb_q[4:0], lb_q[4:2], lb_q[9:5], lb_q[9:7], lb_q[14:10], lb_q[14:12] };
  else
    g_rgb <= dmg_rgb(pal_s1[1:0], lb_q[1:0]);

  g_in_d  <= {g_in_d[1:0], g_in};
  blank_d <= {blank_d[1:0], !(hc < 10'd640 && vc < 10'd480)};
  hs_d    <= {hs_d[1:0], !(hc >= 10'd656 && hc < 10'd752)};
  vs_d    <= {vs_d[1:0], !(vc >= 10'd490 && vc < 10'd492)};

  // stage 3: output
  if (g_in_d[1])
    {vid_r, vid_g, vid_b} <= g_rgb;
  else
    {vid_r, vid_g, vid_b} <= 24'h000000;
  vid_blank   <= blank_d[1];
  vid_hsync_n <= hs_d[1];
  vid_vsync_n <= vs_d[1];
end

// ---------------------------------------------------------------------------
// Audio, to clk25 once stable for two clocks.

reg [31:0] snd_g = 0;
reg [31:0] snd_m, snd_s;
always @(posedge clk_g)
  snd_g <= boot_mode ? 32'd0 : {gb_audio_l, gb_audio_r};
always @(posedge clk25) begin
  snd_m <= snd_g;
  snd_s <= snd_m;
  if (snd_s == snd_m)
    {audio_l, audio_r} <= snd_s;
end

endmodule
