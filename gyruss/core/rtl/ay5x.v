// Five AY-3-8910s sharing one engine.
//
// Gyruss has five AY-3-8910 PSGs.  Five separate cores would take about a
// quarter of the LX16, so this module keeps the registers and the counter
// state of all five chips in small distributed RAMs and runs one engine
// over them in turn.
//
// The engine follows MikeJ's YM2149 model (as used in many FPGA cores):
//   - tone counters count at clock/8 and toggle the output when they reach
//     the period (period 0 = period 1),
//   - the noise counter counts at clock/16 and steps a 17-bit LFSR,
//   - the envelope counter counts at clock/8 and steps a 32-level envelope,
//   - each channel's level is (tone or tone disabled) and (noise or noise
//     disabled), times the fixed volume or the envelope, through a 32-entry
//     logarithmic table.
//
// tick must pulse at clock/8 (one in 8 AY clocks).  A round over all five
// chips takes 70 clocks, so tick may come at most every 70 clocks.
//
// The outputs are the sums of the channel levels (0-255 each) of the chips
// in the left and right groups, updated once per round.

`timescale 1ns / 1ps

module ay5x
   ( input             clk
   , input             reset
   , input             tick

   // CPU side: one chip at a time
   , input       [2:0] chip         // 0-4
   , input             addr_wr      // latch the register address
   , input             data_wr      // write the addressed register
   , input       [7:0] din
   , output      [7:0] dout         // the addressed register
   , input       [7:0] ioa_in2      // chip 2 port A input (register 14)

   , output reg [11:0] left = 0     // chips 1 and 4
   , output reg [11:0] right = 0    // chips 0, 2 and 3
   );

// ---------------------------------------------------------------------------
// Registers: 5 x 16, index {chip, reg}

reg [7:0] regs [0:127];
reg [3:0] alatch [0:7];

wire [3:0] cpu_reg = alatch[chip];
assign dout = (chip == 3'd2 && cpu_reg == 4'd14) ? ioa_in2 : regs[{chip, cpu_reg}];

// Clear the registers after a reset
reg       clr = 1;
reg [6:0] clr_a = 0;

reg [4:0] erst = 0;               // envelope restart (register 13 written)

always @(posedge clk) begin
  if (reset) begin
    clr   <= 1;
    clr_a <= 0;
  end else if (clr) begin
    regs[clr_a] <= 8'd0;
    clr_a <= clr_a + 1'd1;
    if (clr_a == 7'd127)
      clr <= 0;
  end else if (data_wr)
    regs[{chip, cpu_reg}] <= din;

  if (addr_wr)
    alatch[chip] <= din[3:0];
end

// ---------------------------------------------------------------------------
// Engine

reg        busy = 0;
reg  [2:0] c = 0;                 // chip
reg  [3:0] s = 0;                 // step
reg        ntick = 0;             // noise counts every other tick

reg  [3:0] ra;                    // register read by this step
always @* begin
  case (s)
  4'd0: ra = 4'd0;    4'd1: ra = 4'd1;
  4'd2: ra = 4'd2;    4'd3: ra = 4'd3;
  4'd4: ra = 4'd4;    4'd5: ra = 4'd5;
  4'd6: ra = 4'd6;
  4'd7: ra = 4'd11;   4'd8: ra = 4'd12;
  4'd9: ra = 4'd13;
  4'd10: ra = 4'd7;
  4'd11: ra = 4'd8;   4'd12: ra = 4'd9;
  default: ra = 4'd10;
  endcase
end

wire [7:0] rd = regs[{c, ra}];

// State per chip (and per channel for the tones)
reg [12:0] tone [0:31];           // {output, counter}, index {chip, channel}
reg  [4:0] ncnt [0:7];
reg [16:0] poly [0:7];
reg [15:0] ecnt [0:7];
reg  [6:0] env  [0:7];            // {hold, inc, volume}

reg  [7:0] lo;
reg  [5:0] mix;
reg        eena;
reg [11:0] acc_l, acc_r;

wire [1:0]  ch   = (s >= 4'd11) ? s - 4'd11 : s[2:1];
wire [4:0]  ti   = {c, ch};
wire [12:0] t    = tone[ti];
wire [11:0] tper = {rd[3:0], lo};
wire [11:0] tcmp = (tper == 12'd0) ? 12'd0 : tper - 1'd1;

wire [4:0]  ncmp = (rd[4:0] == 5'd0) ? 5'd0 : rd[4:0] - 1'd1;
wire [16:0] p    = poly[c];

wire [15:0] eper = {rd, lo};
wire [15:0] ecmp = (eper == 16'd0) ? 16'd0 : eper - 1'd1;

wire [6:0] e     = env[c];
wire [4:0] evol  = e[4:0];
wire       einc  = e[5];
wire       ehold = e[6];

// Envelope step (MikeJ's shape control), shape = register 13
function [6:0] env_step(input [6:0] cur, input [3:0] shape);
  reg [4:0] v;
  reg inc, hold;
  reg bot, bot_p1, top_m1, top;
  begin
    v = cur[4:0]; inc = cur[5]; hold = cur[6];
    bot    = (v == 5'd0);
    bot_p1 = (v == 5'd1);
    top_m1 = (v == 5'd30);
    top    = (v == 5'd31);
    if (!hold)
      v = inc ? v + 1'd1 : v - 1'd1;
    if (!shape[3]) begin
      if (!inc) begin if (bot_p1) hold = 1; end
      else      begin if (top)    hold = 1; end
    end else if (shape[0]) begin
      if (!inc) begin
        if (shape[1]) begin if (bot) hold = 1; end
        else          begin if (bot_p1) hold = 1; end
      end else begin
        if (shape[1]) begin if (top) hold = 1; end
        else          begin if (top_m1) hold = 1; end
      end
    end else if (shape[1]) begin
      if (!inc) begin
        if (bot_p1) hold = 1;
        if (bot) begin hold = 0; inc = 1; end
      end else begin
        if (top_m1) hold = 1;
        if (top) begin hold = 0; inc = 0; end
      end
    end
    env_step = {hold, inc, v};
  end
endfunction

// Channel output level
wire       tbit  = t[12];
wire       nbit  = p[0];
wire       mixed = (mix[ch] | tbit) & (mix[ch + 3'd3] | nbit);
wire [4:0] amp   = !mixed ? 5'd0 :
                   rd[4] ? evol :
                   (rd[3:0] == 4'd0) ? 5'd0 : {rd[3:0], 1'b1};

reg [7:0] dac;
always @* begin
  case (amp)
  5'd31: dac = 8'hFF; 5'd30: dac = 8'hD9; 5'd29: dac = 8'hBA; 5'd28: dac = 8'h9F;
  5'd27: dac = 8'h88; 5'd26: dac = 8'h74; 5'd25: dac = 8'h63; 5'd24: dac = 8'h54;
  5'd23: dac = 8'h48; 5'd22: dac = 8'h3D; 5'd21: dac = 8'h34; 5'd20: dac = 8'h2C;
  5'd19: dac = 8'h25; 5'd18: dac = 8'h1F; 5'd17: dac = 8'h1A; 5'd16: dac = 8'h16;
  5'd15: dac = 8'h13; 5'd14: dac = 8'h10; 5'd13: dac = 8'h0D; 5'd12: dac = 8'h0B;
  5'd11: dac = 8'h09; 5'd10: dac = 8'h08; 5'd9:  dac = 8'h07; 5'd8:  dac = 8'h06;
  5'd7:  dac = 8'h05; 5'd6:  dac = 8'h04; 5'd5:  dac = 8'h03; 5'd4:  dac = 8'h03;
  5'd3:  dac = 8'h02; 5'd2:  dac = 8'h02; 5'd1:  dac = 8'h01; default: dac = 8'h00;
  endcase
end

wire to_left = (c == 3'd1 || c == 3'd4);

always @(posedge clk) begin
  if (tick && !busy) begin
    busy  <= 1;
    c     <= 0;
    s     <= 0;
    acc_l <= 0;
    acc_r <= 0;
    ntick <= !ntick;
  end else if (busy) begin
    case (s)
    4'd0, 4'd2, 4'd4, 4'd7:
      lo <= rd;
    4'd1, 4'd3, 4'd5:
      if (t[11:0] >= tcmp) tone[ti] <= {!t[12], 12'd0};
      else                 tone[ti] <= {t[12], t[11:0] + 1'd1};
    4'd6:
      if (ntick) begin
        if (ncnt[c] >= ncmp) begin
          ncnt[c] <= 0;
          poly[c] <= {p[0] ^ p[2] ^ (p == 17'd0), p[16:1]};
        end else
          ncnt[c] <= ncnt[c] + 1'd1;
      end
    4'd8:
      if (ecnt[c] >= ecmp) begin
        ecnt[c] <= 0;
        eena    <= 1;
      end else begin
        ecnt[c] <= ecnt[c] + 1'd1;
        eena    <= 0;
      end
    4'd9:
      if (erst[c])
        env[c] <= rd[2] ? 7'b0100000 : 7'b0011111;   // attack: up from 0
      else if (eena)
        env[c] <= env_step(e, rd[3:0]);
    4'd10:
      mix <= rd[5:0];
    default: begin       // 11-13: channels A-C
        if (to_left) acc_l <= acc_l + dac;
        else         acc_r <= acc_r + dac;
      end
    endcase

    if (s == 4'd13) begin
      s <= 0;
      if (c == 3'd4) begin
        busy  <= 0;
        left  <= acc_l + dac;      // chip 4 is a left chip
        right <= acc_r;
      end else
        c <= c + 1'd1;
    end else
      s <= s + 1'd1;
  end
end

// Envelope restart flags: set by a register 13 write, cleared when the
// engine has restarted that chip's envelope.
always @(posedge clk) begin
  if (busy && s == 4'd9)
    erst[c] <= 1'b0;
  if (data_wr && cpu_reg == 4'd13)
    erst[chip] <= 1'b1;
  if (reset)
    erst <= 5'h1f;
end

endmodule
