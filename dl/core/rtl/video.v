// Video: 640x480 at 59.5Hz (25MHz pixel clock), showing a 320x240 disc
// frame doubled in both directions, with a 40x30 text overlay on top.
//
// Disc frames are in the SRAM frame slots written by sd_stream (see there
// for the layout).  At the start of vertical blank the frame the player is
// on is selected, if it has arrived, and its palette is copied into block
// RAM.  Each source line is fetched during the two output lines before it
// is shown: for each of the 80 cells of the line it reads the cell's four
// colours and the mask byte of the line's row in the cell (2 bits per
// pixel, pixel 0 in bits 1:0), and writes 4 palette indices to a line
// buffer.
//
// Overlay: 40x30 characters of 8x8 source pixels, from the text RAM
// (written by the boot loader) and a 128-character font.  A cell with a
// character other than space is drawn opaque: white on black, or yellow
// for codes with bit 7 set.  In game mode the scoreboard row (29) also
// shows the 16 LED digits of the original cabinet, in red.

`timescale 1ns / 1ps

module video
  #( parameter FONT_FILE = "font.hex"
   )
   ( input             clk
   , input             reset

   // Disc frame wanted, and the frames in the SRAM
   , input             game_mode
   , input      [15:0] want_frame
   , input      [15:0] v_lo
   , input      [15:0] v_hi
   , output reg        disp_valid = 0
   , output reg [15:0] disp_frame = 0

   // SRAM read port
   , output reg        rd_req = 0
   , output     [18:0] rd_addr
   , input             rd_ack
   , input             rd_valid
   , input       [7:0] rd_data

   // Overlay
   , input             ov_we
   , input      [10:0] ov_addr
   , input       [7:0] ov_data
   , input             ov_show
   , input      [63:0] leds       // 16 digits, 4 bits each, E030 in 3:0

   // Timing
   , output     [9:0]  hcount
   , output     [9:0]  vcount

   , output reg  [7:0] vid_r
   , output reg  [7:0] vid_g
   , output reg  [7:0] vid_b
   , output reg        vid_hsync_n
   , output reg        vid_vsync_n
   , output reg        vid_blank
   );

// ---------------------------------------------------------------------------
// Counters: 800 x 525

reg [9:0] hc = 0, vc = 0;

assign hcount = hc;
assign vcount = vc;

always @(posedge clk) begin
  if (hc == 10'd799) begin
    hc <= 0;
    vc <= (vc == 10'd524) ? 10'd0 : vc + 1;
  end else
    hc <= hc + 1;
end

// ---------------------------------------------------------------------------
// Frame selection

function [18:0] slot_base(input [2:0] s);
  slot_base = {s, 16'd0} - {2'd0, s, 14'd0};   // s * 0xC000
endfunction

wire [15:0] w_off  = want_frame - v_lo;
wire [15:0] d_off  = disp_frame - v_lo;
wire [15:0] v_len  = v_hi - v_lo;
wire        want_ok = (w_off < v_len);
wire        disp_ok = (d_off < v_len);

reg  [18:0] fbase = 0;
reg         pal_go = 0;

always @(posedge clk) begin
  pal_go <= 0;
  if (hc == 0 && vc == 10'd480) begin
    if (!game_mode) begin
      disp_valid <= 0;
    end else if (want_ok) begin
      disp_frame <= want_frame;
      disp_valid <= 1;
      fbase      <= slot_base(want_frame[2:0]);
      pal_go     <= 1;
    end else if (!disp_ok && disp_frame[2:0] == v_hi[2:0]) begin
      disp_valid <= 0;     // its slot is being refilled
    end
  end
  if (reset)
    disp_valid <= 0;
end

// ---------------------------------------------------------------------------
// SRAM reader: palette (512 bytes) and line fetches (80 cells x 5 bytes)

localparam R_IDLE = 2'd0, R_PAL = 2'd1, R_LINE = 2'd2;

reg  [1:0] rmode = R_IDLE;
reg  [8:0] i_cnt = 0;        // issue: palette byte, or {cell, part}
reg  [6:0] i_cell = 0;
reg  [2:0] i_part = 0;
reg  [8:0] r_cnt = 0;        // responses
reg  [6:0] r_cell = 0;
reg  [2:0] r_part = 0;
reg  [7:0] f_line = 0;       // source line being fetched
reg        line_go = 0;
reg  [7:0] line_next = 0;

// Line fetch triggers: line n+1 at the start of output line 2n (n = 0..238),
// line 0 at output line 522.
always @(posedge clk) begin
  line_go <= 0;
  if (hc == 10'd8) begin
    if (vc[0] == 1'b0 && vc <= 10'd476) begin
      line_go   <= 1;
      line_next <= vc[8:1] + 1;
    end else if (vc == 10'd522) begin
      line_go   <= 1;
      line_next <= 0;
    end
  end
end

wire [5:0]  c_row  = f_line[7:2];
wire [12:0] c_idx  = {1'b0, c_row, 6'd0} + {3'd0, c_row, 4'd0} + {6'd0, i_cell};
wire [15:0] c_off  = 16'h0400 + {c_idx, 3'd0} + ((i_part < 3'd4) ? {13'd0, i_part} : {13'd0, 1'b1, f_line[1:0]});

assign rd_addr = (rmode == R_PAL) ? fbase + 19'h200 + {10'd0, i_cnt} : fbase + {3'd0, c_off};

reg  [7:0] col0, col1, col2, col3;
reg  [7:0] pal_lo;

// Palette, 256 x RGB565
reg [15:0] palette [0:255];
reg        pal_we = 0;
reg  [7:0] pal_wa;
reg [15:0] pal_wd;

always @(posedge clk)
  if (pal_we)
    palette[pal_wa] <= pal_wd;

// Line buffers: 2 lines x 80 words of 4 indices
reg [31:0] linebuf [0:255];
reg        lb_we = 0;
reg  [7:0] lb_wa;
reg [31:0] lb_wd;

always @(posedge clk)
  if (lb_we)
    linebuf[lb_wa] <= lb_wd;

function [7:0] pick(input [1:0] s, input [7:0] a, input [7:0] b, input [7:0] c, input [7:0] d);
  pick = (s == 2'd0) ? a : (s == 2'd1) ? b : (s == 2'd2) ? c : d;
endfunction

always @(posedge clk) begin
  pal_we <= 0;
  lb_we  <= 0;

  case (rmode)
  R_IDLE: begin
      rd_req <= 0;
      if (pal_go) begin
        rmode  <= R_PAL;
        i_cnt  <= 0;
        r_cnt  <= 0;
        rd_req <= 1;
      end else if (line_go && disp_valid) begin
        rmode  <= R_LINE;
        f_line <= line_next;
        i_cell <= 0;
        i_part <= 0;
        r_cell <= 0;
        r_part <= 0;
        rd_req <= 1;
      end
    end

  R_PAL: begin
      if (rd_ack) begin
        i_cnt <= i_cnt + 1;
        if (i_cnt == 9'd511)
          rd_req <= 0;
      end
      if (rd_valid) begin
        r_cnt <= r_cnt + 1;
        if (!r_cnt[0])
          pal_lo <= rd_data;
        else begin
          pal_we <= 1;
          pal_wa <= r_cnt[8:1];
          pal_wd <= {rd_data, pal_lo};
        end
        if (r_cnt == 9'd511)
          rmode <= R_IDLE;
      end
    end

  R_LINE: begin
      if (rd_ack) begin
        if (i_part == 3'd4) begin
          i_part <= 0;
          i_cell <= i_cell + 1;
          if (i_cell == 7'd79)
            rd_req <= 0;
        end else
          i_part <= i_part + 1;
      end
      if (rd_valid) begin
        case (r_part)
        3'd0: col0 <= rd_data;
        3'd1: col1 <= rd_data;
        3'd2: col2 <= rd_data;
        3'd3: col3 <= rd_data;
        default: begin
            lb_we <= 1;
            lb_wa <= {f_line[0], r_cell};
            lb_wd <= {pick(rd_data[7:6], col0, col1, col2, col3),
                      pick(rd_data[5:4], col0, col1, col2, col3),
                      pick(rd_data[3:2], col0, col1, col2, col3),
                      pick(rd_data[1:0], col0, col1, col2, col3)};
          end
        endcase
        if (r_part == 3'd4) begin
          r_part <= 0;
          r_cell <= r_cell + 1;
          if (r_cell == 7'd79)
            rmode <= R_IDLE;
        end else
          r_part <= r_part + 1;
      end
    end

  default: rmode <= R_IDLE;
  endcase

  if (reset) begin
    rmode  <= R_IDLE;
    rd_req <= 0;
  end
end

// ---------------------------------------------------------------------------
// Overlay memories

reg [7:0] textram [0:2047];
reg [7:0] font [0:1023];
initial $readmemh(FONT_FILE, font);

always @(posedge clk)
  if (ov_we)
    textram[ov_addr] <= ov_data;

// ---------------------------------------------------------------------------
// Output pipeline

wire        visible = (hc < 10'd640) && (vc < 10'd480);
wire  [8:0] sx      = hc[9:1];
wire  [7:0] sy      = vc[8:1];
wire  [5:0] t_col   = sx[8:3];
wire  [4:0] t_row   = sy[7:3];
wire [10:0] t_addr  = {1'b0, t_row, 5'd0} + {3'd0, t_row, 3'd0} + {5'd0, t_col};  // row*40 + col

// stage 1
reg [31:0] lb_q;
reg  [7:0] tx_q;
reg  [1:0] px1;
reg  [2:0] gx1, gy1;
reg  [5:0] col1_q;
reg  [4:0] row1_q;

// stage 2
reg  [7:0] pix2;
reg  [7:0] glyph_code2;
reg        led2, opaque2, yellow2;
reg  [2:0] gx2;
reg [15:0] rgb_q;
reg  [7:0] font_q;

// stage 3
reg        led3, opaque3, yellow3;
reg  [2:0] gx3;
reg  [7:0] font3;

reg [3:0] vis_d, hs_d, vs_d, blk_d;

// LED cell for a scoreboard column, or 31 for none
function [4:0] led_at(input [5:0] col);
  case (col)
  6'd4:  led_at = 5'd8;   6'd5:  led_at = 5'd9;   6'd6:  led_at = 5'd10;
  6'd7:  led_at = 5'd11;  6'd8:  led_at = 5'd12;  6'd9:  led_at = 5'd13;
  6'd12: led_at = 5'd14;
  6'd23: led_at = 5'd6;   6'd24: led_at = 5'd7;
  6'd31: led_at = 5'd0;   6'd32: led_at = 5'd1;   6'd33: led_at = 5'd2;
  6'd34: led_at = 5'd3;   6'd35: led_at = 5'd4;   6'd36: led_at = 5'd5;
  6'd39: led_at = 5'd15;
  default: led_at = 5'd31;
  endcase
endfunction

function [7:0] led_char(input [3:0] v);
  case (v)
  4'hA: led_char = "A";  4'hB: led_char = "b";  4'hC: led_char = "C";
  4'hD: led_char = "d";  4'hE: led_char = "E";  4'hF: led_char = " ";
  default: led_char = 8'h30 + {4'd0, v};
  endcase
endfunction

wire [4:0] led_idx  = led_at(col1_q);
wire       led_cell = game_mode && (row1_q == 5'd29) && (led_idx != 5'd31);
wire [3:0] led_val  = leds[{led_idx[3:0], 2'b00} +: 4];
wire [7:0] code1    = led_cell ? led_char(led_val) : tx_q;

always @(posedge clk) begin
  // stage 1: line buffer and text RAM
  lb_q   <= linebuf[{sy[0], sx[8:2]}];
  tx_q   <= textram[t_addr];
  px1    <= sx[1:0];
  gx1    <= sx[2:0];
  gy1    <= sy[2:0];
  col1_q <= t_col;
  row1_q <= t_row;

  // stage 2: palette and font
  pix2    <= lb_q[{px1, 3'b000} +: 8];
  font_q  <= font[{code1[6:0], gy1}];
  led2    <= led_cell;
  opaque2 <= led_cell || (code1[6:0] != 7'h20 && code1[6:0] != 7'h00);
  yellow2 <= code1[7];
  gx2     <= gx1;

  // stage 3
  rgb_q   <= palette[pix2];
  led3    <= led2;
  opaque3 <= opaque2 && (ov_show || !game_mode);
  yellow3 <= yellow2;
  gx3     <= gx2;
  font3   <= font_q;

  vis_d <= {vis_d[2:0], visible};
  blk_d <= {blk_d[2:0], !visible};
  hs_d  <= {hs_d[2:0], !(hc >= 10'd656 && hc < 10'd752)};
  vs_d  <= {vs_d[2:0], !(vc >= 10'd490 && vc < 10'd492)};

  // stage 4: output
  if (!vis_d[2]) begin
    {vid_r, vid_g, vid_b} <= 24'h000000;
  end else if (opaque3) begin
    if (font3[3'd7 - gx3])
      {vid_r, vid_g, vid_b} <= led3 ? 24'hFF2020 : yellow3 ? 24'hFFE040 : 24'hFFFFFF;
    else
      {vid_r, vid_g, vid_b} <= 24'h000000;
  end else if (disp_valid) begin
    vid_r <= {rgb_q[15:11], rgb_q[15:13]};
    vid_g <= {rgb_q[10:5],  rgb_q[10:9]};
    vid_b <= {rgb_q[4:0],   rgb_q[4:2]};
  end else
    {vid_r, vid_g, vid_b} <= 24'h000000;

  vid_blank   <= blk_d[2];
  vid_hsync_n <= hs_d[2];
  vid_vsync_n <= vs_d[2];
end

endmodule
