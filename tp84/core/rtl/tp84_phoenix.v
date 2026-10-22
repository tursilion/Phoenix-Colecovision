// Time Pilot '84 for the Phoenix: clocks, frame lock, memories, boot
// loader interface and video output.  The boards are tp84_main.v and
// tp84_sound.v.  This is the Gyruss core's gyruss_phoenix.v, adapted.
//
// Everything runs from the 25MHz pixel clock.
//
// Clocks
//   - The main board's 12.288MHz enable is fractional: 768 per 1590 clocks,
//     so a 384-pixel line takes 1590 clocks and a 264-line frame 419,760,
//     240 fewer than one 640x480 HDMI frame (420,000).  The game waits for
//     the HDMI output at the end of each frame (h = 176, v = 511) until HDMI
//     line 486, which locks it to 59.52Hz (the original is 60.6Hz).
//   - The sound board runs at its own rate: Z80 3.5797MHz, PSGs 1.79MHz.
//
// External SRAM
//   00000-07FFF main CPU ROM (8000-FFFF)   08000-09FFF sub CPU ROM
//   0C000-0DFFF sound CPU ROM              20000-21FFF boot loader copy
//   40000-4FFFF, 50000-5FFFF frame buffers for the rotated picture
// CPU reads are made when a CPU's address changes (address out on one
// clock, data in on the next).  Writes take two clocks.  Priority: CPU
// reads, writes (loader, frame buffer), display line prefetch.
//
// Boot mode (after power-on, or reset held for a second): the 6809s are
// held in reset and the sound Z80 runs the boot loader, at first from the
// tile ROM's block RAM (which is initialized with it), then from its copy
// in the SRAM, so that it can load the tile ROMs.  Memory map:
//   0000-1FFF boot loader        4000-43FF RAM (sound RAM)
//   5000-57FF RAM (shared RAM)   8400-87FF text (video RAM, 32 x 28)
//   C000 R SPI received byte             W SPI transfer byte (starts it)
//   C001 R b7 SPI busy, b6 card present  W b0 SD select, b1 fast (6.25MHz)
//   C002 R b0 SRAM write pending         W load address 7:0
//   C003 R b0 vertical blank             W load address 15:8
//   C004 W load address 17:16
//   C005 W load data: write it, then address + 1
//   C006 R player 1 (active low, as the game reads it)
//   C007 R system inputs (active low)
//   C008-C009 W DIP switches 1-2
//   C00B W b0 error LED
//   C00C W b0 run the loader from its SRAM copy
//   C00F W start the game
//   I/O read, any port:  the SPI received byte, and start the next transfer
//                        (sending 0xFF), for INIR block reads
//   I/O write, any port: load data, as C005 (for OTIR)
// Load addresses: 00000-0FFFF and 20000-3FFFF go to the SRAM; 10000-1C4FF
// are the graphics ROMs and PROMs (see tp84_main.v).

