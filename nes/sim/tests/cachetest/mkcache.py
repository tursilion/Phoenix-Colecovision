#!/usr/bin/env python3
"""Build CACHETST.NES, the NES ROM cache test cartridge.

    mkcache.py code.bin font.c out.nes

code.bin is main.c linked at $E000 (the last 8K PRG page).  MMC3, 512K PRG
(64 8K pages), 256K CHR.  Page p (0-62) starts with LDA #p / LDX #0 / RTS,
then a pattern; the last page has the 16-bit sum of each 1K block of each
page at $FA00 + 2 (8p + b).  The CHR's first 4K has the font (ASCII 32-122).
"""
import re
import sys

code = open(sys.argv[1], 'rb').read()
assert len(code) == 0x2000
font = bytes(int(x, 16) for x in re.findall(r'0x([0-9A-Fa-f]{2})', open(sys.argv[2]).read()))
assert len(font) == 91 * 8

prg = bytearray(0x80000)
for p in range(63):
    for o in range(0x2000):
        prg[p * 0x2000 + o] = ((p * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55)) & 0xFF
    prg[p * 0x2000:p * 0x2000 + 5] = bytes([0xA9, p, 0xA2, 0x00, 0x60])
prg[0x7E000:] = code
for p in range(63):
    for b in range(8):
        a = p * 0x2000 + b * 0x400
        s = sum(prg[a:a + 0x400]) & 0xFFFF
        t = 0x7FA00 - 0x7E000 + 0x7E000 + 2 * (8 * p + b)
        prg[t] = s & 0xFF
        prg[t + 1] = s >> 8

chr_ = bytearray(0x40000)
for c in range(32, 123):
    chr_[c * 16:c * 16 + 8] = font[(c - 32) * 8:(c - 31) * 8]

hdr = bytes([0x4E, 0x45, 0x53, 0x1A, 32, 32, 0x40, 0x00]) + bytes(8)
open(sys.argv[3], 'wb').write(hdr + prg + chr_)
