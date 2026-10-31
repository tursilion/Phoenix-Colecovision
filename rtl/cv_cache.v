// ROM cache for the ColecoVision core's MegaCart and SGM images (up to 2M).
//
// The SRAM holds 480K of the image: its 8K pages 4-63 (pages 0-3, the
// lowest 32K, are the SGM RAM).  The menu loads an image at the top of
// the SRAM, or the last 480K of a bigger one.  A table maps each 8K ROM
// page (the colecovision module works out the page from the bank
// registers) to its SRAM page, if it has one.  When the CPU reads a page
// that is not there, the CPU waits (its clock enable, like the SD port's
// wait) while the cache reads the page from the SD card into an SRAM page
// not used lately (clock algorithm) and maps it.  The video and sound go
// on.  The page is read with one CMD18 (16 sectors, then CMD12) at
// 12.5MHz, each sector's CRC16 checked; a page with a bad sector is read
// again (and the LED blinks).
//
// The menu gives the SD sector of each page by reading one byte of it with
// FatFs: port >5C names the page, and the cache takes the argument of the
// CMD17s the CPU then sends (the last one is the data sector; FAT reads
// come first).  Port >5D names the page again for a read of its last byte:
// the last CMD17 then must be 15 sectors on (7680 bytes on an SD v1 card),
// or the fragmented flag (port >5E bit 0) is set; so is it by a capture
// without a CMD17.  A write to >5E ends a capture or check.
//
// The cache owns the SD card while a banked game runs (active).

