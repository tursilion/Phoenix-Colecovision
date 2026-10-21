// Gyruss main board: Z80, KONAMI-1 (encrypted 6809) and the Time Pilot
// style video (Konami 082 timing, 083 shifters, 501 bus, 502/503 sprites).
//
// A Verilog-2001 port of Ace's Gyruss_CPU.sv from the MiSTer Gyruss core
// (MIT license, Copyright (C) 2021 Ace), changed for the Phoenix:
//   - one 25MHz clock with clock enables.  cen12 is the 12.288MHz enable
//     (a fractional rate, a little slower, and frozen while the frame waits
//     for the HDMI output); the 6.144MHz pixel, 3.072MHz Z80 and 1.536MHz
//     enables are derived from it with the same phases as on the MiSTer.
//   - tv80 for the Z80 and cpu09 (John Kent, with MiSTer-X's opcode input)
//     for the KONAMI-1, clocked by an enable at the falling edge of E.
//   - the CPU ROMs are in the external SRAM (see gyruss_phoenix.v); the
//     graphics ROMs and the PROMs are block/distributed RAM loaded by the
//     boot loader.
//   - boot mode: the Z80 runs the loader (0000-1FFF from boot_q), and the
//     page C000-C0FF is the loader's register window (handled outside).
//
// The 502/503 models are rewritten for one clock edge; see the comments at
// the sprite line buffer.

