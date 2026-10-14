// SD card SPI master and frame streamer.
//
// One SPI byte engine, shared by two users:
//
//  - The boot loader (cpu_own = 1) drives it a byte at a time, like the NES
//    core: chip select, speed, a transfer byte, and the received byte.
//
//  - In game mode (cpu_own = 0) the stream engine owns it.  On a seek it
//    opens a multi-block read (CMD18) at the frame's first sector and keeps
//    reading whole frames into a ring of 8 frame slots in the SRAM, staying
//    up to 7 frames ahead of the player.  When the ring is full it simply
//    stops clocking between blocks (allowed in SPI mode) and resumes when
//    the player moves on.  A new seek finishes the current block and sends
//    CMD12 before the next CMD18.
//
// Disc file layout: frame f starts at sector base_lba + f * 93.  A frame is
// 93 sectors (47616 bytes) and is copied as is to slot (f mod 8) of the
// SRAM, at slot * 0xC000:
//   0x0000  header sector (frame number, format; see tools/mkdisc.py)
//   0x0200  palette, 256 x RGB565 little-endian
//   0x0400  video, 80 x 60 cells of 4x4 pixels, 8 bytes each
//   0x9A00  audio, 2000 stereo samples (L, R signed 16-bit little-endian)
//
// Frames [v_lo, v_hi) are complete in the SRAM.  v_hi is the frame being
// read.
//
// A third user, the FAT checker, works for the boot loader: it checks that
// a file's clusters are one run (FAT[c] = c + 1 for count entries from the
// first cluster on) by reading the FAT sectors with one multi-block read
// at 25MHz and comparing each entry with a counter as it goes by.  The
// loader starts it and waits; the card must be idle and deselected.
//
// SCLK: speed 0 is ~390kHz and 1 is 12.5MHz, both as a level (sclk_lvl,
// MISO sampled on the rising edge).  Speed 2 is 25MHz: sclk_pulse asks the
// top level for one SCLK pulse in the second half of the clock (ODDR2),
// with MOSI stable for the whole clock and MISO sampled on the falling
// clock edge (miso_fall), i.e. on the SCLK rising edge.

