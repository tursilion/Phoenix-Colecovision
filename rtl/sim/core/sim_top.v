// Simulation top: the ColecoVision core (gen/cv.v, from the VHDL) with its
// SRAM data bus split for the testbench's SRAM model.
module sim_top
  ( input         clk
  , input         clk_3m58_en
  , input         por_n
  , input   [2:1] p1, p2, p3, p4, p6, p7, p9
  , output        p5, p8
  , input         sd_miso
  , output        sd_mosi, sd_sclk, sd_cs_n
  , output [18:0] sram_addr
  , output  [7:0] sram_wdata
  , input   [7:0] sram_rdata
  , output        sram_we_n, sram_ce_n
  , output        led
  , output [14:0] cpu_a     // the CPU address (from the cartridge port)
  , output        cart_en_n // any cartridge window enabled (low)
  // internal signals, for tracing
  , output        dbg_m1_n
  , output [15:0] dbg_addr
  , output        dbg_clken
  , output        dbg_loader
  , output  [7:0] dbg_din
  , output        dbg_iorq_n, dbg_wr_n, dbg_sdcs_n
  , output  [7:0] dbg_dout
  , output  [7:0] dbg_ext, dbg_mux
  , output        dbg_mreq_n, dbg_ext_en
  , output  [5:0] dbg_mc_bank
  , output        dbg_rd_n, dbg_cwait_n
  , output  [2:0] dbg_tstate, dbg_mcycle
  , output  [7:0] dbg_rom_page, dbg_mask
  , output  [5:0] dbg_c_line
  , output        dbg_c_hit
  );
assign dbg_rom_page = cv.rom_page_s;
assign dbg_mask     = cv.mc_mem_size_r;
assign dbg_c_line   = cv.c_line_s;
assign dbg_c_hit    = cv.cache.c_hit;
assign dbg_tstate = cv.inst_t80.tstate;
assign dbg_mcycle = cv.inst_t80.mcycle;
assign dbg_mc_bank = cv.mc_bank_r;
assign dbg_rd_n    = cv.rd_n_s;
assign dbg_cwait_n = cv.cache_wait_n_s;
assign dbg_ext    = cv.d_from_ext512_s;
assign dbg_mux    = cv.cpu_data_mux_s;
assign dbg_mreq_n = cv.mreq_n_s;
assign dbg_ext_en = cv.ext_ram_en_s;
assign dbg_iorq_n = cv.iorq_n_s;
assign dbg_wr_n   = cv.wr_n_s;
assign dbg_sdcs_n = cv.sd_cs_n_s;
assign dbg_dout   = cv.d_from_cpu_s;
assign dbg_m1_n   = cv.m1_n_s;
assign dbg_addr   = cv.cpu_addr_s;
assign dbg_clken  = cv.clk_en_cpu_s;
assign dbg_loader = cv.rom_loader_en_r;
assign dbg_din    = cv.d_to_cpu_s;

wire [7:0] sram_bus;
wire [7:0] cart_bus;
wire       sram_oe_n;
wire       e80, ea0, ec0, ee0;
assign cart_en_n = e80 & ea0 & ec0 & ee0;
// (Verilator does not resolve the netlist's tri-state data buses: the
// Makefile makes them inputs, the write data comes from ext512x8sram's
// register, and the bus always has the read data)
assign sram_bus   = sram_rdata;
assign sram_wdata = cv.ext512.d_to_ext_r;

colecovision cv
  ( .clk_25m0_i (clk), .clk_100m0_i (clk), .clk_3m58_en_i (clk_3m58_en)
  , .reset_i (1'b0), .por_n_i (por_n)
  , .ctrl_p1_i (p1), .ctrl_p2_i (p2), .ctrl_p3_i (p3), .ctrl_p4_i (p4)
  , .ctrl_p6_i (p6), .ctrl_p7_i (p7), .ctrl_p9_i (p9)
  , .ctrl_p5_o (p5), .ctrl_p8_o (p8)
  , .sd_miso_i (sd_miso), .sd_cd_n_i (1'b0)
  , .kbd_byte_i (8'd0), .kbd_stb_i (1'b0)
  , .cart_addr_o (cpu_a), .cart_dir_o (), .cart_data_io (cart_bus), .cart_oe_n_o ()
  , .cart_en_80_n_o (e80), .cart_en_a0_n_o (ea0), .cart_en_c0_n_o (ec0), .cart_en_e0_n_o (ee0)
  , .pcm16_o (), .blank_o (), .hsync_n_o (), .vsync_n_o (), .red_o (), .grn_o (), .blu_o ()
  , .sram_addr_o (sram_addr), .sram_data_io (sram_bus), .sram_ce_n_o (sram_ce_n)
  , .sram_oe_n_o (sram_oe_n), .sram_we_n_o (sram_we_n)
  , .sd_mosi_o (sd_mosi), .sd_sclk_o (sd_sclk), .sd_cs_n_o (sd_cs_n)
  , .kbd_mode_o (), .led_o (led)
  );

endmodule
