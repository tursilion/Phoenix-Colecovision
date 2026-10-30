//
// gb.v
//
// Gameboy for the MIST board https://github.com/mist-devel
// 
// Copyright (c) 2015 Till Harbaum <till@harbaum.org> 
// 
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or 
// (at your option) any later version. 
// 
// This source file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License 
// along with this program.  If not, see <http://www.gnu.org/licenses/>. 
//

module gb (
	input reset,

	input clk_sys,
	input ce,
	input ce_n,
	input ce_2x,

	input isGBC,
	input boot_rom_off,   // loader mode: no boot ROM, the cartridge bus starts at $0000
	input fast_boot_en,

	// cartridge interface
	output [14:0] ext_bus_addr,
	output ext_bus_a15,
	output cart_rd,
	output cart_wr,
	input [7:0] cart_do,
	output [7:0] cart_di,
	input  cart_oe,

	// WRAM or Cart RAM CS
	output nCS,

	// work RAM (8K, 32K on the GBC), outside the core: the read data must
	// follow wram_addr within a few clk_sys clocks
	output [14:0] wram_addr,
	output        wram_we,      // one clk_sys pulse per write
	output  [7:0] wram_wdata,
	input   [7:0] wram_rdata,

	// audio
	output [15:0] audio_l,
	output [15:0] audio_r,

	// lcd interface
	output lcd_clkena,
	output [14:0] lcd_data,
	output [1:0] lcd_data_gb,
	output [1:0] lcd_mode,
	output lcd_on,
	output lcd_vsync,

	output [1:0] joy_p54,
	input  [3:0] joy_din,

	output speed,   //GBC
	output DMA_on
);

// Phoenix port: no Super Game Boy, MegaDuck, cheats, savestates, link
// cable or extra sprites.
wire megaduck = 1'b0;
wire isSGB = 1'b0;
wire extra_spr_en = 1'b0;
wire boot_gba_en = 1'b0;
wire audio_no_pops = 1'b0;
wire serial_clk_in = 1'b0;
wire serial_data_in = 1'b1;
wire serial_clk_out, serial_data_out;

// Savestates removed: the state registers start from their reset values.
wire [63:0] SaveStateBus_Din = 64'd0;
wire [9:0] SaveStateBus_Adr = 10'd0;
wire SaveStateBus_wren = 1'b0, SaveStateBus_rst = 1'b0;

wire [15:0] Savestate_RAMWriteData = 16'd0;
wire [7:0] Savestate_RAMReadData_ORAM;
wire [19:0] Savestate_RAMAddr = 20'd0;
wire [4:0] Savestate_RAMRWrEn = 5'd0;

wire [63:0] ss_unused_0, ss_unused_1, ss_unused_2, ss_unused_3, ss_unused_4, ss_unused_5;

wire [60:0] SS_Top = 61'h1000000000800000;
wire [60:0] SS_Top_BACK;
wire [10:0] SS_Top2 = 11'd0;
wire [10:0] SS_Top2_BACK;
wire  cpu_phi_f_ce;
wire hdma_rd;
wire [12:0] vram_addr;
wire  hdma_read_wram_bus;
wire  hdma_read_ext_bus;

// include cpu
reg boot_rom_enabled;

reg [1:0] ff4c_key0; // GBC DMG mode register
wire isGBC_mode = !ff4c_key0 | boot_rom_enabled;

wire [15:0] cpu_addr;
wire [7:0]  cpu_do;
wire 	    apu_framecount_en;

