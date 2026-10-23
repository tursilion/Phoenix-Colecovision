// Galaga CPU board: three Z80s sharing all RAM, the Namco 06xx interface
// with the 51xx (inputs, coins) and 54xx (explosions) MCUs, interrupts,
// latches, DIP switches and the sound registers.  Written after MAME's
// galaga.cpp, namco06.cpp, namco51.cpp and namco54.cpp.
//
// Memory map (all three CPUs):
//   0000-3FFF ROM (each CPU its own; external SRAM, see galaga_phoenix.v)
//   6800-6807 R  DIP switches: b0 = switch B bit n, b1 = switch A bit n
//   6800-681F W  sound registers (4 bits)
//   6820-6827 W  latch bit 0: IRQ1 (main IRQ enable), IRQ2 (sub IRQ
//                enable), NMION (sound CPU NMI enable, active low), RESET
//                (low: sub CPUs and the 51xx/54xx in reset)
//   6830      W  watchdog (not modelled)
//   7000-70FF    06xx data          7100 06xx control
//   8000-87FF    video RAM (codes 8000-83FF, colours 8400-87FF)
//   8800-8BFF, 9000-93FF, 9800-9BFF  RAM 1-3 (sprite registers at 380-3FF)
//   A000-A007 W  video latch bit 0 (starfield control, flip)
//
// The CPUs share the RAMs through one port: a 3-way round robin at 25MHz
// serves each CPU every third clock, much faster than a Z80 bus cycle at
// 3MHz.  Each write is made once per bus cycle.