`timescale 1ns / 1ps

module sd_stream
  ( input             clk
  , input             reset

  // Boot loader byte port
  , input             cpu_own
  , input             cpu_start
  , input       [7:0] cpu_tx
  , input             cpu_cs
  , input       [1:0] cpu_speed
  , output      [7:0] rx
  , output            busy

  // FAT checker (boot loader)
  , input             chk_start   // pulse
  , input      [31:0] chk_sector  // the FAT sector holding the first entry
  , input       [7:0] chk_index   // the first entry's index in that sector
  , input             chk_fat16   // 2-byte entries (else FAT32, 4 bytes)
  , input      [31:0] chk_expect  // what the first entry must hold (first cluster + 1)
  , input      [31:0] chk_count   // entries to check
  , output reg        chk_busy = 0
  , output reg        chk_bad = 0   // an entry broke the run
  , output reg        chk_err = 0   // the card did not answer

  // Stream control
  , input      [31:0] base_lba
  , input             sdhc        // 1 = block addressing
  , input             seek        // pulse: stream from seek_frame on
  , input      [15:0] seek_frame
  , input      [15:0] cur_frame   // the player's position
  , output reg [15:0] v_lo = 0
  , output reg [15:0] v_hi = 0
  , output reg        str_err = 0
  , output            streaming   // a frame is being read

  // SRAM writes
  , output            wr_req
  , output     [18:0] wr_addr
  , output      [7:0] wr_data
  , input             wr_ack

  // Pins
  , output            sd_cs_n
  , output            sclk_lvl
  , output            sclk_pulse
  , output            sd_mosi
  , input             sd_miso
  , input             miso_fall
  );

localparam FRAME_SECTORS = 7'd93;

// ---------------------------------------------------------------------------
// Byte engine

reg  [7:0] tx_sr = 8'hff, rx_sr = 8'hff;
reg  [2:0] bitn = 0;
reg        bbusy = 0;
reg        lvl = 0;
reg        pulse = 0;
reg  [5:0] div = 0;
reg        bdone = 0;

reg        s_start = 0;
reg  [7:0] s_tx = 8'hff;
reg        s_cs = 0;
reg        c_start = 0;
reg  [7:0] c_tx = 8'hff;
reg        c_cs = 0;

wire       chk_own = cpu_own && chk_busy;
wire [1:0] speed = chk_own ? 2'd2 : cpu_own ? cpu_speed : 2'd2;
wire       start = chk_own ? c_start : cpu_own ? cpu_start : s_start;
wire [7:0] txb   = chk_own ? c_tx    : cpu_own ? cpu_tx    : s_tx;
wire       fast  = (speed == 2'd2);
wire       tick  = (speed == 2'd0) ? (div == 6'd31) : 1'b1;

assign rx         = rx_sr;
assign busy       = bbusy || cpu_start || chk_busy;
assign sd_cs_n    = chk_own ? !c_cs : cpu_own ? !cpu_cs : !s_cs;
assign sclk_lvl   = lvl;
assign sclk_pulse = pulse;
assign sd_mosi    = tx_sr[7];

always @(posedge clk) begin
  div   <= tick ? 6'd0 : div + 1;
  bdone <= 0;

  if (start && !bbusy) begin
    tx_sr <= txb;
    bbusy <= 1;
    bitn  <= 0;
    lvl   <= 0;
    pulse <= fast;
    div   <= 0;
  end else if (bbusy && pulse) begin
    // 25MHz: one bit per clock
    rx_sr <= {rx_sr[6:0], miso_fall};
    tx_sr <= {tx_sr[6:0], 1'b1};
    bitn  <= bitn + 1;
    if (bitn == 3'd7) begin
      bbusy <= 0;
      pulse <= 0;
      bdone <= 1;
    end
  end else if (bbusy && tick) begin
    if (!lvl) begin                       // rising edge: sample MISO
      lvl   <= 1;
      rx_sr <= {rx_sr[6:0], sd_miso};
    end else begin                        // falling edge: shift MOSI
      lvl   <= 0;
      tx_sr <= {tx_sr[6:0], 1'b1};
      bitn  <= bitn + 1;
      if (bitn == 3'd7) begin
        bbusy <= 0;
        bdone <= 1;
      end
    end
  end

  if (reset) begin
    bbusy <= 0;
    pulse <= 0;
    lvl   <= 0;
    tx_sr <= 8'hff;
  end
end

// ---------------------------------------------------------------------------
// Write FIFO (first-word fall-through), {address, data}

reg  [26:0] fifo [0:511];
reg   [8:0] fwp = 0, frp = 0;
reg  [26:0] fq;
reg         fqv = 0;
reg         push = 0;
reg  [26:0] push_d;
wire        fempty_mem = (fwp == frp);
wire  [8:0] fcount = fwp - frp;
wire        froom = (fcount < 9'd448);
wire        fidle = fempty_mem && !fqv && !push;

assign wr_req  = fqv;
assign wr_addr = fq[26:8];
assign wr_data = fq[7:0];

always @(posedge clk) begin
  if (push) begin
    fifo[fwp] <= push_d;
    fwp       <= fwp + 1;
  end
  if ((!fqv || wr_ack) && !fempty_mem) begin
    fq  <= fifo[frp];
    frp <= frp + 1;
    fqv <= 1;
  end else if (wr_ack)
    fqv <= 0;

  if (reset) begin
    fwp <= 0;
    frp <= 0;
    fqv <= 0;
  end
end

// ---------------------------------------------------------------------------
// Stream engine

localparam ST_OFF    = 4'd0,   // CPU owns the card
           ST_IDLE   = 4'd1,   // no stream open
           ST_CMD    = 4'd2,   // sending a command (after one 0xFF)
           ST_R1     = 4'd3,   // waiting for R1
           ST_TOKEN  = 4'd4,   // waiting for a data token
           ST_DATA   = 4'd5,
           ST_CRC    = 4'd6,
           ST_FDONE  = 4'd7,   // frame read, waiting for the SRAM writes
           ST_BUSY   = 4'd8,   // after CMD12: wait for the card to release
           ST_ERR    = 4'd9;

reg  [3:0] st = ST_OFF;
reg        inflight = 0;       // a byte transfer started by this engine
reg  [2:0] cmd_i = 0;          // bytes of the command sent, 0 = the 0xFF gap
reg        cmd_stop = 0;       // the command is CMD12
reg [31:0] cmd_arg = 0;
reg        skip1 = 0;          // CMD12: skip the stuff byte
reg [19:0] wait_cnt = 0;
reg  [6:0] sector = 0;
reg  [8:0] bcnt = 0;
reg        crc_i = 0;
reg        pend = 0;           // seek pending
reg [15:0] pend_frame = 0;
reg        open = 0;           // a CMD18 is open

wire       got = bdone && inflight;

// Frame start sector: base + f * 93 = base + f*64 + f*16 + f*8 + f*4 + f
function [31:0] frame_lba(input [15:0] f, input [31:0] base);
  frame_lba = base + {10'd0, f, 6'd0} + {12'd0, f, 4'd0} + {13'd0, f, 3'd0} + {14'd0, f, 2'd0} + {16'd0, f};
endfunction

wire [31:0] lba = frame_lba(v_hi, base_lba);

// SRAM address of the byte being read: slot * 0xC000 + sector * 512 + byte
wire  [2:0] slot = v_hi[2:0];
wire [18:0] slot_base = {slot, 16'd0} - {2'd0, slot, 14'd0};   // slot * 0xC000
wire [18:0] byte_addr = slot_base + {3'd0, sector, 9'd0} + {10'd0, bcnt};

wire [15:0] ahead  = v_hi - cur_frame;
wire        room   = $signed(ahead) < 16'sd7;
wire [15:0] behind = cur_frame - v_hi;
wire        late   = $signed(behind) > 16'sd2;

assign streaming = open && (st != ST_IDLE);

task send(input [7:0] b);
  begin
    s_start  <= 1;
    s_tx     <= b;
    inflight <= 1;
  end
endtask

wire [7:0] cmd_byte =
  (cmd_i == 3'd1) ? (cmd_stop ? 8'h4C : 8'h52) :
  (cmd_i == 3'd2) ? cmd_arg[31:24] :
  (cmd_i == 3'd3) ? cmd_arg[23:16] :
  (cmd_i == 3'd4) ? cmd_arg[15:8]  :
  (cmd_i == 3'd5) ? cmd_arg[7:0]   :
  (cmd_i == 3'd6) ? (cmd_stop ? 8'h61 : 8'hFF) : 8'hFF;

always @(posedge clk) begin
  s_start <= 0;
  push    <= 0;
  if (got)
    inflight <= 0;

  if (seek) begin
    pend       <= 1;
    pend_frame <= seek_frame;
    v_lo       <= v_hi;            // nothing is valid any more
  end

  case (st)
  ST_OFF: ;

  ST_IDLE:
    if (pend && !inflight) begin
      v_lo     <= pend_frame;
      v_hi     <= pend_frame;
      pend     <= 0;
      sector   <= 0;
      st       <= ST_CMD;
      cmd_stop <= 0;
      cmd_i    <= 0;
    end

  ST_CMD:
    if (!inflight || got) begin
      if (cmd_i == 3'd7) begin
        if (got || !inflight) begin
          st       <= ST_R1;
          wait_cnt <= 0;
          skip1    <= cmd_stop;
        end
      end else begin
        if (cmd_i == 3'd0)
          cmd_arg <= sdhc ? lba : {lba[22:0], 9'd0};
        send(cmd_byte);
        cmd_i <= cmd_i + 1;
      end
    end

  ST_R1:
    if (got) begin
      if (skip1)
        skip1 <= 0;
      else if (rx_sr != 8'hff) begin
        if (cmd_stop) begin
          st       <= ST_BUSY;
          wait_cnt <= 0;
          open     <= 0;
        end else if (rx_sr == 8'h00) begin
          st   <= ST_TOKEN;
          open <= 1;
          wait_cnt <= 0;
        end else
          st <= ST_ERR;
      end else if (wait_cnt == 20'd64)
        st <= ST_ERR;
      else
        wait_cnt <= wait_cnt + 1;
    end else if (!inflight)
      send(8'hff);

  ST_TOKEN:
    if (got) begin
      if (rx_sr == 8'hfe) begin
        st   <= ST_DATA;
        bcnt <= 0;
        if (sector == 0 && (v_hi - v_lo) == 16'd8)
          v_lo <= v_lo + 1;           // its slot is about to be reused
      end else if (rx_sr != 8'hff)
        st <= ST_ERR;                 // data error token
      else if (wait_cnt == 20'hfffff)
        st <= ST_ERR;
      else
        wait_cnt <= wait_cnt + 1;
    end else if (!inflight) begin
      if (pend) begin
        st       <= ST_CMD;           // CMD12 at a block boundary
        cmd_stop <= 1;
        cmd_i    <= 0;
      end else if (sector == 0 && late) begin
        pend       <= 1;              // fell behind: skip ahead
        pend_frame <= cur_frame + 2;
      end else if (sector != 0 || room)
        send(8'hff);
    end

  ST_DATA:
    if (got) begin
      push   <= 1;
      push_d <= {byte_addr, rx_sr};
      bcnt   <= bcnt + 1;
      if (bcnt == 9'd511) begin
        st    <= ST_CRC;
        crc_i <= 0;
      end
    end else if (!inflight && froom && !push)
      send(8'hff);

  ST_CRC:
    if (got) begin
      crc_i <= 1;
      if (crc_i) begin
        wait_cnt <= 0;
        if (sector == FRAME_SECTORS - 1)
          st <= ST_FDONE;
        else begin
          sector <= sector + 1;
          st     <= ST_TOKEN;
        end
      end
    end else if (!inflight)
      send(8'hff);

  ST_FDONE:
    if (fidle) begin
      v_hi   <= v_hi + 1;
      sector <= 0;
      st     <= ST_TOKEN;
    end

  ST_BUSY:
    if (got) begin
      if (rx_sr == 8'hff || wait_cnt == 20'hfffff)
        st <= ST_IDLE;
      else
        wait_cnt <= wait_cnt + 1;
    end else if (!inflight)
      send(8'hff);

  ST_ERR: begin
      str_err <= 1;
      if (!inflight) begin
        if (!pend) begin
          pend       <= 1;            // retry from the frame being read
          pend_frame <= v_hi;
        end
        st       <= ST_CMD;
        cmd_stop <= 1;
        cmd_i    <= 0;
      end
    end

  default: st <= ST_IDLE;
  endcase

  if (cpu_own || reset) begin
    st       <= cpu_own ? ST_OFF : ST_IDLE;
    s_cs     <= 0;
    inflight <= 0;
    open     <= 0;
    pend     <= 0;
    v_lo     <= 0;
    v_hi     <= 0;
    str_err  <= 0;
  end else if (st == ST_OFF) begin
    st   <= ST_IDLE;
    s_cs <= 1;
  end
end

// ---------------------------------------------------------------------------
// FAT checker

localparam C_CMD = 3'd0, C_R1 = 3'd1, C_TOKEN = 3'd2, C_DATA = 3'd3,
           C_CRC = 3'd4, C_BUSY = 3'd5, C_DONE = 3'd6;

reg  [2:0] cst = C_CMD;
reg        c_inflight = 0;
reg  [2:0] c_i = 0;
reg        c_stop = 0;          // the command being sent is CMD12
reg        c_skip1 = 0;
reg [19:0] c_wait = 0;
reg  [8:0] c_bcnt = 0;
reg        c_crc = 0;
reg  [9:0] c_skip = 0;          // bytes before the first entry
reg  [1:0] c_ph = 0;            // byte within the entry
reg [23:0] c_acc = 0;           // entry bytes so far
reg [31:0] c_exp = 0;
reg [31:0] c_left = 0;
reg [31:0] c_arg = 0;
reg        c_fat16 = 0;
`ifdef DL_SIM_TRACE
reg [31:0] c_clocks = 0;
`endif

wire c_got = bdone && c_inflight;

wire [7:0] c_cmd_byte =
  (c_i == 3'd1) ? (c_stop ? 8'h4C : 8'h52) :
  (c_i == 3'd2) ? (c_stop ? 8'h00 : c_arg[31:24]) :
  (c_i == 3'd3) ? (c_stop ? 8'h00 : c_arg[23:16]) :
  (c_i == 3'd4) ? (c_stop ? 8'h00 : c_arg[15:8])  :
  (c_i == 3'd5) ? (c_stop ? 8'h00 : c_arg[7:0])   :
  (c_i == 3'd6) ? (c_stop ? 8'h61 : 8'hFF) : 8'hFF;

// The entry ending with this byte
wire [31:0] c_entry = c_fat16 ? {16'd0, rx_sr, c_acc[7:0]} : {4'd0, rx_sr[3:0], c_acc[23:0]};
wire        c_last  = c_fat16 ? (c_ph == 2'd1) : (c_ph == 2'd3);
wire [31:0] c_want  = c_fat16 ? {16'd0, c_exp[15:0]} : {4'd0, c_exp[27:0]};

task c_send(input [7:0] b);
  begin
    c_start    <= 1;
    c_tx       <= b;
    c_inflight <= 1;
  end
endtask

task c_finish;      // stop the read: CMD12, then deselect
  begin
    cst    <= C_CMD;
    c_stop <= 1;
    c_i    <= 0;
  end
endtask

always @(posedge clk) begin
  c_start <= 0;
  if (c_got)
    c_inflight <= 0;

  if (!chk_busy) begin
    if (chk_start && cpu_own) begin
      chk_busy <= 1;
      chk_bad  <= 0;
      chk_err  <= 0;
      c_cs     <= 1;
      cst      <= C_CMD;
      c_stop   <= 0;
      c_i      <= 0;
      c_arg    <= sdhc ? chk_sector : {chk_sector[22:0], 9'd0};
      c_fat16  <= chk_fat16;
      c_skip   <= chk_fat16 ? {1'b0, chk_index, 1'b0} : {chk_index[6:0], 2'b00};
      c_ph     <= 0;
      c_exp    <= chk_expect;
      c_left   <= chk_count;
      if (chk_count == 0) begin
        chk_busy <= 0;
        c_cs     <= 0;
      end
    end
  end else case (cst)
  C_CMD:
    if (!c_inflight || c_got) begin
      if (c_i == 3'd7) begin
        cst     <= C_R1;
        c_wait  <= 0;
        c_skip1 <= c_stop;
      end else begin
        c_send(c_cmd_byte);
        c_i <= c_i + 1;
      end
    end

  C_R1:
    if (c_got) begin
      if (c_skip1)
        c_skip1 <= 0;
      else if (rx_sr != 8'hff) begin
        if (c_stop) begin
          cst    <= C_BUSY;
          c_wait <= 0;
        end else if (rx_sr == 8'h00) begin
          cst    <= C_TOKEN;
          c_wait <= 0;
        end else begin
          chk_err <= 1;
          c_finish;
        end
      end else if (c_wait == 20'd64) begin
        chk_err <= 1;
        if (c_stop) cst <= C_DONE; else c_finish;
      end else
        c_wait <= c_wait + 1;
    end else if (!c_inflight)
      c_send(8'hff);

  C_TOKEN:
    if (c_got) begin
      if (rx_sr == 8'hfe) begin
        cst    <= C_DATA;
        c_bcnt <= 0;
      end else if (rx_sr != 8'hff || c_wait == 20'hfffff) begin
        chk_err <= 1;
        c_finish;
      end else
        c_wait <= c_wait + 1;
    end else if (!c_inflight)
      c_send(8'hff);

  C_DATA:
    if (c_got) begin
      c_bcnt <= c_bcnt + 1;
      if (c_skip != 0)
        c_skip <= c_skip - 1;
      else if (!c_last) begin
        c_acc <= (c_ph == 2'd0) ? {16'd0, rx_sr} : (c_acc | ({16'd0, rx_sr} << {c_ph, 3'b000}));
        c_ph  <= c_ph + 1;
      end else begin
        c_ph   <= 0;
        c_exp  <= c_exp + 1;
        c_left <= c_left - 1;
      end
      if (c_skip == 0 && c_last && c_entry != c_want) begin
        chk_bad <= 1;
        c_finish;                         // CMD12 mid-block is fine
      end else if (c_skip == 0 && c_last && c_left == 1)
        c_finish;
      else if (c_bcnt == 9'd511) begin
        cst   <= C_CRC;
        c_crc <= 0;
      end
    end else if (!c_inflight)
      c_send(8'hff);

  C_CRC:
    if (c_got) begin
      c_crc <= 1;
      if (c_crc) begin
        cst    <= C_TOKEN;
        c_wait <= 0;
      end
    end else if (!c_inflight)
      c_send(8'hff);

  C_BUSY:
    if (c_got) begin
      if (rx_sr == 8'hff || c_wait == 20'hfffff)
        cst <= C_DONE;
      else
        c_wait <= c_wait + 1;
    end else if (!c_inflight)
      c_send(8'hff);

  C_DONE:
    if (!c_inflight) begin
      c_cs <= 0;
      if (!c_cs)
        chk_busy <= 0;                    // one clock with CS released
    end

  default: cst <= C_DONE;
  endcase

`ifdef DL_SIM_TRACE
  if (chk_busy) c_clocks <= c_clocks + 1; else c_clocks <= 0;
  if (chk_busy && cst == C_DONE && !c_inflight && !c_cs)
    $display("FAT check: %0d entries in %0d clocks, bad=%0d err=%0d", chk_count, c_clocks, chk_bad, chk_err);
`endif

  if (reset) begin
    chk_busy   <= 0;
    c_cs       <= 0;
    c_inflight <= 0;
  end
end

endmodule
