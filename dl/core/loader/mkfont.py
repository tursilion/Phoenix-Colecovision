#!/usr/bin/env python3
"""Make the overlay font ROM (128 characters x 8 rows, $readmemh format)
from font_src.c (ASCII 32-122, the Coleco menu font)."""
import re, sys

src = open(sys.argv[1]).read()
body = src[src.index('{') + 1:src.rindex('}')]
body = re.sub(r'/\*.*?\*/', '', body, flags=re.S)
data = [int(x, 16) for x in re.findall(r'0x([0-9A-Fa-f]{2})', body)]
assert len(data) == (123 - 32) * 8, len(data)
rom = [0] * (128 * 8)
rom[32 * 8:123 * 8] = data
with open(sys.argv[2], 'w') as f:
    f.writelines('%02x\n' % b for b in rom)
