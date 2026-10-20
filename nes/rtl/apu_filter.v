// APU output filter for the HDMI audio path.
//
// The HDMI encoder takes the audio port as it is at each 48 kHz sample, so
// anything the APU produces above 24 kHz folds back into the audible range.
// The usual offender is the triangle channel at very short periods (up to
// 55.9 kHz, an inaudible tone on a NES), which comes out as a whine.  A NES
// filters its output in analog (high-pass ~90 Hz, low-pass ~14 kHz); this
// does the same job digitally at the CPU rate before the 48 kHz sampling:
//
//   1. DC blocker: one-pole high-pass, about 69 Hz.  Removes the large and
//      game-dependent DC level so silence is near zero.
//   2. Three 32-sample moving averages.  Each has nulls at multiples of
//      fs/32 = 55.4 kHz, exactly where the shortest triangle period and all
//      of its harmonics sit, and together they give about -50 dB around
//      48-60 kHz while only rolling off -3 dB at about 15 kHz.
//
// ce must be the APU (CPU) clock enable, or any enable at that rate: the
// sample only changes at that rate.

module apu_filter
   ( input             clk
   , input             ce
   , input      [15:0] sample        // unsigned APU mixer output
   , output reg [15:0] audio = 0     // signed PCM
   );

// --- DC blocker: lp follows the input with a 2^12-sample time constant.
reg  signed [29:0] lp = 0;           // 18.12 fixed point
wire signed [17:0] x  = {2'b00, sample};
wire signed [17:0] hp = x - (lp >>> 12);

// --- Three 32-sample moving averages (sum of the last 32 inputs / 32).
localparam W = 18;

reg  signed [W-1:0]   d1 [0:31];
reg  signed [W-1:0]   d2 [0:31];
reg  signed [W-1:0]   d3 [0:31];
reg  signed [W+4:0]   s1 = 0, s2 = 0, s3 = 0;
wire signed [W-1:0]   a1 = s1 >>> 5;
wire signed [W-1:0]   a2 = s2 >>> 5;
wire signed [W-1:0]   a3 = s3 >>> 5;

integer i;
initial for (i = 0; i < 32; i = i + 1) begin d1[i] = 0; d2[i] = 0; d3[i] = 0; end

always @(posedge clk) begin
  if (ce) begin
    lp <= lp + hp;

    s1 <= s1 + hp - d1[31];
    s2 <= s2 + a1 - d2[31];
    s3 <= s3 + a2 - d3[31];
    d1[0] <= hp;
    d2[0] <= a1;
    d3[0] <= a2;
    for (i = 1; i < 32; i = i + 1) begin
      d1[i] <= d1[i-1];
      d2[i] <= d2[i-1];
      d3[i] <= d3[i-1];
    end

    // Saturate to 16 bits.
    if (a3 > 18'sd32767)
      audio <= 16'h7FFF;
    else if (a3 < -18'sd32768)
      audio <= 16'h8000;
    else
      audio <= a3[15:0];
  end
end

endmodule