`timescale 1ns / 1ps

module galaga_main
   ( input             clk
   , input             reset         // all CPUs, latches and MCUs
   , input             boot_mode     // the main CPU runs the boot loader; the others stay in reset
   , input             cen_cpu       // 3.072MHz
   , input             cen_06        // 06xx timer tick base (96kHz)
   , input             cen_mcu       // MB88 instruction cycle (256kHz)
   , input             vblank        // game vertical blank
   , input             ev_vbl        // pulse: vertical blank starts
   , input             ev_nmi        // pulse: sound CPU NMI lines (64, 192)

   , input       [7:0] in0           // active low, as MAME's IN0 / IN1
   , input       [7:0] in1
   , input       [7:0] dswa
   , input       [7:0] dswb

   // CPU ROMs (SRAM): addresses and data
   , output     [15:0] a0
   , output     [15:0] a1
   , output     [15:0] a2
   , input       [7:0] rom_q0
   , input       [7:0] rom_q1
   , input       [7:0] rom_q2

   // Main CPU bus, for the boot loader
   , output      [7:0] z_dout
   , output            z_mreq_n
   , output            z_iorq_n
   , output            z_rd_n
   , output            z_wr_n
   , output            z_m1_n
   , output            z_rfsh_n
   , input             boot_sel
   , input       [7:0] boot_q

   // MCU ROM loading (51xx at 000, 54xx at 400)
   , input             ld_we
   , input      [10:0] ld_a
   , input       [7:0] ld_d

   // Video access
   , input       [9:0] vid_a         // video RAM (codes and colours)
   , output reg  [7:0] vid_code = 0
   , output reg  [7:0] vid_color = 0
   , input       [6:0] spr_a         // sprite registers (RAM 1-3, 380-3FF)
   , output reg  [7:0] spr_q1 = 0
   , output reg  [7:0] spr_q2 = 0
   , output reg  [7:0] spr_q3 = 0
   , output reg  [7:0] vlatch = 0

   // Sound
   , input       [4:0] sreg_a
   , output      [3:0] sreg_q
   , output reg  [3:0] n54_out0 = 0
   , output reg  [3:0] n54_out1 = 0
   , output reg  [3:0] n54_out2 = 0
   );

// ---------------------------------------------------------------------------
// CPUs

wire [15:0] A [0:2];
wire  [7:0] dout [0:2];
wire  [2:0] mreq_n, iorq_n, rd_n, wr_n, m1_n, rfsh_n;
wire  [7:0] din [0:2];
reg   [2:0] int_n = 3'b111;
wire  [2:0] nmi_n;
reg   [7:0] mlatch = 0;            // 6820-6827
wire        sub_reset = reset || boot_mode || !mlatch[3];

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) cpu0
  ( .m1_n(m1_n[0]), .mreq_n(mreq_n[0]), .iorq_n(iorq_n[0]), .rd_n(rd_n[0]), .wr_n(wr_n[0])
  , .rfsh_n(rfsh_n[0]), .halt_n(), .busak_n(), .A(A[0]), .dout(dout[0])
  , .reset_n(!reset), .clk(clk), .cen(cen_cpu), .wait_n(1'b1), .int_n(int_n[0])
  , .nmi_n(nmi_n[0]), .busrq_n(1'b1), .di(din[0])
  );

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) cpu1
  ( .m1_n(m1_n[1]), .mreq_n(mreq_n[1]), .iorq_n(iorq_n[1]), .rd_n(rd_n[1]), .wr_n(wr_n[1])
  , .rfsh_n(rfsh_n[1]), .halt_n(), .busak_n(), .A(A[1]), .dout(dout[1])
  , .reset_n(!sub_reset), .clk(clk), .cen(cen_cpu), .wait_n(1'b1), .int_n(int_n[1])
  , .nmi_n(1'b1), .busrq_n(1'b1), .di(din[1])
  );

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) cpu2
  ( .m1_n(m1_n[2]), .mreq_n(mreq_n[2]), .iorq_n(iorq_n[2]), .rd_n(rd_n[2]), .wr_n(wr_n[2])
  , .rfsh_n(rfsh_n[2]), .halt_n(), .busak_n(), .A(A[2]), .dout(dout[2])
  , .reset_n(!sub_reset), .clk(clk), .cen(cen_cpu), .wait_n(1'b1), .int_n(1'b1)
  , .nmi_n(nmi_n[2]), .busrq_n(1'b1), .di(din[2])
  );

assign a0 = A[0];
assign a1 = A[1];
assign a2 = A[2];

assign z_dout   = dout[0];
assign z_mreq_n = mreq_n[0];
assign z_iorq_n = iorq_n[0];
assign z_rd_n   = rd_n[0];
assign z_wr_n   = wr_n[0];
assign z_m1_n   = m1_n[0];
assign z_rfsh_n = rfsh_n[0];

// ---------------------------------------------------------------------------
// Shared bus

reg  [1:0] rr = 0;                 // CPU served this clock
reg  [2:0] wdone = 0;              // this bus cycle's write is made

always @(posedge clk)
  rr <= (rr == 2'd2) ? 2'd0 : rr + 1'd1;

wire [15:0] ba   = A[rr];
wire  [7:0] bd   = dout[rr];
wire        bmem = !mreq_n[rr] && rfsh_n[rr];
wire        brd  = bmem && !rd_n[rr];
wire        bwr  = bmem && !wr_n[rr] && !wdone[rr];

wire cs_vram = ba[15:11] == 5'b10000;
wire cs_ram1 = ba[15:11] == 5'b10001;
wire cs_ram2 = ba[15:11] == 5'b10010;
wire cs_ram3 = ba[15:11] == 5'b10011;
wire cs_68   = ba[15:11] == 5'b01101;
wire cs_06   = ba[15:11] == 5'b01110;
wire cs_vl   = ba[15:11] == 5'b10100;

always @(posedge clk) begin
  if (bwr)
    wdone[rr] <= 1;
  if (wr_n[0]) wdone[0] <= 0;
  if (wr_n[1]) wdone[1] <= 0;
  if (wr_n[2]) wdone[2] <= 0;
end

// Video RAM and RAM 1-3: port A the CPUs, port B the video
reg [7:0] vcode [0:1023];
reg [7:0] vcol  [0:1023];
reg [7:0] ram1  [0:1023];
reg [7:0] ram2  [0:1023];
reg [7:0] ram3  [0:1023];
reg [7:0] q_code = 0, q_col = 0, q_r1 = 0, q_r2 = 0, q_r3 = 0;

always @(posedge clk) begin
  if (bwr && cs_vram && !ba[10]) vcode[ba[9:0]] <= bd;
  q_code <= vcode[ba[9:0]];
end
always @(posedge clk) begin
  if (bwr && cs_vram && ba[10]) vcol[ba[9:0]] <= bd;
  q_col <= vcol[ba[9:0]];
end
always @(posedge clk) begin
  if (bwr && cs_ram1) ram1[ba[9:0]] <= bd;
  q_r1 <= ram1[ba[9:0]];
end
always @(posedge clk) begin
  if (bwr && cs_ram2) ram2[ba[9:0]] <= bd;
  q_r2 <= ram2[ba[9:0]];
end
always @(posedge clk) begin
  if (bwr && cs_ram3) ram3[ba[9:0]] <= bd;
  q_r3 <= ram3[ba[9:0]];
end

always @(posedge clk) begin
  vid_code  <= vcode[vid_a];
  vid_color <= vcol[vid_a];
end
always @(posedge clk) spr_q1 <= ram1[{3'b111, spr_a}];
always @(posedge clk) spr_q2 <= ram2[{3'b111, spr_a}];
always @(posedge clk) spr_q3 <= ram3[{3'b111, spr_a}];

// Registers and read data
wire [7:0] n06_q;                  // 06xx data read
reg  [7:0] n06_ctrl = 0;
reg  [7:0] dsw_q;
always @*
  dsw_q = {6'd0, dswa[ba[2:0]], dswb[ba[2:0]]};

reg [2:0] rsel = 0;                // source of the read issued last clock
reg [1:0] rtag = 0;
reg       rvalid = 0;
reg [7:0] rq_reg = 8'hff;
reg [7:0] shq [0:2];

always @(posedge clk) begin
  rvalid <= brd;
  rtag   <= rr;
  rsel   <= cs_vram ? (ba[10] ? 3'd2 : 3'd1) :
            cs_ram1 ? 3'd3 : cs_ram2 ? 3'd4 : cs_ram3 ? 3'd5 : 3'd0;
  rq_reg <= (cs_68 && ba[5:4] == 2'b00) ? dsw_q :
            (cs_06 && !ba[8]) ? n06_q :
            (cs_06 &&  ba[8]) ? n06_ctrl : 8'hff;
  if (rvalid)
    case (rsel)
    3'd1: shq[rtag] <= q_code;
    3'd2: shq[rtag] <= q_col;
    3'd3: shq[rtag] <= q_r1;
    3'd4: shq[rtag] <= q_r2;
    3'd5: shq[rtag] <= q_r3;
    default: shq[rtag] <= rq_reg;
    endcase
end

// CPU data in: interrupt vector (FF), ROM, shared bus
wire [2:0] rom_rg = {A[2][15:14] == 2'b00, A[1][15:14] == 2'b00, A[0][15:14] == 2'b00};
wire [2:0] inta   = ~(m1_n | iorq_n);
wire [2:0] io_rd  = ~(iorq_n | rd_n) & m1_n;

assign din[0] = boot_sel ? boot_q : (inta[0] || io_rd[0]) ? 8'hff : rom_rg[0] ? rom_q0 : shq[0];
assign din[1] = (inta[1] || io_rd[1]) ? 8'hff : rom_rg[1] ? rom_q1 : shq[1];
assign din[2] = (inta[2] || io_rd[2]) ? 8'hff : rom_rg[2] ? rom_q2 : shq[2];

// Latches and sound registers
reg [3:0] sreg [0:31];
assign sreg_q = sreg[sreg_a];

always @(posedge clk) begin
  if (bwr && cs_68 && !ba[5])
    sreg[ba[4:0]] <= bd[3:0];
end

always @(posedge clk) begin
  if (bwr && cs_68 && ba[5:4] == 2'b10)
    mlatch[ba[2:0]] <= bd[0];
  if (bwr && cs_vl)
    vlatch[ba[2:0]] <= bd[0];
  if (reset) begin
    mlatch <= 0;
    vlatch <= 0;
  end
end

// ---------------------------------------------------------------------------
// Interrupts: main and sub CPU IRQ at the start of vertical blank (held
// until the enable latch is cleared), sound CPU NMI on lines 64 and 192.

reg [5:0] nmi2_cnt = 0;

always @(posedge clk) begin
  if (ev_vbl && mlatch[0]) int_n[0] <= 0;
  if (ev_vbl && mlatch[1]) int_n[1] <= 0;
  if (!mlatch[0]) int_n[0] <= 1;
  if (!mlatch[1]) int_n[1] <= 1;

  if (ev_nmi && !mlatch[2])
    nmi2_cnt <= 6'd63;
  else if (nmi2_cnt != 0)
    nmi2_cnt <= nmi2_cnt - 1'd1;
end

assign nmi_n[2] = (nmi2_cnt == 0);

// ---------------------------------------------------------------------------
// 06xx: control register (b3-0 chip selects, b4 read, b7-5 clock divider);
// a timer at twice its clock divided by 2^divider makes the main CPU NMIs
// and the chip selects.  As MAME's namco06.cpp.

reg        nx_state = 0, nmi_str = 0, rw_str = 0, rw_chg = 0;
reg        n06_nmi = 0, n06_rw = 0;
reg  [3:0] n06_cs = 0;
reg [12:0] tdiv = 0;               // cen_06 ticks to the next timer tick
reg        tick_now = 0;
wire [12:0] tper = 13'd1 << n06_ctrl[7:5];             // 96kHz / 2^div

wire wr_06d = bwr && cs_06 && !ba[8];
wire wr_06c = bwr && cs_06 && ba[8];
wire n06_tick = n06_ctrl[7:5] != 0 && (tick_now || (cen_06 && tdiv == 1));

always @(posedge clk) begin
  tick_now <= 0;
  if (cen_06 && n06_ctrl[7:5] != 0)
    tdiv <= (tdiv <= 1) ? tper : tdiv - 1'd1;

  if (n06_tick) begin
    if (rw_chg && nx_state && !rw_str) begin
      n06_rw <= n06_ctrl[4];
      rw_chg <= 0;
    end
    n06_nmi  <= nx_state && !nmi_str;
    n06_cs   <= nx_state ? n06_ctrl[3:0] : 4'd0;
    nx_state <= !nx_state;
    nmi_str  <= 0;
    rw_str   <= 0;
    if (tick_now)
      tdiv <= tper;
  end

  if (wr_06c) begin
    n06_ctrl <= bd;
    if (bd[7:5] == 0) begin
      n06_nmi  <= 0;
      n06_cs   <= 0;
      nx_state <= 1;
    end else begin
      rw_str   <= !nx_state;
      rw_chg   <= 1;
      nx_state <= 1;
      nmi_str  <= bd[4];
      if (bd[4])
        n06_nmi <= 0;
      tick_now <= 1;               // first tick right away
    end
  end

  if (reset) begin
    n06_ctrl <= 0;
    n06_nmi  <= 0;
    n06_cs   <= 0;
    tick_now <= 0;
  end
end

assign nmi_n[0] = !n06_nmi;

// ---------------------------------------------------------------------------
// 51xx and 54xx

reg  [7:0] port_o = 0;             // 51xx O port / data to the main CPU
reg  [7:0] cmd54 = 0;
reg [11:0] irq54_cnt = 0;          // 100us IRQ pulse at 25MHz
wire [4:0] o51, o54;
wire       o51_we, o54_we;
wire [3:0] r54_we, r54_out;

assign n06_q = !n06_ctrl[4] ? 8'h00 : (n06_ctrl[0] ? port_o : 8'hff);

always @(posedge clk) begin
  if (wr_06d && !n06_ctrl[4]) begin
    if (n06_ctrl[0])
      port_o <= bd;
    if (n06_ctrl[3]) begin
      cmd54     <= bd;
      irq54_cnt <= 12'd2500;
    end
  end else if (irq54_cnt != 0)
    irq54_cnt <= irq54_cnt - 1'd1;

  if (o51_we) begin
    if (o51[4]) port_o[7:4] <= o51[3:0];
    else        port_o[3:0] <= o51[3:0];
  end
  if (o54_we) begin
    if (o54[4]) n54_out1 <= o54[3:0];
    else        n54_out0 <= o54[3:0];
  end
  if (r54_we[1])
    n54_out2 <= r54_out;
end

// MCU ROMs: port A the 51xx (and loading), port B the 54xx
reg  [7:0] mrom [0:2047];
reg  [7:0] mrom_qa = 0, mrom_qb = 0;
wire [9:0] m51_a, m54_a;
wire [10:0] mrom_aa = ld_we ? ld_a : {1'b0, m51_a};

always @(posedge clk) begin
  if (ld_we) mrom[mrom_aa] <= ld_d;
  mrom_qa <= mrom[mrom_aa];
end
always @(posedge clk)
  mrom_qb <= mrom[{1'b1, m54_a}];

wire mcu_reset = reset || boot_mode || !mlatch[3];

mb88 n51
  ( .clk(clk), .reset(mcu_reset), .cen(cen_mcu)
  , .rom_a(m51_a), .rom_q(mrom_qa)
  , .k_in({n06_rw, port_o[2:0]})
  , .r_in({in1[7:4], in1[3:0], in0[7:4], in0[3:0]})
  , .r_we(), .r_out()
  , .o_we(o51_we), .o_out(o51)
  , .p_we(), .p_out()
  , .irq(n06_cs[0]), .tc(!vblank)
  );

mb88 n54
  ( .clk(clk), .reset(mcu_reset), .cen(cen_mcu)
  , .rom_a(m54_a), .rom_q(mrom_qb)
  , .k_in(cmd54[7:4])
  , .r_in({12'd0, cmd54[3:0]})
  , .r_we(r54_we), .r_out(r54_out)
  , .o_we(o54_we), .o_out(o54)
  , .p_we(), .p_out()
  , .irq(irq54_cnt != 0), .tc(1'b0)
  );

`ifdef GA_SIM_TRACE
reg [2:0] m1d = 3'b111;
reg [2:0] want = 0;
reg [15:0] nfr = 0;
always @(posedge clk) begin
  m1d <= m1_n;
  if (ev_vbl) begin
    want <= 3'b111;
    nfr  <= nfr + 1'd1;
    $display("F%0d latch=%02x vl=%02x ctrl06=%02x portO=%02x", nfr, mlatch, vlatch, n06_ctrl, port_o);
  end
  if (want[0] && !m1_n[0] && m1d[0]) begin want[0] <= 0; $display("  main PC %04x", A[0]); end
  if (want[1] && !m1_n[1] && m1d[1]) begin want[1] <= 0; $display("  sub  PC %04x", A[1]); end
  if (want[2] && !m1_n[2] && m1d[2]) begin want[2] <= 0; $display("  snd  PC %04x", A[2]); end
end
`endif

endmodule
