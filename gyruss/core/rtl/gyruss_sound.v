// Gyruss sound board: Z80 at 3.58MHz, five AY-3-8910s at 1.79MHz (ay5x.v)
// and an 8039 at 8MHz playing samples through an 8-bit DAC.
//
// Memory and I/O map (from MAME and Ace's Gyruss_SND.sv, MiSTer):
//   0000-3FFF ROM (external SRAM)   6000-7FFF RAM (1K)   8000-9FFF latch
//   I/O (A4:2 picks the chip, A1:0: 0 address, 1 read, 2 write):
//     00-12 AY 1-5, 14 8039 IRQ, 18 8039 latch
// AY 3 port A reads a timer that steps every 1024 Z80 clocks.  AY 1 and 2
// port B switch RC filters on the PCB; those are not modelled.
//
// Mix: as in the MiSTer core, every AY channel at equal weight, the DAC at
// four times that; left = AY 2 and 5 and the DAC, right = AY 1, 3 and 4.

`timescale 1ns / 1ps

module gyruss_sound
   ( input             clk
   , input             reset
   , input             cen_z80      // 3.579545MHz
   , input             cen_8m       // 8MHz (8039 crystal)

   , input       [7:0] latch
   , input             irq_trigger

   // ROM (SRAM)
   , output     [15:0] rom_a
   , input       [7:0] rom_q

   // 8039 ROM loading
   , input             ld_we
   , input      [11:0] ld_a
   , input       [7:0] ld_d

   , output reg signed [15:0] audio_l = 0
   , output reg signed [15:0] audio_r = 0
   );

// ---------------------------------------------------------------------------
// Z80

wire [15:0] A;
wire  [7:0] dout;
wire        n_m1, n_mreq, n_iorq, n_rd, n_wr, n_rfsh;
reg         n_irq = 1;
reg   [7:0] din;

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) u6B
  ( .m1_n(n_m1), .mreq_n(n_mreq), .iorq_n(n_iorq), .rd_n(n_rd), .wr_n(n_wr)
  , .rfsh_n(n_rfsh), .halt_n(), .busak_n(), .A(A), .dout(dout)
  , .reset_n(!reset), .clk(clk), .cen(cen_z80), .wait_n(1'b1), .int_n(n_irq)
  , .nmi_n(1'b1), .busrq_n(1'b1), .di(din)
  );

assign rom_a = A;

wire mem    = !n_mreq && n_rfsh;
wire cs_rom = mem && A[15:14] == 2'b00;
wire cs_ram = mem && A[15:13] == 3'b011;
wire cs_lat = mem && A[15:13] == 3'b100;
wire io     = !n_iorq && n_m1;
wire [2:0] io_chip = A[4:2];

// RAM
reg [7:0] ram [0:1023];
reg [7:0] ram_q;
always @(posedge clk) begin
  if (cs_ram && !n_wr)
    ram[A[9:0]] <= dout;
  ram_q <= ram[A[9:0]];
end

// IRQ: set by the main CPU, cleared by the acknowledge cycle
always @(posedge clk) begin
  if (reset || (!n_iorq && !n_m1))
    n_irq <= 1;
  else if (irq_trigger)
    n_irq <= 0;
end

// I/O write strobes (one per cycle)
reg io_wr_d = 0;
wire io_wr = io && !n_wr;
wire io_wr_stb = io_wr && !io_wr_d;
always @(posedge clk)
  io_wr_d <= io_wr;

`ifdef GY_SIM_SND
reg snd_m1_d = 1;
always @(posedge clk) begin
  snd_m1_d <= n_m1;
  if (io_wr_stb) $display("SND OUT %02x <- %02x t=%0t", A[7:0], dout, $time);
  if (irq_trigger) $display("SND IRQ latch=%02x t=%0t", latch, $time);
