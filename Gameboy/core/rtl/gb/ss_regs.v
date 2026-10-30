// Savestate registers without savestates: each one only gives its reset
// value (the MiSTer core's bus_savestates.vhd eReg_SavestateV, for the
// Verilog modules).

module eReg_SavestateV
  #( parameter index = 0
   , parameter Adr   = 0
   , parameter upper = 0
   , parameter lower = 0
   , parameter [63:0] def = 64'd0
   )
   ( input              clk
   , input       [63:0] BUS_Din
   , input        [9:0] BUS_Adr
   , input              BUS_wren
   , input              BUS_rst
   , output      [63:0] BUS_Dout
   , input  [upper:lower] Din
   , output [upper:lower] Dout
   );

assign BUS_Dout = 64'd0;
assign Dout = def[upper:lower];

endmodule
