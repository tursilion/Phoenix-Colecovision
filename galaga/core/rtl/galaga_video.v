// Galaga video board, written after MAME's galaga_video.cpp and
// starfield_05xx.cpp: 288 x 224 pixels at 6.144MHz (384 x 264 total),
// one 36 x 28 tile layer over 64 sprites over the 05xx starfield.
//
// Coordinates are MAME's (the screen before its ROT90): h 0-287 and v 0-223
// are visible, vertical blank is v 224-263.
//
// Pixel pipeline (clocks after the cen6 that moves h to H):
//   1  video RAM address for H        sprite line buffer read (and clear)
//   2  tile ROM address
//   3  tile pixel and its colour lookup
//   4+ (the next cen6) mix tile, sprite and star; pixel H is out the clock after
// cen6 is at least 4 clocks apart.
//
// Sprites for line v + 1 are drawn during line v into one of two line
// buffers at 25MHz, in MAME's order (a later sprite covers an earlier one).
//
// Output pixel: b7 = 1: b5-0 a direct (star) colour BBGGRR, 0 is black;
// b7 = 0: b4-0 a palette entry.

`timescale 1ns / 1ps

module galaga_video
   ( input             clk
   , input             cen6

   , output reg  [8:0] h = 0
   , output reg  [8:0] v = 0
   , output            vblank
   , output reg        ev_vbl = 0    // pulse: line 224 starts
   , output reg        ev_nmi = 0    // pulse: line 64 or 192 starts

   // Video RAM and sprite registers (galaga_main.v)
   , output      [9:0] vid_a
   , input       [7:0] vid_code
   , input       [7:0] vid_color
   , output      [6:0] spr_a
   , input       [7:0] spr_q1
   , input       [7:0] spr_q2
   , input       [7:0] spr_q3
   , input       [7:0] vlatch

   // ROM loading: tiles (4K), sprites (8K), lookup PROMs; and the boot
   // loader's code, which is the sprite ROM's initial contents
   , input             ld_tile_we
   , input             ld_spr_we
   , input             ld_clut_we
   , input             ld_slut_we
   , input      [12:0] ld_a
   , input       [7:0] ld_d
   , input      [12:0] boot_a
   , output reg  [7:0] boot_q = 0

   , output reg        pix_we = 0
   , output reg  [8:0] pix_x = 0
   , output reg  [7:0] pix_y = 0
   , output reg  [7:0] pixel = 0
   );

// ---------------------------------------------------------------------------
// Counters

reg c1 = 0, c2 = 0, c3 = 0;        // cen6 delayed

always @(posedge clk) begin
  c1     <= cen6;
  c2     <= c1;
  c3     <= c2;
  ev_vbl <= 0;
  ev_nmi <= 0;
  if (cen6) begin
    if (h == 9'd383) begin
      h <= 0;
      v <= (v == 9'd263) ? 9'd0 : v + 1'd1;
      ev_vbl <= (v == 9'd223);
      ev_nmi <= (v == 9'd63 || v == 9'd191);
    end else
      h <= h + 1'd1;
  end
end

assign vblank = (v >= 9'd224);

// ---------------------------------------------------------------------------
// Tiles

reg [7:0] trom [0:4095];
reg [7:0] trom_q = 0;
reg [3:0] clut [0:255];
reg [3:0] slut [0:255];

wire [5:0] col  = h[8:3];
wire [5:0] cm   = col - 6'd2;
wire [4:0] r2   = v[7:3] + 5'd2;
assign vid_a = cm[5] ? {cm[4:0], r2} : {r2, cm[4:0]};

wire [11:0] trom_a = {vid_code[6:0], !h[2], v[2:0]};
always @(posedge clk) begin
  if (ld_tile_we)
    trom[ld_a[11:0]] <= ld_d;
  trom_q <= trom[trom_a];
end

always @(posedge clk) begin
  if (ld_clut_we) clut[ld_a[7:0]] <= ld_d[3:0];
  if (ld_slut_we) slut[ld_a[7:0]] <= ld_d[3:0];
end

reg [5:0] t_color = 0;
reg [3:0] t_pix = 4'hf;            // palette entry 10-1E, F = transparent
wire [1:0] t_bits = {trom_q[3'd7 - h[1:0]], trom_q[3'd3 - h[1:0]]};

always @(posedge clk) begin
  if (c2) t_color <= vid_color[5:0];
  if (c3) t_pix   <= clut[{t_color, t_bits}];
end

// ---------------------------------------------------------------------------
// Sprite line buffers: two lines of 512 x 4 bits (F = transparent)

reg  [3:0] slb [0:1023];
reg  [3:0] slb_q = 4'hf;
reg  [3:0] s_pix = 4'hf;
reg        sw_we = 0;
reg  [9:0] sw_a = 0;
reg  [3:0] sw_d = 0;
wire [9:0] sr_a = {v[0], h};

always @(posedge clk) begin
  if (sw_we)
    slb[sw_a] <= sw_d;
end
always @(posedge clk) begin
  if (c1 && !vblank && h < 9'd288)
    slb[sr_a] <= 4'hf;               // clear behind the display
  slb_q <= slb[sr_a];
end
always @(posedge clk)
  if (c2) s_pix <= slb_q;

// Sprite drawing
reg  [8:0] tv = 0;                 // line being drawn
reg  [2:0] st = 0;
localparam S_IDLE = 3'd0, S_RD0 = 3'd1, S_RD1 = 3'd2, S_RD2 = 3'd3, S_DRAW = 3'd4;
reg  [5:0] si = 0;                 // sprite
reg  [6:0] s_code = 0;
reg  [7:0] s_y = 0;
reg  [3:0] s_flags = 0;            // b0 flip x, b1 flip y, b2 double width, b3 double height
reg  [5:0] s_color = 0;
reg [10:0] s_x = 0;                // left edge, signed
reg  [3:0] s_row = 0;              // row in the 16 x 16 tile (flipped)
reg        s_ty = 0;               // tile row select (flipped)
reg        tx = 0;
reg  [3:0] px = 0;

reg  [7:0] srom [0:8191];
reg  [7:0] srom_q = 0;             // renderer's read
initial $readmemh("galaga_boot.hex", srom);

assign spr_a = {si, st == S_RD1};

wire [7:0]  u     = 8'd1 - s_y - (s_flags[3] ? 8'd16 : 8'd0);
wire [9:0]  d     = {1'b0, tv} + 10'd32 - {2'b00, u};
wire        s_vis = (d[9:5] == 0) && (s_flags[3] || !d[4]);

wire [3:0]  pcol  = px ^ {4{s_flags[0]}};
wire        txs   = tx ^ (s_flags[2] & s_flags[0]);
wire [6:0]  tile  = s_code + {5'd0, s_ty, txs};
wire [12:0] srom_a = {tile, s_row[3], pcol[3:2], s_row[2:0]};
wire [10:0] dx    = s_x + {6'd0, tx, px};

// stage 2 of the pixel pipeline
reg        p_go = 0;
reg  [1:0] p_c = 0;
reg [10:0] p_x = 0;

always @(posedge clk) begin
  srom_q <= srom[srom_a];
end

wire [1:0] s_bits = {srom_q[3'd7 - p_c], srom_q[3'd3 - p_c]};
wire [3:0] s_lut  = slut[{s_color, s_bits}];

always @(posedge clk) begin
  sw_we <= 0;
  p_go  <= 0;

  // pixel stage 2: write it if opaque and on the line
  if (p_go && s_lut != 4'hf && !p_x[10] && p_x[9:0] < 10'd288) begin
    sw_we <= 1;
    sw_a  <= {tv[0], p_x[8:0]};
    sw_d  <= s_lut;
  end

  case (st)
  S_RD0: st <= S_RD1;
  S_RD1: begin
    s_code  <= spr_q1[6:0];
    s_y     <= spr_q2;
    s_flags <= spr_q3[3:0];
    st      <= S_RD2;
  end
  S_RD2: begin
    s_color <= spr_q1[5:0];
    s_x     <= {1'b0, spr_q3[1:0], spr_q2} - 11'd40;
    s_row   <= d[3:0] ^ {4{s_flags[1]}};
    s_ty    <= d[4] ^ (s_flags[3] & s_flags[1]);
    tx      <= 0;
    px      <= 0;
    if (s_vis)
      st <= S_DRAW;
    else begin
      si <= si + 1'd1;
      st <= (si == 6'd63) ? S_IDLE : S_RD0;
    end
  end
  S_DRAW: begin
    p_go <= 1;
    p_c  <= pcol[1:0];
    p_x  <= dx;
    px   <= px + 1'd1;
    if (px == 4'd15) begin
      if (s_flags[2] && !tx)
        tx <= 1;
      else begin
        si <= si + 1'd1;
        st <= (si == 6'd63) ? S_IDLE : S_RD0;
      end
    end
  end
  default: ;
  endcase

  // a new line starts: draw the next one
  if (c1 && h == 0) begin
    tv <= (v == 9'd263) ? 9'd0 : v + 1'd1;
    si <= 0;
    st <= (v == 9'd263 || v < 9'd223) ? S_RD0 : S_IDLE;
    p_go <= 0;
  end
end

// Sprite ROM port A: loading, and the boot loader's code
wire [12:0] srom_b_a = ld_spr_we ? ld_a : boot_a;
always @(posedge clk) begin
  if (ld_spr_we) begin
    srom[srom_b_a] <= ld_d;
    boot_q <= ld_d;
  end else
    boot_q <= srom[srom_b_a];
end

// ---------------------------------------------------------------------------
// 05xx starfield: a 16-bit LFSR run over 256 x 256 pixels per frame
// (x 16-271), with extra or fewer steps in the blanking to scroll it.

reg [15:0] lfsr = 16'h7fff;
reg  [2:0] sf_speed = 0;
reg        sf_a = 0, sf_b = 0, sf_on = 0;

wire [3:0]  sf_n   = {1'b0, !sf_speed[2], sf_speed[1:0]};  // 4 + offset (0 1 2 3 -4 -3 -2 -1)
wire        hit    = (lfsr & 16'hfa14) == 16'h7800;
wire [1:0]  set    = {lfsr[10], lfsr[8]};
wire        star   = sf_on && hit && (set == {1'b0, sf_a} || set == {1'b1, sf_b});
wire [5:0]  s_col  = ~{lfsr[3], lfsr[1], lfsr[0], lfsr[7], lfsr[6], lfsr[5]};
wire        in_x   = (h >= 9'd16 && h < 9'd272);
wire        step   = (v < 9'd255) ? in_x :
                     (v == 9'd255) ? (h >= 9'd16 && h < 9'd268) :
                     (v == 9'd256) ? (h >= 9'd16 && h < 9'd16 + sf_n) : 1'b0;

always @(posedge clk) begin
  if (cen6 && h == 9'd383 && v == 9'd263) begin
    sf_speed <= vlatch[2:0];
    sf_a     <= vlatch[3];
    sf_b     <= vlatch[4];
    sf_on    <= vlatch[5];
  end
  if (!sf_on)
    lfsr <= 16'h7fff;
  else if (cen6 && step)
    lfsr <= {lfsr[0] ^ lfsr[3] ^ lfsr[5] ^ lfsr[10], lfsr[15:1]};
end

// ---------------------------------------------------------------------------
// Mix

always @(posedge clk) begin
  pix_we <= 0;
  if (cen6) begin
    pix_we <= !vblank && h < 9'd288;
    pix_x  <= h;
    pix_y  <= v[7:0];
    if (t_pix != 4'hf)
      pixel <= {3'b000, 1'b1, t_pix};
    else if (s_pix != 4'hf)
      pixel <= {4'b0000, s_pix};
    else if (star && in_x && !vblank)
      pixel <= {2'b10, s_col};
    else
      pixel <= 8'h80;
  end
end

endmodule
