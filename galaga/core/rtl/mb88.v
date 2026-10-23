// Fujitsu MB8843 / MB8844 4-bit MCU (Namco 51xx and 54xx), written after
// MAME's mb88xx.cpp (Ernesto Corvi): 1K ROM, 64 x 4-bit RAM, the same
// instruction semantics, flags, timer and interrupts.  The serial port is
// not implemented (the Namco chips do not use it).
//
// cen is the instruction cycle enable (the chip clock / 6, 256kHz on
// Galaga).  An instruction takes 1 or 2 cycles, an interrupt 3 more.  The
// ROM is external: rom_a is the address, rom_q its data one clock later
// (a block RAM).
//
// Ports
//   k_in        K input (4 bits)
//   r_in[4n+3:4n]  R port n input        r_we[n] / r_out  R port n output
//   o_we / o_out   O output: {carry, A} as MAME's PLA-less outO
//   p_we / p_out   P output
//   irq         the /IRQ pin, active high here (rising edge: interrupt)
//   tc          external timer clock (falling edge counts)

`timescale 1ns / 1ps

module mb88
   ( input             clk
   , input             reset
   , input             cen

   , output      [9:0] rom_a
   , input       [7:0] rom_q

   , input       [3:0] k_in
   , input      [15:0] r_in
   , output reg  [3:0] r_we = 0
   , output reg  [3:0] r_out = 0
   , output reg        o_we = 0
   , output reg  [4:0] o_out = 0
   , output reg        p_we = 0
   , output reg  [3:0] p_out = 0
   , input             irq
   , input             tc
   );

reg  [5:0] pc = 0;
reg  [3:0] pa = 0;
reg [12:0] stk [0:3];              // {cf, zf, st, pa, pc}
reg  [1:0] si = 0;
reg  [3:0] a = 0, x = 0, y = 0;
reg        st = 1, zf = 0, cf = 0, vf = 0, sf = 0, nf = 0;
reg  [7:0] pio = 0;
reg  [3:0] th = 0, tl = 0, sb = 0;
reg  [4:0] tp = 0;
reg  [2:0] pend = 0;               // b0 serial, b1 timer, b2 external
reg        ctr = 0;
reg  [3:0] ram [0:63];

wire [9:0] pcf = {pa, pc};

// Instruction sequencing: phase 0 waits for cen (ROM address = PC, so the
// opcode is ready), phase 1 reads the byte after it, phase 2 executes,
// phase 3 takes a pending interrupt.
reg  [1:0] ph = 0;
reg  [2:0] wait_n = 0;             // cycles still to wait
reg  [7:0] op = 0;

assign rom_a = (ph == 2'd0) ? pcf : pcf + 1'd1;

wire [7:0] arg = rom_q;            // valid in phase 2
// RAM address: X:Y, or 0-7 for xd / xyd (50-57)
wire [5:0] ea  = (op[7:3] == 5'b01010) ? {3'b000, op[2:0]} : {x[1:0], y};
wire [3:0] m   = ram[ea];
reg        ram_we;
reg  [3:0] ram_wd;

// R port read as MAME's read_r[n] (one port per chip pin group)
function [3:0] rsel(input [15:0] r, input [1:0] n);
  rsel = r >> {n, 2'b00};
endfunction

wire [3:0] r_y   = rsel(r_in, y[1:0]);      // inR, outR: Y & 3
wire [3:0] r_y4  = rsel(r_in, y[3:2]);      // setR, rstR, tstR: Y / 4
wire [3:0] bit_y = 4'b0001 << y[1:0];
wire [3:0] bit_o = 4'b0001 << op[1:0];

// 5-bit results: bit 4 is the carry or borrow
wire [4:0] y_inc = {1'b0, y} + 1'd1;
wire [4:0] y_dec = {1'b0, y} - 1'd1;
wire [4:0] m_inc = {1'b0, m} + 1'd1;
wire [4:0] m_dec = {1'b0, m} - 1'd1;
wire [4:0] add_c = {1'b0, m} + {1'b0, a} + cf;
wire [4:0] sub_c = {1'b0, m} - {1'b0, a} - cf;
wire [4:0] add_i = {1'b0, a} + {1'b0, op[3:0]};
wire [4:0] cmp_m = {1'b0, m} - {1'b0, a};
wire [4:0] cmp_y = {1'b0, op[3:0]} - {1'b0, y};
wire [4:0] cmp_a = {1'b0, op[3:0]} - {1'b0, a};
wire [4:0] daa   = (cf || a > 4'd9) ? {1'b0, a} + 5'd6  : {1'b0, a};
wire [4:0] das   = (cf || a > 4'd9) ? {1'b0, a} + 5'd10 : {1'b0, a};
wire [3:0] a_and = a & m;
wire [3:0] a_or  = a | m;
wire [3:0] a_eor = a ^ m;
wire [3:0] a_neg = ~a + 1'd1;

// Timer: count one, as MAME's increment_timer
reg        t_inc;                  // computed in the main block
reg  [4:0] tp_n;

reg irq_d = 0, tc_d = 0;
integer i;

always @(posedge clk) begin
  r_we <= 0;
  o_we <= 0;
  p_we <= 0;
  ram_we = 0;
  ram_wd = 0;
  t_inc  = 0;

  irq_d <= irq;
  tc_d  <= tc;

  if (ph == 2'd0) begin
    if (cen) begin
      if (wait_n != 0)
        wait_n <= wait_n - 1'd1;
      else begin
        op <= rom_q;
        ph <= 2'd1;
      end
    end
  end else if (ph == 2'd1)
    ph <= 2'd2;
  else if (ph == 2'd3) begin
    // Take an interrupt after the instruction (MAME's update_pio)
    ph <= 2'd0;
    if ((pend & pio[2:0]) != 0) begin
      stk[si] <= {cf, zf, st, pcf};
      si      <= si + 1'd1;
      pa      <= 0;
      pc      <= (pend[2] & pio[2]) ? 6'd2 : (pend[1] & pio[1]) ? 6'd4 : 6'd6;
      st      <= 1;
      pend    <= 0;
      wait_n  <= wait_n + 3'd3;
    end
  end else begin
    // ---------------------------------------------------------------
    // Execute (opcode op, its argument byte arg)
    ph     <= 2'd3;
    wait_n <= 0;
    {pa, pc} <= pcf + 1'd1;
    tp_n  = tp;

    casez (op)
    8'h00: st <= 1;                                             // nop
    8'h01: begin o_out <= {cf, a}; o_we <= 1; st <= 1; end      // outO
    8'h02: begin p_out <= a; p_we <= 1; st <= 1; end            // outP
    8'h03: begin r_out <= a; r_we <= 4'b0001 << y[1:0]; st <= 1; end   // outR
    8'h04: begin y <= a; st <= 1; end                           // tay
    8'h05: begin th <= a; st <= 1; end                          // tath
    8'h06: begin tl <= a; st <= 1; end                          // tatl
    8'h07: begin sb <= a; st <= 1; end                          // tas
    8'h08: begin y <= y_inc[3:0]; st <= !y_inc[4]; zf <= (y_inc[3:0] == 0); end        // icy
    8'h09: begin ram_we = 1; ram_wd = m_inc[3:0]; st <= !m_inc[4]; zf <= (m_inc[3:0] == 0); end  // icm
    8'h0a: begin ram_we = 1; ram_wd = a; y <= y_inc[3:0]; st <= !y_inc[4]; zf <= (y_inc[3:0] == 0); end // stic
    8'h0b: begin ram_we = 1; ram_wd = a; a <= m; zf <= (m == 0); st <= 1; end                    // x
    8'h0c: begin a <= {a[2:0], cf}; st <= !a[3]; cf <= a[3]; zf <= ({a[2:0], cf} == 0); end // rol
    8'h0d: begin a <= m; zf <= (m == 0); st <= 1; end           // l
    8'h0e: begin a <= add_c[3:0]; st <= !add_c[4]; cf <= add_c[4]; zf <= (add_c[3:0] == 0); end // adc
    8'h0f: begin a <= a_and; zf <= (a_and == 0); st <= (a_and != 0); end   // and
    8'h10: begin a <= daa[3:0]; st <= !daa[4]; cf <= daa[4]; end           // daa
    8'h11: begin a <= das[3:0]; st <= !das[4]; cf <= das[4]; end           // das
    8'h12: begin a <= k_in; zf <= (k_in == 0); st <= 1; end     // inK
    8'h13: begin a <= r_y; zf <= (r_y == 0); st <= 1; end       // inR
    8'h14: begin a <= y; zf <= (y == 0); st <= 1; end           // tya
    8'h15: begin a <= th; zf <= (th == 0); st <= 1; end         // ttha
    8'h16: begin a <= tl; zf <= (tl == 0); st <= 1; end         // ttla
    8'h17: begin a <= sb; zf <= (sb == 0); st <= 1; end         // tsa
    8'h18: begin y <= y_dec[3:0]; st <= !y_dec[4]; end         // dcy
    8'h19: begin ram_we = 1; ram_wd = m_dec[3:0]; st <= !m_dec[4]; zf <= (m_dec[3:0] == 0); end  // dcm
    8'h1a: begin ram_we = 1; ram_wd = a; y <= y_dec[3:0]; st <= !y_dec[4]; zf <= (y_dec[3:0] == 0); end // stdc
    8'h1b: begin x <= a; a <= x; zf <= (x == 0); st <= 1; end   // xx
    8'h1c: begin a <= {cf, a[3:1]}; st <= !a[0]; cf <= a[0]; zf <= ({cf, a[3:1]} == 0); end // ror
    8'h1d: begin ram_we = 1; ram_wd = a; st <= 1; end                     // st
    8'h1e: begin a <= sub_c[3:0]; st <= !sub_c[4]; cf <= sub_c[4]; zf <= (sub_c[3:0] == 0); end // sbc
    8'h1f: begin a <= a_or; zf <= (a_or == 0); st <= (a_or != 0); end      // or
    8'h20: begin r_out <= r_y4 | bit_y;  r_we <= 4'b0001 << y[3:2]; st <= 1; end      // setR
    8'h21: begin cf <= 1; st <= 1; end                          // setc
    8'h22: begin r_out <= r_y4 & ~bit_y; r_we <= 4'b0001 << y[3:2]; st <= 1; end      // rstR
    8'h23: begin cf <= 0; st <= 1; end                          // rstc
    8'h24: st <= !(r_y4[y[1:0]]);                               // tstr
    8'h25: st <= !nf;                                           // tsti
    8'h26: begin st <= !vf; vf <= 0; end                        // tstv
    8'h27: begin st <= !sf; sf <= 0; end                        // tsts
    8'h28: st <= !cf;                                           // tstc
    8'h29: st <= !zf;                                           // tstz
    8'h2a: begin ram_we = 1; ram_wd = sb; zf <= (sb == 0); st <= 1; end   // sts
    8'h2b: begin sb <= m; zf <= (m == 0); st <= 1; end          // ls
    8'h2c: begin si <= si - 1'd1; {pa, pc} <= stk[si - 1'd1][9:0]; st <= 1; end      // rts
    8'h2d: begin a <= a_neg; st <= (a_neg != 0); end            // neg
    8'h2e: begin cf <= cmp_m[4]; st <= (cmp_m[3:0] != 0); zf <= (cmp_m[3:0] == 0); end // c
    8'h2f: begin a <= a_eor; st <= (a_eor != 0); zf <= (a_eor == 0); end  // eor
    8'b0011_00??: begin ram_we = 1; ram_wd = m | bit_o;  st <= 1; end     // sbit
    8'b0011_01??: begin ram_we = 1; ram_wd = m & ~bit_o; st <= 1; end     // rbit
    8'b0011_10??: st <= !(m[op[1:0]]);                          // tbit
    8'h3c: begin                                                // rti
      si <= si - 1'd1;
      {cf, zf, st, pa, pc} <= stk[si - 1'd1];
    end
    8'h3d: begin pa <= arg[3:0]; pc <= {a, 2'b00}; wait_n <= 1; st <= 1; end         // jpa
    8'h3e: begin pio <= pio | arg;  {pa, pc} <= pcf + 2'd2; wait_n <= 1; st <= 1; end // en
    8'h3f: begin pio <= pio & ~arg; {pa, pc} <= pcf + 2'd2; wait_n <= 1; st <= 1; end // dis
    8'b0100_00??: begin r_out <= rsel(r_in, 2'd0) | bit_o;  r_we <= 4'b0001; st <= 1; end  // setD
    8'b0100_01??: begin r_out <= rsel(r_in, 2'd0) & ~bit_o; r_we <= 4'b0001; st <= 1; end  // rstD
    8'b0100_10??: st <= !(r_in[8 + op[1:0]]);                   // tstD (port 2)
    8'b0100_11??: st <= !(a[op[1:0]]);                          // tba
    8'b0101_00??: begin ram_we = 1; ram_wd = a; a <= m; zf <= (m == 0); st <= 1; end      // xd
    8'b0101_01??: begin ram_we = 1; ram_wd = y; y <= m; zf <= (m == 0); st <= 1; end      // xyd
    8'b0101_1???: begin x <= {1'b0, op[2:0]}; zf <= (op[2:0] == 0); st <= 1; end           // lxi
    8'b0110_0???: begin                                         // call
      wait_n <= 1;
      {pa, pc} <= pcf + 2'd2;
      if (st) begin
        stk[si] <= {3'b000, pcf + 2'd2};
        si <= si + 1'd1;
        pc <= arg[5:0];
        pa <= {op[1:0], arg[7:6]};
      end
      st <= 1;
    end
    8'b0110_1???: begin                                         // jpl
      wait_n <= 1;
      {pa, pc} <= pcf + 2'd2;
      if (st) begin
        pc <= arg[5:0];
        pa <= {op[1:0], arg[7:6]};
      end
      st <= 1;
    end
    8'b0111_????: begin a <= add_i[3:0]; st <= !add_i[4]; cf <= add_i[4]; zf <= (add_i[3:0] == 0); end // ai
    8'b1000_????: begin y <= op[3:0]; zf <= (op[3:0] == 0); st <= 1; end                    // lyi
    8'b1001_????: begin a <= op[3:0]; zf <= (op[3:0] == 0); st <= 1; end                    // li
    8'b1010_????: begin cf <= cmp_y[4]; st <= (cmp_y[3:0] != 0); zf <= (cmp_y[3:0] == 0); end // cyi
    8'b1011_????: begin cf <= cmp_a[4]; st <= (cmp_a[3:0] != 0); zf <= (cmp_a[3:0] == 0); end // ci
    default: begin                                              // jmp (c0-ff)
      if (st)
        pc <= op[5:0];
      st <= 1;
    end
    endcase

    // Internal timer clock (prescaler 32), then interrupts, as MAME's
    // update_pio after each instruction
    if (pio[7]) begin
      tp_n = tp + ((op == 8'h3d || op == 8'h3e || op == 8'h3f || op[7:4] == 4'h6) ? 5'd2 : 5'd1);
      if (tp_n < tp)                       // passed 32
        t_inc = 1;
      tp <= tp_n;
    end
  end

  // Timer increments (internal prescaler, external clock on its falling
  // edge) and the interrupt they may cause
  if ((ph == 2'd2 && t_inc) || (pio[6] && tc_d && !tc)) begin
    tl <= tl + 1'd1;
    if (tl == 4'hf) begin
      th <= th + 1'd1;
      if (th == 4'hf) begin
        vf      <= 1;
        pend[1] <= 1;
      end
    end
  end

  // External interrupt on a rising edge of /IRQ (here: irq) when enabled
  if (irq && !irq_d) begin
    if (pio[2] && !nf)
      pend[2] <= 1;
  end
  if (irq != irq_d)
    nf <= irq;

  if (ram_we)
    ram[ea] <= ram_wd;

  if (reset) begin
    ph     <= 0;
    wait_n <= 0;
    pc     <= 0;
    pa     <= 0;
    si     <= 0;
    a      <= 0;
    x      <= 0;
    y      <= 0;
    st     <= 1;
    zf     <= 0;
    cf     <= 0;
    vf     <= 0;
    sf     <= 0;
    pio    <= 0;
    th     <= 0;
    tl     <= 0;
    tp     <= 0;
    sb     <= 0;
    pend   <= 0;
    for (i = 0; i < 4; i = i + 1)
      stk[i] <= 0;
  end
end

endmodule
