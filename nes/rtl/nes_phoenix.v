// Phoenix glue for the fpganes NES core.
//
// Everything runs from the Phoenix 25MHz pixel clock:
//
//  - The NES runs from a fractional clock-enable (one PPU dot per enable),
//    slightly faster than one NES frame per HDMI frame.  At the start of the
//    pre-render line the NES waits for the HDMI frame to catch up, so the two
//    stay frame-locked and a small line buffer is enough to double each NES
//    line onto two 640x480 HDMI lines.
//
//  - fpganes multiplexes all memory onto one 8-bit bus with a 22-bit address.
//    PRG and CHR ROM (or CHR RAM) go to the external 512Kx8 SRAM, packed by
//    their power-of-two sizes.  The 2K CPU RAM, 2K VRAM and 8K cartridge RAM
//    are block RAM.
//
//  - At power-on the core is in boot mode: the NES CPU runs a loader from a
//    16K block-RAM ROM (mirrored at $8000 and $C000), using an I/O window at
//    $5000-$50FF to talk to the SD card and feed the ROM file to GameLoader.
//    Writing $5004 leaves boot mode and resets the NES into the game.
//    In boot mode the 8K cartridge RAM doubles as 4K of CHR RAM for the PPU
//    (both pattern tables) and 4K of CPU RAM at $6000-$6FFF.
//
// Boot I/O window (only present in boot mode):
//  $5000 R  SPI received byte
//        W  SPI transfer byte
//  $5001 R  bit7 SPI/forward busy, bit6 card present, bit1 load error, bit0 load done
//        W  bit0 SD select (1 = CS asserted), bit1 slow SPI clock,
//           bit2 forward engine discards the bytes instead
//  $5002 W  byte to the ROM loader
//  $5003 W  reset the ROM loader
//  $5004 W  start the game
//  $5005 W  bit0 error LED
//  $5006 W  forward count, low byte
//  $5007 W  forward count, high byte, and start: clock in that many SPI bytes
//           (sending $FF) and feed each one to the ROM loader

`timescale 1ns / 1ps

module nes_phoenix
  #( parameter BOOTROM_FILE = "nes_boot.hex"
   , parameter PALETTE_FILE = "nes_palette.txt"
   , parameter PIXEL_OFFSET = 9'd0 // PPU cycle of the first visible pixel
   )
   ( input             clk         // 25MHz
   , input             reset       // power-on reset, active high, re-enters boot mode
   , input             game_reset  // reset the NES (game) only, active high

   // Controllers, NES bit order (0=A 1=B 2=Select 3=Start 4=Up 5=Down
   // 6=Left 7=Right), 1 = pressed.
   , input       [7:0] joy1
   , input       [7:0] joy2

   // External SRAM.  The data bus tri-state is done at the top level.
   , output reg [18:0] sram_addr
   , output reg  [7:0] sram_dout
   , input       [7:0] sram_din
   , output reg        sram_doe   // 1 = drive sram_dout onto the bus
   , output reg        sram_we_n
   , output reg        sram_oe_n

   // SD card SPI
   , output            sd_cs_n
   , output            sd_sclk
   , output            sd_mosi
   , input             sd_miso
   , input             sd_cd_n

   // 640x480 video, 25MHz pixel clock
   , output reg  [7:0] vid_r
   , output reg  [7:0] vid_g
   , output reg  [7:0] vid_b
   , output reg        vid_hsync_n
   , output reg        vid_vsync_n
   , output reg        vid_blank

   // Audio, signed
   , output     [15:0] audio

   // Status
   , output reg        boot_mode
   , output reg        led_err
   );

// ---------------------------------------------------------------------------
// Clock enable and frame lock

// 89400 PPU dots per 420000 clocks (one 800x525 HDMI frame).  A NES frame
// is 89342 dots (89341 on odd frames), so the NES finishes each frame a
// little early and waits at the start of the pre-render line.
localparam CE_NUM = 19'd89400;
localparam CE_DEN = 19'd420000;

// HDMI line on which the NES leaves the pre-render wait.  The pre-render
// line takes about two HDMI lines, so NES line 0 starts about four HDMI
// lines before HDMI line 0.
localparam RELEASE_LINE = 10'd519;

// HDMI line on which the NES leaves reset, so that it starts in lock: after
// reset the PPU starts at line 0, which belongs two HDMI lines after the
// pre-render release.
localparam START_LINE = 10'd521;

reg  [18:0] ce_acc = 0;
reg         ce_tick = 0;
wire [19:0] ce_sum = ce_acc + CE_NUM;

always @(posedge clk) begin
  if (ce_sum >= CE_DEN) begin
    ce_acc  <= ce_sum - CE_DEN;
    ce_tick <= 1;
  end else begin
    ce_acc  <= ce_sum[18:0];
    ce_tick <= 0;
  end
end

wire [8:0] cycle;
wire [8:0] scanline;
reg        frame_go = 0;
wire       at_frame_start = (scanline == 9'h1ff) && (cycle == 0);
wire       nes_ce = ce_tick && !(at_frame_start && !frame_go);
wire       hdmi_release;

`ifdef NES_SIM_PROFILE
// Sample the CPU bus address while the boot loader runs.
reg [5:0] prof_div = 0;
always @(posedge clk) begin
  prof_div <= prof_div + 1;
  if (boot_mode && !nes_reset && prof_div == 0 && ext_addr[15])
    $display("PC %04x", ext_addr);