`timescale 1ns / 1ps

module tp84_phoenix
   ( input             clk          // 25MHz
   , input             reset        // power-on reset, re-enters boot mode
   , input             game_reset   // reset the game only

   // Controls, 1 = pressed: b0 up b1 down b2 left b3 right b4 fire 1 b5 fire 2
   , input       [5:0] joy1
   , input       [5:0] joy2
   , input       [4:0] sys          // b0 coin1 b1 coin2 b2 service b3 start1 b4 start2
   , input             rot_toggle   // pulse: switch between the rotated and the native picture

   // External SRAM
   , output reg [18:0] sram_addr = 0
   , output reg  [7:0] sram_dout = 0
   , input       [7:0] sram_din
   , output reg        sram_doe = 0
   , output reg        sram_wpulse = 0   // pulse WE low in the second half of this clock
   , output reg        sram_oe_n = 1

   // SD card
   , output reg        sd_cs_n = 1
   , output reg        sd_sclk = 0
   , output reg        sd_mosi = 1
   , input             sd_miso
   , input             sd_cd_n

   // 640x480 video
   , output reg  [7:0] vid_r = 0
   , output reg  [7:0] vid_g = 0
   , output reg  [7:0] vid_b = 0
   , output reg        vid_hsync_n = 1
   , output reg        vid_vsync_n = 1
   , output reg        vid_blank = 1

   // Audio
   , output     [15:0] audio

   , output reg        boot_mode = 1
   , output reg        led_err = 0
   );

// ---------------------------------------------------------------------------
// HDMI timing: 800 x 525, visible 640 x 480

reg [9:0] hc = 0;
reg [9:0] vc = 0;

always @(posedge clk) begin
  if (hc == 10'd799) begin
    hc <= 0;
    vc <= (vc == 10'd524) ? 10'd0 : vc + 1'd1;
  end else
    hc <= hc + 1'd1;
end

wire release_line = (hc == 10'd0 && vc == 10'd486);

// ---------------------------------------------------------------------------
// Main board clock enable and frame lock

wire [8:0] g_h, g_v;
wire       g_d0;
reg        cen12 = 0;
reg [11:0] acc12 = 0;
reg        go = 0;

wire wait_pt = (g_h == 9'd176 && g_v == 9'd511 && !g_d0);
wire run     = !wait_pt || go;
wire ovf12   = (acc12 + 12'd768 >= 12'd1590);

always @(posedge clk) begin
  cen12 <= 0;
  if (run) begin
    acc12 <= ovf12 ? acc12 + 12'd768 - 12'd1590 : acc12 + 12'd768;
    cen12 <= ovf12;
  end
  if (release_line)
    go <= 1;
  else if (cen12 && wait_pt)
    go <= 0;
end

// Sound board enable
reg [15:0] acc_snd = 0;
reg        cen_snd = 0;

always @(posedge clk)
  {cen_snd, acc_snd} <= {1'b0, acc_snd} + 17'd9384;    // 25MHz * 9384 / 65536

// ---------------------------------------------------------------------------
// Resets

reg       start_game = 0;
reg [7:0] rst_cnt = 8'hff;
wire      cpu_reset = (rst_cnt != 0);

always @(posedge clk) begin
  if (reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (reset || start_game || (game_reset && !boot_mode))
    rst_cnt <= 8'hff;
  else if (rst_cnt != 0)
    rst_cnt <= rst_cnt - 1'd1;
end

wire main_reset = cpu_reset || boot_mode;     // the 6809s
wire snd_reset  = cpu_reset;                  // the Z80 (it runs the boot loader)

// ---------------------------------------------------------------------------
// Inputs and DIP switches

reg [7:0] dsw1 = 8'hff, dsw2 = 8'h32;

wire [7:0] in_sys = {3'b111, ~sys[4], ~sys[3], ~sys[2], ~sys[1], ~sys[0]};
wire [7:0] in_p1  = {2'b11, ~joy1[5], ~joy1[4], ~joy1[1], ~joy1[0], ~joy1[3], ~joy1[2]};
wire [7:0] in_p2  = {2'b11, ~joy2[5], ~joy2[4], ~joy2[1], ~joy2[0], ~joy2[3], ~joy2[2]};

// ---------------------------------------------------------------------------
// Boards

wire [15:0] A;                     // sound Z80 (and boot loader) bus
wire  [7:0] z_dout;
wire        z_mreq_n, z_iorq_n, z_rd_n, z_wr_n, z_m1_n, z_rfsh_n;
wire [15:0] m_a, s_a;
reg   [7:0] rom_q0 = 8'hff, rom_q1 = 8'hff, rom_q2 = 8'hff;
reg         boot_sel;
reg   [7:0] boot_q;
wire  [7:0] snd_latch;
wire        snd_irq;
reg         ld_we = 0;
reg  [17:0] ld_a = 0;
reg   [7:0] ld_d = 0;
wire  [7:0] tile_rd_q;
reg  [10:0] text_a = 0;
wire  [7:0] text_q;
wire  [7:0] bz_q;
wire        g_cen6, g_hblk, g_vblk;
wire  [7:0] g_pixel;
wire  [7:0] pal_a;
wire [11:0] pal_q;
wire        bz_we = boot_mode && !z_mreq_n && !z_wr_n && z_rfsh_n;

tp84_main main
  ( .clk(clk), .reset(main_reset), .cen12(cen12), .boot_mode(boot_mode)
  , .in_sys(in_sys), .in_p1(in_p1), .in_p2(in_p2), .dsw1(dsw1), .dsw2(dsw2)
  , .m_a(m_a), .rom_m_q(rom_q0), .s_a(s_a), .rom_s_q(rom_q1)
  , .snd_latch(snd_latch), .snd_irq(snd_irq)
  , .ld_we(ld_we), .ld_a(ld_a), .ld_d(ld_d)
  , .tile_rd_a({1'b0, A[12:0]}), .tile_rd_q(tile_rd_q)
  , .bz_a(A), .bz_d(z_dout), .bz_we(bz_we), .bz_q(bz_q)
  , .text_a(text_a), .text_q(text_q)
  , .h_cnt(g_h), .v_cnt(g_v), .cen6(g_cen6), .d0(g_d0), .hblk(g_hblk), .vblk(g_vblk)
  , .pixel(g_pixel), .pal_a(pal_a), .pal_q(pal_q)
  );

tp84_sound sound
  ( .clk(clk), .reset(snd_reset), .cen_z80(cen_snd), .boot_mode(boot_mode)
  , .latch(snd_latch), .irq_trigger(snd_irq), .rom_q(rom_q2)
  , .z_a(A), .z_dout(z_dout), .z_mreq_n(z_mreq_n), .z_iorq_n(z_iorq_n)
  , .z_rd_n(z_rd_n), .z_wr_n(z_wr_n), .z_m1_n(z_m1_n), .z_rfsh_n(z_rfsh_n)
  , .boot_sel(boot_sel), .boot_q(boot_q)
  , .audio(audio)
  );

// ---------------------------------------------------------------------------
// SRAM

reg        exec_sram = 0;          // boot loader runs from its SRAM copy

wire [18:0] m0_addr = {4'b0000, m_a[14:0]};                                       // 00000
wire [18:0] m1_addr = {6'b000100, s_a[12:0]};                                     // 08000
wire [18:0] m2_addr = boot_mode ? {6'b010000, A[12:0]} : {6'b000110, A[12:0]};    // 20000 / 0C000

reg        b_pend = 0;
reg [18:0] b_addr = 0;
reg  [7:0] b_data = 0;

// Rotated display: frame buffers and the line prefetch (see the video
// output below)
reg        rot = 0;                // 1 = rotated picture (toggled at run time)
reg        wbank = 0, rbank = 0, rbank_next = 0;
reg  [7:0] fq_d [0:7];             // pixel write queue
reg [15:0] fq_a [0:7];             // {line, x}
reg        fq_b [0:7];             // bank
reg  [2:0] fq_wp = 0, fq_rp = 0;
wire       fq_empty = (fq_wp == fq_rp);
reg        rd_pend = 0;            // prefetching a display line
reg  [7:0] rd_u = 0;               // next pixel of that line
reg  [7:0] rd_x = 0;               // its source column
reg        rd_half = 0;
reg        pf_go = 0;              // start a line prefetch
reg  [7:0] rt_u = 0;               // pixel of the read issued last clock
reg        rt_half = 0;
reg        rt_blank = 0;              // a column the PCB blanks (x 253-255)

// CPU ROM reads are made when a CPU's address changes; served_n is the
// address its data register holds.
reg [18:0] s0_addr = 0, s1_addr = 0, s2_addr = 0;
reg        s0_ok = 0, s1_ok = 0, s2_ok = 0;
wire       p0 = !s0_ok || s0_addr != m0_addr;
wire       p1 = !s1_ok || s1_addr != m1_addr;
wire       p2 = !s2_ok || s2_addr != m2_addr;

reg        wph = 0;                // second clock of a write
reg  [2:0] rtag = 0;               // read issued last clock: 1-3 CPU 0-2, 4 frame buffer
reg        lb_we = 0;
reg [10:0] lb_wa = 0;
reg  [8:0] lb_wd = 0;               // {blank, colour}

always @(posedge clk) begin
  rtag        <= 0;
  sram_wpulse <= 0;
  lb_we       <= 0;
  case (rtag)
  3'd1: rom_q0 <= sram_din;
  3'd2: rom_q1 <= sram_din;
  3'd3: rom_q2 <= sram_din;
  3'd4: begin lb_we <= 1; lb_wa <= {2'b00, rt_half, rt_u}; lb_wd <= {rt_blank, sram_din}; end
  default: ;
  endcase

  if (wph) begin
    wph <= 0;                              // address and data held, WE high
  end else if (p0 || p1 || p2) begin
    sram_doe  <= 0;
    sram_oe_n <= 0;
    if (p0) begin
      sram_addr <= m0_addr; s0_addr <= m0_addr; s0_ok <= 1; rtag <= 3'd1;
    end else if (p1) begin
      sram_addr <= m1_addr; s1_addr <= m1_addr; s1_ok <= 1; rtag <= 3'd2;
    end else begin
      sram_addr <= m2_addr; s2_addr <= m2_addr; s2_ok <= 1; rtag <= 3'd3;
    end
  end else if (b_pend || !fq_empty) begin
    // write: WE pulses low in the second half of this clock (ODDR2 in the
    // top level), then one more clock with the address held
    sram_doe    <= 1;
    sram_oe_n   <= 1;
    sram_wpulse <= 1;
    wph         <= 1;
    if (b_pend) begin                      // loader write: the CPUs' data may be stale
      s0_ok     <= 0;
      s1_ok     <= 0;
      s2_ok     <= 0;
      sram_addr <= b_addr;
      sram_dout <= b_data;
      b_pend    <= 0;
    end else begin
      sram_addr <= {2'b10, fq_b[fq_rp], fq_a[fq_rp]};
      sram_dout <= fq_d[fq_rp];
      fq_rp     <= fq_rp + 1'd1;
    end
  end else if (rd_pend) begin
    sram_doe  <= 0;
    sram_oe_n <= 0;
    sram_addr <= {2'b10, rbank, 8'd223 - rd_u, rd_x};
    rtag      <= 3'd4;
    rt_u      <= rd_u;
    rt_half   <= rd_half;
    rt_blank  <= (rd_x >= 8'd253);
    rd_u      <= rd_u + 1'd1;
    if (rd_u == 8'd223)
      rd_pend <= 0;
  end else begin
    sram_doe  <= 0;
    sram_oe_n <= 0;
  end

  if (pf_go) begin
    rd_pend <= 1;
    rd_u    <= 0;
  end

  if (ld_we && (ld_a[17:16] == 2'b00 || ld_a[17])) begin
    b_pend <= 1;
    b_addr <= {1'b0, ld_a};
    b_data <= ld_d;
  end

  if (reset) begin
    wph      <= 0;
    sram_doe <= 0;
    b_pend   <= 0;
  end
end

// ---------------------------------------------------------------------------
// SPI (SD card), mode 0: about 390kHz or 6.25MHz

reg  [7:0] spi_tx = 8'hff;
reg  [7:0] spi_sr = 8'hff;
reg  [7:0] spi_rx = 8'hff;
reg        spi_fast = 0;
reg        spi_start = 0;
reg        spi_busy = 0;
reg  [3:0] spi_cnt = 0;            // half bits left
reg  [4:0] spi_div = 0;

always @(posedge clk) begin
  if (spi_start) begin
    spi_busy <= 1;
    spi_sr   <= spi_tx;
    sd_mosi  <= spi_tx[7];
    sd_sclk  <= 0;
    spi_cnt  <= 4'd15;
    spi_div  <= 0;
  end else if (spi_busy) begin
    spi_div <= spi_div + 1'd1;
    if ((spi_fast && spi_div[0]) || spi_div == 5'd31) begin
      spi_div <= 0;
      if (!sd_sclk) begin                    // rising edge: sample
        sd_sclk <= 1;
        spi_sr  <= {spi_sr[6:0], sd_miso};   // valid a clock after the falling edge
      end else begin                         // falling edge: next bit
        sd_sclk <= 0;
        sd_mosi <= spi_sr[7];
      end
      if (spi_cnt == 0) begin
        spi_busy <= 0;
        spi_rx   <= spi_sr;                    // the last tick is a falling edge
      end else
        spi_cnt <= spi_cnt - 1'd1;
    end
  end
end

// ---------------------------------------------------------------------------
// Boot loader registers

wire vblank_out = (vc >= 10'd480);

wire mem_rd  = !z_mreq_n && !z_rd_n && z_rfsh_n;
wire a_c0    = (A[15:8] == 8'hC0);
reg  wr_n_d  = 1;
wire wr_stb  = !z_mreq_n && !z_wr_n && wr_n_d;
always @(posedge clk) wr_n_d <= z_wr_n;

wire [7:0] boot_io =
  (A[4:0] == 5'h00) ? spi_rx :
  (A[4:0] == 5'h01) ? {spi_busy, !sd_cd_n, 6'd0} :
  (A[4:0] == 5'h02) ? {7'd0, b_pend} :
  (A[4:0] == 5'h03) ? {7'd0, vblank_out} :
  (A[4:0] == 5'h06) ? in_p1 :
  (A[4:0] == 5'h07) ? in_sys : 8'hff;

reg  io_rd_d = 0;
reg  [7:0] io_q = 8'hff;           // frozen during the cycle: the next transfer may end first
wire io_rd = boot_mode && !z_iorq_n && !z_rd_n && z_m1_n;
wire io_rd_stb = io_rd && !io_rd_d;
reg  io_wr_d = 0;
wire io_wr = boot_mode && !z_iorq_n && !z_wr_n;
wire io_wr_stb = io_wr && !io_wr_d;

always @(posedge clk) begin
  io_rd_d <= io_rd;
  io_wr_d <= io_wr;
  if (!io_rd)
    io_q <= spi_rx;
end

always @* begin
  boot_sel = 0;
  boot_q   = 8'hff;
  if (io_rd) begin
    boot_sel = 1;
    boot_q   = io_rd_stb ? spi_rx : io_q;
  end else if (boot_mode && mem_rd && A[15:13] == 3'b000) begin
    boot_sel = 1;
    boot_q   = exec_sram ? rom_q2 : tile_rd_q;
  end else if (boot_mode && mem_rd && (A[15:11] == 5'b01010 || A[15:10] == 6'b100001)) begin
    boot_sel = 1;                          // shared RAM, text
    boot_q   = bz_q;
  end else if (boot_mode && mem_rd && a_c0) begin
    boot_sel = 1;
    boot_q   = boot_io;
  end
end

always @(posedge clk) begin
  spi_start  <= 0;
  start_game <= 0;
  ld_we      <= 0;

  if (ld_we)
    ld_a <= ld_a + 1'd1;

  if (io_rd_stb) begin
    spi_tx    <= 8'hff;
    spi_start <= 1;
  end

  if (io_wr_stb) begin
    ld_d  <= z_dout;
    ld_we <= 1;
  end

  if (wr_stb && boot_mode && a_c0) begin
    case (A[4:0])
    5'h00: begin spi_tx <= z_dout; spi_start <= 1; end
    5'h01: begin sd_cs_n <= !z_dout[0]; spi_fast <= z_dout[1]; end
    5'h02: ld_a[7:0]   <= z_dout;
    5'h03: ld_a[15:8]  <= z_dout;
    5'h04: ld_a[17:16] <= z_dout[1:0];
    5'h05: begin ld_d <= z_dout; ld_we <= 1; end
    5'h08: dsw1 <= z_dout;
    5'h09: dsw2 <= z_dout;
    5'h0B: led_err <= z_dout[0];
    5'h0C: exec_sram <= z_dout[0];
    5'h0F: start_game <= 1;
    default: ;
    endcase
  end

  if (reset) begin
    sd_cs_n   <= 1;
    spi_fast  <= 0;
    led_err   <= 0;
    exec_sram <= 0;
  end
end

`ifdef TP_SIM_PC
reg m1_d = 1;
always @(posedge clk) begin
  m1_d <= z_m1_n;
  if (!z_m1_n && m1_d) $display("PC %04x boot=%0d sram=%0d t=%0t", A, boot_mode, exec_sram, $time);
  if (wr_stb) $display("  W %04x <- %02x", A, z_dout);
  if (io_wr_stb) $display("  OUT %02x -> ld %05x", z_dout, ld_a);
