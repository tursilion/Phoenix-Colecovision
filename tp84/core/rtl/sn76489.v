// SN76489A-style PSG (the Y2404 of Time Pilot '84), after MAME's
// sn76496.cpp model of the Y2404: tone and noise counters step every 8
// chip clocks (output frequency = clock / (16 N), period 0 = 1024), a 17-bit
// noise LFSR with taps at bits 2 and 3, and 2dB volume steps.
//
// clk_en is the chip clock enable (1.79MHz on TP84).  wr writes din, as a
// write to the chip's data bus.  out is the sum of the four channels,
// 0-255 each.

`timescale 1ns / 1ps

module sn76489
   ( input            clk
   , input            reset
   , input            clk_en
   , input            wr
   , input      [7:0] din
   , output reg [9:0] out = 0
   );

reg  [9:0] period [0:2];
reg  [3:0] vol [0:3];
reg  [2:0] nreg = 0;
reg  [2:0] last = 0;
reg [11:0] cnt [0:3];
reg  [3:0] tog = 0;
reg [16:0] rng = 17'h10000;
reg  [2:0] div = 0;
reg  [1:0] ch = 0;              // channel stepped this clock (one per clk_en)
reg        step = 0;

wire [11:0] tper2 = (period[2] == 10'd0) ? 12'd1024 : {2'b00, period[2]};
wire [11:0] nper  = (nreg[1:0] == 2'b11) ? {tper2[10:0], 1'b0} : (12'd32 << nreg[1:0]);

function [7:0] level(input [3:0] v);
  case (v)
  4'd0: level = 8'd255;  4'd1: level = 8'd203;  4'd2: level = 8'd161;  4'd3: level = 8'd128;
  4'd4: level = 8'd102;  4'd5: level = 8'd81;   4'd6: level = 8'd64;   4'd7: level = 8'd51;
  4'd8: level = 8'd40;   4'd9: level = 8'd32;   4'd10: level = 8'd26;  4'd11: level = 8'd20;
  4'd12: level = 8'd16;  4'd13: level = 8'd13;  4'd14: level = 8'd10;  default: level = 8'd0;
  endcase
endfunction

wire [11:0] c   = cnt[ch];
wire [11:0] per = (ch == 2'd3) ? nper :
                  (period[ch] == 10'd0) ? 12'd1024 : {2'b00, period[ch]};
wire        fb  = rng[2] ^ (rng[3] & nreg[2]);

integer i;
always @(posedge clk) begin
  // writes
  if (wr) begin
    if (din[7]) begin
      last <= din[6:4];
      case (din[6:4])
      3'd0: period[0][3:0] <= din[3:0];
      3'd2: period[1][3:0] <= din[3:0];
      3'd4: period[2][3:0] <= din[3:0];
      3'd6: begin nreg <= din[2:0]; rng <= 17'h10000; end
      3'd1: vol[0] <= din[3:0];
      3'd3: vol[1] <= din[3:0];
      3'd5: vol[2] <= din[3:0];
      default: vol[3] <= din[3:0];
      endcase
    end else begin
      case (last)
      3'd0: period[0][9:4] <= din[5:0];
      3'd2: period[1][9:4] <= din[5:0];
      3'd4: period[2][9:4] <= din[5:0];
      3'd6: begin nreg <= din[2:0]; rng <= 17'h10000; end
      3'd1: vol[0] <= din[3:0];
      3'd3: vol[1] <= din[3:0];
      3'd5: vol[2] <= din[3:0];
      default: vol[3] <= din[3:0];
      endcase
    end
  end

  // counters: every 8 chip clocks; the four channels are stepped on four
  // consecutive chip clocks
  if (clk_en) begin
    div <= div + 1'd1;
    if (div == 3'd7)
      step <= 1;
    if (step) begin
      if (c <= 12'd1) begin
        cnt[ch] <= per;
        if (ch == 2'd3)
          rng <= {fb, rng[16:1]};
        else
          tog[ch] <= !tog[ch];
      end else
        cnt[ch] <= c - 1'd1;
      ch <= ch + 1'd1;
      if (ch == 2'd3)
        step <= 0;
    end
  end

  out <= (tog[0] ? level(vol[0]) : 10'd0) + (tog[1] ? level(vol[1]) : 10'd0)
       + (tog[2] ? level(vol[2]) : 10'd0) + (rng[0] ? level(vol[3]) : 10'd0);

  if (reset) begin
    for (i = 0; i < 4; i = i + 1) begin
      vol[i] <= 4'hf;
      cnt[i] <= 0;
    end
    for (i = 0; i < 3; i = i + 1)
      period[i] <= 0;
    nreg <= 0;
    last <= 0;
    rng  <= 17'h10000;
    step <= 0;
    ch   <= 0;
  end
end

endmodule
