// Time Pilot '84 sound board: Z80 at 3.58MHz and three SN76489A-type PSGs
// at 1.79MHz (sn76489.v).
//
// Memory map (from MAME and Ace's TimePilot84_SND.sv, MiSTer):
//   0000-1FFF ROM (external SRAM)   4000-5FFF RAM (1K)   6000 sound latch
//   8000 timer (Z80 clock / 1024, low 4 bits)   A000-BFFF RC filter select
//   C000 PSG data latch   C001 / C003 / C004 write it to PSG 1 / 2 / 3
// The RC filters are not modelled.
//
// In boot mode this Z80 runs the boot loader: the PSGs are not written,
// and boot_sel / boot_q (from tp84_phoenix.v) supply the data
// for the loader's memory and I/O.

`timescale 1ns / 1ps

module tp84_sound
   ( input             clk
   , input             reset
   , input             cen_z80      // 3.579545MHz
   , input             boot_mode

   , input       [7:0] latch
   , input             irq_trigger

   // ROM (SRAM)
   , input       [7:0] rom_q

   // Z80 bus, for the ROM fetch and the boot loader
   , output     [15:0] z_a
   , output      [7:0] z_dout
   , output            z_mreq_n
   , output            z_iorq_n
   , output            z_rd_n
   , output            z_wr_n
   , output            z_m1_n
   , output            z_rfsh_n
   , input             boot_sel
   , input       [7:0] boot_q

   , output reg signed [15:0] audio = 0
   );

wire [15:0] A;
wire  [7:0] dout;
wire        n_m1, n_mreq, n_iorq, n_rd, n_wr, n_rfsh;
reg         n_irq = 1;
reg   [7:0] din;

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) A9
  ( .m1_n(n_m1), .mreq_n(n_mreq), .iorq_n(n_iorq), .rd_n(n_rd), .wr_n(n_wr)
  , .rfsh_n(n_rfsh), .halt_n(), .busak_n(), .A(A), .dout(dout)
  , .reset_n(!reset), .clk(clk), .cen(cen_z80), .wait_n(1'b1), .int_n(n_irq)
  , .nmi_n(1'b1), .busrq_n(1'b1), .di(din)
  );

assign z_a      = A;
assign z_dout   = dout;
assign z_mreq_n = n_mreq;
assign z_iorq_n = n_iorq;
assign z_rd_n   = n_rd;
assign z_wr_n   = n_wr;
assign z_m1_n   = n_m1;
assign z_rfsh_n = n_rfsh;

wire mem    = !n_mreq && n_rfsh;
wire cs_rom = mem && A[15:13] == 3'b000;
wire cs_ram = mem && A[15:13] == 3'b010 && !(boot_mode && A[12]);   // boot: 5000 is the shared RAM
wire cs_lat = mem && A[15:13] == 3'b011;
wire cs_tmr = mem && A[15:13] == 3'b100;
wire cs_sn  = mem && A[15:13] == 3'b110 && !boot_mode;

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
  else if (irq_trigger && !boot_mode)
    n_irq <= 0;
end

// Timer
reg [13:0] tdiv = 0;
always @(posedge clk)
  if (cen_z80) tdiv <= tdiv + 1'd1;
wire [3:0] timer = tdiv[13:10];

// PSGs
reg wr_d = 1;
wire wr_stb = !n_wr && wr_d;
always @(posedge clk) wr_d <= n_wr;

reg [7:0] sn_d = 0;
always @(posedge clk)
  if (wr_stb && cs_sn && A[2:0] == 3'd0)
    sn_d <= dout;

reg  sn_ph = 0;                    // PSG clock = Z80 clock / 2
always @(posedge clk)
  if (cen_z80) sn_ph <= !sn_ph;
wire sn_cen = cen_z80 && sn_ph;

wire [9:0] sn0_out, sn2_out, sn3_out;
sn76489 E5 ( .clk(clk), .reset(reset), .clk_en(sn_cen), .wr(wr_stb && cs_sn && A[2:0] == 3'd1), .din(sn_d), .out(sn0_out) );
sn76489 E6 ( .clk(clk), .reset(reset), .clk_en(sn_cen), .wr(wr_stb && cs_sn && A[2:0] == 3'd3), .din(sn_d), .out(sn2_out) );
sn76489 E7 ( .clk(clk), .reset(reset), .clk_en(sn_cen), .wr(wr_stb && cs_sn && A[2:0] == 3'd4), .din(sn_d), .out(sn3_out) );

// Z80 data in
always @* begin
  if (boot_sel)
    din = boot_q;
  else if (cs_ram)
    din = ram_q;
  else if (boot_mode)
    din = 8'hff;
  else if (cs_rom)
    din = rom_q;
  else if (cs_lat)
    din = latch;
  else if (cs_tmr)
    din = {4'hf, timer};
  else
    din = 8'hff;
end

// ---------------------------------------------------------------------------
// Mix and remove the DC level (one-pole high-pass at about 4Hz)

wire [13:0] mix = {2'b00, sn0_out} + {2'b00, sn2_out} + {2'b00, sn3_out};

reg [23:0] dc = 0;                 // 14.10 fixed point average
reg [13:0] smp_div = 0;
wire signed [15:0] hp = $signed({2'b00, mix}) - $signed({2'b00, dc[23:10]});

function [15:0] clip8(input signed [15:0] v);   // x8 with clipping
  reg signed [18:0] m;
  begin
    m = v * 8;
    clip8 = (m > 19'sd32767) ? 16'h7fff : (m < -19'sd32768) ? 16'h8000 : m[15:0];
  end
endfunction

always @(posedge clk) begin
  smp_div <= smp_div + 1'd1;
  if (smp_div == 0)
    dc <= dc + {{4{hp[15]}}, hp, 4'b0000};
  audio <= clip8(hp);
  if (reset)
    dc <= 0;
end

endmodule