end
`endif

// ---------------------------------------------------------------------------
// Native picture (rot = 0, the default): 8 lines of 256 pixels in lbuf, written by the
// main board and read twice per line by the HDMI output (512x448, centred).
//
// Rotated picture (rot = 1): the game is a vertical game, so
// its 256x224 frame is turned 90 degrees clockwise to 224x256.  Each frame
// is written to one of two frame buffers in the SRAM (40000 / 50000,
// address {line, x}) while the other, finished one is shown, so frames
// never tear.  Each HDMI line is prefetched from the SRAM into lbuf during
// the line before; it shows one source column, pixels doubled to 448 wide
// (centred), and the 256 columns are spread over the 480 lines (15/8).

// The 256-pixel window is h = 269-511, 128-140; the PCB blanks its last 3
// pixels (h 138-140), which are stored with the blank bit.
reg [8:0] lbuf [0:2047];           // {blank, colour}
wire [7:0] g_x = (g_h >= 9'd269) ? g_h - 9'd269 : g_h + 9'd115;
wire [8:0] g_y = g_v - 9'd272;
wire       g_pix = g_cen6 && !(g_h > 9'd140 && g_h < 9'd269) && !g_vblk;

always @(posedge clk) begin
  if (lb_we)
    lbuf[lb_wa] <= lb_wd;
  else if (g_pix && !rot)
    lbuf[{g_v[2:0], g_x}] <= {g_hblk, g_pixel};
end

// Pixel write queue (written here, emptied by the SRAM arbiter)
always @(posedge clk) begin
  if (g_pix && rot && !boot_mode) begin
    fq_d[fq_wp] <= g_pixel;
    fq_a[fq_wp] <= {g_y[7:0], g_x};
    fq_b[fq_wp] <= wbank;
    fq_wp <= fq_wp + 1'd1;
  end
end

`ifdef TP_SIM_FB
reg [31:0] fq_ovf = 0, rd_late = 0;
always @(posedge clk) begin
  if (g_pix && rot && !boot_mode && (fq_wp + 1'd1) == fq_rp) begin
    fq_ovf <= fq_ovf + 1;
    if (fq_ovf[11:0] == 0) $display("FIFO overflow %0d (v=%0d) t=%0t", fq_ovf, g_v, $time);
  end
  if (pf_go && rd_pend) begin
    rd_late <= rd_late + 1;
    if (rd_late[7:0] == 0) $display("prefetch late %0d at u=%0d vc=%0d", rd_late, rd_u, vc);
  end
end
`endif

// Frame buffer swap: at the start of the game's vertical blank the frame
// just written becomes the one to show from the next HDMI frame.
reg g_vblk_d = 1;
always @(posedge clk) begin
  g_vblk_d <= g_vblk;
  if (g_vblk && !g_vblk_d) begin
    wbank      <= !wbank;
    rbank_next <= wbank;
  end
  if (hc == 10'd0 && vc == 10'd0)
    rbank <= rbank_next;
  if (rot_toggle)
    rot <= !rot;
end

// Line prefetch: at the start of HDMI line vc, fetch line vc + 1, which
// shows source column x = floor(8 * line / 15).
reg [3:0] rd_r = 0;                // 8 * line mod 15
always @(posedge clk) begin
  pf_go <= 0;
  if (hc == 10'd0 && (vc == 10'd524 || vc < 10'd479)) begin
    pf_go   <= rot && !boot_mode;
    rd_half <= (vc == 10'd524) ? 1'b0 : !vc[0];
    if (vc == 10'd524) begin
      rd_x <= 0;
      rd_r <= 0;
    end else if (rd_r >= 4'd7) begin
      rd_x <= rd_x + 1'd1;
      rd_r <= rd_r - 4'd7;
    end else
      rd_r <= rd_r + 4'd8;
  end
end

// Output pipeline
//   stage 1: line buffer / video RAM address
//   stage 2: their data; palette / font lookup
//   stage 3: RGB out (the palette entry is registered in stage 2)
wire       in_area = (hc >= 10'd64 && hc < 10'd576 && vc >= 10'd16 && vc < 10'd464);
wire       in_rot  = (hc >= 10'd96 && hc < 10'd544 && vc < 10'd480);
wire [9:0] rx = hc - 10'd96;
wire [9:0] ax = hc - 10'd64;
wire [9:0] ay = vc - 10'd16;

reg  [8:0] lb_q = 0;
reg        area1 = 0, area2 = 0;
reg  [2:0] fx1 = 0, fx2 = 0;
reg  [2:0] fy1 = 0, fy2 = 0;
reg  [1:0] hs = 2'b11, vs = 2'b11, bl = 2'b11;
reg [11:0] pal_r = 0;
reg        blank2 = 0;
reg  [7:0] font [0:511];
initial $readmemh("font64.hex", font);

always @(posedge clk) begin
  lb_q   <= (rot && !boot_mode) ? lbuf[{2'b00, vc[0], rx[8:1]}] : lbuf[{vc[3:1], ax[8:1]}];
  text_a <= {1'b1, ay[8:4], ax[8:4]};
  area1  <= (rot && !boot_mode) ? in_rot : in_area;
  fx1    <= ax[3:1];
  fy1    <= ay[3:1];
  hs[0]  <= !(hc >= 10'd656 && hc < 10'd752);
  vs[0]  <= !(vc == 10'd490 || vc == 10'd491);
  bl[0]  <= (hc >= 10'd640 || vc >= 10'd480);
  hs[1]  <= hs[0];
  vs[1]  <= vs[0];
  bl[1]  <= bl[0];
  area2  <= area1;
  pal_r  <= pal_q;
  blank2 <= lb_q[8];
  fx2    <= fx1;
  fy2    <= fy1;
end

assign pal_a = lb_q[7:0];

// Colour PROMs: 4 bits per colour through 1K, 470, 220, 100 ohm (weights as
// MAME computes them, with the 470 ohm load).
function [7:0] level(input [3:0] b);
  level = (b[0] ? 8'd14 : 8'd0) + (b[1] ? 8'd31 : 8'd0) + (b[2] ? 8'd66 : 8'd0) + (b[3] ? 8'd144 : 8'd0);
endfunction

wire [7:0] glyph = font[{text_q[5:0] - 6'd32, fy2}];
wire       ink   = glyph[3'd7 - fx2];

always @(posedge clk) begin
  vid_hsync_n <= hs[1];
  vid_vsync_n <= vs[1];
  vid_blank   <= bl[1];
  if (!area2 || (blank2 && !boot_mode)) begin
    vid_r <= 0; vid_g <= 0; vid_b <= 0;
  end else if (boot_mode) begin
    if (ink) begin
      vid_r <= 8'hff; vid_g <= 8'hff; vid_b <= text_q[7] ? 8'h00 : 8'hff;
    end else begin
      vid_r <= 8'h00; vid_g <= 8'h00; vid_b <= 8'h60;
    end
  end else begin
    vid_r <= level(pal_r[3:0]);
    vid_g <= level(pal_r[7:4]);
    vid_b <= level(pal_r[11:8]);
  end
end

endmodule
