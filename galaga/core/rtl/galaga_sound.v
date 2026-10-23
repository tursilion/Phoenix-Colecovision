// Galaga sound: the Namco 3-voice waveform generator (WSG) and the filters
// on the 54xx outputs, mixed to one 16-bit channel.
//
// WSG (after MAME's namco.cpp): at 96kHz each voice adds its 20-bit
// frequency to a counter whose top 5 bits index a 32-sample waveform of
// the sound PROM (4 bits, 8 waveforms); the sample is (w - 8) * volume.
// A voice with volume 0 is silent and its counter stops.
//   Registers (4 bits): 05/0A/0F waveform, 10-14 / 16-19 / 1B-1E frequency
//   (voice 0 has the extra low 4 bits at 10), 15/1A/1F volume.
//
// 54xx outputs (after MAME's audio/galaga.cpp): each 4-bit output drives a
// resistor DAC (47K, 22K, 10K, 4.7K) into an op-amp multiple feedback
// band-pass filter, then an op-amp mixer.  Modelled as a DAC table and
// three state-variable band-pass filters at 48.8kHz:
//   output 2:  2521Hz, Q 1.74   output 1: 450Hz, Q 2.12   output 0: 167Hz, Q 2.47
// The levels are MAME's (WSG 0.9 x 10/16, discrete 0.9 x its 40800 gain).

