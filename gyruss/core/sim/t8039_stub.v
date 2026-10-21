// Simulation stand-in for the T48 8039 (GHDL cannot convert t48_core to
// Verilog for the simulator): an idle MCU with its ports high.
module t8039_notri
   ( input  xtal_i, input xtal_en_i, input reset_n_i
   , input  t0_i, output t0_o, output t0_dir_o
   , input  int_n_i, input ea_i
   , output rd_n_o, output psen_n_o, output wr_n_o, output ale_o
   , input  [7:0] db_i, output [7:0] db_o, output db_dir_o
   , input  t1_i
   , input  [7:0] p2_i, output [7:0] p2_o, output p2l_low_imp_o, output p2h_low_imp_o
   , input  [7:0] p1_i, output [7:0] p1_o, output p1_low_imp_o
   , output prog_n_o
   );
assign t0_o = 1'b0; assign t0_dir_o = 1'b0;
assign rd_n_o = 1'b1; assign psen_n_o = 1'b1; assign wr_n_o = 1'b1; assign ale_o = 1'b0;
assign db_o = 8'hff; assign db_dir_o = 1'b0;
assign p2_o = 8'hff; assign p2l_low_imp_o = 1'b0; assign p2h_low_imp_o = 1'b0;
assign p1_o = 8'h80; assign p1_low_imp_o = 1'b0; assign prog_n_o = 1'b1;
endmodule
