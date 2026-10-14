// Dragon's Lair / Space Ace laserdisc board for the Phoenix.
//
// Everything runs from the 25MHz pixel clock.
//
//  - Z80 at 4MHz (tv80, a clock enable 4 times in 25 clocks), AY-3-8910 at
//    2MHz (jt49), IRQ at 16MHz / 8 / 65536 = 30.52Hz held until
//    acknowledged, as in MAME and Daphne.
//
//  - The game ROM (up to 40K, 0000-9FFF) is in the external SRAM at
//    0x70000, loaded by the boot loader.  The Z80 has priority on the SRAM;
//    a read is served in at most 4 clocks, well inside one T-state.  The
//    rest of the SRAM holds 8 disc frame slots of 0xC000 bytes.  RAM
//    (A000-A7FF, mirrored to BFFF) is block RAM.
//
//  - The laserdisc is an LD-V1000 (ldv1000.v) playing frames that
//    sd_stream.v reads from a disc file on the SD card.  video.v shows
//    them, disc_audio.v plays their audio.
//
// Game mode memory map (U.S. board, from MAME, mirrors included):
//   0000-9FFF R  ROM
//   A000-BFFF RW RAM (2K)
//   C000      R  AY data (DIP switches: reg 14 = DSW A, reg 15 = DSW B)
//   C008      R  controls, active low: b0 up b1 down b2 left b3 right
//                b4 sword/fire, b5-b7 Space Ace skill buttons
//   C010      R  b0 START1 b1 START2 b2 COIN1 b3 COIN2 (active low),
//                b6 LD status strobe, b7 LD command strobe
//   C020      R  LD status
//   E000      W  AY data          E010  W  AY address
//   E008      W  misc (coin counter, LD bus control; ignored)
//   E020      W  LD command
//   E030-E03F W  LED digits
//
// Boot mode (after power-on, or reset held): the Z80 runs the loader from
// a 24K block RAM at 0000-5FFF (initialized with the loader, and writable,
// so it also holds the loader's buffers), with the same RAM, and these
// registers:
//   C000 R SPI received byte        W SPI transfer byte (starts it)
//   C001 R b7 SPI busy, b6 card present
//        W b0 SD select, b2:1 SPI speed (0 ~390kHz, 1 12.5MHz, 2 25MHz)
//   C002 W SRAM address 7:0   C003 W 15:8   C004 W 18:16
//   C002 R b0 SRAM write pending
//   C003 R b0 vertical blank
//   C005 W SRAM data: write it, then address + 1
//   C006 R controls (as C008)   C007 R C010 bits 3:0
//   C008-C00B W disc base sector (little-endian)
//   C00C W b0 SDHC (block addressing)
//   C00D-C00E W last frame on the disc
//   C00F W DSW A   C010 W DSW B
//   C011 W b0 error LED
//   C01F W start the game
//   C020-C023 W FAT checker: the FAT sector holding the first entry
//   C024      W   the entry's index in that sector
//   C025      W   b0 FAT16 (2-byte entries)
//   C026-C029 W   the value the first entry must hold (first cluster + 1)
//   C02A-C02D W   the number of entries to check
//   C02E      W   start (SDHC flag C00C must be set first)
//   C020      R   b7 busy, b1 the run is broken, b0 the card did not answer
//   D000-D7FF W overlay text (40 x 30, row-major); kept in game mode
//   I/O read, any port: the SPI received byte, and start the next transfer
//                (sending 0xFF), for INIR block reads
//   I/O write, any port: SRAM data, as C005 (for OTIR)

