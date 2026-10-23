//
// TV80 with a clock enable: tv80s (synchronous bus) with the core's cen
// brought out.  The bus strobes and the data latch only change on enabled
// clocks, so one T-state is one enabled clock.
//
// Based on tv80s.v from TV80 (Guy Hutchison, MIT license, see LICENSE),
// which is based on the VHDL T80 core by Daniel Wallner.
//

module tv80e (
  // Outputs
  m1_n, mreq_n, iorq_n, rd_n, wr_n, rfsh_n, halt_n, busak_n, A, dout,
  // Inputs
  reset_n, clk, cen, wait_n, int_n, nmi_n, busrq_n, di
  );

  parameter Mode = 0;    // 0 => Z80, 1 => Fast Z80, 2 => 8080, 3 => GB
  parameter T2Write = 1; // 0 => wr_n active in T3, /=0 => wr_n active in T2
  parameter IOWait  = 1; // 0 => Single cycle I/O, 1 => Std I/O cycle

  input         reset_n;
  input         clk;
  input         cen;
  input         wait_n;
  input         int_n;
  input         nmi_n;
  input         busrq_n;
  output        m1_n;
  output        mreq_n;
  output        iorq_n;
  output        rd_n;
  output        wr_n;
  output        rfsh_n;
  output        halt_n;
  output        busak_n;
  output [15:0] A;
  input [7:0]   di;
  output [7:0]  dout;

  reg           mreq_n = 1'b1;
  reg           iorq_n = 1'b1;
  reg           rd_n = 1'b1;
  reg           wr_n = 1'b1;

  wire          intcycle_n;
  wire          no_read;
  wire          write;
  wire          iorq;
  reg [7:0]     di_reg;
  wire [6:0]    mcycle;
  wire [6:0]    tstate;

  tv80_core #(Mode, IOWait) i_tv80_core
    (
     .cen (cen),
     .m1_n (m1_n),
     .iorq (iorq),
     .no_read (no_read),
     .write (write),
     .rfsh_n (rfsh_n),
     .halt_n (halt_n),
     .wait_n (wait_n),
     .int_n (int_n),
     .nmi_n (nmi_n),
     .reset_n (reset_n),
     .busrq_n (busrq_n),
     .busak_n (busak_n),
     .clk (clk),
     .IntE (),
     .stop (),
     .A (A),
     .dinst (di),
     .di (di_reg),
     .dout (dout),
     .mc (mcycle),
     .ts (tstate),
     .intcycle_n (intcycle_n)
     );

  always @(posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        begin
          rd_n   <= 1'b1;
          wr_n   <= 1'b1;
          iorq_n <= 1'b1;
          mreq_n <= 1'b1;
          di_reg <= 0;
        end
      else if (cen)
        begin
          rd_n <= 1'b1;
          wr_n <= 1'b1;
          iorq_n <= 1'b1;
          mreq_n <= 1'b1;
          if (mcycle[0])
            begin
              if (tstate[1] || (tstate[2] && wait_n == 1'b0))
                begin
                  rd_n <= ~ intcycle_n;
                  mreq_n <= ~ intcycle_n;
                  iorq_n <= intcycle_n;
                end
            end
          else
            begin
              if ((tstate[1] || (tstate[2] && wait_n == 1'b0)) && no_read == 1'b0 && write == 1'b0)
                begin
                  rd_n <= 1'b0;
                  iorq_n <= ~ iorq;
                  mreq_n <= iorq;
                end
              if (T2Write == 0)
                begin
                  if (tstate[2] && write == 1'b1)
                    begin
                      wr_n <= 1'b0;
                      iorq_n <= ~ iorq;
                      mreq_n <= iorq;
                    end
                end
              else
                begin
                  if ((tstate[1] || (tstate[2] && wait_n == 1'b0)) && write == 1'b1)
                    begin
                      wr_n <= 1'b0;
                      iorq_n <= ~ iorq;
                      mreq_n <= iorq;
                  end
                end
            end

          if (tstate[2] && wait_n == 1'b1 && !write && !no_read)
            di_reg <= di;
        end
    end

endmodule
