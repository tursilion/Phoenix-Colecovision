// Disc audio: plays the 2000 stereo samples stored with each frame
// (1/23.976 s at 47.952kHz) while the player is playing.
//
// The disc's frame numbers count film frames, which last 3 or 2 fields
// (3:2 pulldown), so the audio does not restart at each frame tick: it
// plays on continuously, 2000 samples a frame, and only follows the
// player's frame number when they differ by more than one frame (a search
// or a jump).

`timescale 1ns / 1ps

module disc_audio
  ( input             clk
  , input             reset

  , input             frame_tick
  , input      [15:0] frame
  , input             playing
  , input             audio1        // left channel enable
  , input             audio2        // right channel enable
  , input      [15:0] v_lo
  , input      [15:0] v_hi

  // SRAM read port
  , output reg        rd_req = 0
  , output     [18:0] rd_addr
  , input             rd_ack
  , input             rd_valid
  , input       [7:0] rd_data

  , output reg signed [15:0] left = 0
  , output reg signed [15:0] right = 0
  );

localparam [21:0] DEN = 22'd2502500;

reg [21:0] acc = 0;
reg        stick = 0;

always @(posedge clk) begin
  if (acc + 22'd4800 >= DEN) begin
    acc   <= acc + 22'd4800 - DEN;
    stick <= 1;
  end else begin
    acc   <= acc + 22'd4800;
    stick <= 0;
  end
end

reg  [10:0] idx = 0;
reg  [15:0] cur = 0;
reg   [1:0] i_cnt = 0, r_cnt = 0;
reg   [7:0] b0, b1, b2;
reg         on_l = 0, on_r = 0;

wire [15:0] c_off = cur - v_lo;
wire [15:0] v_len = v_hi - v_lo;
wire        cur_ok = (c_off < v_len);
wire [15:0] drift = frame - cur;
wire        resync = !playing || ($signed(drift) > 16'sd1) || ($signed(drift) < -16'sd1);

reg  [10:0] r_idx = 0;        // the sample being read
reg  [15:0] r_cur = 0;
wire [18:0] slot_base = {r_cur[2:0], 16'd0} - {2'd0, r_cur[2:0], 14'd0};
assign rd_addr = slot_base + 19'h9A00 + {6'd0, r_idx, i_cnt};

always @(posedge clk) begin
  if (rd_ack) begin
    i_cnt <= i_cnt + 1;
    if (i_cnt == 2'd3)
      rd_req <= 0;
  end

  if (rd_valid) begin
    r_cnt <= r_cnt + 1;
    case (r_cnt)
    2'd0: b0 <= rd_data;
    2'd1: b1 <= rd_data;
    2'd2: b2 <= rd_data;
    2'd3: begin
        left  <= on_l ? $signed({b1, b0}) : 16'sd0;
        right <= on_r ? $signed({rd_data, b2}) : 16'sd0;
      end
    endcase
  end

  if (stick && playing) begin
    if ((audio1 || audio2) && cur_ok && !rd_req) begin
      rd_req <= 1;
      i_cnt  <= 0;
      r_cnt  <= 0;
      r_idx  <= idx;
      r_cur  <= cur;
      on_l   <= audio1;
      on_r   <= audio2;
    end else if (!(audio1 || audio2) || !cur_ok) begin
      left  <= 0;
      right <= 0;
    end
    if (idx == 11'd1999) begin
      idx <= 0;
      cur <= cur + 1;
    end else
      idx <= idx + 1;
  end else if (stick) begin
    left  <= 0;
    right <= 0;
  end

  if ((frame_tick && resync) || !playing) begin
    cur <= frame;
    idx <= 0;
  end

  if (reset) begin
    rd_req <= 0;
    left   <= 0;
    right  <= 0;
  end
end

endmodule
