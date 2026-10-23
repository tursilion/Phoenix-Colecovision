// Galaga for the Phoenix: clocks, frame lock, memories, boot loader
// interface and video output.  The boards are galaga_main.v (CPUs, custom
// chips), galaga_video.v and galaga_sound.v.  The structure is the Time
// Pilot '84 core's tp84_phoenix.v.
//
// Everything runs from the 25MHz pixel clock.
//
// Clocks
//   - The game's 6.144MHz pixel enable is fractional, 3170 per 13125
//     clocks (6.038MHz): a 384 x 264 frame then takes 419,735 clocks, 265
//     fewer than one 640x480 HDMI frame.  The game waits for the HDMI
//     output at the end of each frame (h = 383, v = 263) until HDMI line 10,
//     which locks it to 59.52Hz (the original is 60.6Hz).  If it gets there
//     after line 10 (after power-on) it waits for the next frame's line 10.  The CPUs (half
//     the pixel rate) and the 06xx run from it.
//   - The 51xx and 54xx (256kHz instruction cycle) and the sound (96kHz)
//     run at their own exact rates.
//
// External SRAM
//   00000-03FFF main CPU ROM     04000-04FFF sub CPU ROM
//   05000-05FFF sound CPU ROM    20000-21FFF boot loader copy
//   40000-5FFFF, 60000-7FFFF frame buffers for the rotated picture
// CPU ROM reads are made when a CPU's ROM address changes (address out on
// one clock, data in on the next).  Writes take two clocks.  Priority: CPU
// reads, writes (loader, frame buffer), display line prefetch.
//
// Boot mode (after power-on, or reset held for a second): the main Z80 runs
// the boot loader (the others are held in reset), at first from the sprite
// ROM's block RAM (which is initialized with it), then from its copy in
// the SRAM, so that it can load the sprite ROMs.  Memory map:
//   0000-1FFF boot loader        8000-837F text (video RAM, 32 x 28)
//   8800-8BFF RAM (RAM 1)        9000-93FF RAM (RAM 2)
//   C000 R SPI received byte             W SPI transfer byte (starts it)
//   C001 R b7 SPI busy, b6 card present  W b0 SD select, b1 fast (6.25MHz)
//   C002 R b0 SRAM write pending         W load address 7:0
//   C003 R b0 vertical blank             W load address 15:8
//   C004 W load address 17:16
//   C005 W load data: write it, then address + 1
//   C006 R IN0 (active low, as the game reads it)
//   C007 R IN1
//   C008-C009 W DIP switches A, B
//   C00B W b0 error LED
//   C00C W b0 run the loader from its SRAM copy
//   C00F W start the game
//   I/O read, any port:  the SPI received byte, and start the next transfer
//                        (sending 0xFF), for INIR block reads
//   I/O write, any port: load data, as C005 (for OTIR)
// Load addresses: 00000-0FFFF and 20000-3FFFF go to the SRAM; 10000-10FFF
// tile ROM, 12000-13FFF sprite ROM, 14000-147FF 51xx and 54xx ROMs,
// 15000 palette PROM, 15100 tile lookup, 15200 sprite lookup, 15300 sound.

