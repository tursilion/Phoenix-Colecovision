// Phoenix glue for the PC Engine / TurboGrafx-16 core.
//
// Clocks:
//
//  - clk25: the 640x480 HDMI pixel clock.
//  - clk_i: 42.78MHz (25MHz x 77/45), just under the PC Engine's 42.95MHz
//    (12 x 3.58MHz).  A frame (263 lines of 2730 clocks) takes 16.784ms,
//    a little less than an HDMI frame (16.8ms).
//  - clk_g: clk_i through a BUFGCE whose enable is run.  Everything of the
//    PC Engine and the SRAM runs from clk_g.  At the top of each PC Engine
//    frame the frame lock stops clk_g until the HDMI frame reaches
//    RELEASE_LINE (59.52 frames per second).
//
// Picture: the VCE's 2160-clock line window, sampled every second clock
// (1080 samples, so each dot is 2, 3 or 4 samples), shown 640 wide, and
// lines 20-259 each twice: 640 x 480.  A PC Engine line (63.8us) is a
// little shorter than two HDMI lines (64us), so a 4-line buffer is enough.
//
// Loader mode: at power-on the PC Engine's own CPU runs the menu and loader
// (loader/, cc65) from a 16K block RAM ROM in ROM banks 0 and 1 (mirrored),
// and this I/O window is at $1800-$1BFF of the I/O page (address bits 7:0):
//
//  $00 R  SPI received byte
//      W  SPI transfer byte
//  $01 R  bit7 busy (SPI, forward engine or SRAM write), bit6 card present
//      W  bit0 SD select (1 = CS asserted), bit1 slow SPI clock,
//         bit2 forward engine discards the bytes
//  $02 W  byte to the SRAM at the load address, which then increments
//  $04 W  start the game
//  $05 W  bit0 error LED
//  $06 W  forward count, low byte
//  $07 W  forward count, high byte, and start: clock in that many SPI bytes
//         (sending $FF) and write each to the SRAM
//  $08-$0A W  load address, bits 7:0, 15:8, 18:16
//  $0B W  ROM size in K, bits 7:0
//  $0C W  ROM size in K, bits 11:8
//  $0D W  bit0 the ROM's bits are reversed (some US dumps)
//  $10 R  keypad key held on either ColecoVision controller: 0-9, 10 *,
//         11 #, $FF none; also the keyboard's digits, SNES L = 1, R = 2
//  $15 R  SPI received byte, and start the next transfer (sending $FF)
//  $18 W  ROM page (8K) for $1A-$1D, bits 7:0
//  $19 W  bit0: its bit 8
//  $1A-$1D W  the SD read argument of that page's first sector (block
//         number, or byte offset on an SD v1 card), bits 7:0 first; $1D
//         writes it to the page table
//  $1E W  bit0: the card takes byte offsets (SD v1), not block numbers
//
// SRAM: 56 8K pages of ROM from 00000 (448K); the VDC's 64K of video RAM
// at 70000-7FFFF (word w at 70000 + 2w, low byte first).
//
// ROM cache: the ROM can be up to 4M.  A table maps each 8K ROM page to
// its SRAM page, if it has one.  The game starts with ROM pages 0-55 in
// SRAM pages 0-55 (a ROM up to 448K is all there).  When the CPU reads a
// page that is not there, it waits while the cache reads the page from the
// SD card (16 sectors, at the argument the loader gave for the
// page) into an SRAM page that was not used lately (clock algorithm), then
// maps it.  The loader checks that each page is in consecutive sectors.
// The page is read with one multi-sector read (CMD18, then CMD12), each
// sector's CRC16 checked; a page with a bad sector is read again (and the
// LED blinks).

