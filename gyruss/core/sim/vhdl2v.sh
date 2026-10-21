#!/bin/bash
# Convert the VHDL parts (cpu09) to Verilog for Verilator, with the
# GHDL plugin of Yosys (OSS CAD Suite).  Run from sim/.  GHDL 4.0-dev
# crashes on t48_core, so the 8039 is a stub in simulation (t8039_stub.v).
set -e
mkdir -p obj_vhdl
yosys -q -m ghdl -p "ghdl --std=93c -fsynopsys -fexplicit ../rtl/cpu09/cpu09.vhd -e cpu09; proc; opt_clean; write_verilog -noattr obj_vhdl/cpu09.v"
