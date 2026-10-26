// Phoenix glue for the Intellivision core.
//
// Clocks:
//
//  - clk25: the 640x480 HDMI pixel clock.
//  - clk_i: 42.857MHz (25MHz x 12/7), a little faster than the
//    Intellivision's 12 x 3.579545MHz = 42.95MHz / 1.0063 that gives one
//    Intellivision frame (262 lines of 228 pixels, 716832 clocks) per HDMI
//    frame (420000 clocks at 25MHz).
//  - clk_g: clk_i through a BUFGCE whose enable is run.  Everything of the
//    Intellivision, the boot CPU and the SRAM run from clk_g.  At the top of
//    each frame the frame lock below stops clk_g until the HDMI frame
//    reaches RELEASE_LINE, so the two stay locked (59.52 instead of
//    59.92 frames per second) and an 8-line buffer is enough to show each
//    Intellivision line on two HDMI lines.
//
// Picture: the STIC's 190 x 240 visible pixels (with the border), each
// pixel 3 HDMI pixels wide and each line 2 HDMI lines high: 570 x 480,
// centered.
//
// Boot mode: at power-on a 6502 runs the menu and loader from a 24K block
// RAM ROM, with this I/O window at $5000 (like the NES core's):
//
//  $5000 R  SPI received byte
//        W  SPI transfer byte
//  $5001 R  bit7 busy (SPI, forward engine or SRAM write), bit6 card present,
//           bit5 HDMI vertical blank
//        W  bit0 SD select (1 = CS asserted), bit1 slow SPI clock,
//           bit2 forward engine discards the bytes
//  $5002 W  byte to the load target at the load address, which then
//           increments
//  $5003 W  reset the CRC
//  $5004 W  start the game
//  $5005 W  bit0 error LED
//  $5006 W  forward count, low byte
//  $5007 W  forward count, high byte, and start: clock in that many SPI bytes
//           (sending $FF), write each to the load target and add it to the CRC
//  $5008-$500A W  load address, bits 7:0, 15:8, 18:16
//  $500B-$500C W  paged zone mask (intv_cart.vhd), bits 7:0, 15:8
//  $500D W  bit0 swap the hand controllers (port 1 = right controller)
//  $500E W  bit0 ECS, bit1 JLP for the game, bit2 Intellivoice
//  $500F W  load target: 0 SRAM, 1 EXEC, 2 GROM, 3 ECS ROM, 4 SP0256 ROM,
//           7 nowhere (CRC only).  The ROMs take big-endian 16-bit words
//           (EXEC, ECS) or bytes (GROM, SP0256) from load address 0.
//  $5010 R  menu buttons: bit0 A, 1 B, 2 select, 3 start, 4 up, 5 down,
//           6 left, 7 right
//  $5011-$5014 R  CRC-32 (zlib) of the bytes since $5003, bits 7:0 first
//  $5015 R  keypad key held on either ColecoVision controller: 0-9, 10 *,
//           11 #, $FF none; also the keyboard's digits, SNES L = 1, R = 2
//
// Boot memory: RAM $0000-$07FF and $6000-$7FFF, text screen $4000-$43FF
// (32 x 30 characters, 16 x 16 pixels each), ROM $A000-$FFFF (24K).
//
// The Intellivision BIOS (EXEC, GROM, ECS ROM, SP0256 ROM) is not built in:
// the loader reads it from the SD card into the core's ROMs at power-on.

