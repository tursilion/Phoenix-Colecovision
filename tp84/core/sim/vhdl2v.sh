#!/bin/bash
# Convert the VHDL parts (cpu09) to Verilog for Verilator, with the
# GHDL plugin of Yosys (OSS CAD Suite).  Run from sim/.
set -e
mkdir -p obj_vhdl
yosys -q -m ghdl -p "ghdl --std=93c -fsynopsys -fexplicit ../rtl/cpu09/cpu09.vhd -e cpu09; proc; opt_clean; write_verilog -noattr obj_vhdl/cpu09.v"