`timescale 1ns / 1ps

module cv_cache
   ( input             clk          // 25MHz
   , input             reset

   , input             active       // a MegaCart or SGM game runs
   , input             start        // pulse: a game starts (sets up the table)
   , input       [8:0] n_pages      // the image's size in 8K pages (1-256)

   // The CPU's banked ROM reads
   , input             rom_rd       // a memory read (not refresh) of >8000-FFFF
   , input       [7:0] rom_page
   , output            c_hit
   , output      [5:0] c_line       // SRAM page (8K) of rom_page
   , output reg        cpu_wait_n = 1

   // The menu's SD commands and cache ports (one-clock pulses)
   , input             sd_wr        // CPU write to the SD data port >57
   , input             cap_wr       // write to >5C
   , input             chk_wr       // write to >5D
   , input             end_wr       // write to >5E
   , input       [7:0] cpu_data
   , output reg        frag = 0     // a checked page is not in consecutive sectors

   // SRAM writes (into the SRAM controller's CPU port while ov_active)
   , output            ov_active
   , output reg        ov_en = 0
   , output reg        ov_we_n = 1
   , output reg [18:0] ov_addr
   , output reg  [7:0] ov_data

   // SD card, while active
   , output            sd_cs_n
   , output            sd_sclk
   , output            sd_mosi
   , input             sd_miso

   , output reg        led = 0      // blinks for an SD error
   );

// ---------------------------------------------------------------------------
// Tables

reg  [6:0] c_map [0:255];       // ROM page -> {in the SRAM, SRAM page}
reg  [8:0] c_rev [0:63];        // SRAM page -> {holds a page, ROM page}
reg [63:0] c_ref = 0;           // SRAM page used lately
reg [31:0] c_lba [0:255];       // ROM page -> SD argument of its first sector

wire [6:0] c_map_q = c_map[rom_page];
assign c_hit  = c_map_q[6];
assign c_line = c_map_q[5:0];

// One registered write port for each table (XST drops a second one)
reg        cm_we = 0;
reg  [7:0] cm_a;
reg  [6:0] cm_d;
reg        cr_we = 0;
reg  [5:0] cr_a;
reg  [8:0] cr_d;
reg        cl_we = 0;
reg  [7:0] cl_a;
reg [31:0] cl_d;

always @(posedge clk) begin
  if (cm_we) c_map[cm_a] <= cm_d;
  if (cr_we) c_rev[cr_a] <= cr_d;
  if (cl_we) c_lba[cl_a] <= cl_d;
end

reg  [7:0] f_page;
reg  [7:0] chk_page;
reg [31:0] f_arg;               // c_lba[f_page] (the reader), c_lba[chk_page] (a check)
reg        lba_rd_chk = 0;      // which one f_arg reads
always @(posedge clk)
  f_arg <= c_lba[lba_rd_chk ? chk_page : f_page];

// ---------------------------------------------------------------------------
// The menu's SD reads: the arguments of its CMD17s

reg  [2:0] sn_st = 0;           // 0: wait for $51, 1-4: argument bytes
reg [31:0] sn_arg;
reg        cap_on = 0, chk_on = 0;
reg  [7:0] cap_page;
reg [31:0] chk_last;
reg        chk_seen = 0;
reg        cap_seen = 0;

always @(posedge clk) begin
  cl_we <= 0;
  if (sd_wr) begin
    if (sn_st == 0)
      sn_st <= (cpu_data == 8'h51) ? 3'd1 : 3'd0;
    else begin
      sn_arg <= {sn_arg[23:0], cpu_data};
      sn_st  <= (sn_st == 3'd4) ? 3'd0 : sn_st + 3'd1;
      if (sn_st == 3'd4) begin
        if (cap_on) begin
          cap_seen <= 1;
          cl_we <= 1;
          cl_a  <= cap_page;
          cl_d  <= {sn_arg[23:0], cpu_data};
        end
        if (chk_on) begin
          chk_last <= {sn_arg[23:0], cpu_data};
          chk_seen <= 1;
        end
      end
    end
  end

  // The end of a capture: it must have seen a read (else the page's sector
  // is unknown); of a check: its last read must be the page's 16th sector
  if ((cap_wr || chk_wr || end_wr) && cap_on && !cap_seen)
    frag <= 1;
  if ((cap_wr || chk_wr || end_wr) && chk_on) begin
    if (!chk_seen || (chk_last != f_arg + 32'd15 && chk_last != f_arg + 32'd7680))
      frag <= 1;
  end
  if (cap_wr || chk_wr || end_wr) begin
    cap_on <= 0;
    chk_on <= 0;
  end
  if (cap_wr) begin
    cap_on   <= 1;
    cap_seen <= 0;
    cap_page <= cpu_data;
  end
  if (chk_wr) begin
    chk_on     <= 1;
    chk_page   <= cpu_data;
    chk_seen   <= 0;
    lba_rd_chk <= 1;
  end
  if (start)
    lba_rd_chk <= 0;

  if (reset) begin
    sn_st  <= 0;
    cap_on <= 0;
    chk_on <= 0;
    frag   <= 0;
  end
end

// ---------------------------------------------------------------------------
// SPI (mode 0, 12.5MHz)

reg        spi_busy = 0, spi_start = 0;
reg  [7:0] spi_tx = 8'hFF, spi_rx = 8'hFF, spi_txd;
reg  [2:0] spi_bit;
reg        spi_sclk_r = 0;
reg        f_cs = 0;

assign sd_cs_n = !f_cs;
assign sd_sclk = spi_sclk_r;
assign sd_mosi = spi_tx[7];

always @(posedge clk) begin
  if (spi_start) begin
    spi_tx     <= spi_txd;
    spi_busy   <= 1;
    spi_bit    <= 0;
    spi_sclk_r <= 0;
  end else if (spi_busy) begin
    if (!spi_sclk_r) begin               // rising edge: sample MISO
      spi_sclk_r <= 1;
      spi_rx     <= {spi_rx[6:0], sd_miso};
    end else begin                       // falling edge: shift MOSI
      spi_sclk_r <= 0;
      spi_tx     <= {spi_tx[6:0], 1'b1};
      spi_bit    <= spi_bit + 1;
      if (spi_bit == 3'd7)
        spi_busy <= 0;
    end
  end
  if (reset) begin
    spi_busy   <= 0;
    spi_sclk_r <= 0;
    spi_tx     <= 8'hFF;
  end
end

// ---------------------------------------------------------------------------
// SRAM writes: three clocks each (address, WE low, WE high), through the
// SRAM controller's registered CPU port

reg        ld_pend = 0;
reg  [7:0] ld_data;
reg [18:0] ld_addr;
reg  [1:0] ws = 0;
reg        ld_done;
reg        fill_on = 0;          // the reader owns the SRAM port
assign ov_active = fill_on;

always @(posedge clk) begin
  ld_done <= 0;
  case (ws)
  2'd0:
    if (ld_pend && !ld_done) begin
      ov_en   <= 1;
      ov_we_n <= 1;
      ov_addr <= ld_addr;
      ov_data <= ld_data;
      ws      <= 2'd1;
    end
  2'd1: begin ov_we_n <= 0; ws <= 2'd2; end
  2'd2: begin ov_we_n <= 1; ws <= 2'd3; end
  2'd3: begin ld_done <= 1; ws <= 2'd0; end
  endcase
  if (!fill_on) begin
    ov_en   <= 0;
    ov_we_n <= 1;
  end
end

// ---------------------------------------------------------------------------
// The page reader

localparam F_IDLE = 5'd0,  F_VICT = 5'd1,  F_EVICT = 5'd2, F_CMD = 5'd3,
           F_R1 = 5'd4,    F_R1C = 5'd5,   F_TOK = 5'd6,   F_TOKC = 5'd7,
           F_DATA = 5'd8,  F_DATAC = 5'd9, F_CRC = 5'd10,  F_STOP = 5'd11,
           F_STUFF = 5'd12, F_SR1 = 5'd13, F_SR1C = 5'd14, F_BUSY = 5'd15,
           F_BUSYC = 5'd16, F_END = 5'd17, F_MAP = 5'd18,  F_WAIT = 5'd19,
           F_ERR = 5'd20,  F_MAPW = 5'd21, F_CRCC = 5'd22;
reg  [4:0] f_state = F_IDLE, f_next;
reg  [5:0] f_line, f_hand = 6'd4;
reg [15:0] f_cnt;
reg  [3:0] f_blk;
reg  [8:0] f_byte;
reg  [2:0] f_ci;
reg        f_stop;
reg [15:0] f_crc;
reg        f_bad;
reg        f_retry = 0;
reg [22:0] led_time = 0;
reg        c_init = 0;
reg  [8:0] c_init_i;
reg  [2:0] c_settle = 0;
reg  [2:0] ov_settle = 0;     // clocks after the reader gives the SRAM port back
reg        fill_on_d = 0;

function [15:0] crc16_byte(input [15:0] c, input [7:0] d);
  integer i;
  reg [15:0] r;
  begin
    r = c ^ {d, 8'd0};
    for (i = 0; i < 8; i = i + 1)
      r = r[15] ? (r << 1) ^ 16'h1021 : (r << 1);
    crc16_byte = r;
  end
endfunction

wire [7:0] f_cmd_byte = f_ci == 3'd0 ? (f_stop ? 8'h4C : 8'h52) :   // CMD12, CMD18
                        f_ci == 3'd5 ? 8'hFF : f_stop ? 8'h00 :
                        f_ci == 3'd1 ? f_arg[31:24] : f_ci == 3'd2 ? f_arg[23:16] :
                        f_ci == 3'd3 ? f_arg[15:8]  : f_arg[7:0];

// At the start: ROM page i is in SRAM page 64 - n + i (the menu loads the
// image, or its last 480K, at the top of the SRAM)
wire [8:0] ci_sram = 9'd64 - n_pages + c_init_i;    // for page c_init_i
wire [8:0] ci_page = c_init_i + n_pages - 9'd64;    // for SRAM page c_init_i
wire       ci_map  = (c_init_i < n_pages) && (ci_sram >= 9'd4) && (ci_sram < 9'd64);
wire       ci_rev  = (c_init_i >= 9'd4) && (c_init_i + n_pages >= 9'd64);

always @(posedge clk) begin
  spi_start <= 0;
  cm_we     <= 0;
  cr_we     <= 0;

  // The CPU waits while the table is set up, for a page that is not in
  // the SRAM (and a few clocks after it is mapped, for the SRAM's data),
  // and whenever the reader has the SRAM controller's port (and a few
  // clocks after): a fill can start from a read that no longer waits for
  // it (a MegaCart bank switch changes the page within the read), and the
  // CPU's other SRAM accesses (the fixed bank, the SGM RAM) must not run
  // meanwhile.
  cpu_wait_n <= !(c_init || fill_on || ov_settle != 0 ||
                  (active && rom_rd && (!c_hit || c_settle != 0)));

  if (c_settle != 0)
    c_settle <= c_settle - 1;
  fill_on_d <= fill_on;
  if (fill_on_d && !fill_on)
    ov_settle <= 3'd7;
  else if (ov_settle != 0)
    ov_settle <= ov_settle - 1;

  if (led_time != 0) begin
    led_time <= led_time - 1;
    if (led_time == 1)
      led <= 0;
  end

  if (ld_done) begin
    ld_pend <= 0;
    ld_addr <= ld_addr + 1;
  end

  if (start) begin
    c_init   <= 1;
    c_init_i <= 0;
  end else if (c_init) begin
    cm_we <= 1;
    cm_a  <= c_init_i[7:0];
    cm_d  <= ci_map ? {1'b1, ci_sram[5:0]} : 7'd0;
    cr_we <= (c_init_i < 9'd64);
    cr_a  <= c_init_i[5:0];
    cr_d  <= {ci_rev, ci_page[7:0]};
    c_ref    <= 0;
    f_hand   <= 6'd4;
    c_init_i <= c_init_i + 1;
    if (c_init_i == 9'd255)
      c_init <= 0;
  end

  // Reads mark their SRAM page used
  if (active && rom_rd && c_hit)
    c_ref[c_line] <= 1;

  if (!active || c_init) begin
    f_state <= F_IDLE;
    f_cs    <= 0;
    fill_on <= 0;
  end else case (f_state)
  F_IDLE:
    if (rom_rd && !c_hit) begin
      f_page  <= rom_page;
      f_state <= F_VICT;
    end
  F_VICT:                            // clock hand over SRAM pages 4-63
    if (c_ref[f_hand]) begin
      c_ref[f_hand] <= 0;
      f_hand <= (f_hand == 6'd63) ? 6'd4 : f_hand + 6'd1;
    end else begin
      f_line  <= f_hand;
      f_hand  <= (f_hand == 6'd63) ? 6'd4 : f_hand + 6'd1;
      f_state <= F_EVICT;
    end
  F_EVICT: begin
      cm_we <= c_rev[f_line][8];     // unmap the page it had
      cm_a  <= c_rev[f_line][7:0];
      cm_d  <= 7'd0;
      cr_we <= 1;
      cr_a  <= f_line;
      cr_d  <= {1'b1, f_page};
      ld_addr <= {f_line, 13'd0};
      fill_on <= 1;
      f_cnt   <= 0;
      f_blk   <= 0;
      f_ci    <= 0;
      f_stop  <= 0;
      f_bad   <= 0;
      f_cs    <= 1;
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_CMD;
    end
  F_CMD: begin                       // CMD18 or CMD12, 6 bytes
      spi_txd <= f_cmd_byte; spi_start <= 1; f_state <= F_WAIT;
      f_ci <= f_ci + 1;
      f_next <= (f_ci != 3'd5) ? F_CMD : f_stop ? F_STUFF : F_R1;
      f_cnt <= 0;
    end
  F_R1: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_R1C;
      f_cnt <= f_cnt + 1;
    end
  F_R1C:
    if (spi_rx == 8'hFF)
      f_state <= (f_cnt == 16) ? F_ERR : F_R1;
    else
      f_state <= (spi_rx == 8'h00) ? F_TOK : F_ERR;
  F_TOK: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_TOKC;
      f_cnt <= f_cnt + 1;
    end
  F_TOKC:
    if (spi_rx == 8'hFE) begin
      f_byte  <= 0;
      f_crc   <= 0;
      f_state <= F_DATA;
    end else
      f_state <= (spi_rx != 8'hFF || f_cnt == 16'hFFFF) ? F_ERR : F_TOK;
  F_DATA:
    if (!ld_pend) begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_DATAC;
    end
  F_DATAC: if (!ld_pend) begin       // (the SRAM has the last byte)
      ld_data <= spi_rx;
      ld_pend <= 1;
      f_crc   <= crc16_byte(f_crc, spi_rx);
      f_byte  <= f_byte + 1;
      f_cnt   <= 0;
      f_state <= (f_byte == 9'd511) ? F_CRC : F_DATA;
    end
  F_CRC: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT;
      f_cnt <= f_cnt + 1;
      f_next <= F_CRCC;
    end
  F_CRCC: begin
      if (spi_rx != (f_cnt == 1 ? f_crc[15:8] : f_crc[7:0]))
        f_bad <= 1;
      if (f_cnt == 2) begin
        f_blk   <= f_blk + 1;
        f_cnt   <= 0;
        f_state <= (f_blk == 4'd15) ? F_STOP : F_TOK;
      end else
        f_state <= F_CRC;
    end
  F_STOP: begin                      // 16 sectors: CMD12
      f_ci    <= 0;
      f_stop  <= 1;
      f_state <= F_CMD;
    end
  F_STUFF: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_SR1;
      f_cnt <= 0;
    end
  F_SR1: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_SR1C;
      f_cnt <= f_cnt + 1;
    end
  F_SR1C:
    if (spi_rx == 8'hFF && f_cnt != 16)
      f_state <= F_SR1;
    else begin
      f_cnt   <= 0;
      f_state <= F_BUSY;
    end
  F_BUSY: begin
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_BUSYC;
      f_cnt <= f_cnt + 1;
    end
  F_BUSYC:
    if (spi_rx == 8'hFF)
      f_state <= F_END;
    else
      f_state <= (f_cnt == 16'hFFFF) ? F_ERR : F_BUSY;
  F_END:
    if (!ld_pend && ws == 2'd0) begin
      f_cs    <= 0;
      fill_on <= 0;
      spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT;
      f_next  <= f_bad ? F_ERR : F_MAP;
    end
  F_MAP: begin
      cm_we <= 1;
      cm_a  <= f_page;
      cm_d  <= {1'b1, f_line};
      c_ref[f_line] <= 1;
      f_state <= F_MAPW;
    end
  F_MAPW: begin
      c_settle <= 3'd7;
      f_state  <= F_IDLE;
    end
  F_WAIT:
    if (!spi_start && !spi_busy)
      f_state <= f_next;
  F_ERR: begin                       // stop the read (CMD12), then start the page again
      led      <= 1;
      led_time <= 23'h7FFFFF;
      if (!f_retry) begin
        f_retry <= 1;
        f_bad   <= 1;
        f_cs    <= 1;
        f_state <= F_STOP;
      end else if (!ld_pend) begin
        f_retry <= 0;
        f_cs    <= 0;
        spi_txd <= 8'hFF; spi_start <= 1; f_state <= F_WAIT; f_next <= F_EVICT;
      end
    end
  default: f_state <= F_IDLE;
  endcase

  if (reset) begin
    c_init  <= 0;
    f_state <= F_IDLE;
    f_cs    <= 0;
    fill_on <= 0;
    ld_pend <= 0;
  end
end

endmodule
