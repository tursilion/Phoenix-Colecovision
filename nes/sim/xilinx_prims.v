// Behavioral models of the Xilinx carry-chain primitives used by fpganes's
// cpu.v, for simulation only. ISE uses its own unisim library.
module MUXCY  (output O,  input CI, input DI, input S); assign O  = S ? CI : DI; endmodule
module MUXCY_L(output LO, input CI, input DI, input S); assign LO = S ? CI : DI; endmodule
module MUXCY_D(output O, output LO, input CI, input DI, input S);
  assign O = S ? CI : DI; assign LO = O;
endmodule
module XORCY  (output O, input CI, input LI); assign O = CI ^ LI; endmodule
module XOR2   (output O, input I0, input I1); assign O = I0 ^ I1; endmodule