`timescale 1ns / 1ps

module tg16_phoenix
  #( parameter LOADER_FILE = "tg16_loader.hex"
   )
   ( input             clk25
   , input             clk_i       // 42.78MHz
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
   , output     [18:0] sram_addr
   , output      [7:0] sram_dout
   , input       [7:0] sram_din
   , output      [7:0] sram_doe    // per data pin: drive the bus
   , output            sram_we_n   // changes at the falling edge of clk_g
   , output            sram_oe_n

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
   , output     [31:0] dbg         // simulation: the ROM cache's state
   );

// HDMI line on which a waiting PC Engine starts its next frame.  Its line
// 20, the first one shown, is then in the buffer just before HDMI line 0.
localparam RELEASE_LINE = 10'd482;

// The VCE's line window: clocks LEFT_CLK to LEFT_CLK + 2159
localparam [11:0] LEFT_CLK = 12'd458;

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

reg        frame_top = 0;    // clk_g: the PC Engine is at the top of a frame
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
reg [7:0] pce_rst_cnt = 8'hff;
reg       c_init = 0;           // the cache table is being set up
wire      pce_reset = (pce_rst_cnt != 0) || c_init;

initial boot_mode = 1;

always @(posedge clk_g) begin
  if (g_reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (g_reset || start_game || (game_reset_s[2] && !boot_mode))
    pce_rst_cnt <= 8'hff;
  else if (pce_rst_cnt != 0)
    pce_rst_cnt <= pce_rst_cnt - 1;
end

// ---------------------------------------------------------------------------
// Controllers

// ColecoVision key codes (pins 4..1, active low)
localparam [3:0] CV_STAR = 4'b0101, CV_HASH = 4'b1010;

// Pad bits: 0 up, 1 right, 2 down, 3 left, 4 I, 5 II, 6 select, 7 run
function [7:0] cv_pad(input [9:0] p);
  // left fire I, right fire II, # run, * select
  cv_pad = { p[9:6] == CV_HASH, p[9:6] == CV_STAR, p[5], p[4], p[2], p[1], p[3], p[0] };
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
  // SNES: A and X I, B and Y II; keyboard: arrows, X I, Z II, Q run, W select
  joy <= cv_pad(cv1) | cv_pad(cv2) |
         { snes[4], snes[5], snes[1] | snes[3], snes[0] | snes[2],
           snes[10], snes[9], snes[11], snes[8] } |
         { kb_keys[6], kb_keys[9], kb_joy[4], kb_keys[0],
           kb_joy[2], kb_joy[1], kb_joy[3], kb_joy[0] };
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

// Rapid fire, like the TurboPad's: a counter that each pad read (CLR
// rising) steps, and a button in turbo mode only reads pressed while its
// counter bit is 0 (MAME's pce_ctrl/joypad2.cpp).  Modes: 0 off, 1 slow
// (bit 2: every 4 reads, 7.5/s at a read a frame), 2 fast (bit 1, 15/s),
// 3 fastest (bit 0, 30/s; the TurboPad has slow and fast).  Key 1 (or SNES
// L) steps I's mode, key 2 (or SNES R) II's.
wire [1:0] joy_out;
reg  [1:0] turbo_i = 0, turbo_ii = 0;
reg  [7:0] mkey_d = 8'hff;
reg        clr_d = 0;
reg  [2:0] turbo_cnt = 0;

always @(posedge clk_g) begin
  mkey_d <= mkey_g;
  if (mkey_g != mkey_d) begin
    if (mkey_g == 8'd1) turbo_i  <= turbo_i + 2'd1;
    if (mkey_g == 8'd2) turbo_ii <= turbo_ii + 2'd1;
  end
  clr_d <= joy_out[1];
  if (joy_out[1] && !clr_d)
    turbo_cnt <= turbo_cnt + 3'd1;
end

function fire(input [1:0] mode, input [2:0] cnt);
  case (mode)
  2'd0: fire = 1'b1;
  2'd1: fire = !cnt[2];
  2'd2: fire = !cnt[1];
  default: fire = !cnt[0];
  endcase
endfunction

wire pad_i  = joy_g[4] && fire(turbo_i, turbo_cnt);
wire pad_ii = joy_g[5] && fire(turbo_ii, turbo_cnt);

// The pad: SEL (joy_out[0]) high gives the directions, low the buttons;
// CLR (joy_out[1]) high gives 0000.  Active low.
reg  [3:0] joy_in = 4'hf;
always @(posedge clk_g)
  joy_in <= joy_out[1] ? 4'b0000 : joy_out[0] ? ~joy_g[3:0] : ~{joy_g[7:6], pad_ii, pad_i};

// ---------------------------------------------------------------------------
// The PC Engine

reg  [11:0] rom_size = 0;       // the game's settings ($0B-$0D)
reg         rom_swap = 0;

wire        rom_rd;
wire [21:0] rom_a;
wire  [7:0] rom_do;
wire        rom_rdy;
wire [15:0] vram_a, vram_do;
reg  [15:0] vram_q = 0;
reg  [15:0] vram_di;           // the VDC's word (SRAM controller)
wire        vram_we, vram_ce;
wire  [9:0] ext_a;
wire  [7:0] ext_do;
reg   [7:0] ext_di;
wire        ext_wr, ext_rd;
wire [15:0] psg_l, psg_r;
wire  [2:0] video_r, video_g, video_b;
wire [11:0] hcnt;
wire  [9:0] vcnt;

pce_top pce
  ( .RESET       (pce_reset)
  , .CLK         (clk_g)
  , .ROM_RD      (rom_rd)
  , .ROM_RDY     (rom_rdy)
  , .ROM_A       (rom_a)
  , .ROM_DO      (rom_do)
  , .ROM_SZ      (rom_size)
  , .ROM_CLKEN   ()
  , .VRAM_A      (vram_a)
  , .VRAM_DI     (vram_di)
  , .VRAM_DO     (vram_do)
  , .VRAM_WE     (vram_we)
  , .VRAM_CE     (vram_ce)
  , .EXT_A       (ext_a)
  , .EXT_DI      (ext_di)
  , .EXT_DO      (ext_do)
  , .EXT_WR      (ext_wr)
  , .EXT_RD      (ext_rd)
  , .JOY_OUT     (joy_out)
  , .JOY_IN      (joy_in)
  , .PSG_SL      (psg_l)
  , .PSG_SR      (psg_r)
  , .VIDEO_R     (video_r)
  , .VIDEO_G     (video_g)
  , .VIDEO_B     (video_b)
  , .VIDEO_CE    ()
  , .VIDEO_CE_FS ()
  , .VIDEO_VS    ()
  , .VIDEO_HS    ()
  , .VIDEO_HBL   ()
  , .VIDEO_VBL   ()
  , .VIDEO_HCNT  (hcnt)
  , .VIDEO_VCNT  (vcnt)
  );

// Frame top: the VCE's first clock of line 0 (it starts there after reset)
always @(posedge clk_g)
  frame_top <= !pce_reset && (vcnt == 10'd0) && (hcnt == 12'd0);

// Loader ROM, 16K in ROM banks 0 and 1, mirrored
reg [7:0] loader_rom [0:16383];
reg [7:0] loader_q;
initial $readmemh(LOADER_FILE, loader_rom);
always @(posedge clk_g)
  loader_q <= loader_rom[rom_a[13:0]];

// The game's ROM byte, from the SRAM controller
reg  [7:0] rom_q = 8'hff;
reg [21:0] rom_q_a = 0;
reg        rom_q_ok = 0;
reg        rom_want;
wire       rom_hit = rom_q_ok && (rom_q_a == rom_a);

// ROM cache tables (see the top).  c_map: ROM page -> {in SRAM, SRAM page}.
reg  [6:0] c_map [0:511];
reg  [8:0] c_rev [0:63];        // SRAM page -> ROM page (56 used)
reg [55:0] c_ref = 0;           // SRAM page used since the clock hand passed
reg [31:0] c_lba [0:511];       // ROM page -> SD argument
wire [8:0] c_page  = rom_a[21:13];
wire [6:0] c_map_q = c_map[c_page];
wire       c_hit   = c_map_q[6];
wire [5:0] c_line  = c_map_q[5:0];
wire [9:0] c_pages = (rom_size + 12'd7) >> 3;

function [7:0] bitrev(input [7:0] b);
  bitrev = {b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]};
endfunction

assign rom_do  = boot_mode ? loader_q : rom_swap ? bitrev(rom_q) : rom_q;
assign rom_rdy = boot_mode || !rom_rd || rom_hit;

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
reg [15:0] fwd_count = 0;
reg  [7:0] fwd_lo;
reg        fwd_active = 0;
reg        fwd_discard = 0;
reg        fwd_feed = 0;
reg        fwd_feed_wait = 0;

reg        ld_pend = 0;      // a byte waits for the SRAM
reg  [7:0] ld_data;
reg [18:0] ld_addr = 0;
reg        ld_done = 0;      // SRAM write finished (from the controller)

reg        f_cs = 0;         // the cache's SD select

assign sd_cs_n = !(boot_mode ? spi_sel : f_cs);
assign sd_sclk = spi_sclk_r;
assign sd_mosi = spi_tx[7];

// SPI half period: 2 clocks fast (10.7MHz SCLK), 80 clocks slow (267kHz).
// (21.4MHz read wrong sectors on the Phoenix: commands have no CRC.)
// MISO is taken at the end of SCLK's high half: the card changes it only
// after SCLK falls, so it has had the low half and the high half to settle.
wire spi_tick = (spi_slow && boot_mode) ? (spi_div == 7'd79) : (spi_div[0] == 1'b1);

always @(posedge clk_g) begin
  spi_div <= spi_tick ? 7'd0 : spi_div + 1;

  if (spi_start) begin
    spi_tx     <= spi_txd;
    spi_busy   <= 1;
    spi_bit    <= 0;
    spi_sclk_r <= 0;
    spi_div    <= 0;
  end else if (spi_busy && spi_tick) begin
    if (!spi_sclk_r) begin                // rising edge
      spi_sclk_r <= 1;
    end else begin                        // falling edge: sample MISO, shift MOSI
      spi_sclk_r <= 0;
      spi_rx     <= {spi_rx[6:0], sd_miso};
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

// I/O accesses: EXT_WR / EXT_RD pulse at the end of the CPU's access.
wire io_wr  = boot_mode && ext_wr && (ext_a[9:8] == 2'd0);
wire io_rd  = boot_mode && ext_rd && (ext_a[9:8] == 2'd0);
wire io_rd_next = io_rd && (ext_a[7:0] == 8'h15);

wire fwd_byte_ready = fwd_feed_wait && !spi_busy;

// The cache's page reader
localparam F_IDLE = 5'd0,  F_VICT = 5'd1,  F_EVICT = 5'd2, F_CMD = 5'd3,
           F_R1 = 5'd4,    F_R1C = 5'd5,   F_TOK = 5'd6,   F_TOKC = 5'd7,
           F_DATA = 5'd8,  F_DATAC = 5'd9, F_CRC = 5'd10,  F_STOP = 5'd11,
           F_STUFF = 5'd12, F_SR1 = 5'd13, F_SR1C = 5'd14, F_BUSY = 5'd15,
           F_BUSYC = 5'd16, F_END = 5'd17, F_MAP = 5'd18,  F_WAIT = 5'd19,
           F_ERR = 5'd20,  F_MAPW = 5'd21, F_CRCC = 5'd22;
reg  [4:0] f_state = F_IDLE, f_next;
reg  [8:0] f_page;
reg  [5:0] f_line, f_hand = 0;
reg [15:0] f_cnt;
reg  [3:0] f_blk;
reg  [8:0] f_byte;
reg  [2:0] f_ci;              // command byte
reg        f_stop;            // sending CMD12 (else CMD18)
reg [31:0] f_arg;             // the page's first sector
reg [31:0] f_sarg;            // its read argument
reg        f_bytes = 0;       // SD v1: arguments are byte offsets ($1E)
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
reg  [9:0] c_init_i;
reg        cm_we = 0;         // the one write port of c_map (LUT RAM)
reg  [8:0] cm_a;
reg  [6:0] cm_d;
reg        cr_we = 0;         // and of c_rev (XST drops one of two)
reg  [5:0] cr_a;
reg  [8:0] cr_d;

always @(posedge clk_g) begin
  if (cm_we)
    c_map[cm_a] <= cm_d;
  if (cr_we)
    c_rev[cr_a] <= cr_d;
end
reg  [7:0] lba_page_lo;
reg        lba_page_hi;
reg [23:0] lba_lo;

always @(posedge clk_g)
  f_arg <= c_lba[f_page];

wire [7:0] f_cmd_byte = f_ci == 3'd0 ? (f_stop ? 8'h4C : 8'h52) :   // CMD12, CMD18
                        f_ci == 3'd5 ? 8'hFF : f_stop ? 8'h00 :
                        f_ci == 3'd1 ? f_sarg[31:24] : f_ci == 3'd2 ? f_sarg[23:16] :
                        f_ci == 3'd3 ? f_sarg[15:8]  : f_ci == 3'd4 ? f_sarg[7:0] : 8'hFF;

always @(posedge clk_g) begin
  spi_start  <= 0;
  start_game <= 0;
  fwd_feed   <= 0;

  // The cache's error blink (0.4s)
  if (!boot_mode && led_time != 0) begin
    led_time <= led_time - 1;
    if (led_time == 1)
      led_err <= 0;
  end

  // Cache table writes: set-up at the start of a game, and the reader's
  cm_we <= 0;
  cr_we <= 0;
  if (start_game) begin
    c_init   <= 1;
    c_init_i <= 0;
  end else if (c_init) begin
    cm_we <= 1;
    cm_a  <= c_init_i[8:0];
    cm_d  <= (c_init_i < 10'd56) ? {1'b1, c_init_i[5:0]} : 7'd0;
    cr_we <= (c_init_i < 10'd56);
    cr_a  <= c_init_i[5:0];
    cr_d  <= c_init_i[8:0];
    c_ref    <= 0;
    f_hand   <= 0;
    c_init_i <= c_init_i + 1;
    if (c_init_i == 10'd511)
      c_init <= 0;
  end

  // The CPU's ROM reads mark their SRAM page used
  if (!boot_mode && rom_rd && c_hit && !c_init)
    c_ref[c_line] <= 1;

  if (boot_mode || c_init) begin
    f_state <= F_IDLE;
    f_cs    <= 0;
  end else case (f_state)
  F_IDLE:
    if (rom_rd && !c_hit) begin
      f_page  <= c_page;
      f_state <= F_VICT;
    end
  F_VICT:                            // clock hand: the first page not used lately
    if (c_ref[f_hand]) begin
      c_ref[f_hand] <= 0;
      f_hand <= (f_hand == 6'd55) ? 6'd0 : f_hand + 1;
    end else begin
      f_line  <= f_hand;
      f_hand  <= (f_hand == 6'd55) ? 6'd0 : f_hand + 1;
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
      f_sarg  <= f_arg;
      if (f_page >= c_pages[8:0] && c_pages < 10'd512)
        f_state <= F_MAP;              // past the end of the ROM: nothing to read
      else begin
        f_cs    <= 1;
        spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_CMD;
      end
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
  F_MAPW:                            // the table write lands
    f_state <= F_IDLE;
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
        ld_addr <= {f_line, 13'd0};
        f_cnt <= 0; f_blk <= 0; f_ci <= 0; f_stop <= 0;
        spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_EVICT;
      end
    end
  default: f_state <= F_IDLE;
  endcase

  if (fwd_feed)
    fwd_feed_wait <= 1;
  else if (fwd_byte_ready)
    fwd_feed_wait <= 0;

  if (ld_done) begin
    ld_pend <= 0;
    ld_addr <= ld_addr + 1;
  end

  if (io_wr) begin
    case (ext_a[7:0])
    8'h00: begin spi_txd <= ext_do; spi_start <= 1; end
    8'h01: begin spi_sel <= ext_do[0]; spi_slow <= ext_do[1]; fwd_discard <= ext_do[2]; end
    8'h02: begin ld_data <= ext_do; ld_pend <= 1; end
    8'h04: start_game <= 1;
    8'h05: led_err    <= ext_do[0];
    8'h06: fwd_lo     <= ext_do;
    8'h07: begin fwd_count <= {ext_do, fwd_lo}; fwd_active <= 1; end
    8'h08: ld_addr[7:0]   <= ext_do;
    8'h09: ld_addr[15:8]  <= ext_do;
    8'h0A: ld_addr[18:16] <= ext_do[2:0];
    8'h0B: rom_size[7:0]  <= ext_do;
    8'h0C: rom_size[11:8] <= ext_do[3:0];
    8'h0D: rom_swap       <= ext_do[0];
    8'h18: lba_page_lo    <= ext_do;
    8'h19: lba_page_hi    <= ext_do[0];
    8'h1A: lba_lo[7:0]    <= ext_do;
    8'h1B: lba_lo[15:8]   <= ext_do;
    8'h1C: lba_lo[23:16]  <= ext_do;
    8'h1D: c_lba[{lba_page_hi, lba_page_lo}] <= {ext_do, lba_lo};
    8'h1E: f_bytes        <= ext_do[0];
    default: ;
    endcase
  end

  if (io_rd_next) begin
    spi_txd   <= 8'hff;
    spi_start <= 1;
  end

  // Forward engine: one byte at a time, each to the SRAM.  The next
  // transfer starts once the SRAM has taken the previous byte.
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

  if (fwd_byte_ready && !fwd_discard) begin
    ld_data <= spi_rx;
    ld_pend <= 1;
  end

  if (g_reset) begin
    spi_sel       <= 0;
    spi_slow      <= 1;
    fwd_discard   <= 0;
    fwd_active    <= 0;
    fwd_feed_wait <= 0;
    ld_pend       <= 0;
    led_err       <= 0;
    rom_size      <= 0;
    rom_swap      <= 0;
  end
end

always @(posedge clk_g) begin
  case (ext_a[7:0])
  8'h00,
  8'h15:   ext_di <= spi_rx;
  8'h01:   ext_di <= {spi_busy || spi_start || fwd_active || fwd_feed || fwd_feed_wait || ld_pend,
                      !sd_cd_n, 6'd0};
  8'h10:   ext_di <= mkey_g;
  default: ext_di <= 8'hff;
  endcase
end

// ---------------------------------------------------------------------------
// SRAM controller (clk_g, 23.4ns).  The pins come from I/O block registers
// (sram_addr and the others drive nothing else), the data is taken into an
// I/O block register (din_r) and used a clock later.  A read takes one
// clock on the bus; a write takes two: the address and data go out at a
// clock edge, WE is low from the falling edge in that clock to the falling
// edge in the next.
//
// The VDC reads its video RAM word for each dot period (4, 6 or 8 clocks,
// VRAM_CE high in the last) in the period's clocks 2 and 3 on the bus, so
// the word is in din_r and vlo in clock 4.  The other clocks (1, and 4 on)
// serve, in order, the VDC's writes (posted at the end of their period,
// two bytes), the CPU's ROM reads and the loader's writes.  A write only
// starts in clock 4 or later, so its second clock is never clock 2.

localparam [18:0] VRAM_BASE = 19'h70000;

reg  [2:0] ph = 3'd4;            // clock of the dot period (4: 4 or later)
wire [2:0] ph_n = vram_ce ? 3'd1 : (ph == 3'd4) ? 3'd4 : ph + 3'd1;

// The pins' registers, each in its I/O block (XST would otherwise merge
// OE with the data pins' output enables, which are always alike).
(* IOB = "TRUE" *) reg [7:0] din_r;
(* IOB = "TRUE", equivalent_register_removal = "no" *) reg [18:0] sa_r;
(* IOB = "TRUE", equivalent_register_removal = "no" *) reg  [7:0] sd_r;
(* IOB = "TRUE", equivalent_register_removal = "no" *) reg  [7:0] sdoe_r = 0;
(* IOB = "TRUE", equivalent_register_removal = "no" *) reg        soe_n_r = 0;
(* IOB = "TRUE", equivalent_register_removal = "no" *) reg        swe_n_r = 1;
always @(posedge clk_g)
  din_r <= sram_din;
assign sram_addr = sa_r;
assign sram_dout = sd_r;
assign sram_doe  = sdoe_r;
assign sram_oe_n = soe_n_r;
assign sram_we_n = swe_n_r;

// VDC writes: one being written, one waiting
reg        vw_pend = 0;
reg [14:0] vw_a;
reg [15:0] vw_d;
reg        vx_act = 0;           // write in progress
reg [14:0] vx_a;
reg [15:0] vx_d;
reg        vx_hi;                // its byte: 0 low, 1 high

// The bus access of the current clock, and of the one before
localparam BUS_IDLE = 3'd0, BUS_VLO = 3'd1, BUS_VHI = 3'd2, BUS_ROM = 3'd3, BUS_WR = 3'd4;
reg  [2:0] bus = BUS_IDLE, bus_d = BUS_IDLE;
reg        wr2 = 0;              // the current clock is a write's second
reg        wr_ld = 0;            // the write is the loader's
reg  [7:0] vlo;
reg [14:0] vr_a;                 // the VDC word being read
reg [21:0] rom_iss_a;            // the ROM byte being read (CPU address)
reg        rom_pend = 0;

wire       vdc_wr_now = vram_we && !vram_a[15];

// A VDC write still has a byte to write after this clock (not when this
// clock ends its high byte), and the loader or the cache has a byte to
// write (not again in the clock its last write ends).
wire       vx_next = vx_act && !(wr2 && !wr_ld && vx_hi);
wire       ld_ok   = ld_pend && !ld_done && !wr2;

// The VDC's word: in the clock after its high byte's, else kept.  A word
// being written, or waiting to be, gives its new data.
always @* begin
  if (bus_d == BUS_VHI) begin
    if (vx_act && vx_a == vr_a)
      vram_di = vx_d;
    else if (vw_pend && vw_a == vr_a)
      vram_di = vw_d;
    else
      vram_di = {din_r, vlo};
  end else
    vram_di = vram_q;
end

assign dbg = {f_state, f_blk, f_byte, ld_pend, c_hit, rom_rd, f_cs, c_page};   // 5+4+9+4+9

// The CPU wants a ROM byte that it has not got, from a page in the SRAM
always @*
  rom_want = !boot_mode && !c_init && rom_rd && !rom_hit && !rom_pend && c_hit;

always @(posedge clk_g) begin
  ph      <= ph_n;
  ld_done <= 0;
  bus_d   <= bus;
  vram_q  <= vram_di;

  // VDC write at the end of its dot period
  if (vdc_wr_now) begin
    vw_pend <= 1;
    vw_a    <= vram_a[14:0];
    vw_d    <= vram_do;
  end

  // Data of the last clock's read, now in din_r
  if (bus_d == BUS_VLO)
    vlo <= din_r;
  if (bus_d == BUS_ROM) begin
    rom_q    <= din_r;
    rom_q_a  <= rom_iss_a;
    rom_q_ok <= 1;
    rom_pend <= 0;
  end

  // A write's second clock
  if (wr2) begin
    wr2 <= 0;
    if (wr_ld)
      ld_done <= 1;
    else if (!vx_hi)
      vx_hi <= 1;
    else
      vx_act <= 0;
  end

  // The next clock's access
  if (wr2 || bus != BUS_WR) begin
    sdoe_r    <= 8'h00;
    soe_n_r   <= 0;
    bus       <= BUS_IDLE;
    if (ph_n == 3'd2 || ph_n == 3'd3) begin
      // the VDC's word, low byte then high byte
      sa_r      <= VRAM_BASE | {vram_a[14:0], ph_n == 3'd3};
      vr_a      <= vram_a[14:0];
      bus       <= (ph_n == 3'd3) ? BUS_VHI : BUS_VLO;
    end else if (ph_n == 3'd4 && (vx_next || vw_pend || ld_ok)) begin
      sdoe_r    <= 8'hff;
      soe_n_r   <= 1;
      bus       <= BUS_WR;
      wr_ld     <= 0;
      if (vx_next) begin
        sa_r      <= VRAM_BASE | {vx_a, wr2 ? 1'b1 : vx_hi};
        sd_r      <= (wr2 || vx_hi) ? vx_d[15:8] : vx_d[7:0];
      end else if (vw_pend) begin
        sa_r      <= VRAM_BASE | {vw_a, 1'b0};
        sd_r      <= vw_d[7:0];
        vx_act    <= 1;
        vx_a      <= vw_a;
        vx_d      <= vw_d;
        vx_hi     <= 0;
        vw_pend   <= vdc_wr_now;
      end else begin
        sa_r      <= ld_addr;
        sd_r      <= ld_data;
        wr_ld     <= 1;
      end
    end else if (rom_want && !wr2) begin   // not right after a write: bus turnaround
      sa_r      <= {c_line, rom_a[12:0]};
      rom_iss_a <= rom_a;
      rom_q_ok  <= 0;
      rom_pend  <= 1;
      bus       <= BUS_ROM;
    end
  end else begin
    wr2 <= 1;                    // keep address and data for the second clock
  end

  if (c_init)
    rom_q_ok <= 0;              // a new game: nothing read yet

  if (g_reset) begin
    vw_pend  <= 0;
    vx_act   <= 0;
    wr2      <= 0;
    rom_pend <= 0;
    bus      <= BUS_IDLE;
  end
end

// WE low from the falling edge in a write's first clock to the one in its
// second
always @(negedge clk_g)
  swe_n_r <= !(bus == BUS_WR && !wr2);

// ---------------------------------------------------------------------------
// Line buffer: 4 lines of 1080 samples (in 2048), written at clk_g, read at
// clk25.  Lines 20-259 go to buffer line (line & 3).

reg [8:0]  linebuf [0:8191];
reg [11:0] sx = 0;
reg        s_odd = 0;
wire       lb_line = (vcnt >= 10'd20) && (vcnt < 10'd260);
wire       lb_in   = (hcnt >= LEFT_CLK) && (hcnt < LEFT_CLK + 12'd2160);

always @(posedge clk_g) begin
  if (!lb_in) begin
    sx    <= 0;
    s_odd <= 0;
  end else begin
    s_odd <= !s_odd;
    if (s_odd)
      sx <= sx + 1;
    if (!s_odd && lb_line)
      linebuf[{vcnt[1:0], sx[10:0]}] <= {video_g, video_r, video_b};
  end
end

// ---------------------------------------------------------------------------
// Video (clk25)

// Sample for each HDMI pixel: x * 1080 / 640 = x * 27 / 16
reg [14:0] sacc = 0;
always @(posedge clk25)
  sacc <= (hc == 10'd799) ? 15'd0 : sacc + 15'd27;

reg [8:0] lb_q;
always @(posedge clk25)
  lb_q <= linebuf[{vc[2:1], sacc[14:4]}];

reg blank_d, hs_d, vs_d;

always @(posedge clk25) begin
  blank_d <= !(hc < 10'd640 && vc < 10'd480);
  hs_d    <= !(hc >= 10'd656 && hc < 10'd752);
  vs_d    <= !(vc >= 10'd490 && vc < 10'd492);

  // 3 bits per colour to 8
  if (!blank_d) begin
    vid_g <= {lb_q[8:6], lb_q[8:6], lb_q[8:7]};
    vid_r <= {lb_q[5:3], lb_q[5:3], lb_q[5:4]};
    vid_b <= {lb_q[2:0], lb_q[2:0], lb_q[2:1]};
  end else
    {vid_r, vid_g, vid_b} <= 24'h000000;
  vid_blank   <= blank_d;
  vid_hsync_n <= hs_d;
  vid_vsync_n <= vs_d;
end

// ---------------------------------------------------------------------------
// Audio, to clk25 once stable for two clocks.

reg [31:0] snd_g = 0;
reg [31:0] snd_m, snd_s;
always @(posedge clk_g)
  snd_g <= boot_mode ? 32'd0 : {psg_l, psg_r};
always @(posedge clk25) begin
  snd_m <= snd_g;
  snd_s <= snd_m;
  if (snd_s == snd_m)
    {audio_l, audio_r} <= snd_s;
end

endmodule