`timescale 1ns / 1ps

module intv_phoenix
  #( parameter BOOTROM_FILE = "intv_boot.hex"
   , parameter FONT_FILE    = "font.hex"
   )
   ( input             clk25
   , input             clk_i       // 42.857MHz
   , input             clk_g       // clk_i, stopped while run is low
   , output reg        run         // enable of clk_g (clk_i domain)

   , input             reset       // power-on or hold-reset (clk25): back to the menu
   , input             game_reset  // reset the game (clk25)

   // Controllers (clk25), 1 = pressed
   , input       [9:0] cv1         // ColecoVision port 1 (cv_pads_ga format)
   , input       [9:0] cv2         // ColecoVision port 2
   , input      [11:0] snes        // 0 A 1 B 2 X 3 Y 4 start 5 select 6 L 7 R 8 up 9 down 10 left 11 right
   , input      [15:0] kb_keys     // colecoKeyboard keys
   , input       [4:0] kb_joy      // colecoKeyboard arrows + Z
   , input       [7:0] kb_byte     // PS/2 scan code bytes (set 2), for the ECS keyboard
   , input             kb_stb      // one clk25 per byte

   // External SRAM.  The data bus tri-state is done at the top level.
   , output reg [18:0] sram_addr
   , output reg  [7:0] sram_dout
   , input       [7:0] sram_din
   , output reg        sram_doe
   , output reg        sram_we_n
   , output reg        sram_oe_n

   // SD card SPI
   , output            sd_cs_n
   , output            sd_sclk
   , output            sd_mosi
   , input             sd_miso
   , input             sd_cd_n

   // 640x480 video (clk25)
   , output reg  [7:0] vid_r
   , output reg  [7:0] vid_g
   , output reg  [7:0] vid_b
   , output reg        vid_hsync_n
   , output reg        vid_vsync_n
   , output reg        vid_blank

   // Audio (clk25), signed
   , output reg [15:0] audio

   , output reg        boot_mode
   , output reg        led_err
   );

// HDMI line on which a waiting Intellivision starts its next frame: eight
// lines (two Intellivision lines and a half) before HDMI line 0, so line 0
// is in the line buffer before it is shown.  The Intellivision gains about
// 0.6 line per frame, well inside the 8-line buffer.
localparam RELEASE_LINE = 10'd517;

// ---------------------------------------------------------------------------
// HDMI timing (clk25)

reg [9:0] hc = 0, vc = 0;

always @(posedge clk25) begin
  if (hc == 10'd799) begin
    hc <= 0;
    vc <= (vc == 10'd524) ? 10'd0 : vc + 1;
  end else
    hc <= hc + 1;
end

reg release_tog = 0;
always @(posedge clk25)
  if (vc == RELEASE_LINE && hc == 0)
    release_tog <= !release_tog;

// ---------------------------------------------------------------------------
// Frame lock (clk_i)

wire hvsync;                 // clk_g: the STIC is at the top of a frame
reg  [2:0] rel_sync = 0;
reg        waiting = 0;
wire       rel_event = rel_sync[2] ^ rel_sync[1];

initial run = 1;

always @(posedge clk_i) begin
  rel_sync <= {rel_sync[1:0], release_tog};
  if (!waiting) begin
    // The clock stops one clk_g edge after the frame start; that is the
    // same place in every frame.
    if (hvsync) begin
      waiting <= 1;
      run     <= 0;
    end
  end else if (rel_event) begin
    waiting <= 0;
    run     <= 1;
  end
end

`ifdef INTV_SIM_TRACE
always @(posedge clk_i)
  if (!waiting && hvsync)
    $display("frame top: waits for line %0d (HDMI now %0d)", RELEASE_LINE, vc);
