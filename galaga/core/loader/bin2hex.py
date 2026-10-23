#!/usr/bin/env python3
"""Write a binary as one hex byte per line, for Verilog $readmemh."""
import sys

with open(sys.argv[1], 'rb') as f:
    data = f.read()
with open(sys.argv[2], 'w') as f:
    f.writelines('%02x\n' % b for b in data)
