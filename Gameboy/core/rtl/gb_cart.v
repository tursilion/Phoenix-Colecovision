// Game Boy cartridge mappers for the Phoenix: no MBC, MBC1, MBC2, MBC3 and
// MBC5, with the ROM and the cartridge RAM in the SRAM.  The register logic
// follows the MiSTer core's mappers (rtl/mappers/ in Gameboy_MiSTer).
//
// ROM: the 8K page of the access (up to 8M) and the address in it; the
// glue's ROM cache puts the page in the SRAM.  Cartridge RAM: in the SRAM
// from ram_base (8K banks, up to 128K), or up to 8K in the glue's block RAM
// instead (sram_addr bits 12:0).  The MBC3 clock registers read 0.

`timescale 1ns / 1ps

module gb_cart
   ( input             clk
   , input             ce_cpu
   , input             reset

   , input       [2:0] mapper      // MAP_*
   , input       [8:0] rom_mask    // 16K banks - 1
   , input       [3:0] ram_mask    // 8K banks - 1
   , input             has_ram
   , input       [5:0] ram_base    // SRAM address bits 18:13 of the RAM, aligned to its size

   // gb.v cartridge bus
   , input      [14:0] addr
   , input             a15
   , input             cart_rd
   , input             cart_wr
   , input       [7:0] cart_di
   , input             nCS

   , output     [18:0] sram_addr   // cartridge RAM byte to read, or to write when ram_wr
   , output      [9:0] rom_page    // ROM: 8K page; the byte is addr[12:0]
   , output            is_ram      // the access is to the cartridge RAM
   , output            cart_oe
   , output            ram_wr      // level: a write to the cartridge RAM
   , output            rtc_sel     // the read is an MBC3 clock register
   , output            mbc2_ram    // the read is MBC2 RAM (4 bits)
   );

localparam MAP_NONE = 3'd0, MAP_MBC1 = 3'd1, MAP_MBC2 = 3'd2,
           MAP_MBC3 = 3'd3, MAP_MBC5 = 3'd4;

reg       ram_enable;
reg [8:0] rom_bank_reg;   // MBC1 5 bits, MBC2 4, MBC3 7, MBC5 9
reg [3:0] ram_bank_reg;   // MBC1 2 bits (bank2), MBC3 4 (8-C: clock), MBC5 4
reg       mbc1_mode;

wire is_cram = ~nCS & ~addr[14];       // $A000-$BFFF

always @(posedge clk) begin
  if (reset) begin
    ram_enable   <= 0;
    rom_bank_reg <= 9'd1;
    ram_bank_reg <= 0;
    mbc1_mode    <= 0;
  end else if (ce_cpu && cart_wr && !a15) begin
    case (mapper)
    MAP_MBC1:
      case (addr[14:13])
      2'b00: ram_enable <= (cart_di[3:0] == 4'hA);
      2'b01: rom_bank_reg <= (cart_di[4:0] == 0) ? 9'd1 : {4'd0, cart_di[4:0]};
      2'b10: ram_bank_reg <= {2'b00, cart_di[1:0]};
      2'b11: mbc1_mode <= cart_di[0];
      endcase
    MAP_MBC2:
      // A8 selects: 0 = RAM enable, 1 = ROM bank
      if (!addr[14]) begin
        if (addr[8])
          rom_bank_reg <= (cart_di[3:0] == 0) ? 9'd1 : {5'd0, cart_di[3:0]};
        else
          ram_enable <= (cart_di[3:0] == 4'hA);
      end
    MAP_MBC3:
      case (addr[14:13])
      2'b00: ram_enable <= (cart_di[3:0] == 4'hA);
      2'b01: rom_bank_reg <= (cart_di[6:0] == 0) ? 9'd1 : {2'd0, cart_di[6:0]};
      2'b10: ram_bank_reg <= cart_di[3:0];
      2'b11: ;                         // clock latch
      endcase
    MAP_MBC5:
      case (addr[14:12])
      3'b000, 3'b001: ram_enable <= (cart_di == 8'h0A);
      3'b010: rom_bank_reg[7:0] <= cart_di;
      3'b011: rom_bank_reg[8] <= cart_di[0];
      3'b100, 3'b101: ram_bank_reg <= cart_di[3:0];
      default: ;
      endcase
    default: ;
    endcase
  end
end

// ROM bank for the access
wire [1:0] mbc1_bank2 = ram_bank_reg[1:0] & {2{addr[14] | mbc1_mode}};
reg  [8:0] rom_bank;
always @* begin
  case (mapper)
  MAP_MBC1: rom_bank = {2'b00, mbc1_bank2, addr[14] ? rom_bank_reg[4:0] : 5'd0};
  MAP_NONE: rom_bank = {8'd0, addr[14]};
  default:  rom_bank = addr[14] ? rom_bank_reg : 9'd0;
  endcase
end

// RAM bank
reg [3:0] ram_bank;
always @* begin
  case (mapper)
  MAP_MBC1: ram_bank = {2'b00, mbc1_bank2};
  MAP_MBC3: ram_bank = {2'b00, ram_bank_reg[1:0]};
  MAP_MBC5: ram_bank = ram_bank_reg;
  default:  ram_bank = 4'd0;
  endcase
end

assign rtc_sel  = (mapper == MAP_MBC3) && ram_bank_reg[3];
assign is_ram   = is_cram;
assign mbc2_ram = (mapper == MAP_MBC2);

wire [8:0] rom_b = rom_bank & rom_mask;
wire [3:0] ram_b = ram_bank & ram_mask;

assign rom_page  = {rom_b, addr[13]};
assign sram_addr = mbc2_ram ? {ram_base, 4'd0, addr[8:0]} :
                              {ram_base | {2'b00, ram_b}, addr[12:0]};

wire ram_ok = ram_enable && (has_ram || mbc2_ram || rtc_sel);

assign cart_oe = cart_rd && (!a15 || (is_cram && ram_ok));
assign ram_wr  = cart_wr && is_cram && ram_enable && (has_ram || mbc2_ram) && !rtc_sel;

endmodule
