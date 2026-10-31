// The menu ROM for the simulation (menu.hex from phoenixBoot.rom).
module rom_sim(input clk, input [14:0] addr, output reg [7:0] dout);
  reg [7:0] rom [0:24575];
  initial $readmemh("menu.hex", rom);
  always @(posedge clk)
    dout <= (addr < 15'd24576) ? rom[addr] : 8'hFF;
endmodule
