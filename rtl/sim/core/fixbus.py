#!/usr/bin/env python3
"""Verilator does not resolve the tri-state data buses of the netlist that
GHDL + Yosys make from the VHDL.  Make them inputs: the SRAM bus drives the
net the SRAM controller reads (the testbench gives it the read data; the
write data comes from ext512x8sram's register, see sim_top.v), and the
cartridge bus is not used.

    fixbus.py gen/cv.v
"""
import re
import sys

p = sys.argv[1]
s = open(p).read()
s = s.replace('  inout [7:0] sram_data_io;', '  input [7:0] sram_data_io;')
s = s.replace('  inout [7:0] cart_data_io;', '  input [7:0] cart_data_io;')
top, rest = s.split('\nendmodule', 1)            # colecovision is first
top = re.sub(r'  assign sram_data_io = (\S+);', r'  assign \1 = sram_data_io;', top)
top = re.sub(r'  assign cart_data_io = \S+;\n', '', top)
rest = re.sub(r'  assign sram_data_io = \S+;\n', '', rest)
open(p, 'w').write(top + '\nendmodule' + rest)