end
`endif

// ---------------------------------------------------------------------------
// AY timer: 0,1,2,3,4,9,A,B,A,D stepping every 1024 Z80 clocks

reg [9:0] tdiv = 0;
reg [3:0] tsel = 0;
reg [3:0] timer;
always @(posedge clk) begin
  if (cen_z80) begin
    tdiv <= tdiv + 1'd1;
    if (tdiv == 10'd1023)
      tsel <= (tsel == 4'd9) ? 4'd0 : tsel + 1'd1;
  end
end
always @* begin
  case (tsel)
  4'd0: timer = 4'h0; 4'd1: timer = 4'h1; 4'd2: timer = 4'h2; 4'd3: timer = 4'h3;
  4'd4: timer = 4'h4; 4'd5: timer = 4'h9; 4'd6: timer = 4'hA; 4'd7: timer = 4'hB;
  4'd8: timer = 4'hA; default: timer = 4'hD;
  endcase
end

// ---------------------------------------------------------------------------
// AYs

reg [3:0] ay_div = 0;
reg       ay_tick = 0;
always @(posedge clk) begin
  ay_tick <= 0;
  if (cen_z80) begin
    ay_div <= ay_div + 1'd1;       // AY clock = Z80 / 2, tick = AY / 8
    if (ay_div == 4'd15)
      ay_tick <= 1;
  end
end

wire        ay_sel = io && io_chip <= 3'd4;
wire  [7:0] ay_dout;
wire [11:0] ay_l, ay_r;

ay5x ays
  ( .clk(clk), .reset(reset), .tick(ay_tick)
  , .chip(io_chip), .addr_wr(io_wr_stb && ay_sel && A[1:0] == 2'b00)
  , .data_wr(io_wr_stb && ay_sel && A[1:0] == 2'b10)
  , .din(dout), .dout(ay_dout), .ioa_in2({4'b0000, timer})
  , .left(ay_l), .right(ay_r)
  );

// ---------------------------------------------------------------------------
// 8039

reg  [7:0] i8039_latch = 0;
reg        n_i8039_irq = 1;
wire       n_i8039_irq_clr;

always @(posedge clk) begin
  if (io_wr_stb && io_chip == 3'd6)
    i8039_latch <= dout;
  if (!n_i8039_irq_clr)
    n_i8039_irq <= 1;
  else if (io_wr_stb && io_chip == 3'd5)
    n_i8039_irq <= 0;
end

wire [7:0] mcu_db_o, mcu_p1, mcu_p2;
wire       mcu_ale, mcu_psen_n, mcu_rd_n;
reg  [7:0] mcu_alat = 0;
reg  [7:0] mcu_rom [0:4095];
reg  [7:0] mcu_rom_q;
wire [7:0] mcu_db_i = !mcu_psen_n ? mcu_rom_q :
                      !mcu_rd_n   ? i8039_latch : 8'hff;

assign n_i8039_irq_clr = mcu_p2[7];

always @(posedge clk) begin
  if (mcu_ale)
    mcu_alat <= mcu_db_o;
  mcu_rom_q <= mcu_rom[{mcu_p2[3:0], mcu_alat}];
  if (ld_we)
    mcu_rom[ld_a] <= ld_d;
end

t8039_notri u7H
  ( .xtal_i(clk), .xtal_en_i(cen_8m), .reset_n_i(!reset)
  , .t0_i(1'b0), .t0_o(), .t0_dir_o()
  , .int_n_i(n_i8039_irq), .ea_i(1'b1)
  , .rd_n_o(mcu_rd_n), .psen_n_o(mcu_psen_n), .wr_n_o(), .ale_o(mcu_ale)
  , .db_i(mcu_db_i), .db_o(mcu_db_o), .db_dir_o()
  , .t1_i(1'b0), .p2_i(8'hff), .p2_o(mcu_p2), .p2l_low_imp_o(), .p2h_low_imp_o()
  , .p1_i(8'hff), .p1_o(mcu_p1), .p1_low_imp_o(), .prog_n_o()
  );

// ---------------------------------------------------------------------------
// Z80 data in

always @* begin
  if (io && !n_rd)
    din = (io_chip <= 3'd4 && A[1:0] == 2'b01) ? ay_dout : 8'hff;
  else if (cs_rom)
    din = rom_q;
  else if (cs_ram)
    din = ram_q;
  else if (cs_lat)
    din = latch;
  else
    din = 8'hff;
end

// ---------------------------------------------------------------------------
// Mix and remove the DC level (one-pole high-pass at about 4Hz)

wire [13:0] mix_l = {2'b00, ay_l} + {4'b0000, mcu_p1, 2'b00};
wire [13:0] mix_r = {2'b00, ay_r};

reg [23:0] dc_l = 0, dc_r = 0;     // 14.10 fixed point averages
reg [13:0] smp_div = 0;
wire signed [15:0] hp_l = $signed({2'b00, mix_l}) - $signed({2'b00, dc_l[23:10]});
wire signed [15:0] hp_r = $signed({2'b00, mix_r}) - $signed({2'b00, dc_r[23:10]});

function [15:0] clip3(input signed [15:0] v);   // x3 with clipping
  reg signed [17:0] m;
  begin
    m = v * 3;
    clip3 = (m > 18'sd32767) ? 16'h7fff : (m < -18'sd32768) ? 16'h8000 : m[15:0];
  end
endfunction

always @(posedge clk) begin
  smp_div <= smp_div + 1'd1;
  if (smp_div == 0) begin          // 1526Hz update of the averages
    dc_l <= dc_l + {{4{hp_l[15]}}, hp_l, 4'b0000};   // time constant 64 updates
    dc_r <= dc_r + {{4{hp_r[15]}}, hp_r, 4'b0000};
  end
  audio_l <= clip3(hp_l <<< 2);
  audio_r <= clip3(hp_r <<< 2);
  if (reset) begin
    dc_l <= 0;
    dc_r <= 0;
  end
end

endmodule
