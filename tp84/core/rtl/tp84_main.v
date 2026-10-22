// Time Pilot '84 main board: two 6809s and the Konami video (082 timing,
// 083 shifters, 502/503 sprites, two tile layers).
//
// A Verilog-2001 port of Ace's TimePilot84_CPU.sv from the MiSTer core
// (MIT license, Copyright (C) 2020, 2021 Ace), changed for the Phoenix the
// same way as the Gyruss core (see ../../gyruss/core):
//   - one 25MHz clock with clock enables derived from a fractional
//     12.288MHz enable (cen12), with the MiSTer core's phases.
//   - cpu09 (John Kent) for both 6809s, clocked by an enable at the
//     falling edge of E: the main CPU's E falls as h[1:0] goes 10 -> 11, the
//     sub CPU's as it goes 00 -> 01 (the sub CPU's half of the sprite RAM
//     slots).
//   - the CPU ROMs are in the external SRAM; the graphics ROMs and PROMs are
//     block/distributed RAM loaded by the boot loader.
//   - in boot mode both CPUs are held in reset, and the boot loader (on the
//     sound Z80) uses the shared RAM and the video RAM through bz_*.
//
// Only the original memory map (sets 1 and 2) is supported.

`timescale 1ns / 1ps

module tp84_main
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

   // CPU ROMs (SRAM)
   , output     [15:0] m_a
   , input       [7:0] rom_m_q
   , output     [15:0] s_a
   , input       [7:0] rom_s_q

   // Sound board
   , output reg  [7:0] snd_latch = 0
   , output            snd_irq       // pulse: interrupt the sound CPU

   // Graphics ROM and PROM loading
   , input             ld_we
   , input      [17:0] ld_a
   , input       [7:0] ld_d
   , input      [13:0] tile_rd_a     // tile ROM second port (boot ROM reads)
   , output reg  [7:0] tile_rd_q

   // Boot loader access: 5000-57FF shared RAM, 8400-87FF text (video RAM)
   , input      [15:0] bz_a
   , input       [7:0] bz_d
   , input             bz_we
   , output      [7:0] bz_q

   // Boot text: the video RAM's second port in boot mode
   , input      [10:0] text_a
   , output      [7:0] text_q

   // Video
   , output      [8:0] h_cnt
   , output      [8:0] v_cnt
   , output            cen6
   , output            d0            // the next cen12 is not a pixel enable
   , output            hblk
   , output            vblk
   , output      [7:0] pixel         // colour PROM address
   , input       [7:0] pal_a
   , output     [11:0] pal_q         // {blue, green, red}, 4 bits each
   );

// ---------------------------------------------------------------------------
// Clock enables (see gyruss_main.v)

reg  [2:0] d = 0;
always @(posedge clk)
  if (cen12) d <= d + 1'd1;

assign cen6  = cen12 && d[0] == 1'b0;
assign d0    = d[0];
wire   cen3  = cen12 && d[1:0] == 2'b00;
wire   cen1m5= cen12 && d[2:0] == 3'b000;

// ---------------------------------------------------------------------------
// Konami 082: video timing

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
assign hblk  = (hc > 9'd137 && hc < 9'd269);

reg [7:0] vcnt_lat = 0;
reg       old_h256 = 0;
always @(posedge clk) begin
  old_h256 <= hc[8];
  if (!old_h256 && hc[8])
    vcnt_lat <= vc[7:0];
end

// h1d: H1 a little after it changes (latched on the falling clock edge of
// the pixel enable on the PCB)
reg h1d = 0;
always @(posedge clk)
  h1d <= hc[0];

// ---------------------------------------------------------------------------
// Main CPU

reg mE = 0, sE = 0;
always @(posedge clk) begin
  mE <= cen6 && hc[1:0] == 2'b10;
  sE <= cen6 && hc[1:0] == 2'b00;
end

wire [15:0] mA;
wire  [7:0] mD_out;
wire        m_rw, m_vma;
reg   [7:0] mD_in;
reg         mirq = 1;

cpu09 u12G
  ( .clk(clk), .rst(reset), .rw(m_rw), .vma(m_vma), .address(mA)
  , .data_in(mD_in), .data_out(mD_out), .halt(1'b0), .hold(!mE)
  , .irq(!mirq), .firq(1'b0), .nmi(1'b0), .opc_in(mD_in)
  );

assign m_a = mA;

wire m_wr = !m_rw && m_vma;
wire cs_vram        = mA[15:11] == 5'b01000;
wire cs_cram        = mA[15:11] == 5'b01001;
wire cs_msharedram  = mA[15:11] == 5'b01010;
wire cs_mainlatch   = mA[15:8] == 8'h30 && m_wr;
wire cs_xscrollreg  = mA[15:8] == 8'h3C && m_wr;
wire cs_yscrollreg  = mA[15:8] == 8'h3E && m_wr;
wire cs_colorlatch  = mA[15:8] == 8'h28 && m_wr;
wire cs_soundirq    = mA[15:8] == 8'h38 && m_wr;
wire cs_sounddata   = mA[15:8] == 8'h3A && m_wr;
wire cs_controls    = (mA[15:4] == 12'h280 || mA[15:4] == 12'h282 ||
                       mA[15:4] == 12'h284 || mA[15:4] == 12'h286) && m_rw;
wire cs_dip2        = mA[15:8] == 8'h30 && m_rw;
wire cs_mrom        = mA[15];

wire [7:0] controls = (mA[6:5] == 2'b00) ? in_sys :
                      (mA[6:5] == 2'b01) ? in_p1 :
                      (mA[6:5] == 2'b10) ? in_p2 : dsw1;

// Latches
reg vflip = 0, hflip = 0, mirq_mask = 0;
reg [4:0] color_latch = 0;
reg [7:0] xscroll_reg = 0, yscroll_reg = 0;
reg sound_irq = 0, sound_irq_d = 0;

always @(posedge clk) begin
  if (cen3) begin
    if (cs_mainlatch)
      case (mA[2:0])
      3'b000: mirq_mask <= mD_out[0];
      3'b100: vflip <= mD_out[0];
      3'b101: hflip <= mD_out[0];
      default: ;
      endcase
    if (cs_colorlatch) color_latch <= mD_out[4:0];
    if (cs_xscrollreg) xscroll_reg <= mD_out;
    if (cs_yscrollreg) yscroll_reg <= mD_out;
    if (cs_sounddata)  snd_latch <= mD_out;
    sound_irq <= cs_soundirq;
  end
  sound_irq_d <= sound_irq;
  if (reset) begin
    vflip <= 0;
    hflip <= 0;
    mirq_mask <= 0;
    color_latch <= 0;
  end
end
assign snd_irq = sound_irq && !sound_irq_d;

always @(posedge clk) begin
  if (cen6) begin
    if (!mirq_mask)
      mirq <= 1;
    else if (vblank_irq_en)
      mirq <= 0;
  end
end

// ---------------------------------------------------------------------------
// Sub CPU

wire [15:0] sA;
wire  [7:0] sD_out;
wire        s_rw, s_vma;
reg   [7:0] sD_in;
reg         sirq = 1;

cpu09 u12E
  ( .clk(clk), .rst(reset), .rw(s_rw), .vma(s_vma), .address(sA)
  , .data_in(sD_in), .data_out(sD_out), .halt(1'b0), .hold(!sE)
  , .irq(!sirq), .firq(1'b0), .nmi(1'b0), .opc_in(sD_in)
  );

assign s_a = sA;

wire cs_beam       = sA[15:13] == 3'b001;
wire cs_sirqmask   = sA[15:13] == 3'b010 && !s_rw && s_vma;
wire cs_ssharedram = sA[15:11] == 5'b10000;
wire cs_spriteram  = sA[15:13] == 3'b011;
wire cs_srom       = sA[15:13] == 3'b111;

reg sirq_mask = 0;
always @(posedge clk) begin
  if (reset)
    sirq_mask <= 0;
  else if (cen3 && cs_sirqmask)
    sirq_mask <= sD_out[0];
end

always @(posedge clk) begin
  if (cen6) begin
    if (!sirq_mask)
      sirq <= 1;
    else if (vblank_irq_en)
      sirq <= 0;
  end
end

// ---------------------------------------------------------------------------
// RAM

// Shared RAM: main CPU 5000-57FF (or the boot loader), sub CPU 8000-87FF
reg  [7:0] shared [0:2047];
reg  [7:0] shared_qa, shared_qb;
wire [10:0] sh_aa = boot_mode ? bz_a[10:0] : mA[10:0];
wire        sh_wa = boot_mode ? (bz_we && bz_a[15:11] == 5'b01010) : (cs_msharedram && m_wr);
wire  [7:0] sh_da = boot_mode ? bz_d : mD_out;

always @(posedge clk) begin
  if (sh_wa) begin
    shared[sh_aa] <= sh_da;
    shared_qa <= sh_da;
  end else
    shared_qa <= shared[sh_aa];
end

always @(posedge clk) begin
  if (cs_ssharedram && !s_rw && s_vma) begin
    shared[sA[10:0]] <= sD_out;
    shared_qb <= sD_out;
  end else
    shared_qb <= shared[sA[10:0]];
end

// Video RAM (codes) and colour RAM: the CPU (or the boot loader's text,
// 8400-87FF) on one port, the tile fetch on the other.  Each holds the
// playfield (000-3FF) and the status columns (400-7FF).
wire        n_scroll_en = !(hc > 9'd271 && hc < 9'd496);
wire  [7:2] hcnt_x = hc[7:2] ^ {6{hflip}};
wire  [7:0] vcnt_x = vcnt_lat ^ {8{vflip}};
wire  [7:0] L    = n_scroll_en ? 8'hFF : yscroll_reg;
wire  [7:2] J    = n_scroll_en ? 6'h3F : xscroll_reg[7:2];
wire        shf1 = n_scroll_en ? 1'b1 : xscroll_reg[1];
wire        shf0 = n_scroll_en ? 1'b1 : xscroll_reg[0];
wire  [7:2] ha   = hcnt_x + J + {5'd0, n_scroll_en};
wire  [7:0] va   = vcnt_x + L + {7'd0, n_scroll_en};
wire [10:0] vram_cram_A = {n_scroll_en, va[7:3], ha[7:3]};

reg  [7:0] vram [0:2047];
reg  [7:0] cram [0:2047];
reg  [7:0] vram_qa, vram_qb, cram_qa, cram_qb;
wire [10:0] vr_aa = boot_mode ? {1'b1, bz_a[9:0]} : mA[10:0];
wire        vr_wa = boot_mode ? (bz_we && bz_a[15:10] == 6'b100001) : (cs_vram && m_wr);
wire  [7:0] vr_da = boot_mode ? bz_d : mD_out;
wire [10:0] vr_ab = boot_mode ? text_a : vram_cram_A;

always @(posedge clk) begin
  if (vr_wa) begin
    vram[vr_aa] <= vr_da;
    vram_qa <= vr_da;
  end else
    vram_qa <= vram[vr_aa];
end
always @(posedge clk)
  vram_qb <= vram[vr_ab];

always @(posedge clk) begin
  if (cs_cram && m_wr) begin
    cram[mA[10:0]] <= mD_out;
    cram_qa <= mD_out;
  end else
    cram_qa <= cram[mA[10:0]];
end
always @(posedge clk)
  cram_qb <= cram[vram_cram_A];

assign text_q = vram_qb;
assign bz_q   = (bz_a[15:11] == 5'b01010) ? shared_qa : vram_qa;

// Sprite RAM: 1K x 16 (two banks selected by A1); the sub CPU has it while
// H2 is low.
wire spriteram_en  = !hc[1] && cs_spriteram;
wire spriteram_wr  = !(h1d | s_rw) && s_vma;
wire spriteram0_we = spriteram_en && sA[1] && spriteram_wr;
wire spriteram1_we = spriteram_en && !sA[1] && spriteram_wr;
wire cs_spriteram0 = spriteram_en && sA[1] && (spriteram_wr || s_rw);
wire cs_spriteram1 = spriteram_en && !sA[1] && (spriteram_wr || s_rw);
wire [9:0] spriteram_A;
assign spriteram_A[9:8] = {hc[1] | sA[10], hc[1] | sA[9]};
assign spriteram_A[7:0] = hc[1] ? {2'b11, hc[7], (hc[8] ^ hc[7]), hc[6:4], hc[2]} : {sA[8:2], sA[0]};

reg  [7:0] spr0 [0:1023];
reg  [7:0] spr1 [0:1023];
reg [15:0] spriteram_D;

always @(posedge clk) begin
  if (spriteram0_we) begin
    spr0[spriteram_A] <= sD_out;
    spriteram_D[7:0] <= sD_out;
  end else
    spriteram_D[7:0] <= spr0[spriteram_A];
end
always @(posedge clk) begin
  if (spriteram1_we) begin
    spr1[spriteram_A] <= sD_out;
    spriteram_D[15:8] <= sD_out;
  end else
    spriteram_D[15:8] <= spr1[spriteram_A];
end

// CPU data in
always @* begin
  if (cs_controls)
    mD_in = controls;
  else if (cs_dip2)
    mD_in = dsw2;
  else if (cs_vram && m_rw)
    mD_in = vram_qa;
  else if (cs_cram && m_rw)
    mD_in = cram_qa;
  else if (cs_msharedram && m_rw)
    mD_in = shared_qa;
  else if (cs_mrom)
    mD_in = rom_m_q;
  else
    mD_in = 8'hff;
end

always @* begin
  if (cs_srom)
    sD_in = rom_s_q;
  else if (cs_ssharedram && s_rw)
    sD_in = shared_qb;
  else if (cs_spriteram1 && !spriteram1_we)
    sD_in = spriteram_D[15:8];
  else if (cs_spriteram0 && !spriteram0_we)
    sD_in = spriteram_D[7:0];
  else if (cs_beam)
    sD_in = vcnt_lat;
  else
    sD_in = 8'hff;
end

// ---------------------------------------------------------------------------
// Graphics ROMs and PROMs, written by the loader:
//   10000-17FFF sprite ROMs (gfx2: e09, e10, e11, e12)
//   18000-1BFFF tile ROMs (gfx1: h02, d01)
//   1C000 red, 1C100 green, 1C200 blue, 1C300 tile lookup, 1C400 sprite
//   lookup PROMs

wire ld_spr  = ld_we && ld_a[17:15] == 3'b010;
wire ld_tile = ld_we && ld_a[17:14] == 4'b0110;
wire ld_prom = ld_we && ld_a[17:11] == 7'b0111000;

// Tile ROMs (16K); the second port reads the boot ROM (this block RAM holds
// the boot loader until the tile ROMs are loaded over it).
reg [7:0] tilerom [0:16383];
initial $readmemh("tp84_boot.hex", tilerom);

wire [13:0] tilerom_A;
reg   [7:0] tilerom_q;

always @(posedge clk)
  tilerom_q <= tilerom[tilerom_A];

// Second port: loader writes, boot ROM reads (the loader runs from its SRAM
// copy by the time it writes here).  Sharing it keeps this one block RAM
// instead of a copy per read port.
wire [13:0] tile_b_a = ld_tile ? ld_a[13:0] : tile_rd_a;

always @(posedge clk) begin
  if (ld_tile) begin
    tilerom[tile_b_a] <= ld_d;
    tile_rd_q <= ld_d;
  end else
    tile_rd_q <= tilerom[tile_b_a];
end

// Sprite ROMs, as two 16K x 8 halves: low = planes 0/1 (e09, e10), high =
// planes 2/3 (e11, e12)
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
reg [3:0] prom_r [0:255];
reg [3:0] prom_g [0:255];
reg [3:0] prom_b [0:255];
reg [3:0] tile_lut [0:255];
reg [3:0] sprite_lut [0:255];

always @(posedge clk) begin
  if (ld_prom && ld_a[10:8] == 3'd0) prom_r[ld_a[7:0]] <= ld_d[3:0];
  if (ld_prom && ld_a[10:8] == 3'd1) prom_g[ld_a[7:0]] <= ld_d[3:0];
  if (ld_prom && ld_a[10:8] == 3'd2) prom_b[ld_a[7:0]] <= ld_d[3:0];
  if (ld_prom && ld_a[10:8] == 3'd3) tile_lut[ld_a[7:0]] <= ld_d[3:0];
  if (ld_prom && ld_a[10:8] == 3'd4) sprite_lut[ld_a[7:0]] <= ld_d[3:0];
end

assign pal_q = {prom_b[pal_a], prom_g[pal_a], prom_r[pal_a]};

// ---------------------------------------------------------------------------
// Tile layers

reg [15:0] tile_code = 0;
reg [15:0] tile_attrib = 0;
always @(posedge clk) begin
  if (cen1m5) begin
    tile_code   <= {vram_qb, tile_code[15:8]};
    tile_attrib <= {cram_qb, tile_attrib[15:8]};
  end
end

wire tile_hflip  = tile_attrib[6];
wire tile_vflip  = tile_attrib[7];
wire tilerom_sel = tile_attrib[5];
wire tile_flip   = tile_hflip ^ !hflip;

reg tile_083_flip = 0;
reg [3:0] tile_color = 0;
reg va1l = 0, va2l = 0, va4l = 0, ha2l = 0;
always @(posedge clk) begin
  if (cen6 && hc[1:0] == 2'b11) begin
    tile_083_flip <= tile_flip;
    tile_color <= tile_attrib[3:0];
    va1l <= va[0];
    va2l <= va[1];
    va4l <= va[2];
    ha2l <= ha[2];
  end
end

assign tilerom_A = {tilerom_sel, tile_attrib[4], tile_code[7:0], ha2l ^ tile_hflip,
                    va4l ^ tile_vflip, va2l ^ tile_vflip, va1l ^ tile_vflip};

// Konami 083 (tiles)
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

wire [3:0] tile_lut_D = tile_lut[{color_latch[4:3], tile_color, tile_pix}];

// Fine horizontal scroll: delay the tile pixels by 0-3
reg [15:0] tilemap_Dshift = 0;
always @(posedge clk)
  if (cen6)
    tilemap_Dshift <= {tilemap_Dshift[11:0], tile_lut_D};

wire bottom_hud_en = (hc > 9'd504 || hc < 9'd138);
wire top_hud_en    = (hc > 9'd507 || hc < 9'd284);

reg shf0_l = 0, shf1_l = 0;
wire tile_sel0 = !(shf0_l | top_hud_en) | bottom_hud_en;
wire tile_sel1 = !(shf1_l | top_hud_en) | bottom_hud_en;
wire [3:0] tile_D = ({tile_sel1, tile_sel0} == 2'b00) ? tilemap_Dshift[15:12] :
                    ({tile_sel1, tile_sel0} == 2'b01) ? tilemap_Dshift[11:8] :
                    ({tile_sel1, tile_sel0} == 2'b10) ? tilemap_Dshift[7:4] :
                                                        tilemap_Dshift[3:0];

// ---------------------------------------------------------------------------
// Sprite layer

// Konami 503
wire [7:0] k503_ob = spriteram_D[7:0];
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
assign k503_R[4] = sprite_flip ^ hc[3];
assign k503_R[3] = sprite_flip ^ !hc[2];
assign k503_R[2] = k503_sprite[2] ^ sprite_vflip;
assign k503_R[1] = k503_sprite[1] ^ sprite_vflip;
assign k503_R[0] = k503_sprite[0] ^ sprite_vflip;

reg [7:0] sprite_code = 0;
always @(posedge clk)
  if (cen6 && hc[3:0] == 4'b0111)
    sprite_code <= spriteram_D[15:8];

assign sprrom_A = {sprite_code[7], sprite_code[6:0], k503_R};

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
  if (cen6 && hc[3:0] == 4'b1011) begin
    sprite_color <= spriteram_D[3:0];
    shf0_l <= shf0 ^ !hflip;
    shf1_l <= shf1 ^ !hflip;
    sprite_lbuff_en <= cs_linebuffer;
    sprite_k083_flip <= sprite_flip;
  end
end

wire [3:0] sprite_lut_D = sprite_lut[{sprite_color, spix1, spix0}];

// Konami 502 and the sprite line buffer (as in gyruss_main.v)
reg ldo = 1;
always @(posedge clk)
  ldo <= !(hc[2:0] == 3'b111);

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

reg lb0_ld = 0, lb1_ld = 0, lb0_clr = 0, lb1_clr = 0;
always @(posedge clk) begin
  if (hc[1:0] == 2'b11) begin
    lb0_clr <= !OCLR && OLD;
    lb1_clr <= OCLR && !OLD;
  end else begin
    lb0_clr <= 0;
    lb1_clr <= 0;
  end
  if (hc[3:0] == 4'b1011) begin
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
      lb0_a <= spriteram_D[15:8];
    else
      lb0_a <= {lb0_a[7:4] + (lb0_a[3:0] == 4'hf), lb0_a[3:0] + 1'd1};
    if (lb1_clr)
      lb1_a <= 0;
    else if (lb1_ld)
      lb1_a <= spriteram_D[15:8];
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
// Final pixel: the status columns and the playfield where there is no
// sprite pixel.

wire       tile_sprite_sel = bottom_hud_en | top_hud_en | sprite_D[4];
wire [3:0] tile_sprite_D   = tile_sprite_sel ? tile_D : sprite_D[3:0];

reg [4:0] pixel_D = 0;
always @(posedge clk)
  if (cen6)
    pixel_D <= {tile_sprite_sel, tile_sprite_D};

assign pixel = {pixel_D[4], color_latch[2:0], pixel_D[3:0]};

endmodule
