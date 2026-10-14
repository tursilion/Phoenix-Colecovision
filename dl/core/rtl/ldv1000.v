// Pioneer LD-V1000 laserdisc player, as seen by the Dragon's Lair board.
//
// Behaviour follows the Daphne/Hypseus model (ldp-in/ldv1000.cpp), which
// runs Dragon's Lair and Space Ace:
//
//  - Each write to E020 is one command byte.  The player is "ready" (status
//    bit 7) after a 0xFF (NO ENTRY); a command is accepted only when ready,
//    and clears bit 7.  The game always sends 0xFF before each command.
//  - Digits (3F 0F 8F 4F 2F AF 6F 1F 9F 5F) shift into a 5-digit frame
//    buffer.  F7 SEARCH seeks to it: status 0x50 while searching, then 0xD0
//    (still on that frame), or 0x90 if the frame is not on the disc.
//  - FD PLAY: status 0x64.  A3 FORWARD 1X starts playing muted (0x2E) if
//    stopped.  FB STOP and FE: still frame, 0x65.  A0: still frame.
//    F9 REJECT: 0x7C.  F4 / FC: audio channel 1 / 2, toggled, or set from
//    the parity of a digit entered just before.  BF clears the digits.
//    Other commands are ignored.
//  - Reading C020 returns the status.
//
// The disc turns at 29.97 video frames (59.94 fields) per second, but the
// Dragon's Lair and Space Ace discs hold film with 3:2 pulldown and their
// frame numbers count film frames (Daphne/Hypseus play them at 23.976
// frames per second): while playing, the frame number goes up after 3
// fields, then 2, then 3, then 2.  Every field the player
// pulses the status strobe and then the command strobe (C010 bits 6 and
// 7), with the LD-V1000's timing: 527us after vsync for 26us, and 54us
// later for 25us.
//
// The frame data comes from sd_stream: a search asks it to stream from the
// frame, and completes once that frame is in the SRAM.