`timescale 1ns / 1ps

module galaga_sound
   ( input             clk
   , input             reset
   , input             cen_wsg       // 96kHz

   , output reg  [4:0] sreg_a = 0
   , input       [3:0] sreg_q

   , input       [3:0] out0          // 54xx outputs
   , input       [3:0] out1
   , input       [3:0] out2

   , input             ld_wave_we    // sound PROM loading
   , input       [7:0] ld_a
   , input       [7:0] ld_d

   , output reg signed [15:0] audio = 0
   );

// ---------------------------------------------------------------------------
// WSG

reg  [3:0] wave [0:255];
always @(posedge clk)
  if (ld_wave_we) wave[ld_a] <= ld_d[3:0];

reg [19:0] acc [0:2];
reg  [4:0] j = 31;                 // register read step, 31 = idle
reg  [1:0] k = 0;                  // voice
reg  [2:0] w_sel = 0;
reg [19:0] w_f = 0;
reg  [3:0] w_vol = 0;
reg signed [10:0] w_sum = 0, w_out = 0;

wire [19:0] acc_n = acc[k] + w_f;
wire signed [4:0] w_s = {1'b0, wave[{w_sel, acc[k][19:15]}]} - 5'sd8;
wire signed [9:0] w_m = w_s * $signed({1'b0, w_vol});

// Register read order per voice: waveform, frequency 19:16 ... 7:4, then
// 3:0 (voice 0 only), volume
always @* begin
  case (j[2:0])
  3'd0: sreg_a = 5'h05 + 5'd5 * k;
  3'd1: sreg_a = 5'h14 + 5'd5 * k;
  3'd2: sreg_a = 5'h13 + 5'd5 * k;
  3'd3: sreg_a = 5'h12 + 5'd5 * k;
  3'd4: sreg_a = 5'h11 + 5'd5 * k;
  3'd5: sreg_a = 5'h10;
  default: sreg_a = 5'h15 + 5'd5 * k;
  endcase
end

integer i;
always @(posedge clk) begin
  if (cen_wsg) begin
    j     <= 0;
    k     <= 0;
    w_sum <= 0;
  end else if (j != 31) begin
    j <= j + 1'd1;
    case (j[2:0])
    3'd0: w_sel <= sreg_q[2:0];
    3'd1: w_f[19:16] <= sreg_q;
    3'd2: w_f[15:12] <= sreg_q;
    3'd3: w_f[11:8]  <= sreg_q;
    3'd4: w_f[7:4]   <= sreg_q;
    3'd5: w_f[3:0]   <= (k == 0) ? sreg_q : 4'd0;
    3'd6: w_vol <= sreg_q;
    default: begin                       // 7: add the voice
      if (w_vol != 0) begin
        acc[k] <= acc_n;
        w_sum  <= w_sum + w_m;
      end
      if (k == 2'd2) begin
        j <= 31;
        w_out <= (w_vol != 0) ? w_sum + w_m : w_sum;
      end else begin
        k <= k + 1'd1;
        j <= 0;
      end
    end
    endcase
  end
  if (reset) begin
    for (i = 0; i < 3; i = i + 1)
      acc[i] <= 0;
  end
end

// ---------------------------------------------------------------------------
// 54xx filters: lp += f bp; hp = in - lp - q bp; bp += f hp; out = g bp
// (states 26 bits with 12 fraction bits; coefficients / 65536)

function [7:0] dac(input [3:0] n);
  case (n)
  4'd0: dac = 0;    4'd1: dac = 14;   4'd2: dac = 31;   4'd3: dac = 45;
  4'd4: dac = 67;   4'd5: dac = 81;   4'd6: dac = 98;   4'd7: dac = 112;
  4'd8: dac = 143;  4'd9: dac = 157;  4'd10: dac = 174; 4'd11: dac = 188;
  4'd12: dac = 210; 4'd13: dac = 224; 4'd14: dac = 241; default: dac = 255;
  endcase
endfunction

reg  [8:0] fdiv = 0;
reg  [3:0] fs = 15;                // filter step, 15 = idle
reg  [1:0] fc = 0;                 // channel
reg signed [25:0] lp [0:2];
reg signed [25:0] bp [0:2];
reg signed [25:0] hp = 0;
reg signed [17:0] f_out [0:2];
reg signed [19:0] d_sum = 0;

wire [3:0] f_in_n = (fc == 0) ? out2 : (fc == 1) ? out1 : out0;
wire signed [25:0] f_in = {6'd0, dac(f_in_n), 12'd0};

reg signed [17:0] coef;
reg signed [25:0] mop;
always @* begin
  case (fs[1:0])
  2'd0: begin mop = bp[fc]; coef = (fc == 0) ? 18'sd21167 : (fc == 1) ? 18'sd3798  : 18'sd1412;  end  // f
  2'd1: begin mop = bp[fc]; coef = (fc == 0) ? 18'sd37613 : (fc == 1) ? 18'sd30875 : 18'sd26511; end  // q
  2'd2: begin mop = hp;     coef = (fc == 0) ? 18'sd21167 : (fc == 1) ? 18'sd3798  : 18'sd1412;  end  // f
  default: begin mop = bp[fc]; coef = (fc == 0) ? 18'sd567 : (fc == 1) ? 18'sd656 : 18'sd1894; end   // g
  endcase
end
wire signed [43:0] prod = mop * coef;
wire signed [25:0] pm   = prod[41:16];

always @(posedge clk) begin
  fdiv <= fdiv + 1'd1;
  if (fdiv == 0) begin
    fs <= 0;
    fc <= 0;
  end else if (fs != 15) begin
    case (fs[1:0])
    2'd0: lp[fc] <= lp[fc] + pm;
    2'd1: hp <= f_in - lp[fc] - pm;
    2'd2: bp[fc] <= bp[fc] + pm;
    default: f_out[fc] <= pm[17:0];
    endcase
    if (fs[1:0] == 2'd3) begin
      if (fc == 2'd2) begin
        fs    <= 15;
        d_sum <= f_out[0] + f_out[1] + $signed(pm[17:0]);
      end else begin
        fc <= fc + 1'd1;
        fs <= 0;
      end
    end else
      fs <= fs + 1'd1;
  end
  if (reset) begin
    for (i = 0; i < 3; i = i + 1) begin
      lp[i] <= 0;
      bp[i] <= 0;
      f_out[i] <= 0;
    end
  end
end

// ---------------------------------------------------------------------------
// Mix: WSG x 48 (0.9 x 10/16 x 256/3) plus the filters, clipped

wire signed [21:0] mix = $signed(w_out) * 22'sd48 + d_sum;

always @(posedge clk)
  audio <= (mix > 22'sd32767) ? 16'sh7fff : (mix < -22'sd32768) ? 16'sh8000 : mix[15:0];

endmodule