`timescale 1ns / 1ps

module gyruss_main
   ( input             clk
   , input             reset         // CPUs (active high)
   , input             cen12         // 12.288MHz enable, frozen with the frame
   , input             boot_mode

   // Controls and DIP switches (active low, as read by the game)
   , input       [7:0] in_sys
   , input       [7:0] in_p1
   , input       [7:0] in_p2
   , input       [7:0] dsw1
   , input       [7:0] dsw2
   , input       [7:0] dsw3

   // Z80 bus (for the ROM fetch and the boot loader)
   , output     [15:0] z80_a
   , output      [7:0] z80_dout
   , output            z80_mreq_n
   , output            z80_iorq_n
   , output            z80_rd_n
   , output            z80_wr_n
   , output            z80_m1_n
   , output            z80_rfsh_n
   , input       [7:0] rom1_q        // main ROM data (SRAM) for z80_a
   , input             boot_sel      // boot_q drives the Z80 data bus
   , input       [7:0] boot_q

   // KONAMI-1 ROM (SRAM)
   , output     [15:0] k1_a
   , input       [7:0] rom4_q

   // Sound board
   , output reg  [7:0] snd_latch = 0
   , output            snd_irq       // pulse: interrupt the sound CPU

   // Graphics ROM and PROM loading
   , input             ld_we
   , input      [17:0] ld_a
   , input       [7:0] ld_d
   , input      [12:0] tile_rd_a     // tile ROM second port (boot ROM reads)
   , output reg  [7:0] tile_rd_q

   // Boot text: the video RAM's second port
   , input      [10:0] text_a
   , output reg  [7:0] text_q

   // Video
   , output      [8:0] h_cnt
   , output      [8:0] v_cnt
   , output            cen6
   , output            d0            // the next cen12 is not a pixel enable
   , output            hblk
   , output            vblk
   , output reg  [4:0] pixel = 0     // color PROM address
   , input       [4:0] pal_a
   , output      [7:0] pal_q
   );

// ---------------------------------------------------------------------------
// Clock enables: the MiSTer core counts a 49.152MHz clock (div), giving
// cen_12m = div[1:0]==0, cen_6m = div[2:0]==0, cen_3m = div[3:0]==0,
// cen_1m5 = div[4:0]==0.  Here d counts the 12.288MHz enables.

reg  [2:0] d = 0;
always @(posedge clk)
  if (cen12) d <= d + 1'd1;

assign cen6  = cen12 && d[0] == 1'b0;
assign d0    = d[0];
wire   cen3  = cen12 && d[1:0] == 2'b00;
wire   cen1m5= cen12 && d[2:0] == 3'b000;

// ---------------------------------------------------------------------------
// Konami 082: video timing
//   horizontal 128-511 (384 pixels), vertical 248-511 (264 lines),
//   the vertical count steps at h = 176, VBlank from 495 to 271.

reg [8:0] hc = 0;
reg [8:0] vc = 0;
reg       vblk_r = 1;
reg       vblank_irq_en = 0;

always @(posedge clk) begin
  if (cen6) begin
    case (hc)
    9'd48: begin
        vc <= vc + 1'd1;
        hc <= hc + 1'd1;
      end
    9'd176: begin
        hc <= hc + 1'd1;
        case (vc)
        9'd16:  begin vblk_r <= 0; vc <= vc + 1'd1; end
        9'd271: begin vblk_r <= 0; vc <= vc + 1'd1; end
        9'd495: begin vblk_r <= 1; vblank_irq_en <= 1; vc <= vc + 1'd1; end
        9'd511: vc <= 9'd248;
        default: vc <= vc + 1'd1;
        endcase
      end
    9'd177: begin
        vblank_irq_en <= 0;
        hc <= hc + 1'd1;
      end
    9'd511: hc <= 9'd128;
    default: hc <= hc + 1'd1;
    endcase
  end
end

assign h_cnt = hc;
assign v_cnt = vc;
assign vblk  = vblk_r;
assign hblk  = (hc > 9'd140 && hc < 9'd269);

wire [7:0] vcnt8 = vc[7:0];

// ---------------------------------------------------------------------------
// Z80

wire [15:0] A;
wire  [7:0] z80_do;
wire        n_mreq, n_iorq, n_rd, n_wr, n_m1, n_rfsh;
wire        n_wait;
reg         z80_nmi = 1;
reg   [7:0] z80_din;

tv80e #(.Mode(0), .T2Write(1), .IOWait(1)) u13G
  ( .m1_n(n_m1), .mreq_n(n_mreq), .iorq_n(n_iorq), .rd_n(n_rd), .wr_n(n_wr)
  , .rfsh_n(n_rfsh), .halt_n(), .busak_n(), .A(A), .dout(z80_do)
  , .reset_n(!reset), .clk(clk), .cen(cen3), .wait_n(n_wait), .int_n(1'b1)
  , .nmi_n(z80_nmi), .busrq_n(1'b1), .di(z80_din)
  );

assign z80_a      = A;
assign z80_dout   = z80_do;
assign z80_mreq_n = n_mreq;
assign z80_iorq_n = n_iorq;
assign z80_rd_n   = n_rd;
assign z80_wr_n   = n_wr;
assign z80_m1_n   = n_m1;
assign z80_rfsh_n = n_rfsh;

wire mem     = !n_mreq && n_rfsh;
wire cs_rom  = mem && (A[15:13] == 3'b000 || A[15:13] == 3'b001 || A[15:13] == 3'b010);
wire n_cs_k501 = !(mem && A[15]);

// Konami 501: CPU access to the video/work RAM only in the half of each
// 4-pixel slot where the video does not use it.
reg [1:0] h1_reg = 0;
always @(posedge clk) begin
  if (hc[1])
    h1_reg[0] <= 1'b1;
  else if (cen12)
    h1_reg <= {h1_reg[0], hc[0]};
end

wire h1_lat        = &h1_reg;
assign n_wait      = !hc[1] | n_cs_k501;
wire n_k501_enable = h1_lat | n_cs_k501;
wire n_ram_write   = !n_rd | n_k501_enable;

wire io_sel = !n_k501_enable && A[14];
wire cs_controls_dip1 = io_sel && A[8:7] == 2'b01 && n_ram_write;
wire cs_dip2          = io_sel && A[8:7] == 2'b00 && n_ram_write;
wire cs_dip3          = io_sel && A[8:7] == 2'b10 && n_ram_write;
wire cs_sounddata     = io_sel && A[8:7] == 2'b10 && !n_ram_write;
wire cs_soundirq      = io_sel && A[8:7] == 2'b01 && !n_ram_write;
wire cs_mainlatch     = io_sel && A[8:7] == 2'b11 && !n_ram_write;
wire cs_z80sharedram  = A[14:13] == 2'b01 && !n_k501_enable;
wire n_cs_vram_wram   = !(A[14:13] == 2'b00 && !n_k501_enable);

wire n_cs_vram = A[12] & !hc[1];
wire cs_wram   = n_cs_vram;                  // A12 set, CPU slot
wire n_vram_wram_wr = n_cs_vram_wram | n_ram_write;

// Inputs and DIP switches
wire [7:0] controls_dip1 = (A[6:5] == 2'b00) ? in_sys :
                           (A[6:5] == 2'b01) ? in_p1 :
                           (A[6:5] == 2'b10) ? in_p2 : dsw1;
wire [7:0] controls_dip  = cs_controls_dip1 ? controls_dip1 :
                           cs_dip2 ? dsw2 :
                           cs_dip3 ? dsw3 : 8'hff;

// Sound
reg sound_irq = 0;
always @(posedge clk) begin
  if (cen3) begin
    sound_irq <= cs_soundirq;
    if (cs_sounddata)
      snd_latch <= z80_do;
  end
end
reg sound_irq_d = 0;
always @(posedge clk) sound_irq_d <= sound_irq;
assign snd_irq = sound_irq && !sound_irq_d;

// Main latch: NMI mask and flip
reg z80_nmi_mask = 0;
reg flip = 0;
always @(posedge clk) begin
  if (reset) begin
    z80_nmi_mask <= 0;
    flip <= 0;
  end else if (cen3 && cs_mainlatch) begin
    case (A[2:0])
    3'b000: z80_nmi_mask <= z80_do[0];
    3'b101: flip <= z80_do[0];
    default: ;
    endcase
  end
end

always @(posedge clk) begin
  if (cen6) begin
    if (!z80_nmi_mask)
      z80_nmi <= 1;
    else if (vblank_irq_en)
      z80_nmi <= 0;
  end
end

// ---------------------------------------------------------------------------
// Video counters as the board uses them

reg [7:0] vcnt_lat = 0;
reg       old_h256 = 0;
always @(posedge clk) begin
  old_h256 <= hc[8];
  if (!old_h256 && hc[8])
    vcnt_lat <= vcnt8;
end

reg h1d = 0;
always @(posedge clk)
  if (cen6) h1d <= hc[0];

wire [7:2] hcnt_x = hc[7:2] ^ {6{flip}};
wire [7:0] vcnt_x = vcnt_lat ^ {8{flip}};

// ---------------------------------------------------------------------------
// RAM

// Video RAM (colour 8000-83FF, codes 8400-87FF): shared in time with the
// tile fetch; second port for the boot loader's text.
reg  [7:0] vram [0:2047];
reg  [7:0] vram_q;
wire [10:0] vram_wram_A = hc[1] ? {hc[2], vcnt_x[7:3], hcnt_x[7:3]} : A[10:0];
wire vram_we = !n_cs_vram_wram && !n_cs_vram && !n_vram_wram_wr;

always @(posedge clk) begin
  if (vram_we) begin
    vram[vram_wram_A] <= z80_do;
    vram_q <= z80_do;
  end else
    vram_q <= vram[vram_wram_A];
end

always @(posedge clk)
  text_q <= vram[text_a];

// Work RAM 9000-9FFF
reg  [7:0] wram [0:4095];
reg  [7:0] wram_q;
wire wram_we = !n_cs_vram_wram && cs_wram && !n_vram_wram_wr;

always @(posedge clk) begin
  if (wram_we) begin
    wram[A[11:0]] <= z80_do;
    wram_q <= z80_do;
  end else
    wram_q <= wram[A[11:0]];
end

// Shared RAM (Z80 A000-A7FF, KONAMI-1 6000-67FF)
reg  [7:0] sram2 [0:2047];
reg  [7:0] z80_shared_q;
reg  [7:0] k1_shared_q;
wire       n_z80_sharedram_wr = !cs_z80sharedram | n_ram_write;
wire [15:0] k1_A;
wire  [7:0] k1_dout;
wire        k1_rw, k1_vma;
wire        cs_k1sharedram = k1_A[15:13] == 3'b011;
wire        k1_shared_we = cs_k1sharedram && !k1_rw && k1_vma && hc[1];

always @(posedge clk) begin
  if (cs_z80sharedram && !n_z80_sharedram_wr) begin
    sram2[A[10:0]] <= z80_do;
    z80_shared_q <= z80_do;
  end else
    z80_shared_q <= sram2[A[10:0]];
end

always @(posedge clk) begin
  if (k1_shared_we) begin
    sram2[k1_A[10:0]] <= k1_dout;
    k1_shared_q <= k1_dout;
  end else
    k1_shared_q <= sram2[k1_A[10:0]];
end

// 501 data pass-through
wire [7:0] k501_din = (!n_cs_vram_wram && cs_wram && n_vram_wram_wr)    ? wram_q :
                      (!n_cs_vram_wram && !n_cs_vram && n_vram_wram_wr) ? vram_q :
                      (cs_z80sharedram && n_z80_sharedram_wr)           ? z80_shared_q :
                      (cs_controls_dip1 | cs_dip2 | cs_dip3)            ? controls_dip :
                      8'hff;

always @* begin
  if (boot_sel)
    z80_din = boot_q;
  else if (cs_rom)
    z80_din = rom1_q;
  else if (!n_cs_k501)
    z80_din = k501_din;
  else
    z80_din = 8'hff;
end

// ---------------------------------------------------------------------------
// KONAMI-1: E and Q at a quarter of the pixel clock, E falling as h[1:0]
// goes from 10 to 11 (the CPU's half of the RAM slots).

reg k1_E = 0;
always @(posedge clk)
  k1_E <= cen6 && hc[1:0] == 2'b10;

reg  [7:0] k1_din;
wire [7:0] k1_opc = k1_din ^ {k1_A[1], 1'b0, !k1_A[1], 1'b0, k1_A[3], 1'b0, !k1_A[3], 1'b0};
reg        k1_irq = 1;

cpu09 u18F
  ( .clk(clk), .rst(reset), .rw(k1_rw), .vma(k1_vma), .address(k1_A)
  , .data_in(k1_din), .data_out(k1_dout), .halt(1'b0), .hold(!k1_E)
  , .irq(!k1_irq), .firq(1'b0), .nmi(1'b0), .opc_in(k1_opc)
  );

assign k1_a = k1_A;

wire cs_beam        = k1_A[15:13] == 3'b000 && k1_rw;
wire cs_k1irqmask   = k1_A[15:13] == 3'b001 && !k1_rw && k1_vma;
wire cs_spriteram   = k1_A[15:13] == 3'b010;
wire cs_rom4        = k1_A[15:13] == 3'b111;

// Sprite RAM: 1K x 16 (two banks selected by A1), shared in time with the
// sprite scan.
wire n_cs_spriteram = !cs_spriteram | !hc[1];
wire k1_rw1         = h1d | k1_rw | !k1_vma;
wire spriteram0_wr  = !n_cs_spriteram && !k1_rw1 && k1_A[1];
wire spriteram1_wr  = !n_cs_spriteram && !k1_rw1 && !k1_A[1];
wire [9:0] spriteram_A = hc[1] ? {k1_A[10:2], k1_A[0]} :
                         {3'b000, hc[7], (hc[8] ^ hc[7]), hc[6], hc[3], hc[4], hc[5], hc[2]};

reg  [7:0] spr0 [0:1023];
reg  [7:0] spr1 [0:1023];
reg [15:0] spriteram_D;

always @(posedge clk) begin
  if (spriteram0_wr) begin
    spr0[spriteram_A] <= k1_dout;
    spriteram_D[7:0] <= k1_dout;
  end else
    spriteram_D[7:0] <= spr0[spriteram_A];
end

always @(posedge clk) begin
  if (spriteram1_wr) begin
    spr1[spriteram_A] <= k1_dout;
    spriteram_D[15:8] <= k1_dout;
  end else
    spriteram_D[15:8] <= spr1[spriteram_A];
end

always @* begin
  if (cs_beam)
    k1_din = vcnt8;
  else if (cs_spriteram && !n_cs_spriteram && k1_A[1])
    k1_din = spriteram_D[7:0];
  else if (cs_spriteram && !n_cs_spriteram && !k1_A[1])
    k1_din = spriteram_D[15:8];
  else if (cs_k1sharedram && k1_rw && hc[1])
    k1_din = k1_shared_q;
  else if (cs_rom4)
    k1_din = rom4_q;
  else
    k1_din = 8'hff;
end

reg k1_irq_mask = 0;
always @(posedge clk) begin
  if (reset)
    k1_irq_mask <= 0;
  else if (cen3 && cs_k1irqmask)
    k1_irq_mask <= k1_dout[0];
end

always @(posedge clk) begin
  if (cen6) begin
    if (!k1_irq_mask)
      k1_irq <= 1;
    else if (vblank_irq_en)
      k1_irq <= 0;
  end
end

// ---------------------------------------------------------------------------
// Graphics ROMs and PROMs, written by the loader:
//   10000-17FFF sprite ROMs (gfx1: 6, 5, 8, 7), 18000-19FFF tile ROM (4),
//   1A000-1A01F colour PROM, 1A100-1A1FF sprite lookup, 1A200-1A2FF tile
//   lookup.

wire ld_spr  = ld_we && ld_a[17:15] == 3'b010;
wire ld_tile = ld_we && ld_a[17:13] == 5'b01100;
wire ld_prom = ld_we && ld_a[17:10] == 8'b01101000;

// Tile ROM; its second port reads the boot ROM (this block RAM holds the
// boot loader until the tile ROM is loaded over it).
reg [7:0] tilerom [0:8191];
initial $readmemh("gyruss_boot.hex", tilerom);

wire [12:0] tilerom_A;
reg   [7:0] tilerom_q;

always @(posedge clk)
  tilerom_q <= tilerom[tilerom_A];

always @(posedge clk) begin
  if (ld_tile)
    tilerom[ld_a[12:0]] <= ld_d;
  tile_rd_q <= tilerom[tile_rd_a];
end

// Sprite ROMs, as two 16K x 8 halves: low = planes 0/1 (gfx1 0000-3FFF,
// ROMs 6 and 5), high = planes 2/3 (gfx1 4000-7FFF, ROMs 8 and 7).
reg [7:0] sprlo [0:16383];
reg [7:0] sprhi [0:16383];
wire [13:0] sprrom_A;
reg   [7:0] sprlo_q, sprhi_q;

always @(posedge clk) begin
  sprlo_q <= sprlo[sprrom_A];
  sprhi_q <= sprhi[sprrom_A];
  if (ld_spr && !ld_a[14])
    sprlo[ld_a[13:0]] <= ld_d;
  if (ld_spr && ld_a[14])
    sprhi[ld_a[13:0]] <= ld_d;
end

// PROMs (distributed RAM)
reg [7:0] color_prom [0:31];
reg [3:0] sprite_lut [0:255];
reg [3:0] tile_lut   [0:255];

always @(posedge clk) begin
  if (ld_prom && ld_a[9:8] == 2'b00 && ld_a[7:5] == 3'b000)
    color_prom[ld_a[4:0]] <= ld_d;
  if (ld_prom && ld_a[9:8] == 2'b01)
    sprite_lut[ld_a[7:0]] <= ld_d[3:0];
  if (ld_prom && ld_a[9:8] == 2'b10)
    tile_lut[ld_a[7:0]] <= ld_d[3:0];
end

// ---------------------------------------------------------------------------
// Tile layer

reg ldo = 1;
always @(posedge clk)
  ldo <= !(hc[2:0] == 3'b111);

reg [7:0] tile_code = 0;
always @(posedge clk)
  if (!ldo && hc[2:0] == 3'b000)
    tile_code <= vram_q;

reg tile_attrib_latch = 1;
always @(posedge clk)
  tile_attrib_latch <= !(hc[2:0] == 3'b011);

reg [7:0] tile_attrib = 0;
always @(posedge clk)
  if (hc[8] && !tile_attrib_latch && hc[2:0] == 3'b100)
    tile_attrib <= vram_q;

reg v1l = 0, v2l = 0, v4l = 0, cra = 0, tile_hflip = 0, tile_vflip = 0;
reg old_h4 = 0;
always @(posedge clk) begin
  old_h4 <= hc[2];
  if (old_h4 && !hc[2]) begin
    v1l <= vcnt_x[0];
    v2l <= vcnt_x[1];
    v4l <= vcnt_x[2];
    tile_hflip <= tile_attrib[6];
    tile_vflip <= tile_attrib[7];
    cra <= tile_attrib[5];
  end
end

wire tile_flip = tile_hflip ^ !flip;
reg  tile_083_flip = 0;
reg  tilemap_en = 0;
reg  [3:0] tile_color = 0;
always @(posedge clk) begin
  if (cen6 && hc[2:0] == 3'b011) begin
    tile_083_flip <= tile_flip;
    tile_color <= tile_attrib[3:0];
    tilemap_en <= tile_attrib[4];
  end
end

assign tilerom_A = {cra, tile_code, hcnt_x[2] ^ tile_hflip, v4l ^ tile_vflip,
                    v2l ^ tile_vflip, v1l ^ tile_vflip};

// Konami 083 (tiles): shift registers
wire       k083_load = hc[1:0] == 2'b11;
reg  [7:0] t_l = 0, t_r = 0;
always @(posedge clk) begin
  if (cen6) begin
    if (k083_load) begin
      t_l <= tilerom_q;
      t_r <= tilerom_q;
    end else begin
      t_l <= {t_l[6:4], 1'b0, t_l[2:0], 1'b0};
      t_r <= {1'b0, t_r[7:5], 1'b0, t_r[3:1]};
    end
  end
end
wire [1:0] tile_pix = tile_083_flip ? {t_l[3], t_l[7]} : {t_r[0], t_r[4]};

wire [3:0] tile_D = tile_lut[{2'b00, tile_color, tile_pix}];

// ---------------------------------------------------------------------------
// Sprite layer

reg [15:0] spriteram_reg = 0;
always @(posedge clk)
  if (cen1m5) spriteram_reg <= spriteram_D;

// Konami 503
wire [7:0] k503_ob = spriteram_reg[7:0];
wire [7:0] sprite_sum = k503_ob + vcnt_lat;
wire       sprite_sel = !(&sprite_sum[7:4]);
reg  [6:0] k503_sprite = 0;
reg        k503_hflip = 0, k503_vflip = 0;
reg        k503_old_h4 = 0;
always @(posedge clk) begin
  k503_old_h4 <= hc[2];
  if (!k503_old_h4 && hc[2]) begin
    k503_hflip <= k503_ob[6];
    k503_vflip <= k503_ob[7];
  end else if (k503_old_h4 && !hc[2])
    k503_sprite <= {sprite_sel, k503_hflip, k503_vflip, sprite_sum[3:0]};
end
wire       sprite_vflip  = k503_sprite[4];
wire       sprite_flip   = k503_sprite[5];     // OFLP
wire       cs_linebuffer = k503_sprite[6];     // OCS (low = sprite on this line)
wire [5:0] k503_R;
assign k503_R[5] = k503_sprite[3] ^ sprite_vflip;
assign k503_R[4] = sprite_flip;                // H8 is tied low
assign k503_R[3] = sprite_flip ^ !hc[2];
assign k503_R[2] = k503_sprite[2] ^ sprite_vflip;
assign k503_R[1] = k503_sprite[1] ^ sprite_vflip;
assign k503_R[0] = k503_sprite[0] ^ sprite_vflip;

reg [7:0] sprite_code = 0;
always @(posedge clk)
  if (hc[2:0] == 3'b000)
    sprite_code <= spriteram_reg[15:8];

reg [4:0] sprite_attrib = 0;
reg [7:0] sprite_hpos = 0;
always @(posedge clk) begin
  if (hc[2:0] == 3'b100) begin
    sprite_attrib <= {spriteram_reg[5], spriteram_reg[3:0]};
    sprite_hpos <= spriteram_reg[15:8];
  end
end

reg spriterom_sel = 0;
always @(posedge clk)
  if (hc[2:0] == 3'b000)
    spriterom_sel <= sprite_attrib[4];

// Sprite ROM address: {ROM select, code[7:1], R5, code[0], R3:0}
wire [12:0] spriterom_A = {sprite_code[7:1], k503_R[5], sprite_code[0], k503_R[3:0]};
assign sprrom_A = {spriterom_sel, spriterom_A};

// Konami 083 (sprites)
reg [7:0] s0_l = 0, s0_r = 0, s1_l = 0, s1_r = 0;
reg sprite_k083_flip = 0;
always @(posedge clk) begin
  if (cen6) begin
    if (k083_load) begin
      s0_l <= sprlo_q; s0_r <= sprlo_q;
      s1_l <= sprhi_q; s1_r <= sprhi_q;
    end else begin
      s0_l <= {s0_l[6:4], 1'b0, s0_l[2:0], 1'b0};
      s1_l <= {s1_l[6:4], 1'b0, s1_l[2:0], 1'b0};
      s0_r <= {1'b0, s0_r[7:5], 1'b0, s0_r[3:1]};
      s1_r <= {1'b0, s1_r[7:5], 1'b0, s1_r[3:1]};
    end
  end
end
wire [1:0] spix0 = sprite_k083_flip ? {s0_l[3], s0_l[7]} : {s0_r[0], s0_r[4]};
wire [1:0] spix1 = sprite_k083_flip ? {s1_l[3], s1_l[7]} : {s1_r[0], s1_r[4]};

reg [3:0] sprite_color = 0;
reg       sprite_lbuff_en = 1;
always @(posedge clk) begin
  if (cen6 && hc[2:0] == 3'b011) begin
    sprite_color <= sprite_attrib[3:0];
    sprite_lbuff_en <= cs_linebuffer;
    sprite_k083_flip <= sprite_flip;
  end
end

wire [3:0] sprite_lut_D = sprite_lut[{sprite_color, spix1, spix0}];

// ---------------------------------------------------------------------------
// Konami 502 and the sprite line buffer.
//
// Two 256 x 4 banks: one is drawn for the next line while the other is
// shown and cleared.  Each pixel reads the old value at the bank's address
// and writes the new one on the pixel clock enable.  The real 502 latches
// the read data on the falling clock edge inside that enable; here the
// (registered) RAM outputs are used directly, which gives the same values.

reg old_ldo = 1;
reg h256_lat = 0;
always @(posedge clk) begin
  old_ldo <= ldo;
  if (!old_ldo && ldo)
    h256_lat <= hc[8];
end
reg old_h256_lat = 0;
reg h256_dly = 0;
always @(posedge clk) begin
  old_h256_lat <= h256_lat;
  if (!old_h256_lat && h256_lat)
    h256_dly <= !h256_dly;
end

reg k502_h4 = 0;
reg old_h2 = 0;
always @(posedge clk) begin
  old_h2 <= hc[1];
  if (!old_h2 && hc[1])
    k502_h4 <= !k502_h4;
end

reg [1:0] osel_reg = 0;
always @(posedge clk) begin
  if (old_h2 && !hc[1]) begin
    if (!k502_h4)
      osel_reg[1] <= h256_dly;
    else
      osel_reg[0] <= osel_reg[1];
  end
end
wire OLD  = !osel_reg[1];
wire OSEL = osel_reg[0];
wire OCLR = !osel_reg[0];

wire [3:0] lb0_q, lb1_q;
wire [7:0] SPLBi = {lb1_q, lb0_q};
wire [3:0] lbuff_Dmux = OCLR ? SPLBi[3:0] : SPLBi[7:4];

wire [4:0] sprite_D = {!(|lbuff_Dmux), lbuff_Dmux};

wire sel2 = (SPLBi[7:4] == 4'd0);
wire sel1 = (SPLBi[3:0] == 4'd0);
wire [7:0] SPLBo;
assign SPLBo[3:0] = OSEL  ? (sel1 ? sprite_lut_D : SPLBi[3:0]) : 4'h0;
assign SPLBo[7:4] = !OSEL ? (sel2 ? sprite_lut_D : SPLBi[7:4]) : 4'h0;

// Line buffer address counters
reg lb0_ld = 0, lb1_ld = 0, lb0_clr = 0, lb1_clr = 0;
always @(posedge clk) begin
  if (hc[1:0] == 2'b11) begin
    lb0_clr <= !OCLR && OLD;
    lb1_clr <= OCLR && !OLD;
  end else begin
    lb0_clr <= 0;
    lb1_clr <= 0;
  end
  if (hc[2:0] == 3'b011) begin
    lb0_ld <= !OLD;
    lb1_ld <= OLD;
  end else begin
    lb0_ld <= 0;
    lb1_ld <= 0;
  end
end

reg [7:0] lb0_a = 0, lb1_a = 0;
always @(posedge clk) begin
  if (cen6) begin
    if (lb0_clr)
      lb0_a <= 0;
    else if (lb0_ld)
      lb0_a <= sprite_hpos;
    else
      lb0_a <= {lb0_a[7:4] + (lb0_a[3:0] == 4'hf), lb0_a[3:0] + 1'd1};
    if (lb1_clr)
      lb1_a <= 0;
    else if (lb1_ld)
      lb1_a <= sprite_hpos;
    else
      lb1_a <= {lb1_a[7:4] + (lb1_a[3:0] == 4'hf), lb1_a[3:0] + 1'd1};
  end
end

wire lb0_we = cen6 && !(sprite_lbuff_en && OSEL);
wire lb1_we = cen6 && !(sprite_lbuff_en && !OSEL);

reg [3:0] lbuf0 [0:255];
reg [3:0] lbuf1 [0:255];
reg [3:0] lb0_r = 0, lb1_r = 0;

always @(posedge clk) begin
  if (lb0_we) begin
    lbuf0[lb0_a] <= SPLBo[3:0];
    lb0_r <= SPLBo[3:0];
  end else
    lb0_r <= lbuf0[lb0_a];
  if (lb1_we) begin
    lbuf1[lb1_a] <= SPLBo[7:4];
    lb1_r <= SPLBo[7:4];
  end else
    lb1_r <= lbuf1[lb1_a];
end
assign lb0_q = lb0_r;
assign lb1_q = lb1_r;

// ---------------------------------------------------------------------------
// Final pixel: tiles in front when their priority bit is set or there is
// no sprite pixel.

wire       tile_sprite_sel = tilemap_en | sprite_D[4];
wire [3:0] tile_sprite_D   = tile_sprite_sel ? tile_D : sprite_D[3:0];

always @(posedge clk)
  if (cen6)
    pixel <= {tile_sprite_sel, tile_sprite_D};

// Colour PROM, read by the video output
assign pal_q = color_prom[pal_a];

endmodule