`timescale 1ns / 1ps

module dl_phoenix
  #( parameter BOOTROM_FILE = "dl_boot.hex"
   , parameter FONT_FILE    = "font.hex"
   )
   ( input             clk          // 25MHz
   , input             reset        // power-on reset, re-enters boot mode
   , input             game_reset   // reset the game only

   // Controls, 1 = pressed
   , input       [7:0] joy          // b0 up b1 down b2 left b3 right b4 fire, b5-b7 skill
   , input       [3:0] sys          // b0 start1 b1 start2 b2 coin1 b3 coin2
   , input             ov_toggle    // pulse: show/hide the scoreboard

   // External SRAM
   , output reg [18:0] sram_addr = 0
   , output reg  [7:0] sram_dout = 0
   , input       [7:0] sram_din
   , output reg        sram_doe = 0
   , output reg        sram_we_n = 1
   , output reg        sram_oe_n = 1

   // SD card
   , output            sd_cs_n
   , output            sd_sclk_lvl
   , output            sd_sclk_pulse
   , output            sd_mosi
   , input             sd_miso
   , input             sd_cd_n

   // 640x480 video
   , output      [7:0] vid_r
   , output      [7:0] vid_g
   , output      [7:0] vid_b
   , output            vid_hsync_n
   , output            vid_vsync_n
   , output            vid_blank

   // Audio
   , output reg [15:0] audio_l = 0
   , output reg [15:0] audio_r = 0

   , output reg        boot_mode = 1
   , output reg        led_err = 0
   );

// ---------------------------------------------------------------------------
// Clock enables and IRQ

reg [4:0] z_acc = 0;
reg       z_cen = 0;
reg [4:0] ay_acc = 0;
reg       ay_cen = 0;

always @(posedge clk) begin
  if (z_acc + 5'd4 >= 5'd25) begin z_acc <= z_acc + 5'd4 - 5'd25; z_cen <= 1; end
  else begin z_acc <= z_acc + 5'd4; z_cen <= 0; end
  if (ay_acc + 5'd2 >= 5'd25) begin ay_acc <= ay_acc + 5'd2 - 5'd25; ay_cen <= 1; end
  else begin ay_acc <= ay_acc + 5'd2; ay_cen <= 0; end
end

// ---------------------------------------------------------------------------
// Resets

reg       start_game = 0;
reg [4:0] z_rst_cnt = 5'h1f;
wire      z_reset = (z_rst_cnt != 0);

always @(posedge clk) begin
  if (reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (reset || start_game || (game_reset && !boot_mode))
    z_rst_cnt <= 5'h1f;
  else if (z_rst_cnt != 0 && z_cen)
    z_rst_cnt <= z_rst_cnt - 1;
end

wire game_mode = !boot_mode;

// ---------------------------------------------------------------------------
// Z80

wire [15:0] A;
wire  [7:0] z_dout;
wire        m1_n, mreq_n, iorq_n, rd_n, wr_n, rfsh_n, halt_n, busak_n;
reg   [7:0] z_din;
reg         int_n = 1;

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) cpu
  ( .m1_n(m1_n), .mreq_n(mreq_n), .iorq_n(iorq_n), .rd_n(rd_n), .wr_n(wr_n)
  , .rfsh_n(rfsh_n), .halt_n(halt_n), .busak_n(busak_n), .A(A), .dout(z_dout)
  , .reset_n(!z_reset), .clk(clk), .cen(z_cen), .wait_n(1'b1), .int_n(int_n)
  , .nmi_n(1'b1), .busrq_n(1'b1), .di(z_din)
  );

// IRQ: 819200 clocks = 32.768ms
reg [19:0] irq_cnt = 0;

always @(posedge clk) begin
  if (irq_cnt == 20'd819199) begin
    irq_cnt <= 0;
    if (game_mode) int_n <= 0;
  end else
    irq_cnt <= irq_cnt + 1;
  if (!m1_n && !iorq_n)
    int_n <= 1;
  if (z_reset || boot_mode)
    int_n <= 1;
end

// Bus decode
wire mem_rd = !mreq_n && !rd_n;
reg  wr_n_d = 1;
wire wr_stb = !mreq_n && !wr_n && wr_n_d && !z_reset;   // one clock per write cycle

always @(posedge clk)
  wr_n_d <= wr_n;

wire a_rom  = (A < 16'hA000);
wire a_ram  = (A[15:13] == 3'b101);
wire a_in   = (A[15:13] == 3'b110);          // C000-DFFF
wire a_out  = (A[15:13] == 3'b111);          // E000-FFFF
wire [2:0] port = A[5:3];

// ---------------------------------------------------------------------------
// Memories

reg  [7:0] ram [0:2047];
reg  [7:0] ram_q;
reg  [7:0] bootrom [0:24575];
reg  [7:0] bootrom_q;
initial $readmemh(BOOTROM_FILE, bootrom);
wire       a_boot = (A < 16'h6000);

always @(posedge clk) begin
  if (wr_stb && a_ram)
    ram[A[10:0]] <= z_dout;
  ram_q <= ram[A[10:0]];
end

always @(posedge clk) begin
  if (wr_stb && boot_mode && a_boot)
    bootrom[A[14:0]] <= z_dout;
  bootrom_q <= bootrom[A[14:0]];
end

// ---------------------------------------------------------------------------
// SRAM arbiter
//
// Priority: Z80 ROM read / boot loader write, video, disc audio, SD writes.
// A read puts the address out for one clock and the data is captured on
// the next; a write takes three clocks (address and data, WE low, WE high).

reg        z_done = 0;             // this Z80 read cycle has been served
reg  [7:0] rom_q = 8'hff;
wire       z_req = game_mode && mem_rd && a_rom && !z_done;

reg        b_pend = 0;
reg [18:0] b_addr = 0;
reg  [7:0] b_data;

wire        v_req, a_req, s_req;
wire [18:0] v_addr, a_addr, s_addr;
wire  [7:0] s_data;

localparam G_NONE = 3'd0, G_Z = 3'd1, G_B = 3'd2, G_V = 3'd3, G_A = 3'd4, G_S = 3'd5;

reg  [1:0] wst = 0;
reg  [2:0] rtag = G_NONE;          // read issued last clock
reg  [2:0] vtag = G_NONE;          // read captured last clock
reg  [7:0] rdata;

wire [2:0] grant = (wst != 0) ? G_NONE :
                   z_req  ? G_Z :
                   b_pend ? G_B :
                   v_req  ? G_V :
                   a_req  ? G_A :
                   s_req  ? G_S : G_NONE;

wire v_ack = (grant == G_V);
wire a_ack = (grant == G_A);
wire s_ack = (grant == G_S);

always @(posedge clk) begin
  rtag  <= G_NONE;
  vtag  <= rtag;
  rdata <= sram_din;
  if (rtag == G_Z)
    rom_q <= sram_din;

  case (wst)
  2'd0: begin
      sram_we_n <= 1;
      case (grant)
      G_Z, G_V, G_A: begin
          sram_addr <= (grant == G_Z) ? {3'b111, A} :
                       (grant == G_V) ? v_addr : a_addr;
          sram_doe  <= 0;
          sram_oe_n <= 0;
          rtag      <= grant;
        end
      G_B, G_S: begin
          sram_addr <= (grant == G_B) ? b_addr : s_addr;
          sram_dout <= (grant == G_B) ? b_data : s_data;
          sram_doe  <= 1;
          sram_oe_n <= 1;
          wst       <= 2'd1;
        end
      default: begin
          sram_doe  <= 0;
          sram_oe_n <= 0;
        end
      endcase
    end
  2'd1: begin sram_we_n <= 0; wst <= 2'd2; end
  default: begin sram_we_n <= 1; wst <= 2'd0; end
  endcase

  if (grant == G_Z)
    z_done <= 1;
  if (rd_n)
    z_done <= 0;

  if (reset) begin
    wst       <= 0;
    sram_we_n <= 1;
    sram_doe  <= 0;
  end
end

`ifdef DL_SIM_LED
always @(posedge clk)
  if (wr_stb && game_mode && a_out && (port == 3'd6 || port == 3'd7))
    $display("LED %04x <- %02x t=%0t", A, z_dout, $time);