`timescale 1ns / 1ps

module ldv1000
  ( input             clk          // 25MHz
  , input             reset

  , input             cmd_wr       // write strobe, one clock
  , input       [7:0] cmd
  , output      [7:0] status

  , output            status_strobe
  , output            command_strobe

  // Disc
  , input      [15:0] max_frame    // last frame on the disc
  , output reg [15:0] frame = 0    // the frame under the head
  , output reg        playing = 0
  , output            field_tick
  , output reg        frame_tick = 0
  , output reg        seek = 0     // to sd_stream
  , output reg [15:0] seek_frame = 0
  , input      [15:0] v_lo
  , input      [15:0] v_hi
  , output            audio1       // channel enables, for the disc audio
  , output            audio2
  );

// ---------------------------------------------------------------------------
// Field timing: 59.94Hz is 25MHz * 6 / 2502500

localparam [21:0] FIELD_DEN = 22'd2502500;

reg [21:0] field_acc = 0;
reg        ftick = 0;
reg  [3:0] field_ph = 0;     // position in the 10-field pulldown cycle
reg [14:0] since_field = 0;

assign field_tick = ftick;

always @(posedge clk) begin
  if (field_acc + 22'd6 >= FIELD_DEN) begin
    field_acc <= field_acc + 22'd6 - FIELD_DEN;
    ftick     <= 1;
  end else begin
    field_acc <= field_acc + 22'd6;
    ftick     <= 0;
  end

  if (ftick)
    since_field <= 0;
  else if (since_field != 15'h7fff)
    since_field <= since_field + 1;
end

assign status_strobe  = (since_field >= 15'd13178) && (since_field < 15'd13828);
assign command_strobe = (since_field >= 15'd15178) && (since_field < 15'd15803);

// ---------------------------------------------------------------------------
// Commands

reg  [7:0] st = 8'hFC;        // status; reads 0x50 while searching
reg  [3:0] d4 = 0, d3 = 0, d2 = 0, d1 = 0, d0 = 0;
reg        have_digit = 0;
reg        a1 = 1, a2 = 1;
reg        temp_mute = 0;
reg        searching = 0;
reg  [2:0] search_wait = 0;    // let sd_stream take the seek first
reg [15:0] target = 0;

assign status = searching ? 8'h50 : st;

assign audio1 = a1 && !temp_mute && playing;
assign audio2 = a2 && !temp_mute && playing;

function [16:0] x10(input [16:0] v);
  x10 = {v[13:0], 3'b0} + {v[15:0], 1'b0};
endfunction

wire [16:0] digits_bin =
  x10(x10(x10(x10({13'd0, d4}) + d3) + d2) + d1) + d0;

function is_digit(input [7:0] c);
  is_digit = (c == 8'h3F) || (c == 8'h0F) || (c == 8'h8F) || (c == 8'h4F) ||
             (c == 8'h2F) || (c == 8'hAF) || (c == 8'h6F) || (c == 8'h1F) ||
             (c == 8'h9F) || (c == 8'h5F);
endfunction

function [3:0] digit_val(input [7:0] c);
  case (c)
  8'h0F: digit_val = 4'd1;  8'h8F: digit_val = 4'd2;
  8'h4F: digit_val = 4'd3;  8'h2F: digit_val = 4'd4;
  8'hAF: digit_val = 4'd5;  8'h6F: digit_val = 4'd6;
  8'h1F: digit_val = 4'd7;  8'h9F: digit_val = 4'd8;
  8'h5F: digit_val = 4'd9;  default: digit_val = 4'd0;
  endcase
endfunction

wire [15:0] t_off  = target - v_lo;
wire [15:0] v_len  = v_hi - v_lo;
wire        target_ready = (t_off < v_len);

`ifdef DL_SIM_TRACE
always @(posedge clk) begin
  if (cmd_wr && st[7] && cmd != 8'hFF && !is_digit(cmd))
    $display("LD: cmd %02x  digits %0d  (frame %0d, status %02x) t=%0t", cmd, digits_bin, frame, status, $time);
  if (searching && search_wait == 0 && target_ready)
    $display("LD: search %0d done t=%0t", target, $time);
end
`endif

always @(posedge clk) begin
  seek       <= 0;
  frame_tick <= 0;

  // Disc motion
  if (ftick) begin
    field_ph <= (field_ph == 4'd9) ? 4'd0 : field_ph + 1;
    if (field_ph == 4'd2 || field_ph == 4'd4 || field_ph == 4'd7 || field_ph == 4'd9) begin
      frame_tick <= 1;
      if (playing)
        frame <= frame + 1;
    end
  end

  // Search completion
  if (searching) begin
    if (search_wait != 0)
      search_wait <= search_wait - 1;
    else if (target_ready) begin
      searching <= 0;
      frame     <= target;
      st    <= 8'hD0;
    end
  end

  if (cmd_wr) begin
    if (st[7]) begin
      st[7] <= 0;
      if (is_digit(cmd)) begin
        {d4, d3, d2, d1, d0} <= {d3, d2, d1, d0, digit_val(cmd)};
        have_digit <= 1;
      end else case (cmd)
      8'hBF: begin                                   // CLEAR
          {d4, d3, d2, d1, d0} <= 0;
          have_digit <= 0;
        end
      8'hF4: begin                                   // AUDIO 1
          a1 <= have_digit ? d0[0] : !a1;
          if (have_digit) begin {d4, d3, d2, d1, d0} <= 0; have_digit <= 0; end
        end
      8'hFC: begin                                   // AUDIO 2
          a2 <= have_digit ? d0[0] : !a2;
          if (have_digit) begin {d4, d3, d2, d1, d0} <= 0; have_digit <= 0; end
        end
      8'hA0: playing <= 0;                           // play at 0X
      8'hA3: if (!playing && !searching) begin       // FORWARD 1X
          playing   <= 1;
          temp_mute <= 1;
          st    <= 8'h2E;
        end
      8'hF9: st <= 8'h7C;                        // REJECT
      8'hFD: if (!searching) begin                   // PLAY
          playing   <= 1;
          temp_mute <= 0;
          st    <= 8'h64;
        end
      8'hFB, 8'hFE: if (!searching) begin            // STOP (still)
          playing <= 0;
          st  <= 8'h65;
        end
      8'hF7: begin                                   // SEARCH
          {d4, d3, d2, d1, d0} <= 0;
          have_digit <= 0;
          playing    <= 0;
          if (digits_bin == 0 || digits_bin > {1'b0, max_frame}) begin
            st <= 8'h90;
          end else begin
            target      <= digits_bin[15:0];
            seek        <= 1;
            seek_frame  <= digits_bin[15:0];
            searching   <= 1;
            search_wait <= 3'd7;
            frame       <= digits_bin[15:0];   // the head goes there
            st      <= 8'h50;
          end
        end
      8'hFF: st[7] <= 1;                         // NO ENTRY
      default: ;
      endcase
    end else if (cmd == 8'hFF)
      st[7] <= 1;
  end

  if (reset) begin
    st     <= 8'hFC;
    playing    <= 0;
    searching  <= 0;
    temp_mute  <= 0;
    a1         <= 1;
    a2         <= 1;
    have_digit <= 0;
    {d4, d3, d2, d1, d0} <= 0;
  end
end

endmodule