`timescale 1ns / 1ps

module galaga_phoenix
   ( input             clk          // 25MHz
   , input             reset        // power-on reset, re-enters boot mode
   , input             game_reset   // reset the game only

   // Controls, 1 = pressed: b0 up b1 down b2 left b3 right b4 fire
   , input       [4:0] joy1
   , input       [4:0] joy2
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

wire release_line = (hc == 10'd0 && vc == 10'd10);

// ---------------------------------------------------------------------------
// Game clock enables and frame lock

wire [8:0] g_h, g_v;
reg        cen6 = 0;
reg [13:0] acc6 = 0;
reg        go = 0;

wire wait_pt = (g_h == 9'd383 && g_v == 9'd263);
wire run     = !wait_pt || go;
wire ovf6    = (acc6 + 14'd3170 >= 14'd13125);

always @(posedge clk) begin
  cen6 <= 0;
  if (run) begin
    acc6 <= ovf6 ? acc6 + 14'd3170 - 14'd13125 : acc6 + 14'd3170;
    cen6 <= ovf6;
  end
  if (release_line && wait_pt)        // only a game already waiting is released,
    go <= 1;                         // so it locks within one frame
  else if (cen6 && wait_pt)
    go <= 0;
end

wire cen_cpu = cen6 && g_h[0];                 // 3.072MHz
wire cen_06  = cen6 && g_h[5:0] == 6'd0;       // 96kHz (06xx timer base)

// MCUs (1.536MHz / 6) and sound (96kHz), 24-bit phase accumulators
reg [23:0] acc_mcu = 0, acc_wsg = 0;
reg        cen_mcu = 0, cen_wsg = 0;
always @(posedge clk) begin
  {cen_mcu, acc_mcu} <= {1'b0, acc_mcu} + 25'd171799;
  {cen_wsg, acc_wsg} <= {1'b0, acc_wsg} + 25'd64425;
end

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

// ---------------------------------------------------------------------------
// Inputs and DIP switches

reg [7:0] dswa = 8'hf7, dswb = 8'h97;

wire [7:0] in0 = {~joy2[2], 1'b1, ~joy2[3], 1'b1, ~joy1[2], 1'b1, ~joy1[3], 1'b1};
wire [7:0] in1 = {1'b1, ~sys[2], ~sys[1], ~sys[0], ~sys[4], ~sys[3], ~joy2[4], ~joy1[4]};

// ---------------------------------------------------------------------------
// Boards

wire [15:0] A, a1, a2;             // main CPU (and boot loader) bus, sub CPUs
wire  [7:0] z_dout;
wire        z_mreq_n, z_iorq_n, z_rd_n, z_wr_n, z_m1_n, z_rfsh_n;
reg   [7:0] rom_q0 = 8'hff, rom_q1 = 8'hff, rom_q2 = 8'hff;
reg         boot_sel;
reg   [7:0] boot_q;
reg         ld_we = 0;
reg  [17:0] ld_a = 0;
reg   [7:0] ld_d = 0;
wire  [7:0] srom_boot_q;

wire  [9:0] v_vid_a;
reg   [9:0] text_a = 0;
wire  [7:0] vid_code, vid_color;
wire  [6:0] spr_a;
wire  [7:0] spr_q1, spr_q2, spr_q3, vlatch;
wire  [4:0] sreg_a;
wire  [3:0] sreg_q;
wire  [3:0] n54_0, n54_1, n54_2;
wire        g_vblank, ev_vbl, ev_nmi;
wire        pix_we;
wire  [8:0] pix_x;
wire  [7:0] pix_y;
wire  [7:0] g_pixel;

wire ld_mcu  = ld_we && ld_a[17:11] == 7'b0101000;      // 14000-147FF
wire ld_tile = ld_we && ld_a[17:12] == 6'b010000;       // 10000-10FFF
wire ld_spr  = ld_we && ld_a[17:13] == 5'b01001;        // 12000-13FFF
wire ld_pal  = ld_we && ld_a[17:8]  == 10'h150;
wire ld_clut = ld_we && ld_a[17:8]  == 10'h151;
wire ld_slut = ld_we && ld_a[17:8]  == 10'h152;
wire ld_wave = ld_we && ld_a[17:8]  == 10'h153;

galaga_main main
  ( .clk(clk), .reset(cpu_reset), .boot_mode(boot_mode)
  , .cen_cpu(cen_cpu), .cen_06(cen_06), .cen_mcu(cen_mcu)
  , .vblank(g_vblank), .ev_vbl(ev_vbl), .ev_nmi(ev_nmi)
  , .in0(in0), .in1(in1), .dswa(dswa), .dswb(dswb)
  , .a0(A), .a1(a1), .a2(a2), .rom_q0(rom_q0), .rom_q1(rom_q1), .rom_q2(rom_q2)
  , .z_dout(z_dout), .z_mreq_n(z_mreq_n), .z_iorq_n(z_iorq_n), .z_rd_n(z_rd_n)
  , .z_wr_n(z_wr_n), .z_m1_n(z_m1_n), .z_rfsh_n(z_rfsh_n)
  , .boot_sel(boot_sel), .boot_q(boot_q)
  , .ld_we(ld_mcu), .ld_a(ld_a[10:0]), .ld_d(ld_d)
  , .vid_a(boot_mode ? text_a : v_vid_a), .vid_code(vid_code), .vid_color(vid_color)
  , .spr_a(spr_a), .spr_q1(spr_q1), .spr_q2(spr_q2), .spr_q3(spr_q3), .vlatch(vlatch)
  , .sreg_a(sreg_a), .sreg_q(sreg_q)
  , .n54_out0(n54_0), .n54_out1(n54_1), .n54_out2(n54_2)
  );

galaga_video video
  ( .clk(clk), .cen6(cen6)
  , .h(g_h), .v(g_v), .vblank(g_vblank), .ev_vbl(ev_vbl), .ev_nmi(ev_nmi)
  , .vid_a(v_vid_a), .vid_code(vid_code), .vid_color(vid_color)
  , .spr_a(spr_a), .spr_q1(spr_q1), .spr_q2(spr_q2), .spr_q3(spr_q3), .vlatch(vlatch)
  , .ld_tile_we(ld_tile), .ld_spr_we(ld_spr), .ld_clut_we(ld_clut), .ld_slut_we(ld_slut)
  , .ld_a(ld_a[12:0]), .ld_d(ld_d)
  , .boot_a(A[12:0]), .boot_q(srom_boot_q)
  , .pix_we(pix_we), .pix_x(pix_x), .pix_y(pix_y), .pixel(g_pixel)
  );

galaga_sound sound
  ( .clk(clk), .reset(cpu_reset), .cen_wsg(cen_wsg)
  , .sreg_a(sreg_a), .sreg_q(sreg_q)
  , .out0(n54_0), .out1(n54_1), .out2(n54_2)
  , .ld_wave_we(ld_wave), .ld_a(ld_a[7:0]), .ld_d(ld_d)
  , .audio(audio)
  );

// Palette PROM: b2-0 red, b5-3 green, b7-6 blue
reg [7:0] pal [0:31];
always @(posedge clk)
  if (ld_pal) pal[ld_a[4:0]] <= ld_d;

// ---------------------------------------------------------------------------
// SRAM

reg        exec_sram = 0;          // boot loader runs from its SRAM copy

wire        r0 = boot_mode ? (A[15:13] == 3'b000) : (A[15:14] == 2'b00);
wire        r1 = (a1[15:14] == 2'b00);
wire        r2 = (a2[15:14] == 2'b00);
wire [18:0] m0_addr = boot_mode ? {6'b010000, A[12:0]} : {5'b00000, A[13:0]};   // 20000 / 00000
wire [18:0] m1_addr = {7'b0000100, a1[11:0]};                                     // 04000
wire [18:0] m2_addr = {7'b0000101, a2[11:0]};                                     // 05000

reg        b_pend = 0;
reg [18:0] b_addr = 0;
reg  [7:0] b_data = 0;

// Rotated display: frame buffers and the line prefetch (see the video
// output below)
reg        rot = 0;                // 1 = rotated picture (toggled at run time)
reg        wbank = 0, rbank = 0, rbank_next = 0;
reg  [7:0] fq_d [0:15];            // pixel write queue
reg [16:0] fq_a [0:15];            // {line, x}
reg        fq_b [0:15];            // bank
reg  [3:0] fq_wp = 0, fq_rp = 0;
wire       fq_empty = (fq_wp == fq_rp);
reg        rd_pend = 0;            // prefetching a display line
reg  [7:0] rd_u = 0;               // next pixel of that line
reg  [8:0] rd_x = 0;               // its source column
reg        rd_half = 0;
reg        pf_go = 0;              // start a line prefetch
reg  [7:0] rt_u = 0;               // pixel of the read issued last clock
reg        rt_half = 0;

// CPU ROM reads are made when a CPU's ROM address changes; s_addr is the
// address its data register holds.
reg [18:0] s0_addr = 0, s1_addr = 0, s2_addr = 0;
reg        s0_ok = 0, s1_ok = 0, s2_ok = 0;
wire       p0 = r0 && (!s0_ok || s0_addr != m0_addr);
wire       p1 = r1 && (!s1_ok || s1_addr != m1_addr);
wire       p2 = r2 && (!s2_ok || s2_addr != m2_addr);

reg        wph = 0;                // second clock of a write
reg  [2:0] rtag = 0;               // read issued last clock: 1-3 CPU 0-2, 4 frame buffer
reg        lb_we = 0;
reg [11:0] lb_wa = 0;
reg  [7:0] lb_wd = 0;

always @(posedge clk) begin
  rtag        <= 0;
  sram_wpulse <= 0;
  lb_we       <= 0;
  case (rtag)
  3'd1: rom_q0 <= sram_din;
  3'd2: rom_q1 <= sram_din;
  3'd3: rom_q2 <= sram_din;
  3'd4: begin lb_we <= 1; lb_wa <= {3'b000, rt_half, rt_u}; lb_wd <= sram_din; end
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
      sram_addr <= {1'b1, fq_b[fq_rp], fq_a[fq_rp]};
      sram_dout <= fq_d[fq_rp];
      fq_rp     <= fq_rp + 1'd1;
    end
  end else if (rd_pend) begin
    sram_doe  <= 0;
    sram_oe_n <= 0;
    sram_addr <= {1'b1, rbank, 8'd223 - rd_u, rd_x};
    rtag      <= 3'd4;
    rt_u      <= rd_u;
    rt_half   <= rd_half;
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
  (A[4:0] == 5'h06) ? in0 :
  (A[4:0] == 5'h07) ? in1 : 8'hff;

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
    boot_q   = exec_sram ? rom_q0 : srom_boot_q;
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
    5'h08: dswa <= z_dout;
    5'h09: dswb <= z_dout;
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

`ifdef GA_SIM_PC
reg m1_d = 1;
always @(posedge clk) begin
  m1_d <= z_m1_n;
  if (!z_m1_n && m1_d) $display("PC %04x boot=%0d sram=%0d t=%0t", A, boot_mode, exec_sram, $time);
  if (wr_stb) $display("  W %04x <- %02x", A, z_dout);
  if (io_wr_stb) $display("  OUT %02x -> ld %05x", z_dout, ld_a);