`endif

`ifdef DL_SIM_AY
always @(posedge clk)
  if (ay_wr) $display("AY r%0d <- %02x t=%0t", ay_addr, ay_din, $time);
`endif

`ifdef DL_SIM_PC
reg m1_d = 1;
always @(posedge clk) begin
  m1_d <= m1_n;
  if (!m1_n && m1_d) $display("PC %04x boot=%0d t=%0t", A, boot_mode, $time);
  if (wr_stb) $display("  W %04x <- %02x", A, z_dout);
end
`endif

`ifdef DL_SIM_CHECK
// The Z80 latches read data on the enabled clock that ends T2; ROM data
// must have arrived by then.
reg [3:0] z_wait = 0;
always @(posedge clk) begin
  if (z_req) z_wait <= z_wait + 1;
  else if (!mem_rd) z_wait <= 0;
  if (z_req && z_wait > 4'd4)
    $display("WARNING: Z80 ROM read waited %0d clocks at %04x", z_wait, A);
end
`endif

// ---------------------------------------------------------------------------
// AY-3-8910

reg  [3:0] ay_addr = 0;
reg        ay_wr = 0;
reg  [7:0] ay_din = 0;
wire [7:0] ay_dout;
wire [9:0] ay_sound;
reg  [7:0] dsw_a = 8'h00, dsw_b = 8'h00;

jt49 #(.CLKDIV(3)) ay
  ( .rst_n(!z_reset), .clk(clk), .clk_en(ay_cen), .addr(ay_addr)
  , .cs_n(!ay_wr), .wr_n(!ay_wr), .din(ay_din), .sel(1'b1), .dout(ay_dout)
  , .sound(ay_sound), .A(), .B(), .C(), .sample()
  , .IOA_in(dsw_a), .IOA_out(), .IOA_oe(), .IOB_in(dsw_b), .IOB_out(), .IOB_oe()
  );

// ---------------------------------------------------------------------------
// I/O

wire  [9:0] vcount;
wire        vblank = (vcount >= 10'd480);
reg  [63:0] leds = {16{4'hF}};
reg         ov_show = 1;

wire        ld_wr = game_mode && wr_stb && a_out && port == 3'd4;
wire  [7:0] ld_status;
wire        ld_sstb, ld_cstb;
wire [15:0] ld_frame;
wire        ld_playing, ld_frame_tick, ld_field_tick, ld_audio1, ld_audio2;
wire        ld_seek;
wire [15:0] ld_seek_frame;
wire [15:0] v_lo, v_hi;
reg  [15:0] max_frame = 16'd0;

wire  [7:0] c008 = ~joy;
wire  [7:0] c010 = {ld_cstb, ld_sstb, 2'b11, ~sys};

// Boot loader registers
reg         spi_start = 0;
reg   [7:0] spi_tx = 8'hff;
reg         spi_cs = 0;
reg   [1:0] spi_speed = 0;
wire  [7:0] spi_rx;
wire        spi_busy;
reg  [31:0] base_lba = 0;
reg         chk_start = 0;
reg  [31:0] chk_sector = 0, chk_expect = 0, chk_count = 0;
reg   [7:0] chk_index = 0;
reg         chk_fat16 = 0;
wire        chk_busy, chk_bad, chk_err;
reg         sdhc = 0;
reg         ov_we = 0;
reg  [10:0] ov_addr;
reg   [7:0] ov_data;

wire  [7:0] boot_io =
  (A[5:0] == 6'h00) ? spi_rx :
  (A[5:0] == 6'h01) ? {spi_busy, !sd_cd_n, 6'd0} :
  (A[5:0] == 6'h02) ? {7'd0, b_pend} :
  (A[5:0] == 6'h03) ? {7'd0, vblank} :
  (A[5:0] == 6'h06) ? c008 :
  (A[5:0] == 6'h07) ? {4'hF, ~sys} :
  (A[5:0] == 6'h20) ? {chk_busy, 5'd0, chk_bad, chk_err} : 8'hff;

wire  [7:0] game_io =
  (port == 3'd0) ? ay_dout :
  (port == 3'd1) ? c008 :
  (port == 3'd2) ? c010 :
  (port == 3'd4) ? ld_status : 8'hff;

// Boot mode I/O read: one strobe per IN cycle
reg  io_rd_d = 0;
reg  [7:0] io_q = 8'hff;     // frozen during the cycle: the new transfer may end first
wire io_rd = boot_mode && !iorq_n && !rd_n && m1_n;
wire io_rd_stb = io_rd && !io_rd_d;

reg  io_wr_d = 0;
wire io_wr = boot_mode && !iorq_n && !wr_n;
wire io_wr_stb = io_wr && !io_wr_d;

always @(posedge clk) begin
  io_wr_d <= io_wr;
  io_rd_d <= io_rd;
  if (!io_rd)
    io_q <= spi_rx;
end

always @* begin
  if (io_rd)
    z_din = io_rd_stb ? spi_rx : io_q;
  else if (boot_mode && a_boot)
    z_din = bootrom_q;
  else if (a_rom)
    z_din = boot_mode ? 8'hff : rom_q;
  else if (a_ram)
    z_din = ram_q;
  else if (a_in)
    z_din = boot_mode ? boot_io : game_io;
  else
    z_din = 8'hff;
end

always @(posedge clk) begin
  spi_start  <= 0;
  chk_start  <= 0;
  start_game <= 0;
  ay_wr      <= 0;
  ov_we      <= 0;

  if (grant == G_B) begin
    b_pend <= 0;
    b_addr <= b_addr + 1;
  end

  if (ov_toggle)
    ov_show <= !ov_show;

  if (io_rd_stb) begin
    spi_tx    <= 8'hff;
    spi_start <= 1;
  end

  if (io_wr_stb) begin
    b_data <= z_dout;
    b_pend <= 1;
  end

  if (wr_stb && boot_mode) begin
    if (A[15:8] == 8'hC0) begin
      case (A[5:0])
      6'h00: begin spi_tx <= z_dout; spi_start <= 1; end
      6'h01: begin spi_cs <= z_dout[0]; spi_speed <= z_dout[2:1]; end
      6'h02: b_addr[7:0]   <= z_dout;
      6'h03: b_addr[15:8]  <= z_dout;
      6'h04: b_addr[18:16] <= z_dout[2:0];
      6'h05: begin b_data <= z_dout; b_pend <= 1; end
      6'h08: base_lba[7:0]   <= z_dout;
      6'h09: base_lba[15:8]  <= z_dout;
      6'h0A: base_lba[23:16] <= z_dout;
      6'h0B: base_lba[31:24] <= z_dout;
      6'h0C: sdhc <= z_dout[0];
      6'h0D: max_frame[7:0]  <= z_dout;
      6'h0E: max_frame[15:8] <= z_dout;
      6'h0F: dsw_a <= z_dout;
      6'h10: dsw_b <= z_dout;
      6'h11: led_err <= z_dout[0];
      6'h1F: start_game <= 1;
      6'h20: chk_sector[7:0]   <= z_dout;
      6'h21: chk_sector[15:8]  <= z_dout;
      6'h22: chk_sector[23:16] <= z_dout;
      6'h23: chk_sector[31:24] <= z_dout;
      6'h24: chk_index  <= z_dout;
      6'h25: chk_fat16  <= z_dout[0];
      6'h26: chk_expect[7:0]   <= z_dout;
      6'h27: chk_expect[15:8]  <= z_dout;
      6'h28: chk_expect[23:16] <= z_dout;
      6'h29: chk_expect[31:24] <= z_dout;
      6'h2A: chk_count[7:0]    <= z_dout;
      6'h2B: chk_count[15:8]   <= z_dout;
      6'h2C: chk_count[23:16]  <= z_dout;
      6'h2D: chk_count[31:24]  <= z_dout;
      6'h2E: chk_start  <= 1;
      default: ;
      endcase
    end else if (A[15:11] == 5'b11010) begin     // D000-D7FF
      ov_we   <= 1;
      ov_addr <= A[10:0];
      ov_data <= z_dout;
    end
  end

  if (wr_stb && game_mode && a_out) begin
    case (port)
    3'd0: begin ay_din <= z_dout; ay_wr <= 1; end
    3'd2: ay_addr <= z_dout[3:0];
    3'd6, 3'd7: leds[{A[3:0], 2'b00} +: 4] <= z_dout[3:0];
    default: ;
    endcase
  end

  if (reset) begin
    spi_cs    <= 0;
    spi_speed <= 0;
    led_err   <= 0;
    b_pend    <= 0;
    ov_show   <= 1;
    leds      <= {16{4'hF}};
  end
end

// ---------------------------------------------------------------------------
// Laserdisc

ldv1000 ld
  ( .clk(clk), .reset(z_reset || boot_mode)
  , .cmd_wr(ld_wr), .cmd(z_dout), .status(ld_status)
  , .status_strobe(ld_sstb), .command_strobe(ld_cstb)
  , .max_frame(max_frame), .frame(ld_frame), .playing(ld_playing)
  , .field_tick(ld_field_tick), .frame_tick(ld_frame_tick)
  , .seek(ld_seek), .seek_frame(ld_seek_frame), .v_lo(v_lo), .v_hi(v_hi)
  , .audio1(ld_audio1), .audio2(ld_audio2)
  );

reg miso_fall = 1;
always @(negedge clk)
  miso_fall <= sd_miso;

wire str_err;

sd_stream sd
  ( .clk(clk), .reset(reset)
  , .cpu_own(boot_mode), .cpu_start(spi_start), .cpu_tx(spi_tx), .cpu_cs(spi_cs)
  , .cpu_speed(spi_speed), .rx(spi_rx), .busy(spi_busy)
  , .chk_start(chk_start), .chk_sector(chk_sector), .chk_index(chk_index)
  , .chk_fat16(chk_fat16), .chk_expect(chk_expect), .chk_count(chk_count)
  , .chk_busy(chk_busy), .chk_bad(chk_bad), .chk_err(chk_err)
  , .base_lba(base_lba), .sdhc(sdhc), .seek(ld_seek), .seek_frame(ld_seek_frame)
  , .cur_frame(ld_frame), .v_lo(v_lo), .v_hi(v_hi), .str_err(str_err), .streaming()
  , .wr_req(s_req), .wr_addr(s_addr), .wr_data(s_data), .wr_ack(s_ack)
  , .sd_cs_n(sd_cs_n), .sclk_lvl(sd_sclk_lvl), .sclk_pulse(sd_sclk_pulse)
  , .sd_mosi(sd_mosi), .sd_miso(sd_miso), .miso_fall(miso_fall)
  );

// ---------------------------------------------------------------------------
// Video and audio

wire v_rvalid = (vtag == G_V);
wire a_rvalid = (vtag == G_A);
wire video_req;
wire audio_req;

assign v_req = video_req;
assign a_req = audio_req;

video #(.FONT_FILE(FONT_FILE)) vid
  ( .clk(clk), .reset(reset)
  , .game_mode(game_mode), .want_frame(ld_frame), .v_lo(v_lo), .v_hi(v_hi)
  , .disp_valid(), .disp_frame()
  , .rd_req(video_req), .rd_addr(v_addr), .rd_ack(v_ack), .rd_valid(v_rvalid), .rd_data(rdata)
  , .ov_we(ov_we), .ov_addr(ov_addr), .ov_data(ov_data), .ov_show(ov_show), .leds(leds)
  , .hcount(), .vcount(vcount)
  , .vid_r(vid_r), .vid_g(vid_g), .vid_b(vid_b)
  , .vid_hsync_n(vid_hsync_n), .vid_vsync_n(vid_vsync_n), .vid_blank(vid_blank)
  );

wire signed [15:0] disc_l, disc_r;

disc_audio dau
  ( .clk(clk), .reset(z_reset || boot_mode)
  , .frame_tick(ld_frame_tick), .frame(ld_frame), .playing(ld_playing)
  , .audio1(ld_audio1), .audio2(ld_audio2), .v_lo(v_lo), .v_hi(v_hi)
  , .rd_req(audio_req), .rd_addr(a_addr), .rd_ack(a_ack), .rd_valid(a_rvalid), .rd_data(rdata)
  , .left(disc_l), .right(disc_r)
  );

// Mix: disc audio at half scale, plus the AY (unsigned, 0..+16368, so
// silence is 0).
wire signed [16:0] ay_v  = {3'b000, ay_sound, 4'd0};
wire signed [16:0] mix_l = (disc_l >>> 1) + ay_v;
wire signed [16:0] mix_r = (disc_r >>> 1) + ay_v;

function [15:0] clip(input signed [16:0] v);
  clip = (v > 17'sd32767) ? 16'h7fff : (v < -17'sd32768) ? 16'h8000 : v[15:0];
endfunction

always @(posedge clk) begin
  audio_l <= clip(mix_l);
  audio_r <= clip(mix_r);
end

endmodule
