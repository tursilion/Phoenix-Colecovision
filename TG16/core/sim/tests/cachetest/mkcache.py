#!/usr/bin/env python3
"""Build CACHETST.PCE, the 1M ROM cache test HuCard.

    mkcache.py bank0.bin CACHETST.PCE

Bank 0 is the test program (8K, $E000-$FFFF).  Banks 1-127 start with
LDA #bank / RTS, then a pattern of the bank number and the offset.  The
table at $FE00 (bank 0 offset $1E00) gets each bank's 16-bit byte sum.
"""
import struct
import sys

BANKS = 128
code = bytearray(open(sys.argv[1], 'rb').read())
assert len(code) == 0x2000
rom = bytearray(BANKS * 0x2000)
rom[:0x2000] = code
for b in range(1, BANKS):
    page = bytearray(0x2000)
    page[0:3] = bytes([0xA9, b, 0x60])
    for o in range(3, 0x2000):
        page[o] = ((b * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55)) & 0xFF
    rom[b * 0x2000:(b + 1) * 0x2000] = page
for b in range(BANKS):
    s = sum(rom[b * 0x2000:(b + 1) * 0x2000]) & 0xFFFF
    struct.pack_into('<H', rom, 0x1E00 + 2 * b, s)
open(sys.argv[2], 'wb').write(rom)