end
`endif

`ifdef NES_SIM_TRACE
always @(posedge clk)
  if (nes_ce && at_frame_start)
    $display("frame start: hdmi line %0d, pixel %0d, waited=%0d", vc, hc, frame_go);
`endif

always @(posedge clk) begin
  if (nes_ce && at_frame_start)
    frame_go <= 0;
  if (hdmi_release)
    frame_go <= 1;
  if (nes_reset)
    frame_go <= 0;
end

// ---------------------------------------------------------------------------
// Boot mode and resets

reg       start_game = 0;  // $5004 write strobe
reg [4:0] nes_rst_cnt = 5'h1f;
reg       nes_rst_hold = 1;
wire      nes_reset = (nes_rst_cnt != 0) || nes_rst_hold;
wire      hdmi_start;

initial boot_mode = 1;

always @(posedge clk) begin
  if (reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (reset || start_game || (game_reset && !boot_mode)) begin
    nes_rst_cnt  <= 5'h1f;
    nes_rst_hold <= 1;
  end else if (nes_rst_cnt != 0)
    nes_rst_cnt  <= nes_rst_cnt - 1;
  else if (hdmi_start)
    nes_rst_hold <= 0;
end

// ---------------------------------------------------------------------------
// ROM loader (iNES parser)

reg         ldr_reset = 1;
reg   [7:0] ldr_data;
reg         ldr_clk = 0;
wire [21:0] ldr_addr;
wire  [7:0] ldr_wdata;
wire        ldr_write;
wire [31:0] ldr_flags;
wire        ldr_done;
wire        ldr_error;

GameLoader loader(clk, ldr_reset, ldr_data, ldr_clk,
                  ldr_addr, ldr_wdata, ldr_write,
                  ldr_flags, ldr_done, ldr_error);

// Boot program: mapper 0, 32K PRG, CHR RAM.
localparam [31:0] BOOT_FLAGS = {16'b0, 1'b1, 1'b0, 3'd0, 3'd1, 8'd0};
wire [31:0] mapper_flags = boot_mode ? BOOT_FLAGS : ldr_flags;

// ---------------------------------------------------------------------------
// NES

wire [15:0] sample;
wire  [5:0] color;
wire        joypad_strobe;
wire  [1:0] joypad_clock;
reg   [7:0] joypad_bits = 0, joypad_bits2 = 0;
reg   [1:0] last_joypad_clock = 0;

wire [21:0] memory_addr;
wire        memory_read_cpu, memory_read_ppu, memory_write;
wire  [7:0] memory_dout;
reg   [7:0] memory_din_cpu = 0, memory_din_ppu = 0;

wire [15:0] ext_addr;
wire  [7:0] ext_dout;
wire        ext_write;
wire        ext_io  = (ext_addr[15:8] == 8'h50);   // boot I/O registers
wire        ext_ram = (ext_addr[15:12] == 4'h6);   // boot CPU RAM
wire        ext_cs  = boot_mode && (ext_io || ext_ram);
reg   [7:0] ext_din;

wire [31:0] dbgadr;
wire  [1:0] dbgctr;

NES nes(clk, nes_reset, nes_ce,
        mapper_flags,
        sample, color,
        joypad_strobe, joypad_clock, {joypad_bits2[0], joypad_bits[0]},
        5'b11111,
        memory_addr,
        memory_read_cpu, memory_din_cpu,
        memory_read_ppu, memory_din_ppu,
        memory_write, memory_dout,
        cycle, scanline,
        dbgadr, dbgctr,
        ext_addr, ext_dout, ext_write, ext_cs, ext_din);

// Unsigned APU output to signed PCM.
assign audio = {~sample[15], sample[14:0]};

// Joypads, as in fpganes's NES_Nexys4.v.
always @(posedge clk) begin
  if (joypad_strobe) begin
    joypad_bits  <= joy1;
    joypad_bits2 <= joy2;
  end
  if (!joypad_clock[0] && last_joypad_clock[0])
    joypad_bits  <= {1'b0, joypad_bits[7:1]};
  if (!joypad_clock[1] && last_joypad_clock[1])
    joypad_bits2 <= {1'b0, joypad_bits2[7:1]};
  last_joypad_clock <= joypad_clock;
end

// ---------------------------------------------------------------------------
// Memory

// fpganes address map (22 bits):
//   0.....  PRG ROM          10....  CHR ROM / CHR RAM
//   1100..  VRAM (2K)        1110..  CPU RAM (2K)
//   1111..  cartridge RAM    01....  MMC5 PRG RAM
// TQROM CHR RAM (1111111...) shares the cartridge RAM here.

localparam SRC_SRAM = 3'd0, SRC_VRAM = 3'd1, SRC_CPURAM = 3'd2,
           SRC_CARTRAM = 3'd3, SRC_BOOTROM = 3'd4;

function [2:0] mem_src(input [21:0] a, input boot);
  if (a[21:18] == 4'b1100)                           mem_src = SRC_VRAM;
  else if (a[21:18] == 4'b1110)                      mem_src = SRC_CPURAM;
  else if (a[21:18] == 4'b1111 || a[21:20] == 2'b01) mem_src = SRC_CARTRAM;
  else if (boot && a[21:20] == 2'b10)                mem_src = SRC_CARTRAM; // boot CHR RAM
  else if (boot && a[21] == 1'b0)                    mem_src = SRC_BOOTROM;
  else                                               mem_src = SRC_SRAM;
endfunction

// Pack PRG and CHR into the SRAM.  Both sizes are powers of two, so the
// larger one goes first and the smaller one is ORed in after it.
wire  [4:0] prg_log2 = 5'd14 + ldr_flags[10:8];   // 16K << prg_size
wire  [4:0] chr_log2 = 5'd13 + ldr_flags[13:11];  //  8K << chr_size
wire [19:0] prg_len  = 20'd1 << prg_log2;
wire [19:0] chr_len  = 20'd1 << chr_log2;
wire        prg_first = (prg_log2 >= chr_log2);

function [18:0] sram_map(input [21:0] a, input [19:0] plen, input [19:0] clen, input pfirst);
  reg [19:0] r;
  begin
    if (a[21] == 1'b0)  // PRG
      r = (a[19:0] & (plen - 1)) | (pfirst ? 20'd0 : clen);
    else                // CHR
      r = (a[19:0] & (clen - 1)) | (pfirst ? plen : 20'd0);
    sram_map = r[18:0];
  end
endfunction

reg       mem_slot = 0;  // the clock after a NES clock-enable
reg [2:0] src_q;
reg       rd_cpu_q = 0, rd_ppu_q = 0;
reg       pend_cpu = 0, pend_ppu = 0;
reg [7:0] hold_cpu, hold_ppu;
reg [1:0] wr_state = 0;

wire [2:0] src = mem_src(memory_addr, boot_mode);
wire       nes_rd = mem_slot && (memory_read_cpu || memory_read_ppu);
wire       nes_wr = mem_slot && memory_write;

// Block RAMs
reg [7:0] vram    [0:2047];
reg [7:0] cpuram  [0:2047];
reg [7:0] cartram [0:8191];
reg [7:0] bootrom [0:16383];
reg [7:0] vram_q, cpuram_q, cartram_q, bootrom_q;

initial $readmemh(BOOTROM_FILE, bootrom);

always @(posedge clk) begin
  if (nes_wr && src == SRC_VRAM) vram[memory_addr[10:0]] <= memory_dout;
  vram_q <= vram[memory_addr[10:0]];
end

always @(posedge clk) begin
  if (nes_wr && src == SRC_CPURAM) cpuram[memory_addr[10:0]] <= memory_dout;
  cpuram_q <= cpuram[memory_addr[10:0]];
end

// Cartridge RAM, dual port.  Port A is the NES memory bus; in boot mode
// CHR accesses use the lower 4K.  Port B is the boot CPU RAM at $6000, in
// the upper 4K.
wire [12:0] cartram_a = (boot_mode && memory_addr[21:20] == 2'b10) ?
                        {1'b0, memory_addr[11:0]} : memory_addr[12:0];
reg   [7:0] cartram_qb;

always @(posedge clk) begin
  if (nes_wr && src == SRC_CARTRAM) cartram[cartram_a] <= memory_dout;
  cartram_q <= cartram[cartram_a];
end

always @(posedge clk) begin
  if (ext_write && ext_ram) cartram[{1'b1, ext_addr[11:0]}] <= ext_dout;
  cartram_qb <= cartram[{1'b1, ext_addr[11:0]}];
end

always @(posedge clk)
  bootrom_q <= bootrom[memory_addr[13:0]];

wire [7:0] rdata = (src_q == SRC_VRAM)    ? vram_q    :
                   (src_q == SRC_CPURAM)  ? cpuram_q  :
                   (src_q == SRC_CARTRAM) ? cartram_q :
                   (src_q == SRC_BOOTROM) ? bootrom_q :
                                            sram_din;

// In boot mode the SRAM belongs to the ROM loader.
wire sram_nes   = !boot_mode && src == SRC_SRAM;
wire sram_write = boot_mode ? ldr_write : (nes_wr && sram_nes);

always @(posedge clk) begin
  mem_slot <= nes_ce;

  // Read: the address goes out at the end of the slot, the data is
  // captured one clock later and handed to the NES on its next enable,
  // the same latency as the original PSRAM controller.
  rd_cpu_q <= nes_rd && memory_read_cpu;
  rd_ppu_q <= nes_rd && memory_read_ppu;
  if (mem_slot)
    src_q <= src;
  if (rd_cpu_q) hold_cpu <= rdata;
  if (rd_ppu_q) hold_ppu <= rdata;

  if (nes_ce) begin
    if (pend_cpu) memory_din_cpu <= hold_cpu;
    if (pend_ppu) memory_din_ppu <= hold_ppu;
    pend_cpu <= 0;
    pend_ppu <= 0;
  end
  if (nes_rd && memory_read_cpu) pend_cpu <= 1;
  if (nes_rd && memory_read_ppu) pend_ppu <= 1;

  // SRAM: reads take the address for one clock; writes take four clocks
  // (address and data, WE low, WE high, release the bus).
  case (wr_state)
  2'd0: begin
      sram_we_n <= 1;
      if (sram_write) begin
        sram_addr <= sram_map(boot_mode ? ldr_addr : memory_addr, prg_len, chr_len, prg_first);
        sram_dout <= boot_mode ? ldr_wdata : memory_dout;
        sram_doe  <= 1;
        sram_oe_n <= 1;
        wr_state  <= 2'd1;
      end else begin
        if (nes_rd && sram_nes)
          sram_addr <= sram_map(memory_addr, prg_len, chr_len, prg_first);
        sram_doe  <= 0;
        sram_oe_n <= 0;
      end
    end
  2'd1: begin sram_we_n <= 0; wr_state <= 2'd2; end
  2'd2: begin sram_we_n <= 1; wr_state <= 2'd3; end
  2'd3: begin sram_doe  <= 0; wr_state <= 2'd0; end
  endcase

  if (reset) begin
    wr_state  <= 0;
    sram_we_n <= 1;
    sram_doe  <= 0;
  end
end

// ---------------------------------------------------------------------------
// Boot I/O: SD card SPI, forward engine, loader control

reg        spi_sel = 0;
reg        spi_slow = 1;
reg        spi_busy = 0;
reg  [7:0] spi_tx = 8'hff, spi_rx = 8'hff;
reg  [7:0] spi_txd;          // byte for the next transfer
reg  [2:0] spi_bit;
reg  [5:0] spi_div = 0;
reg        spi_sclk_r = 0;
reg        spi_start = 0;
reg [15:0] fwd_count = 0;
reg  [7:0] fwd_lo;
reg        fwd_active = 0;
reg        fwd_discard = 0;    // forward engine just skips bytes
reg        fwd_feed = 0;       // the transfer just started belongs to the forward engine
reg        fwd_feed_wait = 0;  // waiting for that transfer to finish

assign sd_cs_n = !spi_sel;
assign sd_sclk = spi_sclk_r;
assign sd_mosi = spi_tx[7];

// One SPI half-period: 1 clock fast (12.5MHz SCLK), 32 clocks slow (~390kHz).
wire spi_tick = spi_slow ? (spi_div == 6'd31) : 1'b1;

// SPI mode 0 byte engine.
always @(posedge clk) begin
  spi_div <= spi_tick ? 6'd0 : spi_div + 1;

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

  if (reset) begin
    spi_busy   <= 0;
    spi_sclk_r <= 0;
    spi_tx     <= 8'hff;
  end
end

// The forward engine's byte is ready when its transfer finishes.
wire fwd_byte_ready = fwd_feed_wait && !spi_busy;

always @(posedge clk) begin
  spi_start  <= 0;
  start_game <= 0;
  ldr_clk    <= 0;
  ldr_reset  <= 0;
  fwd_feed   <= 0;

  if (fwd_feed)
    fwd_feed_wait <= 1;
  else if (fwd_byte_ready)
    fwd_feed_wait <= 0;

  if (ext_write && ext_io) begin
    case (ext_addr[7:0])
    8'h00: begin spi_txd <= ext_dout; spi_start <= 1; end
    8'h01: begin spi_sel <= ext_dout[0]; spi_slow <= ext_dout[1]; fwd_discard <= ext_dout[2]; end
    8'h02: begin ldr_data <= ext_dout; ldr_clk <= 1; end
    8'h03: ldr_reset  <= 1;
    8'h04: start_game <= 1;
    8'h05: led_err    <= ext_dout[0];
    8'h06: fwd_lo     <= ext_dout;
    8'h07: begin fwd_count <= {ext_dout, fwd_lo}; fwd_active <= 1; end
    default: ;
    endcase
  end

  // Forward engine: clock in one byte at a time and feed it to the loader.
  if (fwd_active && !spi_busy && !spi_start && !fwd_feed && !fwd_feed_wait) begin
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
    ldr_data <= spi_rx;
    ldr_clk  <= 1;
  end

  if (reset) begin
    spi_sel       <= 0;
    spi_slow      <= 1;
    fwd_discard   <= 0;
    fwd_active    <= 0;
    fwd_feed_wait <= 0;
    ldr_reset     <= 1;
    led_err       <= 0;
  end
end

always @* begin
  if (ext_ram)
    ext_din = cartram_qb;
  else case (ext_addr[7:0])
  8'h00:   ext_din = spi_rx;
  8'h01:   ext_din = {spi_busy || spi_start || fwd_active || fwd_feed || fwd_feed_wait,
                      !sd_cd_n, 4'b0, ldr_error, ldr_done};
  default: ext_din = 8'hff;
  endcase
end

// ---------------------------------------------------------------------------
// Video: 640x480, NES 256x240 doubled to 512x480 and centered.

reg [9:0] hc = 0, vc = 0;

always @(posedge clk) begin
  if (hc == 10'd799) begin
    hc <= 0;
    vc <= (vc == 10'd524) ? 10'd0 : vc + 1;
  end else
    hc <= hc + 1;
end

assign hdmi_release = (vc == RELEASE_LINE) && (hc == 0);
assign hdmi_start   = (vc == START_LINE)   && (hc == 0);

// Four NES lines of 256 pixels.
reg  [5:0] linebuf [0:1023];
wire [8:0] pix_x  = cycle - PIXEL_OFFSET;
wire       pix_we = nes_ce && (scanline < 9'd240) && (pix_x < 9'd256);

always @(posedge clk)
  if (pix_we)
    linebuf[{scanline[1:0], pix_x[7:0]}] <= color;

reg [14:0] palette [0:63];
initial $readmemh(PALETTE_FILE, palette);

wire       in_pic = (hc >= 10'd64) && (hc < 10'd576) && (vc < 10'd480);
wire [9:0] pic_x  = hc - 10'd64;
reg  [5:0] lb_q;
reg [14:0] rgb15;
reg  [2:0] in_pic_d, blank_d, hs_d, vs_d;

always @(posedge clk) begin
  // stage 1: line buffer
  lb_q <= linebuf[{vc[2:1], pic_x[8:1]}];
  // stage 2: palette
  rgb15 <= palette[lb_q];

  in_pic_d <= {in_pic_d[1:0], in_pic};
  blank_d  <= {blank_d[1:0], !(hc < 10'd640 && vc < 10'd480)};
  hs_d     <= {hs_d[1:0], !(hc >= 10'd656 && hc < 10'd752)};
  vs_d     <= {vs_d[1:0], !(vc >= 10'd490 && vc < 10'd492)};

  // stage 3: output
  if (in_pic_d[1]) begin
    vid_r <= {rgb15[4:0],   rgb15[4:2]};
    vid_g <= {rgb15[9:5],   rgb15[9:7]};
    vid_b <= {rgb15[14:10], rgb15[14:12]};
  end else begin
    vid_r <= 0;
    vid_g <= 0;
    vid_b <= 0;
  end
  vid_blank   <= blank_d[1];
  vid_hsync_n <= hs_d[1];
  vid_vsync_n <= vs_d[1];
end

endmodule
