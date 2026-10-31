#!/usr/bin/env python3
"""Build the ColecoVision ROM cache test images.

    mkcart.py megacart.bin sgm.bin CACHE1M.ROM CACHE2M.SGM

The .bin files are main.c linked at $8000 (64K images, from makebin).
Each 8K page p of an image starts with LD A,p / RET, then a pattern; the
program's page has the 16-bit sum of each 1K block of each page at $9000.

  CACHE1M.ROM: 1M MegaCart, the program in the last 16K bank (pages 126,
  127), which the core shows at $8000.  On odd pages (shown at $E000)
  block 7's sum leaves out the last 64 bytes ($FFC0-$FFFF switch banks).
  CACHE2M.SGM: 2M SGM image, the program in page 0.
"""
import sys


def page(p):
    b = bytearray(((p * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55)) & 0xFF for o in range(0x2000))
    b[0:3] = bytes([0x3E, p & 0xFF, 0xC9])
    return b


def build(code, npages, code_page, code_len, odd_short):
    img = bytearray()
    for p in range(npages):
        img += page(p)
    c = code[0x8000:0x8000 + code_len]
    assert all(x in (0, 0xFF) for x in c[0x1000:0x2000]), 'code over $9000'
    img[code_page * 0x2000:code_page * 0x2000 + code_len] = c
    sums = bytearray(npages * 16)
    for p in range(npages):
        for b in range(8):
            a = p * 0x2000 + b * 0x400
            n = 0x3C0 if (odd_short and p & 1 and b == 7) else 0x400
            s = sum(img[a:a + n]) & 0xFFFF
            sums[16 * p + 2 * b] = s & 0xFF
            sums[16 * p + 2 * b + 1] = s >> 8
    t = code_page * 0x2000 + 0x1000
    img[t:t + len(sums)] = sums
    return img


mc = open(sys.argv[1], 'rb').read()
sg = open(sys.argv[2], 'rb').read()
# Sums of the code pages include the table itself; the test does not check them.
open(sys.argv[3], 'wb').write(build(mc, 128, 126, 0x4000, True))
open(sys.argv[4], 'wb').write(build(sg, 256, 0, 0x2000, False))
