// A TMS9918 register / VRAM model for the simulation, without video: the
// CPU interface, the status register (vertical blank at 60Hz, with the
// interrupt), and the 16K VRAM.  The testbench prints the name table.
module vdp_spy
  ( input        clk          // 25MHz
  , input        mode         // 0 data, 1 control
  , input        csw_n
  , input        csr_n
  , input  [7:0] din
  , output reg [7:0] dout
  , output       int_n
  );

reg  [7:0] vram [0:16383] /*verilator public*/;
reg  [7:0] regs [0:7] /*verilator public*/;
reg [13:0] addr = 0;
reg        latch_first = 1;
reg  [7:0] latch;
reg  [7:0] rd_buf = 0;
reg        f_flag = 0;
reg [18:0] fcnt = 0;
reg        csw_d = 1, csr_d = 1;
integer i;
initial for (i = 0; i < 8; i = i + 1) regs[i] = 0;

assign int_n = !(f_flag && regs[1][5]);

always @(posedge clk) begin
  csw_d <= csw_n;
  csr_d <= csr_n;
  fcnt <= (fcnt == 19'd416666) ? 19'd0 : fcnt + 1;
  if (fcnt == 19'd416666)
    f_flag <= 1;

  // writes, at the start of the CPU's write
  if (!csw_n && csw_d) begin
    if (mode) begin
      if (latch_first) begin
        latch <= din;
        latch_first <= 0;
      end else begin
        latch_first <= 1;
        if (din[7])
          regs[din[2:0]] <= latch;
        else begin
          addr <= {din[5:0], latch};
          if (!din[6]) begin          // read set-up: prefetch
            rd_buf <= vram[{din[5:0], latch}];
            addr   <= {din[5:0], latch} + 1;
          end
        end
      end
    end else begin
      vram[addr] <= din;
      rd_buf <= din;
      addr <= addr + 1;
      latch_first <= 1;
    end
  end

  // reads
  if (!csr_n && csr_d) begin
    if (mode) begin
      dout <= {f_flag, 7'h1F};
      f_flag <= 0;
      latch_first <= 1;
    end else begin
      dout <= rd_buf;
      rd_buf <= vram[addr];
      addr <= addr + 1;
      latch_first <= 1;
    end
  end
end

endmodule
