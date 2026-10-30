#!/usr/bin/env python3
"""Build the save test cartridges.

    mksave.py code.bin logo-source.gb outdir

SAVE32.GB: MBC5 + RAM + battery, 64K ROM, 32K RAM.
SAVE8.GB:  MBC1 + RAM + battery, 64K ROM, 8K RAM.
"""
import os
import sys

code = open(sys.argv[1], 'rb').read()[:0x8000]
logo = open(sys.argv[2], 'rb').read()[0x104:0x134]
for name, mbc, ram in (('SAVE32', 0x1B, 0x03), ('SAVE8', 0x03, 0x02)):
    rom = bytearray(0x10000)
    rom[:len(code)] = code
    rom[0x104:0x134] = logo
    rom[0x134:0x134 + len(name)] = name.encode()
    rom[0x147] = mbc
    rom[0x148] = 0x01           # 64K
    rom[0x149] = ram
    x = 0
    for b in rom[0x134:0x14D]:
        x = (x - b - 1) & 0xFF
    rom[0x14D] = x
    open(os.path.join(sys.argv[3], name + '.GB'), 'wb').write(rom)
