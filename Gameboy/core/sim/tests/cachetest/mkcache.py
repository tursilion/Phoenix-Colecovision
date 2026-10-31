#!/usr/bin/env python3
"""Build CACHETST.GB, the 2M MBC5 ROM cache test cartridge.

    mkcache.py code.bin logo-source.gb out.gb

code.bin is main.c linked at $0150 (bank 0).  The Nintendo logo for the
header comes from logo-source.gb (any Game Boy image).  Each 8K page p of
banks 1-127 (bank p / 2, half p & 1) starts with LD A,n / RET (n = the
bank, | $80 in the second half), then a pattern; bank 0 has the 16-bit
sum of each 1K block b of each page at $3000 + 2 (8p + b).
"""
import sys

code = open(sys.argv[1], 'rb').read()
assert all(b in (0, 0xFF) for b in code[0x3000:0x4000]), 'code over $3000'
logo = open(sys.argv[2], 'rb').read()[0x104:0x134]
rom = bytearray(0x200000)
rom[:min(len(code), 0x3000)] = code[:0x3000]
for n in range(1, 128):
    for o in range(0x4000):
        rom[n * 0x4000 + o] = ((n * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55)) & 0xFF
    for h in range(2):
        b = n * 0x4000 + h * 0x2000
        rom[b:b + 3] = bytes([0x3E, n | (0x80 if h else 0), 0xC9])
for p in range(2, 256):
    for b in range(8):
        a = p * 0x2000 + b * 0x400
        s = sum(rom[a:a + 0x400]) & 0xFFFF
        rom[0x3000 + 2 * (8 * p + b)] = s & 0xFF
        rom[0x3001 + 2 * (8 * p + b)] = s >> 8
rom[0x104:0x134] = logo
title = b'CACHETEST'
rom[0x134:0x134 + 11] = title.ljust(11, b'\0')
rom[0x143] = 0x80           # Game Boy Color, and the original
rom[0x147] = 0x19           # MBC5
rom[0x148] = 0x06           # 2M
rom[0x149] = 0x00           # no RAM
x = 0
for b in rom[0x134:0x14D]:
    x = (x - b - 1) & 0xFF
rom[0x14D] = x
open(sys.argv[3], 'wb').write(rom)
