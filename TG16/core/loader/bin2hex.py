#!/usr/bin/env python3
"""Write the 16K loader ($C000-$FFFF) as one hex byte per line, for Verilog
$readmemh, in ROM bank order: the $E000 half (bank 0) first, then the $C000
half (bank 1)."""
import sys

with open(sys.argv[1], 'rb') as f:
    data = f.read()
assert len(data) == 0x4000
data = data[0x2000:] + data[:0x2000]
with open(sys.argv[2], 'w') as f:
    f.writelines('%02x\n' % b for b in data)
