#!/usr/bin/env python3
"""Build BIG512.GB, the 512K MBC1 test cartridge.

    mkbig.py code.bin logo-source.gb out.gb

code.bin is bigtest.c linked at $0150 (32K image).  The Nintendo logo for
the header comes from logo-source.gb (any Game Boy image).  Each 16K bank n
(1-31) starts with the byte n.
"""
import sys

code = bytearray(open(sys.argv[1], 'rb').read()[:0x4000])
logo = open(sys.argv[2], 'rb').read()[0x104:0x134]
rom = bytearray(0x80000)
rom[:len(code)] = code
rom[0x104:0x134] = logo
title = b'BIG512'
rom[0x134:0x134 + len(title)] = title
rom[0x143] = 0x00           # original Game Boy
rom[0x147] = 0x03           # MBC1 + RAM + battery
rom[0x148] = 0x04           # 512K
rom[0x149] = 0x02           # 8K RAM
x = 0
for b in rom[0x134:0x14D]:
    x = (x - b - 1) & 0xFF
rom[0x14D] = x
for n in range(1, 32):
    rom[n * 0x4000] = n
open(sys.argv[3], 'wb').write(rom)