end
`endif

// ---------------------------------------------------------------------------
// Native picture (rot = 0, the default): 8 lines of 288 pixels in lbuf,
// written by the video board and read twice per line by the HDMI output
// (576 x 448, centred).
//
// Rotated picture (rot = 1): Galaga is a vertical game, so its 288 x 224
// frame is turned 90 degrees clockwise to 224 x 288.  Each frame is
// written to one of two frame buffers in the SRAM (40000 / 60000, address
// {line, x}) while the other, finished one is shown, so frames never tear.
// Each HDMI line is prefetched from the SRAM into lbuf during the line
// before; it shows one source column, pixels doubled to 448 wide (centred),
// and the 288 columns are spread over the 480 lines (5/3).

reg  [6:0] lbuf [0:4095];            // {star, colour}: b6 = the pixel's b7
wire        lbw_en = lb_we || (pix_we && !rot);
wire [11:0] lbw_a  = lb_we ? lb_wa : {pix_y[2:0], pix_x};
wire  [6:0] lbw_d  = lb_we ? {lb_wd[7], lb_wd[5:0]} : {g_pixel[7], g_pixel[5:0]};
wire [11:0] lbr_a;                 // read address (output pipeline)

always @(posedge clk)
  if (lbw_en)
    lbuf[lbw_a] <= lbw_d;

// Pixel write queue (written here, emptied by the SRAM arbiter)
always @(posedge clk) begin
  if (pix_we && rot && !boot_mode) begin
    fq_d[fq_wp] <= g_pixel;
    fq_a[fq_wp] <= {pix_y, pix_x};
    fq_b[fq_wp] <= wbank;
    fq_wp <= fq_wp + 1'd1;
  end
end

`ifdef GA_SIM_FB
reg [31:0] fq_ovf = 0, rd_late = 0;
always @(posedge clk) begin
  if (pix_we && rot && !boot_mode && (fq_wp + 1'd1) == fq_rp) begin
    fq_ovf <= fq_ovf + 1;
    if (fq_ovf[11:0] == 0) $display("FIFO overflow %0d (v=%0d) t=%0t", fq_ovf, pix_y, $time);
  end
  if (pf_go && rd_pend) begin
    rd_late <= rd_late + 1;
    if (rd_late[7:0] == 0) $display("prefetch late %0d at u=%0d vc=%0d", rd_late, rd_u, vc);
  end
end
`endif

// Frame buffer swap: at the start of the game's vertical blank the frame
// just written becomes the one to show from the next HDMI frame.
always @(posedge clk) begin
  if (ev_vbl) begin
    wbank      <= !wbank;
    rbank_next <= wbank;
  end
  if (hc == 10'd0 && vc == 10'd0)
    rbank <= rbank_next;
  if (rot_toggle)
    rot <= !rot;
end

// Line prefetch: at the start of HDMI line vc, fetch line vc + 1, which
// shows source column x = floor(3 * line / 5).
reg [2:0] rd_r = 0;                // 3 * line mod 5
always @(posedge clk) begin
  pf_go <= 0;
  if (hc == 10'd0 && (vc == 10'd524 || vc < 10'd479)) begin
    pf_go   <= rot && !boot_mode;
    rd_half <= (vc == 10'd524) ? 1'b0 : !vc[0];
    if (vc == 10'd524) begin
      rd_x <= 0;
      rd_r <= 0;
    end else if (rd_r >= 3'd2) begin
      rd_x <= rd_x + 1'd1;
      rd_r <= rd_r - 3'd2;
    end else
      rd_r <= rd_r + 3'd3;
  end
end

// Output pipeline
//   stage 1: line buffer / video RAM address
//   stage 2: their data
//   stage 3: palette / font lookup, RGB out
wire       in_area = (hc >= 10'd32 && hc < 10'd608 && vc >= 10'd16 && vc < 10'd464);
wire       in_text = (hc >= 10'd64 && hc < 10'd576 && vc >= 10'd16 && vc < 10'd464);
wire       in_rot  = (hc >= 10'd96 && hc < 10'd544 && vc < 10'd480);
wire [9:0] rx = hc - 10'd96;
wire [9:0] ax = hc - 10'd32;
wire [9:0] tx = hc - 10'd64;
wire [9:0] ay = vc - 10'd16;

assign lbr_a = (rot && !boot_mode) ? {3'b000, vc[0], rx[8:1]} : {ay[3:1], ax[9:1]};

reg  [6:0] lb_q = 0;
reg        area1 = 0, area2 = 0;
reg  [2:0] fx1 = 0, fx2 = 0;
reg  [2:0] fy1 = 0, fy2 = 0;
reg  [1:0] hs = 2'b11, vs = 2'b11, bl = 2'b11;
reg  [4:0] pidx2 = 0;
reg        star2 = 0;
reg  [5:0] scol2 = 0;
reg  [7:0] font [0:511];
initial $readmemh("font64.hex", font);

always @(posedge clk) begin
  lb_q   <= lbuf[lbr_a];
  text_a <= {ay[8:4], tx[8:4]};
  area1  <= boot_mode ? in_text : rot ? in_rot : in_area;
  fx1    <= tx[3:1];
  fy1    <= ay[3:1];
  hs[0]  <= !(hc >= 10'd656 && hc < 10'd752);
  vs[0]  <= !(vc == 10'd490 || vc == 10'd491);
  bl[0]  <= (hc >= 10'd640 || vc >= 10'd480);
  hs[1]  <= hs[0];
  vs[1]  <= vs[0];
  bl[1]  <= bl[0];
  area2  <= area1;
  pidx2  <= lb_q[4:0];
  star2  <= lb_q[6];
  scol2  <= lb_q[5:0];
  fx2    <= fx1;
  fy2    <= fy1;
end

// Colour levels: the palette PROM through 1K, 470, 220 ohm (blue 470, 220),
// the stars through 470, 220 ohm (MAME's values)
function [7:0] lv3(input [2:0] b);
  lv3 = (b[0] ? 8'h21 : 8'h00) + (b[1] ? 8'h47 : 8'h00) + (b[2] ? 8'h97 : 8'h00);
endfunction
function [7:0] lv2(input [1:0] b);
  lv2 = (b == 2'd0) ? 8'h00 : (b == 2'd1) ? 8'h47 : (b == 2'd2) ? 8'h97 : 8'hde;
endfunction

wire [7:0] pal_q = pal[pidx2];
wire [7:0] glyph = font[{vid_code[5:0] - 6'd32, fy2}];
wire       ink   = glyph[3'd7 - fx2];

always @(posedge clk) begin
  vid_hsync_n <= hs[1];
  vid_vsync_n <= vs[1];
  vid_blank   <= bl[1];
  if (!area2) begin
    vid_r <= 0; vid_g <= 0; vid_b <= 0;
  end else if (boot_mode) begin
    if (ink) begin
      vid_r <= 8'hff; vid_g <= 8'hff; vid_b <= vid_code[7] ? 8'h00 : 8'hff;
    end else begin
      vid_r <= 8'h00; vid_g <= 8'h00; vid_b <= 8'h60;
    end
  end else if (star2) begin
    vid_r <= lv2(scol2[1:0]);
    vid_g <= lv2(scol2[3:2]);
    vid_b <= lv2(scol2[5:4]);
  end else begin
    vid_r <= lv3(pal_q[2:0]);
    vid_g <= lv3(pal_q[5:3]);
    vid_b <= lv3({pal_q[7:6], 1'b0});
  end
end

endmodule