wire sel_timer = (cpu_addr[15:4] == 12'hff0) && (cpu_addr[3:2] == 2'b01);
wire sel_video_reg = (cpu_addr[15:4] == 12'hff4) || (isGBC && (cpu_addr[15:4] == 12'hff6) && (cpu_addr[3:0] >= 4'h8 && cpu_addr[3:0] <= 4'hC)); //video and oam dma (+ ff68-ff6C when gbc)
wire sel_video_oam = cpu_addr[15:8] == 8'hfe;
wire sel_joy  = cpu_addr == 16'hff00;                // joystick controller
wire sel_sb  = cpu_addr == 16'hff01;  			        // serial SB - Serial transfer data
wire sel_sc  = cpu_addr == 16'hff02;  			        // SC - Serial Transfer Control (R/W)
wire sel_rom  = !cpu_addr[15];                       // lower 32k are rom
wire sel_cram = cpu_addr[15:13] == 3'b101;           // 8k cart ram at $a000
wire sel_vram = cpu_addr[15:13] == 3'b100;           // 8k video ram at $8000
wire sel_ie   = cpu_addr == 16'hffff;                // interupt enable
wire sel_if   = cpu_addr == 16'hff0f;                // interupt flag
wire sel_wram = (cpu_addr[15:14] == 2'b11) && (~&cpu_addr[13:9]); // 8k internal ram at $C000-DFFF. C000-DDFF mirrored to E000-FDFF
wire sel_zpram = (cpu_addr[15:7] == 9'b111111111) && // 127 bytes zero pageram at $ff80
					 (cpu_addr != 16'hffff);
wire sel_audio = (cpu_addr[15:8] == 8'hff) &&        // audio reg ff10 - ff3f and ff76/ff77 PCM12/PCM34 (undocumented registers)
					((cpu_addr[7:5] == 3'b001) || (cpu_addr[7:4] == 4'b0001) || (cpu_addr[7:0] == 8'h76) || (cpu_addr[7:0] == 8'h77));

wire sel_ext_bus = sel_rom | sel_cram | sel_wram;

wire sel_boot_rom, sel_boot_rom_cgb;

// unused cgb registers
wire sel_FF72  = isGBC && cpu_addr == 16'hff72;            // unused register, all bits read/write
wire sel_FF73  = isGBC && cpu_addr == 16'hff73;            // unused register, all bits read/write
wire sel_FF74  = isGBC && isGBC_mode && (cpu_addr == 16'hff74); // unused register, all bits read/write, only in CGB mode
wire sel_FF75  = isGBC && cpu_addr == 16'hff75;            // unused register, bits 4-6 read/write

// Special MiSTer register for signalling to cpu bootrom
wire sel_FF50  = boot_rom_enabled && cpu_addr == 16'hff50;

wire ext_bus_wram_sel, ext_bus_cram_sel, ext_bus_rom_sel;
wire ext_bus_rd, ext_bus_wr;
wire [7:0] ext_bus_di;
wire cart_sel;


//  From Game Boy: Complete Technical Reference:
//  DMA register value, Selected bus, Asserted CS:
//  0x00-0x7F, external bus,  external ROM (A15)
//  0x80-0x9F, video RAM bus, video RAM (MCS)
//  0xA0-0xFF, external bus,  external RAM (CS)
wire [15:0] dma_addr;				
wire dma_sel_rom = ~dma_addr[15];                       // lower 32k are rom
wire dma_sel_vram = dma_addr[15:13] == 3'b100;          // 8k video ram at $8000-$9FFF
wire dma_sel_ext_bus_dmg = ~dma_sel_vram;               // WRAM or Cart ROM/RAM
wire dma_sel_ext_ram = ~dma_sel_rom;                    // External RAM CS

//CGB
wire dma_sel_cram = dma_addr[15:13] == 3'b101;          // 8k cart ram at $a000
wire dma_sel_wram = dma_addr[15:13] == 3'b110;          // 8k WRAM at $c000-$dfff
wire dma_sel_ext_bus_cgb = dma_sel_rom | dma_sel_cram;  // Cart ROM/RAM

wire dma_sel_ext_bus = isGBC ? dma_sel_ext_bus_cgb : dma_sel_ext_bus_dmg;

//CGB
wire sel_vram_bank = (cpu_addr==16'hff4f);
wire sel_wram_bank = isGBC && isGBC_mode && (cpu_addr==16'hff70);
wire sel_hdma = isGBC && isGBC_mode && (cpu_addr[15:4]==12'hff5) && 
					((cpu_addr[3:0]!=4'd0)&&(cpu_addr[3:0]< 4'd6)); //HDMA FF51-FF55 
wire sel_key0 = isGBC && boot_rom_enabled && (cpu_addr == 16'hff4c); // KEY0 - CGB / DMG mode register
wire sel_key1 = isGBC && isGBC_mode && (cpu_addr == 16'hff4d); // KEY1 - CGB Mode Only - Prepare Speed Switch
wire sel_rp = isGBC && isGBC_mode && (cpu_addr == 16'hff56); //FF56 - RP - CGB Mode Only - Infrared Communications Port

//HDMA can select from $0000 to $7ff0 or A000-DFF0
wire [15:0] hdma_source_addr;
wire hdma_sel_rom = !hdma_source_addr[15];                  // lower 32k are rom
wire hdma_sel_cram = hdma_source_addr[15:13] == 3'b101;     // 8k cart ram at $a000
wire hdma_sel_wram = hdma_source_addr[15:13] == 3'b110;     // 8k WRAM at $c000-$dff0
wire hdma_sel_ext_bus = hdma_sel_rom | hdma_sel_cram;

wire sc_start;
wire sc_shiftclock;
wire [7:0] sc_r = {sc_start,6'h3F,sc_shiftclock};

wire irq_ack;
wire [7:0] irq_vec;
reg [4:0] if_r;
reg [7:0] ie_r; // writing  $ffff sets the irq enable mask
wire irq_n;
				
reg [2:0] wram_bank; //1-7 FF70 - SVBK
reg vram_bank; //0-1 FF4F - VBK

wire [7:0] hdma_do;

reg cpu_speed; // - 0 Normal mode (4MHz) - 1 Double Speed Mode (8MHz)
reg prepare_switch; // set to 1 to toggle speed

wire oam_cpu_allow;
wire vram_cpu_allow;

wire [7:0] joy_do;
wire [7:0] sb_o;
wire [7:0] timer_do;
wire [7:0] video_do;
wire [7:0] audio_do;
wire [7:0] boot_do;
wire [7:0] vram_do;
wire [7:0] vram1_do;
wire [7:0] zpram_do;
wire [7:0] wram_do;

reg[7:0] FF72;
reg[7:0] FF73;
reg[7:0] FF74;
reg[2:0] FF75;

// http://gameboy.mongenel.com/dmg/asmmemmap.html
wire [7:0] cpu_di = 
		irq_ack?irq_vec:
		sel_if?{3'b111, if_r}:  // interrupt flag register
		sel_rp?8'h02:
		sel_wram_bank?{5'h1f,wram_bank}:
		isGBC&&sel_vram_bank?{7'h7f,vram_bank}:
		sel_hdma?{hdma_do}:  //hdma GBC
		sel_key0 ? { 4'hF, ff4c_key0, 2'b10 } :
		sel_key1?{cpu_speed,6'h3f,prepare_switch}: //key1 cpu speed register(GBC)
		sel_joy?joy_do:         // joystick register
		sel_sb?sb_o:				// serial transfer data register
		sel_sc?sc_r:				// serial transfer control register
		sel_timer?timer_do:     // timer registers
		sel_video_reg?video_do: // video registers
		(sel_video_oam&&oam_cpu_allow)?video_do: // video object attribute memory
		sel_audio?audio_do:                                // audio registers
		sel_boot_rom?boot_do:                             // boot rom
		isGBC&sel_wram ? wram_do:                         // wram on GBC
		sel_ext_bus?ext_bus_di:                           // wram (DMG) + cartridge rom/ram
		(sel_vram&&vram_cpu_allow)?(isGBC&&vram_bank)?vram1_do:vram_do:       // vram (GBC bank 0+1)
		sel_zpram?zpram_do:     // zero page ram
		sel_ie?ie_r:  // interrupt enable register
		sel_FF72?FF72: // unused register, all bits read/write
		sel_FF73?FF73: // unused register, all bits read/write
		sel_FF74?FF74: // unused register, all bits read/write, only in CGB mode
		sel_FF75?{1'b1,FF75, 4'b1111}: // unused register, bits 4-6 read/write
        sel_FF50?{6'b0, fast_boot_en, boot_gba_en}: // MiSTer special instruction register 
		8'hff;

wire cpu_wr_n;
wire cpu_rd_n;
wire cpu_iorq_n;
wire cpu_m1_n;
wire cpu_mreq_n;
wire cpu_halt_n;
wire [2:0] cpu_tstate;

wire ce_cpu = cpu_speed ? ce_2x:ce;

// when hdma is enabled stop CPU (GBC).
wire hdma_cpu_stop = (isGBC & hdma_rd);
wire cpu_clken = ~hdma_cpu_stop & ce_cpu;

reg reset_r  = 1;
wire reset_ss = reset_r;

//sync reset with clock
always  @ (posedge clk_sys) begin
	if (ce) reset_r <= reset;
end

// Generate PHI signal. Normally the CPU runs from the PHI signal but the current CPU does not use it.
// So here we sync to the CPU Tstates.
reg [2:0] phi_clk_div;
always @(posedge clk_sys) begin
	if (reset_ss) begin
		phi_clk_div <= SS_Top[59:57]; // 3'd0;
	end else begin
		if (ce_2x) begin
			phi_clk_div <= phi_clk_div + 1'b1;
		end

		if (cpu_clken & cpu_halt_n) begin
			if (cpu_tstate == 3'd4) begin
				if (cpu_speed) begin
					phi_clk_div[1:0] <= 2'd1;
				end else begin
					phi_clk_div <= 3'd2;
				end
			end
		end
	end
end

wire phi_1m = ~phi_clk_div[2];
wire phi_2m = ~phi_clk_div[1];

wire phi_early_1m = ~|phi_clk_div[2:1];
wire phi_early_2m = ~|phi_clk_div[1:0];

wire cpu_phi = (cpu_speed ? phi_2m : phi_1m) | ~cpu_halt_n;

reg cpu_phi_d;

assign SS_Top_BACK[59:57] = phi_clk_div;
assign SS_Top_BACK[   60] = cpu_phi_d;

always @(posedge clk_sys) begin
	if(reset_ss) cpu_phi_d <= SS_Top[60]; // 1'b1
	else if (ce_2x) cpu_phi_d <= cpu_phi;
end

wire cpu_phi_r_ce = ce_2x & cpu_halt_n & (cpu_speed ? (phi_clk_div[1:0] == 2'd3) : (phi_clk_div == 3'd7) );
//wire cpu_phi_f_ce = ce_2x & cpu_halt_n & (cpu_speed ? (phi_clk_div[1:0] == 2'd1) : (phi_clk_div == 3'd3) );
// There is an issue with falling edge missing when going out of Halt with the current CPU so do it another way.
assign cpu_phi_f_ce = ce_2x & cpu_phi_d & ~cpu_phi;

wire hdma_phi_r_ce = ce_2x & (phi_clk_div[1:0] == 2'd3);
wire hdma_phi_f_ce = ce_2x & (phi_clk_div[1:0] == 2'd1);

reg old_cpu_wr_n;

assign SS_Top_BACK[54] = old_cpu_wr_n;

always @(posedge clk_sys) begin
	if(reset_ss) old_cpu_wr_n <= SS_Top[54]; // 1'b0
	else if (ce_cpu) old_cpu_wr_n <= cpu_wr_n;
end
wire cpu_wr_n_edge = ~(old_cpu_wr_n & ~cpu_wr_n);

wire cpu_stop;

wire genie_ovr;
wire [7:0] genie_data;
wire [15:0] cpu_addr_raw;

wire [7:0] snd_d_in;
wire [7:0] snd_d_out;
assign cpu_addr = cpu_addr_raw;
assign snd_d_in = cpu_do;
assign audio_do = snd_d_out;

GBse cpu (
	.RESET_n           ( !reset_ss        ),
	.CLK_n             ( clk_sys         ),
	.CLKEN             ( cpu_clken       ),
	.WAIT_n            ( 1'b1            ),
	.INT_n             ( irq_n           ),
	.NMI_n             ( 1'b1            ),
	.BUSRQ_n           ( 1'b1            ),
   .M1_n              ( cpu_m1_n        ),
   .MREQ_n            ( cpu_mreq_n      ),
   .IORQ_n            ( cpu_iorq_n      ),
   .RD_n              ( cpu_rd_n        ),
   .WR_n              ( cpu_wr_n        ),
   .RFSH_n            (                 ),
   .HALT_n            ( cpu_halt_n      ),
   .BUSAK_n           (                 ),
   .A                 ( cpu_addr_raw        ),
   .DI                ( genie_ovr ? genie_data : cpu_di),
   .DO                ( cpu_do          ),
	.STOP              ( cpu_stop        ),
    .TS               ( cpu_tstate       ),
    .isGBC             ( isGBC           ),
   // savestates
   .SaveStateBus_Din  (SaveStateBus_Din ), 
   .SaveStateBus_Adr  (SaveStateBus_Adr ),
   .SaveStateBus_wren (SaveStateBus_wren),
   .SaveStateBus_rst  (SaveStateBus_rst ),
   .SaveStateBus_Dout (ss_unused_0)
);

// --------------------------------------------------------------------
// --------------------------- Cheat Engine ---------------------------
// --------------------------------------------------------------------

assign genie_ovr = 1'b0;
assign genie_data = 8'h00;

// --------------------------------------------------------------------
// --------------------- GBC/DMG mode KEY0 (GBC) ----------------------
// --------------------------------------------------------------------

assign SS_Top_BACK[56:55] = ff4c_key0;

// KEY0 FF4C CPU mode register
// Bits 2 and 3 CPU mode select
// 00: CGB mode (Mode used by carts supporting CGB)
// 01: DMG/MGB mode (Mode used by DMG/MGB-only carts)
 //10: PGB1 mode (STOP the CPU, with the LCD operated by an external signal)
// 11: PGB2 mode (CPU still running, with the LCD operated by an external signal)
// R/W only when boot rom is enabled
// https://forums.nesdev.org/viewtopic.php?t=19888
always @(posedge clk_sys) begin
	if(reset_ss) begin
		ff4c_key0 <= SS_Top[56:55]; // 2'd0;
	end else if(sel_key0 & ce_cpu & ~cpu_wr_n_edge) begin
		ff4c_key0 <= cpu_do[3:2];
	end
end

// --------------------------------------------------------------------
// --------------------- Speed Toggle KEY1 (GBC)-----------------------
// --------------------------------------------------------------------
assign speed = cpu_speed;

assign SS_Top_BACK[3] = cpu_speed;
assign SS_Top_BACK[4] = prepare_switch;

always @(posedge clk_sys) begin
   if(reset_ss) begin
		cpu_speed      <= SS_Top[3]; // 1'b0;
		prepare_switch <= SS_Top[4]; // 1'b0;
	end
	else if (ce_2x && sel_key1 && !cpu_wr_n_edge)begin
		prepare_switch <= cpu_do[0];
	end
	
	if (ce_2x && isGBC && prepare_switch && cpu_stop) begin
		cpu_speed <= !cpu_speed;
		prepare_switch <= 1'b0;
	end
end

// --------------------------------------------------------------------
// ------------------------------ audio -------------------------------
// --------------------------------------------------------------------
wire audio_rd = !cpu_rd_n && sel_audio;
wire audio_wr = !cpu_wr_n && sel_audio;

gbc_snd audio (
	.clk				( clk_sys			),
	.ce            ( ce           ),
	.reset			( reset_ss			),
	.apu_framecount_en		( apu_framecount_en ),

	.is_gbc        ( isGBC           ),
	.remove_pops   ( audio_no_pops   ),

	.s1_read  		( audio_rd  		),
	.s1_write 		( audio_wr  		),
	.s1_addr    	( cpu_addr[6:0]	),
   .s1_readdata 	( snd_d_out       ),
	.s1_writedata  ( snd_d_in       	),

   .snd_left 		( audio_l  			),
	.snd_right  	( audio_r  			),
	
  .SaveStateBus_Din  (SaveStateBus_Din ), 
  .SaveStateBus_Adr  (SaveStateBus_Adr ),
  .SaveStateBus_wren (SaveStateBus_wren),
  .SaveStateBus_rst  (SaveStateBus_rst ),
  .SaveStateBus_Dout (ss_unused_5)
);

// --------------------------------------------------------------------
// -----------------------serial port()--------------------------------
// --------------------------------------------------------------------

// SNAC
wire serial_irq;


link link (
  .clk_sys(clk_sys),
  .ce(ce_cpu),
  .rst(reset_ss),

  .sel_sc(sel_sc),
  .sel_sb(sel_sb),
  .cpu_wr_n(cpu_wr_n_edge),
  .sc_start_in(cpu_do[7]),
  .sc_int_clock_in(cpu_do[0]),

  .sb_in(cpu_do),

  .serial_clk_in(serial_clk_in),
  .serial_data_in(serial_data_in),

  .serial_clk_out(serial_clk_out),
  .serial_data_out(serial_data_out),
  .sb(sb_o),
  .serial_irq(serial_irq),
  .sc_start(sc_start),
  .sc_int_clock(sc_shiftclock),
	
  .SaveStateBus_Din  (SaveStateBus_Din ), 
  .SaveStateBus_Adr  (SaveStateBus_Adr ),
  .SaveStateBus_wren (SaveStateBus_wren),
  .SaveStateBus_rst  (SaveStateBus_rst ),
  .SaveStateBus_Dout (ss_unused_3)
);

// --------------------------------------------------------------------
// ------------------------------ inputs ------------------------------
// --------------------------------------------------------------------

reg  [1:0] p54;

assign SS_Top_BACK[6:5] = p54;

always @(posedge clk_sys) begin
	if(reset_ss) p54 <= SS_Top[6:5]; //2'b00 for DMG, 2'b11 for CGB/SGB will be written by BIOS
	else if(ce_cpu && sel_joy && !cpu_wr_n_edge)	p54 <= cpu_do[5:4];
end

assign joy_do = { 2'b11, p54, joy_din };
assign joy_p54 = p54;

// --------------------------------------------------------------------
// ------------------------------ unused regs -------------------------
// --------------------------------------------------------------------

assign SS_Top_BACK[34:27] = FF72;
assign SS_Top_BACK[42:35] = FF73;
assign SS_Top_BACK[50:43] = FF74;
assign SS_Top_BACK[53:51] = FF75;

always @(posedge clk_sys) begin
	if(reset_ss) begin
		FF72 <= SS_Top[34:27]; // 0;  
		FF73 <= SS_Top[42:35]; // 0;  
		FF74 <= SS_Top[50:43]; // 0;  
		FF75 <= SS_Top[53:51]; // 0;  
	end else if(ce_cpu && !cpu_wr_n_edge)	begin
		if (sel_FF72) FF72 <= cpu_do;
		if (sel_FF73) FF73 <= cpu_do;
		if (sel_FF74) FF74 <= cpu_do;
		if (sel_FF75) FF75 <= cpu_do[6:4];
	end
end

// --------------------------------------------------------------------
// ---------------------------- interrupts ----------------------------
// --------------------------------------------------------------------

// interrupt flags are set when the event happens or when the cpu writes
// the register to 1. The "highest" one active is cleared when the cpu
// runs an interrupt ack cycle or when it writes a 0 to the register

assign irq_ack = !cpu_iorq_n && !cpu_m1_n;

// irq vector
assign irq_vec = 
			if_r[0]&&ie_r[0]?8'h40:   // vsync
			if_r[1]&&ie_r[1]?8'h48:   // lcdc
			if_r[2]&&ie_r[2]?8'h50:   // timer
			if_r[3]&&ie_r[3]?8'h58:   // serial
			if_r[4]&&ie_r[4]?8'h60:   // input
			8'h00;

//wire vs = (lcd_mode == 2'b01);
//reg vsD, vsD2;
reg [3:0] inputD, inputD2;

// irq is low when an enable irq is active
assign irq_n = !(ie_r & if_r);

wire video_irq,vblank_irq;
wire timer_irq;

reg old_vblank_irq, old_video_irq, old_timer_irq, old_serial_irq;
reg old_ack = 0;

assign SS_Top_BACK[11: 7] = ie_r[4:0];
assign SS_Top_BACK[16:12] = if_r;
assign SS_Top_BACK[   17] = old_vblank_irq;
assign SS_Top_BACK[   18] = old_video_irq;
assign SS_Top_BACK[   19] = old_timer_irq;
assign SS_Top_BACK[   20] = old_serial_irq;
assign SS_Top_BACK[   21] = old_ack;
assign SS_Top_BACK[26:24] = ie_r[7:5];

always @(negedge clk_sys) begin //negedge to trigger interrupt earlier

	if(reset_ss) begin
		ie_r[4:0] 		 <= SS_Top[11: 7]; // 5'h00;
		if_r 			    <= SS_Top[16:12]; // 5'h00;
		old_vblank_irq  <= SS_Top[   17]; // 1'b0;
		old_video_irq   <= SS_Top[   18]; // 1'b0;
		old_timer_irq   <= SS_Top[   19]; // 1'b0;
		old_serial_irq  <= SS_Top[   20]; // 1'b0;
		old_ack         <= SS_Top[   21]; // 1'b0;
		ie_r[7:5] 		 <= SS_Top[26:24]; // 3'h00;
	end else if (ce_cpu) begin

		// "When an interrupt signal changes from low to high,
		//  then the corresponding bit in the IF register becomes set."
		old_vblank_irq <= vblank_irq;
		if(~old_vblank_irq & vblank_irq) if_r[0] <= 1'b1;
	
		// video irq already is a 1 clock event
		old_video_irq <= video_irq;
		if(~old_video_irq & video_irq) if_r[1] <= 1'b1;
		
		// timer_irq already is a 1 clock event
		old_timer_irq <= timer_irq;
		if(~old_timer_irq & timer_irq) if_r[2] <= 1'b1;
		
		// serial irq already is a 1 clock event
		old_serial_irq <= serial_irq;
		if(~old_serial_irq & serial_irq) if_r[3] <= 1'b1;
	
		// falling edge on any input line P10..P13
	
		inputD <= joy_din;
		inputD2 <= inputD;
		if(~inputD & inputD2) if_r[4] <= 1'b1;
	
		// cpu acknowledges irq. this clears the active irq with hte 
		// highest priority
		old_ack <= irq_ack;
		
		if(old_ack & ~irq_ack) begin
			if(if_r[0] && ie_r[0]) if_r[0] <= 1'b0;
			else if(if_r[1] && ie_r[1]) if_r[1] <= 1'b0;
			else if(if_r[2] && ie_r[2]) if_r[2] <= 1'b0;
			else if(if_r[3] && ie_r[3]) if_r[3] <= 1'b0;
			else if(if_r[4] && ie_r[4]) if_r[4] <= 1'b0;
		end
	
		// cpu writes interrupt enable register
		if(sel_ie && !cpu_wr_n_edge)
			ie_r <= cpu_do;
	
		// cpu writes interrupt flag register
		if(sel_if && !cpu_wr_n_edge)
			if_r <= cpu_do[4:0];
			
	end
end
			
// --------------------------------------------------------------------
// ------------------------------ timer -------------------------------
// --------------------------------------------------------------------

timer timer (
	.reset	    		 ( reset_ss      ),
	.clk_sys		     ( clk_sys       ),
	.ce                  ( ce_cpu        ), // 2x in fast mode
	.ce_4MHz 		     (ce), // Always 4 MiHz
	.cpu_speed			 ( cpu_speed 	 ),

	.irq         		 ( timer_irq     ),
				 
	.cpu_sel     		 ( sel_timer     ),
	.cpu_addr    		 ( cpu_addr[1:0] ),
	.cpu_wr      		 ( !cpu_wr_n_edge ),
	.cpu_di      		 ( cpu_do        ),
	.cpu_do      		 ( timer_do      ),
	.apu_framecount_en	 ( apu_framecount_en),
	
	.SaveStateBus_Din  (SaveStateBus_Din ), 
	.SaveStateBus_Adr  (SaveStateBus_Adr ),
	.SaveStateBus_wren (SaveStateBus_wren),
	.SaveStateBus_rst  (SaveStateBus_rst ),
	.SaveStateBus_Dout (ss_unused_1)
);
	
// --------------------------------------------------------------------
// ------------------------------ video -------------------------------
// --------------------------------------------------------------------

// cpu tries to read or write the lcd controller registers
wire [12:0] video_addr;
wire video_rd, dma_rd;

wire [7:0] dma_data = (isGBC & dma_sel_wram) ? wram_do :
                        dma_sel_ext_bus ? ext_bus_di :
                            dma_sel_vram ? (isGBC&vram_bank ? vram1_do : vram_do) :
                                8'hFF;

video video (
	.reset       ( reset_ss         ),
	.clk         ( clk_sys       ),
	.ce          ( ce            ),   // 4Mhz
	.ce_n        ( ce_n          ),
	.ce_cpu      ( ce_cpu        ),   //can be 2x in cgb double speed mode
	.isGBC       ( isGBC         ),
	.isGBC_mode  ( isGBC_mode    ),  //enable GBC mode during bootstrap rom
	.megaduck    ( megaduck      ),

	.boot_rom_en ( boot_rom_enabled ),

	.irq         ( video_irq     ),
	.vblank_irq  ( vblank_irq    ),


	.cpu_sel_reg ( sel_video_reg ),
	.cpu_sel_oam ( sel_video_oam ),
	.cpu_addr    ( cpu_addr[7:0] ),
	.cpu_wr      ( !cpu_wr_n_edge ),
	.cpu_di      ( cpu_do        ),
	.cpu_do      ( video_do      ),

	.cpu_phi      ( cpu_phi       ),
	.cpu_phi_r_ce ( cpu_phi_r_ce  ),
	.cpu_phi_f_ce ( cpu_phi_f_ce  ),
	
	.lcd_on      ( lcd_on        ),
	.lcd_clkena  ( lcd_clkena    ),
	.lcd_data    ( lcd_data      ),
	.lcd_data_gb ( lcd_data_gb   ),
	.mode        ( lcd_mode      ),
	.lcd_vsync   ( lcd_vsync     ),

	.oam_cpu_allow  ( oam_cpu_allow  ),
	.vram_cpu_allow ( vram_cpu_allow ),
	.vram_rd     ( video_rd      ),
	.vram_addr   ( video_addr    ),
	.vram_data   ( vram_do       ),
	
	// vram connection bank1 (GBC)
	.vram1_data  ( vram1_do      ),
	
	.dma_rd      ( dma_rd        ),
	.dma_addr    ( dma_addr      ),
	.dma_data    ( dma_data      ),

	.extra_spr_en( extra_spr_en  ),
	.extra_wait  ( (isGBC & hdma_rd) | dma_rd | sel_vram ),
   
   .Savestate_OAMRAMAddr      (Savestate_RAMAddr[7:0]),
   .Savestate_OAMRAMRWrEn     (Savestate_RAMRWrEn[2]),
   .Savestate_OAMRAMWriteData (Savestate_RAMWriteData[7:0]),
   .Savestate_OAMRAMReadData  (Savestate_RAMReadData_ORAM),
	
	.SaveStateBus_Din  (SaveStateBus_Din ), 
	.SaveStateBus_Adr  (SaveStateBus_Adr ),
	.SaveStateBus_wren (SaveStateBus_wren),
	.SaveStateBus_rst  (SaveStateBus_rst ),
	.SaveStateBus_Dout (ss_unused_4)
);

// total 8k/16k (CGB) vram from $8000 to $9fff
wire cpu_wr_vram = sel_vram && !cpu_wr_n && vram_cpu_allow;



wire [7:0] vram_di = (hdma_read_wram_bus) ? wram_do :
                        (hdma_read_ext_bus) ? ext_bus_di :
                        cpu_do;

wire vram_wren  = video_rd ? 1'b0 : !vram_bank && ((hdma_rd & isGBC & ~phi_2m) | cpu_wr_vram);
wire vram1_wren = video_rd ? 1'b0 :  vram_bank && ((hdma_rd & isGBC & ~phi_2m) | cpu_wr_vram);

wire [15:0] hdma_target_addr;
assign vram_addr = video_rd?video_addr:(hdma_rd&&isGBC)?hdma_target_addr[12:0]:(dma_rd&&dma_sel_vram)?dma_addr[12:0]:cpu_addr[12:0];

// Video RAM, 8K (+ 8K bank 1 on the GBC).  The MiSTer core clocks these
// RAMs with clk_sys & ce_cpu, which rises just after the clk_sys edge that
// starts a ce_cpu cycle; here they take the falling edge of clk_sys in that
// cycle, which sees the same values.
reg [7:0] vram0_m [0:8191];
reg [7:0] vram1_m [0:8191];
reg [7:0] vram_do_r, vram1_do_r;
assign vram_do = vram_do_r;
assign vram1_do = vram1_do_r;

always @(negedge clk_sys) begin
	if (ce_cpu) begin
		if (vram_wren) vram0_m[vram_addr] <= vram_di;
		vram_do_r <= vram0_m[vram_addr];
	end
end

always @(negedge clk_sys) begin
	if (ce_cpu) begin
		if (vram1_wren) vram1_m[vram_addr] <= vram_di;
		vram1_do_r <= vram1_m[vram_addr];
	end
end

//GBC VRAM banking

assign SS_Top_BACK[22] = vram_bank;

always @(posedge clk_sys) begin
	if(reset_ss)
		vram_bank <= SS_Top[22]; // 1'd0;
	else if (ce_cpu) begin
		if((cpu_addr == 16'hff4f) && !cpu_wr_n_edge && isGBC)
			vram_bank <= cpu_do[0];
	end
end

// --------------------------------------------------------------------
// -------------------------- HDMA engine(GBC) ------------------------
// --------------------------------------------------------------------

hdma hdma(
	.reset	          ( reset_ss         ),
	.clk		          ( clk_sys       ),
	.ce                ( ce_cpu         ),
	.speed				 ( cpu_speed     ),
	
	// cpu register interface
	.sel_reg 	       ( sel_hdma      ),
	.addr			       ( cpu_addr[3:0] ),
	.wr			       ( !cpu_wr_n_edge   ),
	.dout			       ( hdma_do       ),
	.din               ( cpu_do        ),

	.cpu_phi_r_ce      ( cpu_phi_r_ce  ),
	.cpu_phi_f_ce      ( cpu_phi_f_ce  ),
	.hdma_phi_r_ce     ( hdma_phi_r_ce ),
	.hdma_phi_f_ce     ( hdma_phi_f_ce ),

	.lcd_mode          ( lcd_mode      ),
	
	// dma connection
	.hdma_rd           ( hdma_rd          ),
	.hdma_source_addr  ( hdma_source_addr ),
	.hdma_target_addr  ( hdma_target_addr ),
	
	.SaveStateBus_Din  (SaveStateBus_Din ), 
	.SaveStateBus_Adr  (SaveStateBus_Adr ),
	.SaveStateBus_wren (SaveStateBus_wren),
	.SaveStateBus_rst  (SaveStateBus_rst ),
	.SaveStateBus_Dout (ss_unused_2)
);

// --------------------------------------------------------------------
// -------------------------- zero page ram ---------------------------
// --------------------------------------------------------------------

// 127 bytes internal zero page ram from $ff80 to $fffe
wire cpu_wr_zpram = sel_zpram && !cpu_wr_n;

reg [7:0] zpram_m [0:127];
reg [7:0] zpram_do_r;
assign zpram_do = zpram_do_r;

always @(negedge clk_sys) begin
	if (ce_cpu) begin
		if (cpu_wr_zpram) zpram_m[cpu_addr[6:0]] <= cpu_do;
		zpram_do_r <= zpram_m[cpu_addr[6:0]];
	end
end

// --------------------------------------------------------------------
// -------------------------- 8k/32k(GBC) work ram  -------------------
// --------------------------------------------------------------------

// Separate WRAM bus on GBC.
assign hdma_read_wram_bus = (isGBC & hdma_rd & hdma_sel_wram);
wire dma_read_wram_bus = (dma_rd & dma_sel_wram);

wire wram_wren = ~isGBC ? (ext_bus_wram_sel & ext_bus_wr) :
                    (sel_wram & ~cpu_wr_n_edge & ~hdma_read_wram_bus & ~dma_read_wram_bus);

wire [12:0] wram_addr_i = ~isGBC ? ext_bus_addr[12:0] :
                            hdma_read_wram_bus ? hdma_source_addr[12:0] :
                                dma_read_wram_bus ? dma_addr[12:0] :
                                cpu_addr[12:0];

// 0 -> 1
wire [2:0] wram_bank_o = (!wram_bank ? 3'd1 : wram_bank);
assign wram_addr = (wram_addr_i[12]) ? { wram_bank_o, wram_addr_i[11:0] }  // bank 1-7 $D000-DFFF
                                       : {        3'd0, wram_addr_i[11:0] }; // bank 0   $C000-CFFF

// The MiSTer core writes its WRAM at the ce_cpu edges where wram_wren is high.
assign wram_we = wram_wren & ce_cpu;
assign wram_wdata = cpu_do;
assign wram_do = wram_rdata;

//GBC WRAM banking
assign SS_Top_BACK[2:0] = wram_bank;

always @(posedge clk_sys) begin
	if(reset_ss)
		wram_bank <= SS_Top[2:0]; // 3'd0;
	else if(ce_cpu && sel_wram_bank && !cpu_wr_n_edge) begin
		wram_bank <= cpu_do[2:0];
	end
end

// --------------------------------------------------------------------
// ------------------------ internal boot rom -------------------------
// --------------------------------------------------------------------

// writing 01(GB) or 11(GBC) to $ff50 disables the internal rom

assign SS_Top_BACK[23] = boot_rom_enabled;

always @(posedge clk_sys) begin
	if(reset_ss)
		boot_rom_enabled <= !boot_rom_off;
	else if (ce) begin
		if((cpu_addr == 16'hff50) && !cpu_wr_n_edge && cpu_do[0]) begin
			boot_rom_enabled <= 1'b0;
		end
	end
end
			
// combine boot rom data with cartridge data

wire [15:0] boot_rom_addr = (isGBC && hdma_rd) ? hdma_source_addr : cpu_addr;

//  0- FF bootrom 1st part
//100-1FF Cart Header
//200-8FF bootrom 2nd part
assign sel_boot_rom_cgb = isGBC && (boot_rom_addr[15:8] >= 8'h02 && boot_rom_addr[15:8] <= 8'h08);
assign sel_boot_rom = boot_rom_enabled && (!boot_rom_addr[15:8] || sel_boot_rom_cgb) && ~megaduck;


// $000-8FF: GBC
// $900-9FF: DMG
wire [11:0] boot_addr =
        isGBC ? boot_rom_addr[11:0] :
        { 4'h9, boot_rom_addr[7:0] };

// The SameBoy-based boot ROMs from the MiSTer core (MIT license).
reg [7:0] boot_rom_m [0:2559];
initial $readmemh("gb_boot.hex", boot_rom_m);

reg [7:0] boot_q;
always @(posedge clk_sys)
	boot_q <= boot_rom_m[boot_addr];

assign boot_do = boot_q;
// --------------------------------------------------------------------
// ------------------ External bus (WRAM, Cartridge) ------------------
// --------------------------------------------------------------------

// Emulate cartridge open bus behavior.
// Some games read from Cart RAM while it is disabled or not present and
// expect to read the previous ROM byte instead of $FF otherwise they freeze.
// Ex. Tokyo Disneyland - Fantasy Tour (in Minnie's house) and
// Daiku no Gen-san - Kachikachi no Tonkachi ga Kachi (Stage 1-4)

reg [7:0] open_bus_data;
reg [2:0] open_bus_cnt;

assign SS_Top2_BACK[ 7: 0] = open_bus_data;
assign SS_Top2_BACK[10: 8] = open_bus_cnt;

always @(posedge clk_sys) begin
	if(reset_ss) begin
		open_bus_data <= SS_Top2[ 7: 0]; // 8'd0;
		open_bus_cnt  <= SS_Top2[10: 8]; // 3'd0;
	end else if (ce) begin
		open_bus_data <= ext_bus_di;
		if ( (~isGBC & ext_bus_wram_sel) | (cart_sel & cart_oe) ) begin
			open_bus_cnt <= 0;
		end else if (~&open_bus_cnt) begin
			open_bus_cnt <= open_bus_cnt + 1'b1;
			if (open_bus_cnt == 3'd4) open_bus_data <= 8'hFF; // Slow pull-up
		end
	end
end

assign cart_di = cpu_do;

assign hdma_read_ext_bus = (isGBC & hdma_rd & hdma_sel_ext_bus);
wire dma_read_ext_bus = (dma_rd & dma_sel_ext_bus);

assign nCS = ~( hdma_read_ext_bus ? hdma_sel_cram : dma_read_ext_bus ? dma_sel_ext_ram : (sel_cram | sel_wram) );

wire [15:0] ext_bus_i = hdma_read_ext_bus ? hdma_source_addr : dma_read_ext_bus ? dma_addr : cpu_addr;

// External A15 is not directly connected to internal A15. It does not go low when accessing the boot rom.
assign ext_bus_a15 = ext_bus_i[15] | sel_boot_rom;
assign ext_bus_addr = ext_bus_i[14:0];

assign ext_bus_rd = hdma_read_ext_bus | dma_read_ext_bus | (sel_ext_bus & ~cpu_rd_n);
assign ext_bus_wr = (sel_ext_bus & ~cpu_wr_n) & ~hdma_read_ext_bus & ~dma_read_ext_bus;

assign ext_bus_wram_sel = ~nCS &  ext_bus_addr[14];
assign ext_bus_cram_sel = ~nCS & ~ext_bus_addr[14];
assign ext_bus_rom_sel  = ~ext_bus_a15;

assign ext_bus_di = (~isGBC & ext_bus_wram_sel) ? wram_do :
                        (cart_sel & cart_oe) ? cart_do : open_bus_data;

assign cart_sel = ext_bus_rom_sel | ext_bus_cram_sel;
assign cart_rd = cart_sel & ext_bus_rd;
assign cart_wr = cart_sel & ext_bus_wr;



assign DMA_on = cart_sel & (hdma_rd | dma_rd);

endmodule