`endif

// ---------------------------------------------------------------------------
// Resets (clk_g)

reg [2:0] reset_s = 3'b111, game_reset_s = 0;
always @(posedge clk_g) begin
  reset_s      <= {reset_s[1:0], reset};
  game_reset_s <= {game_reset_s[1:0], game_reset};
end
wire g_reset = reset_s[2];

reg       start_game = 0;
reg [7:0] intv_rst_cnt = 8'hff;
wire      intv_reset = (intv_rst_cnt != 0);

initial boot_mode = 1;

always @(posedge clk_g) begin
  if (g_reset)
    boot_mode <= 1;
  else if (start_game)
    boot_mode <= 0;

  if (g_reset || start_game || boot_mode || game_reset_s[2])
    intv_rst_cnt <= 8'hff;
  else if (intv_rst_cnt != 0)
    intv_rst_cnt <= intv_rst_cnt - 1;
end

// ---------------------------------------------------------------------------
// Controllers

// Intellivision hand controller codes (1 = pressed; the port reads them
// inverted).  Keypad: 1-9, clear, 0, enter.
function [7:0] disc(input up, input down, input left, input right);
  case ({up, down, left, right})
  4'b0001: disc = 8'h02;  // E
  4'b0010: disc = 8'h08;  // W
  4'b0100: disc = 8'h01;  // S
  4'b0101: disc = 8'h13;  // SE
  4'b0110: disc = 8'h19;  // SW
  4'b0111: disc = 8'h01;
  4'b1000: disc = 8'h04;  // N
  4'b1001: disc = 8'h16;  // NE
  4'b1010: disc = 8'h1C;  // NW
  4'b1011: disc = 8'h04;
  4'b1101: disc = 8'h02;
  4'b1110: disc = 8'h08;
  default: disc = 8'h00;
  endcase
endfunction

localparam [7:0] K1 = 8'h81, K2 = 8'h41, K3 = 8'h21, K4 = 8'h82, K5 = 8'h42,
                 K6 = 8'h22, K7 = 8'h84, K8 = 8'h44, K9 = 8'h24,
                 KCLR = 8'h88, K0 = 8'h48, KENT = 8'h28,
                 A_TOP = 8'hA0, A_BL = 8'h60, A_BR = 8'hC0;

// ColecoVision keypad code on pins 4..1 (active low) to an Intellivision
// key: * is clear, # is enter.
function [7:0] cv_key(input [3:0] k);
  case (k)
  4'b0111: cv_key = K1;   4'b1011: cv_key = K2;   4'b0110: cv_key = K3;
  4'b1000: cv_key = K4;   4'b1001: cv_key = K5;   4'b1110: cv_key = K6;
  4'b0011: cv_key = K7;   4'b0001: cv_key = K8;   4'b1101: cv_key = K9;
  4'b0101: cv_key = KCLR; 4'b1100: cv_key = K0;   4'b1010: cv_key = KENT;
  default: cv_key = 8'h00;
  endcase
endfunction

// Two fire buttons: left = top, right = bottom left, both = bottom right.
function [7:0] fires(input l, input r);
  fires = (l && r) ? A_BR : l ? A_TOP : r ? A_BL : 8'h00;
endfunction

function [7:0] cv_pad(input [9:0] p);
  cv_pad = disc(p[0], p[1], p[2], p[3]) | fires(p[4], p[5]) | cv_key(p[9:6]);
endfunction

// SNES pad: Y or X top, B bottom left, A bottom right, start enter,
// select clear, L 1, R 2.
wire [7:0] snes_pad = disc(snes[8], snes[9], snes[10], snes[11]) |
                      ((snes[3] | snes[2]) ? A_TOP : 8'h00) |
                      (snes[1] ? A_BL : 8'h00) | (snes[0] ? A_BR : 8'h00) |
                      (snes[4] ? KENT : 8'h00) | (snes[5] ? KCLR : 8'h00) |
                      (snes[6] ? K1 : 8'h00) | (snes[7] ? K2 : 8'h00);

// Keyboard: arrows, Z top, X bottom left, 0-9, W clear, Q enter.
wire [7:0] kb_pad = disc(kb_joy[0], kb_joy[1], kb_joy[2], kb_joy[3]) |
                    fires(kb_joy[4], kb_keys[0]) |
                    (kb_keys[13] ? K1 : 8'h00) | (kb_keys[7]  ? K2 : 8'h00) |
                    (kb_keys[12] ? K3 : 8'h00) | (kb_keys[2]  ? K4 : 8'h00) |
                    (kb_keys[3]  ? K5 : 8'h00) | (kb_keys[14] ? K6 : 8'h00) |
                    (kb_keys[5]  ? K7 : 8'h00) | (kb_keys[1]  ? K8 : 8'h00) |
                    (kb_keys[11] ? K9 : 8'h00) | (kb_keys[10] ? K0 : 8'h00) |
                    (kb_keys[9]  ? KCLR : 8'h00) | (kb_keys[6] ? KENT : 8'h00);

reg [7:0] ctl1 = 0, ctl2 = 0, menu_pad = 0;
reg [7:0] menu_key = 8'hff;
reg       ecs_on = 0;          // from clk_g, slow
reg       ecs_g = 0, jlp_g = 0, voice_g = 0; // clk_g: the game's extensions ($500E)

// ColecoVision key code (pins 4..1) to the key number for the menu
function [7:0] cv_num(input [3:0] k);
  case (k)
  4'b1100: cv_num = 0;  4'b0111: cv_num = 1;  4'b1011: cv_num = 2;
  4'b0110: cv_num = 3;  4'b1000: cv_num = 4;  4'b1001: cv_num = 5;
  4'b1110: cv_num = 6;  4'b0011: cv_num = 7;  4'b0001: cv_num = 8;
  4'b1101: cv_num = 9;  4'b0101: cv_num = 10; 4'b1010: cv_num = 11;
  default: cv_num = 8'hff;
  endcase
endfunction

always @(posedge clk25) begin
  menu_key <= (cv1[9:6] != 4'b1111) ? cv_num(cv1[9:6]) :
              (cv2[9:6] != 4'b1111) ? cv_num(cv2[9:6]) :
              snes[6] ? 8'd1 : snes[7] ? 8'd2 :
              kb_keys[10] ? 8'd0 : kb_keys[13] ? 8'd1 : kb_keys[7] ? 8'd2 : 8'hff;
  ecs_on <= ecs_g;
end

always @(posedge clk25) begin
  ctl1 <= cv_pad(cv1) | snes_pad | (ecs_on ? 8'h00 : kb_pad);
  ctl2 <= cv_pad(cv2);
  // Menu: A = left fire, SNES A or X, Z, keypad #; B = right fire,
  // SNES B or Y, X, keypad *; select = SNES select.  The keypad keys
  // themselves are in menu_key.
  menu_pad <= { cv1[3] | cv2[3] | snes[11] | kb_joy[3],
                cv1[2] | cv2[2] | snes[10] | kb_joy[2],
                cv1[1] | cv2[1] | snes[9]  | kb_joy[1],
                cv1[0] | cv2[0] | snes[8]  | kb_joy[0],
                snes[4] | kb_keys[13] | (cv1[9:6] == 4'b1010) | (cv2[9:6] == 4'b1010),
                snes[5],
                cv1[5] | cv2[5] | snes[1] | snes[3] | kb_keys[0] | (cv1[9:6] == 4'b0101) | (cv2[9:6] == 4'b0101),
                cv1[4] | cv2[4] | snes[0] | snes[2] | kb_joy[4] };
end

// To clk_g: take a value once it has been the same for two clocks.
reg [7:0] ctl1_m, ctl1_s, ctl1_g = 0, ctl2_m, ctl2_s, ctl2_g = 0, menu_m, menu_s, menu_g = 0;
reg [7:0] mkey_m, mkey_s, mkey_g = 8'hff;
reg       swap = 0;

always @(posedge clk_g) begin
  ctl1_m <= ctl1;  ctl1_s <= ctl1_m;  if (ctl1_s == ctl1_m) ctl1_g <= ctl1_s;
  ctl2_m <= ctl2;  ctl2_s <= ctl2_m;  if (ctl2_s == ctl2_m) ctl2_g <= ctl2_s;
  menu_m <= menu_pad; menu_s <= menu_m; if (menu_s == menu_m) menu_g <= menu_s;
  mkey_m <= menu_key; mkey_s <= mkey_m; if (mkey_s == mkey_m) mkey_g <= mkey_s;
end

// ColecoVision port 1 (with the SNES pad and the keyboard) is player 1, the
// Intellivision's left controller ($1FF); port 2 is the right controller
// ($1FE).  swap exchanges them.
wire [7:0] pa = ~(swap ? ctl1_g : ctl2_g);
wire [7:0] pb = ~(swap ? ctl2_g : ctl1_g);

// ECS keyboard, from the PS/2 scan codes.  Matrix (the MiSTer core's):
// row = the ECS AY's port A bit pulled low, columns bit 7..0 on port B:
//   row 6: shift
//   row 5: a ctrl right 1 q up down space
//   row 4: d e 2 3 w s z x
//   row 3: g t 4 5 r f c v
//   row 2: j u 6 7 y h b n
//   row 1: l o 8 9 i k m ,
//   row 0: - enter 0 esc p ; . left
reg [63:0] ecs_keys = 0;        // {row, column}, 1 = down
reg        kb_rel = 0, kb_ext = 0;
reg  [5:0] kb_pos;
reg        kb_hit;

always @* begin
  kb_hit = 1;
  case ({kb_ext, kb_byte})
  9'h012, 9'h059: kb_pos = {3'd6, 3'd7};             // shift
  9'h01C: kb_pos = {3'd5, 3'd7};  9'h014: kb_pos = {3'd5, 3'd6};  // a ctrl
  9'h114: kb_pos = {3'd5, 3'd6};  9'h174: kb_pos = {3'd5, 3'd5};  // rctrl right
  9'h016: kb_pos = {3'd5, 3'd4};  9'h015: kb_pos = {3'd5, 3'd3};  // 1 q
  9'h175: kb_pos = {3'd5, 3'd2};  9'h172: kb_pos = {3'd5, 3'd1};  // up down
  9'h029: kb_pos = {3'd5, 3'd0};                                  // space
  9'h023: kb_pos = {3'd4, 3'd7};  9'h024: kb_pos = {3'd4, 3'd6};  // d e
  9'h01E: kb_pos = {3'd4, 3'd5};  9'h026: kb_pos = {3'd4, 3'd4};  // 2 3
  9'h01D: kb_pos = {3'd4, 3'd3};  9'h01B: kb_pos = {3'd4, 3'd2};  // w s
  9'h01A: kb_pos = {3'd4, 3'd1};  9'h022: kb_pos = {3'd4, 3'd0};  // z x
  9'h034: kb_pos = {3'd3, 3'd7};  9'h02C: kb_pos = {3'd3, 3'd6};  // g t
  9'h025: kb_pos = {3'd3, 3'd5};  9'h02E: kb_pos = {3'd3, 3'd4};  // 4 5
  9'h02D: kb_pos = {3'd3, 3'd3};  9'h02B: kb_pos = {3'd3, 3'd2};  // r f
  9'h021: kb_pos = {3'd3, 3'd1};  9'h02A: kb_pos = {3'd3, 3'd0};  // c v
  9'h03B: kb_pos = {3'd2, 3'd7};  9'h03C: kb_pos = {3'd2, 3'd6};  // j u
  9'h036: kb_pos = {3'd2, 3'd5};  9'h03D: kb_pos = {3'd2, 3'd4};  // 6 7
  9'h035: kb_pos = {3'd2, 3'd3};  9'h033: kb_pos = {3'd2, 3'd2};  // y h
  9'h032: kb_pos = {3'd2, 3'd1};  9'h031: kb_pos = {3'd2, 3'd0};  // b n
  9'h04B: kb_pos = {3'd1, 3'd7};  9'h044: kb_pos = {3'd1, 3'd6};  // l o
  9'h03E: kb_pos = {3'd1, 3'd5};  9'h046: kb_pos = {3'd1, 3'd4};  // 8 9
  9'h043: kb_pos = {3'd1, 3'd3};  9'h042: kb_pos = {3'd1, 3'd2};  // i k
  9'h03A: kb_pos = {3'd1, 3'd1};  9'h041: kb_pos = {3'd1, 3'd0};  // m ,
  9'h05A: kb_pos = {3'd0, 3'd6};  9'h045: kb_pos = {3'd0, 3'd5};  // enter 0
  9'h076: kb_pos = {3'd0, 3'd4};  9'h04D: kb_pos = {3'd0, 3'd3};  // esc p
  9'h04C: kb_pos = {3'd0, 3'd2};  9'h049: kb_pos = {3'd0, 3'd1};  // ; .
  9'h16B: kb_pos = {3'd0, 3'd0};                                  // left
  default: begin kb_pos = 0; kb_hit = 0; end
  endcase
end

always @(posedge clk25) begin
  if (kb_stb) begin
    if (kb_byte == 8'hF0)
      kb_rel <= 1;
    else if (kb_byte == 8'hE0)
      kb_ext <= 1;
    else begin
      if (kb_hit)
        ecs_keys[kb_pos] <= !kb_rel;
      kb_rel <= 0;
      kb_ext <= 0;
    end
  end
end

// To clk_g (slow key presses; a torn read only misses one scan).
reg [63:0] ecs_keys_m, ecs_keys_g = 0;
always @(posedge clk_g) begin
  ecs_keys_m <= ecs_keys;
  ecs_keys_g <= ecs_keys_m;
end

wire [7:0] pa2_o;
wire       pa2_en;
reg  [7:0] kb_cols;
integer    r;
always @* begin
  kb_cols = 8'h00;
  for (r = 0; r < 8; r = r + 1)
    if (!pa2_o[r])
      kb_cols = kb_cols | ecs_keys_g[r * 8 +: 8];
end
// Both ECS ports read the columns while port A drives the rows; the ECS
// hand controllers (3 and 4) are not connected.
wire [7:0] pa2_in = pa2_en ? ~kb_cols : 8'hff;
wire [7:0] pb2_in = pa2_en ? ~kb_cols : 8'hff;


// ---------------------------------------------------------------------------
// The Intellivision

wire        cart_req, cart_we;
wire [18:0] cart_addr;
wire  [7:0] cart_wdata;
wire        pix_we;
wire  [3:0] pix_col;
wire  [8:0] pix_x, pix_y;
wire [15:0] core_audio;
reg  [15:0] paged_mask = 0;

reg   [7:0] mem_rdata;
reg         rom_we = 0;
reg   [2:0] rom_sel;
reg  [11:0] rom_a;
reg   [9:0] rom_d;
wire [15:0] dbg_ad;
wire  [2:0] dbg_bdic;
wire        dbg_phi;
reg         mem_ack;

intv_core intv
  ( .clk        (clk_g)
  , .reset_n    (!intv_reset)
  , .ecs        (ecs_g)
  , .jlp        (jlp_g)
  , .ivoice     (voice_g)
  , .rom_we     (rom_we)
  , .rom_sel    (rom_sel)
  , .rom_a      (rom_a)
  , .rom_d      (rom_d)
  , .pa_i       (pa)
  , .pb_i       (pb)
  , .pa2_o      (pa2_o)
  , .pa2_en     (pa2_en)
  , .pa2_i      (pa2_in)
  , .pb2_i      (pb2_in)
  , .paged_mask (paged_mask)
  , .mem_req    (cart_req)
  , .mem_we     (cart_we)
  , .mem_addr   (cart_addr)
  , .mem_wdata  (cart_wdata)
  , .mem_rdata  (mem_rdata)
  , .mem_ack    (mem_ack && !boot_mode)
  , .hvsync     (hvsync)
  , .pix_we     (pix_we)
  , .pix_col    (pix_col)
  , .pix_x      (pix_x)
  , .pix_y      (pix_y)
  , .audio      (core_audio)
  , .dbg_ad     (dbg_ad)
  , .dbg_bdic   (dbg_bdic)
  , .dbg_phi    (dbg_phi)
  );


`ifdef INTV_SIM_TRACE
// CPU bus: each address put on the bus (BAR = 1: fetches and indirect
// operands, ADAR = 4: direct operands)
always @(posedge clk_g)
  if (!boot_mode && dbg_phi && (dbg_bdic == 3'b001 || dbg_bdic == 3'b100))
    $display("%s %04x", dbg_bdic == 3'b001 ? "BAR" : "ADR", dbg_ad);
`endif

// ---------------------------------------------------------------------------
// Boot CPU

wire [15:0] cpu_a;
wire  [7:0] cpu_do;
wire        cpu_we;
reg   [7:0] cpu_di;

cpu boot_cpu
  ( .clk   (clk_g)
  , .reset (g_reset || !boot_mode)
  , .AB    (cpu_a)
  , .DI    (cpu_di)
  , .DO    (cpu_do)
  , .WE    (cpu_we)
  , .IRQ   (1'b0)
  , .NMI   (1'b0)
  , .RDY   (1'b1)
  );

wire sel_ram0 = (cpu_a[15:11] == 5'b00000);
wire sel_text = (cpu_a[15:10] == 6'b010000);
wire sel_io   = (cpu_a[15:8]  == 8'h50);
wire sel_ram6 = (cpu_a[15:13] == 3'b011);
wire sel_rom  = (cpu_a[15:13] >= 3'b101);

reg [7:0] ram0 [0:2047];
reg [7:0] ram6 [0:8191];
reg [7:0] bootrom [0:24575];
reg [7:0] ram0_q, ram6_q, rom_q, io_q;
reg [2:0] sel_q;

initial $readmemh(BOOTROM_FILE, bootrom);

always @(posedge clk_g) begin
  if (cpu_we && sel_ram0) ram0[cpu_a[10:0]] <= cpu_do;
  ram0_q <= ram0[cpu_a[10:0]];
end

always @(posedge clk_g) begin
  if (cpu_we && sel_ram6) ram6[cpu_a[12:0]] <= cpu_do;
  ram6_q <= ram6[cpu_a[12:0]];
end

// $A000-$FFFF: three 8K parts
wire [1:0] rom_part = cpu_a[14:13] - 2'd1;
always @(posedge clk_g)
  rom_q <= bootrom[{rom_part, cpu_a[12:0]}];

always @(posedge clk_g)
  sel_q <= sel_ram0 ? 3'd0 : sel_ram6 ? 3'd1 : sel_io ? 3'd2 : sel_rom ? 3'd3 : 3'd4;

always @* begin
  case (sel_q)
  3'd0:    cpu_di = ram0_q;
  3'd1:    cpu_di = ram6_q;
  3'd2:    cpu_di = io_q;
  3'd3:    cpu_di = rom_q;
  default: cpu_di = 8'hff;
  endcase
end

// Text screen: written by the boot CPU, read by the video side.
reg [7:0] text [0:1023];
always @(posedge clk_g)
  if (cpu_we && sel_text) text[cpu_a[9:0]] <= cpu_do;

// ---------------------------------------------------------------------------
// Boot I/O: SD card SPI, forward engine, SRAM loader

reg        spi_sel = 0;
reg        spi_slow = 1;
reg        spi_busy = 0;
reg  [7:0] spi_tx = 8'hff, spi_rx = 8'hff;
reg  [7:0] spi_txd;
reg  [2:0] spi_bit;
reg  [6:0] spi_div = 0;
reg        spi_sclk_r = 0;
reg        spi_start = 0;
reg [15:0] fwd_count = 0;
reg  [7:0] fwd_lo;
reg        fwd_active = 0;
reg        fwd_discard = 0;
reg        fwd_feed = 0;
reg        fwd_feed_wait = 0;

reg [18:0] ld_addr = 0;
reg  [7:0] ld_data;
reg        ld_pend = 0;      // a byte waits for the SRAM
reg        ld_byte = 0;      // a byte for the load target
reg        ld_byte_d = 0;    // ... went to a ROM
reg  [2:0] ld_target = 0;
reg  [7:0] ld_hi;            // high byte of a ROM word
reg        ld_done = 0;      // SRAM write finished (from the controller)
reg [31:0] crc = 32'hffffffff;
reg  [7:0] mask_lo;

assign sd_cs_n = !spi_sel;
assign sd_sclk = spi_sclk_r;
assign sd_mosi = spi_tx[7];

// SPI half period: 2 clocks fast (10.7MHz SCLK), 64 clocks slow (335kHz).
wire spi_tick = spi_slow ? (spi_div == 7'd63) : (spi_div[0] == 1'b1);

always @(posedge clk_g) begin
  spi_div <= spi_tick ? 7'd0 : spi_div + 1;

  if (spi_start) begin
    spi_tx     <= spi_txd;
    spi_busy   <= 1;
    spi_bit    <= 0;
    spi_sclk_r <= 0;
    spi_div    <= 0;
  end else if (spi_busy && spi_tick) begin
    if (!spi_sclk_r) begin                // rising edge: sample MISO
      spi_sclk_r <= 1;
      spi_rx     <= {spi_rx[6:0], sd_miso};
    end else begin                        // falling edge: shift MOSI
      spi_sclk_r <= 0;
      spi_tx     <= {spi_tx[6:0], 1'b1};
      spi_bit    <= spi_bit + 1;
      if (spi_bit == 3'd7)
        spi_busy <= 0;
    end
  end

  if (g_reset) begin
    spi_busy   <= 0;
    spi_sclk_r <= 0;
    spi_tx     <= 8'hff;
  end
end

// CRC-32, reflected, polynomial EDB88320 (zlib)
function [31:0] crc32_byte(input [31:0] c, input [7:0] d);
  integer i;
  reg [31:0] r;
  begin
    r = c ^ {24'd0, d};
    for (i = 0; i < 8; i = i + 1)
      r = r[0] ? (r >> 1) ^ 32'hEDB88320 : (r >> 1);
    crc32_byte = r;
  end
endfunction

wire fwd_byte_ready = fwd_feed_wait && !spi_busy;
wire io_wr = boot_mode && cpu_we && sel_io;

always @(posedge clk_g) begin
  spi_start  <= 0;
  start_game <= 0;
  fwd_feed   <= 0;

  if (fwd_feed)
    fwd_feed_wait <= 1;
  else if (fwd_byte_ready)
    fwd_feed_wait <= 0;

  if (ld_done)
    ld_pend <= 0;

  if (io_wr) begin
    case (cpu_a[7:0])
    8'h00: begin spi_txd <= cpu_do; spi_start <= 1; end
    8'h01: begin spi_sel <= cpu_do[0]; spi_slow <= cpu_do[1]; fwd_discard <= cpu_do[2]; end
    8'h02: begin ld_data <= cpu_do; ld_byte <= 1; end
    8'h03: crc        <= 32'hffffffff;
    8'h04: start_game <= 1;
    8'h05: led_err    <= cpu_do[0];
    8'h06: fwd_lo     <= cpu_do;
    8'h07: begin fwd_count <= {cpu_do, fwd_lo}; fwd_active <= 1; end
    8'h08: ld_addr[7:0]   <= cpu_do;
    8'h09: ld_addr[15:8]  <= cpu_do;
    8'h0A: ld_addr[18:16] <= cpu_do[2:0];
    8'h0B: mask_lo    <= cpu_do;
    8'h0C: paged_mask <= {cpu_do, mask_lo};
    8'h0D: swap       <= cpu_do[0];
    8'h0E: begin ecs_g <= cpu_do[0]; jlp_g <= cpu_do[1]; voice_g <= cpu_do[2]; end
    8'h0F: ld_target <= cpu_do[2:0];
    default: ;
    endcase
  end

  // Forward engine: one byte at a time, each to the SRAM and the CRC.  The
  // next transfer starts once the SRAM has taken the previous byte.
  if (fwd_active && !spi_busy && !spi_start && !fwd_feed && !fwd_feed_wait && !ld_pend && !ld_byte) begin
    if (fwd_count == 0) begin
      fwd_active <= 0;
    end else begin
      spi_txd   <= 8'hff;
      spi_start <= 1;
      fwd_feed  <= 1;
      fwd_count <= fwd_count - 1;
    end
  end

  if (fwd_byte_ready && !fwd_discard) begin
    ld_data <= spi_rx;
    ld_byte <= 1;
    crc     <= crc32_byte(crc, spi_rx);
  end

  // A byte for the load target: the SRAM takes it through the SRAM
  // controller, the ROMs right away.
  rom_we  <= 0;
  ld_byte_d <= 0;
  if (ld_byte) begin
    ld_byte <= 0;
    if (ld_target == 3'd0)
      ld_pend <= 1;
    else begin
      ld_byte_d <= 1;
      case (ld_target)
      3'd1: begin rom_sel <= 3'd0; rom_a <= ld_addr[12:1]; rom_we <= ld_addr[0]; end
      3'd2: begin rom_sel <= 3'd1; rom_a <= {1'b0, ld_addr[10:0]}; rom_we <= 1; end
      3'd3: begin rom_sel <= 3'd2 + ld_addr[14:13]; rom_a <= ld_addr[12:1]; rom_we <= ld_addr[0]; end
      3'd4: begin rom_sel <= 3'd5; rom_a <= {1'b0, ld_addr[10:0]}; rom_we <= 1; end
      default: ;
      endcase
      rom_d   <= ld_addr[0] ? {ld_hi[1:0], ld_data} : {2'b00, ld_data};
      ld_hi   <= ld_data;
    end
  end

  if (ld_done || ld_byte_d)
    ld_addr <= ld_addr + 1;

  if (g_reset) begin
    spi_sel       <= 0;
    spi_slow      <= 1;
    fwd_discard   <= 0;
    fwd_active    <= 0;
    fwd_feed_wait <= 0;
    ld_pend       <= 0;
    ld_byte       <= 0;
    ld_target     <= 0;
    led_err       <= 0;
    paged_mask    <= 0;
  end
end

reg [2:0] vblank_s = 0;

wire [31:0] crc_out = ~crc;

always @(posedge clk_g) begin
  case (cpu_a[7:0])
  8'h00:   io_q <= spi_rx;
  8'h01:   io_q <= {spi_busy || spi_start || fwd_active || fwd_feed || fwd_feed_wait || ld_pend || ld_byte,
                    !sd_cd_n, vblank_s[2], 5'd0};
  8'h10:   io_q <= menu_g;
  8'h11:   io_q <= crc_out[7:0];
  8'h12:   io_q <= crc_out[15:8];
  8'h13:   io_q <= crc_out[23:16];
  8'h14:   io_q <= crc_out[31:24];
  8'h15:   io_q <= mkey_g;
  default: io_q <= 8'hff;
  endcase
  vblank_s <= {vblank_s[1:0], vc >= 10'd480};
end

// ---------------------------------------------------------------------------
// SRAM controller (clk_g, 23.3ns): reads present the address for two
// clocks; writes take five (address and data, WE low for two clocks, WE
// high, release the bus).  In boot mode the loader writes, otherwise the
// cartridge reads and writes.

reg  [2:0] ms = 0;
wire       m_req   = boot_mode ? (ld_pend && !ld_done) : cart_req;
wire       m_we    = boot_mode ? 1'b1 : cart_we;
wire [18:0] m_addr = boot_mode ? ld_addr : cart_addr;
wire  [7:0] m_data = boot_mode ? ld_data : cart_wdata;

initial begin
  sram_we_n = 1;
  sram_oe_n = 1;
  sram_doe  = 0;
end

always @(posedge clk_g) begin
  mem_ack <= 0;
  ld_done <= 0;
  case (ms)
  3'd0: begin
      sram_we_n <= 1;
      sram_doe  <= 0;
      sram_oe_n <= 0;
      if (m_req && !mem_ack && !ld_done) begin
        sram_addr <= m_addr;
        sram_dout <= m_data;
        if (m_we) begin
          sram_doe  <= 1;
          sram_oe_n <= 1;
          ms <= 3'd3;
        end else
          ms <= 3'd1;
      end
    end
  3'd1: ms <= 3'd2;
  3'd2: begin
      mem_rdata <= sram_din;
      mem_ack   <= 1;
      ms <= 3'd0;
    end
  3'd3: begin sram_we_n <= 0; ms <= 3'd4; end
  3'd4: ms <= 3'd5;
  3'd5: begin sram_we_n <= 1; ms <= 3'd6; end
  3'd6: begin
      sram_doe <= 0;
      mem_ack  <= !boot_mode;
      ld_done  <= boot_mode;
      ms <= 3'd0;
    end
  default: ms <= 3'd0;
  endcase
end

// ---------------------------------------------------------------------------
// Line buffer: 8 lines of 256 pixels, written at clk_g, read at clk25.

reg [3:0] linebuf [0:2047];

always @(posedge clk_g)
  if (pix_we && pix_y < 9'd240 && pix_x < 9'd256)
    linebuf[{pix_y[2:0], pix_x[7:0]}] <= pix_col;

// ---------------------------------------------------------------------------
// Video (clk25)

reg [1:0] boot_s = 2'b11;
always @(posedge clk25)
  boot_s <= {boot_s[0], boot_mode};
wire show_menu = boot_s[1];

// Game picture: x 35..604, 3 HDMI pixels per Intellivision pixel.
reg  [7:0] gx = 0;
reg  [1:0] gsub = 0;
wire       g_in = (hc >= 10'd35) && (hc < 10'd605) && (vc < 10'd480);
wire [8:0] gline = vc[9:1];

always @(posedge clk25) begin
  if (hc == 10'd34) begin
    gx   <= 0;
    gsub <= 0;
  end else if (gsub == 2'd2) begin
    gsub <= 0;
    gx   <= gx + 1;
  end else
    gsub <= gsub + 1;
end

reg [3:0] lb_q;
always @(posedge clk25)
  lb_q <= linebuf[{gline[2:0], gx}];

// Menu text: 32 x 30 characters of 16 x 16 pixels, x 64..575.  The font
// is the Intellivision's (GROM cards 0-95, ASCII 32-127), doubled.
reg  [7:0] font [0:1023];
initial $readmemh(FONT_FILE, font);

wire [9:0] tx = hc - 10'd64;
wire       t_in = (hc >= 10'd64) && (hc < 10'd576) && (vc < 10'd480);
reg  [7:0] ch_q;
reg  [7:0] glyph_q;
reg  [2:0] tx_d1, tx_d2;
reg        ch_ok;

always @(posedge clk25) begin
  ch_q  <= text[{vc[8:4], tx[8:4]}];          // stage 1
  tx_d1 <= tx[3:1];
  glyph_q <= font[{ch_q[6:0] - 7'd32, vc[3:1]}]; // stage 2
  ch_ok <= (ch_q >= 8'd32) && (ch_q < 8'd128);
  tx_d2 <= tx_d1;
end

// Intellivision palette (the MiSTer core's)
function [23:0] palette(input [3:0] c);
  case (c)
  4'd0:  palette = 24'h0C0005;  4'd1:  palette = 24'h002DFF;
  4'd2:  palette = 24'hFF3E00;  4'd3:  palette = 24'hC9D464;
  4'd4:  palette = 24'h00780F;  4'd5:  palette = 24'h00A720;
  4'd6:  palette = 24'hFAEA27;  4'd7:  palette = 24'hFFFCFF;
  4'd8:  palette = 24'hA7A8A8;  4'd9:  palette = 24'h5ACBFF;
  4'd10: palette = 24'hFFA600;  4'd11: palette = 24'h3C5800;
  4'd12: palette = 24'hFF3276;  4'd13: palette = 24'hBD95FF;
  4'd14: palette = 24'h6CCD30;  default: palette = 24'hC81A7D;
  endcase
endfunction

reg [2:0] g_in_d, t_in_d, blank_d, hs_d, vs_d;
reg [23:0] g_rgb;

always @(posedge clk25) begin
  // stage 2: palette
  g_rgb <= palette(lb_q);

  g_in_d  <= {g_in_d[1:0], g_in};
  t_in_d  <= {t_in_d[1:0], t_in};
  blank_d <= {blank_d[1:0], !(hc < 10'd640 && vc < 10'd480)};
  hs_d    <= {hs_d[1:0], !(hc >= 10'd656 && hc < 10'd752)};
  vs_d    <= {vs_d[1:0], !(vc >= 10'd490 && vc < 10'd492)};

  // stage 3: output
  if (show_menu) begin
    if (t_in_d[1] && ch_ok && glyph_q[3'd7 - tx_d2])
      {vid_r, vid_g, vid_b} <= 24'hFFFFFF;
    else
      {vid_r, vid_g, vid_b} <= 24'h000040;
  end else if (g_in_d[1])
    {vid_r, vid_g, vid_b} <= g_rgb;
  else
    {vid_r, vid_g, vid_b} <= 24'h000000;
  vid_blank   <= blank_d[1];
  vid_hsync_n <= hs_d[1];
  vid_vsync_n <= vs_d[1];
end

// ---------------------------------------------------------------------------
// Audio (mixed in intv_core.vhd), to clk25 once stable for two clocks.

reg [15:0] snd_g = 0;
reg [15:0] snd_m, snd_s;
always @(posedge clk_g)
  snd_g <= boot_mode ? 16'd0 : core_audio;
always @(posedge clk25) begin
  snd_m <= snd_g;
  snd_s <= snd_m;
  if (snd_s == snd_m)
    audio <= snd_s;
end

endmodule
