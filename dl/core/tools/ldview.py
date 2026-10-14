#!/usr/bin/env python3
"""Show frames of a Phoenix laserdisc file (.LD) the way the core decodes
them, to check an encode.

  ldview.py FILE.LD FRAME [FRAME...] [-o prefix]   write PNGs (640x480)
  ldview.py FILE.LD --info                        print the header
"""

import argparse
import struct
import sys

import numpy as np

sys.path.insert(0, __import__('os').path.dirname(__file__))
from mkdisc import HEADER, FRAME_BYTES, OFF_PALETTE, OFF_VIDEO, CW, CH  # noqa: E402


def decode(blk):
    pal16 = np.frombuffer(blk[OFF_PALETTE:OFF_PALETTE + 512], '<u2').astype(np.uint32)
    r = (pal16 >> 11) & 31
    g = (pal16 >> 5) & 63
    b = pal16 & 31
    pal = np.stack([(r << 3) | (r >> 2), (g << 2) | (g >> 4), (b << 3) | (b >> 2)], 1).astype(np.uint8)
    cells = np.frombuffer(blk[OFF_VIDEO:OFF_VIDEO + CW * CH * 8], np.uint8).reshape(CH, CW, 8)
    cols = cells[:, :, 0:4]
    masks = cells[:, :, 4:8]
    sel = np.stack([(masks >> (2 * i)) & 3 for i in range(4)], axis=3)      # (CH,CW,row,x)
    idx = np.take_along_axis(cols[:, :, None, :].repeat(4, 2), sel.astype(np.int64), axis=3)
    img = pal[idx].transpose(0, 2, 1, 3, 4).reshape(CH * 4, CW * 4, 3)
    return img


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('file')
    ap.add_argument('frames', nargs='*', type=int)
    ap.add_argument('--info', action='store_true')
    ap.add_argument('-o', default='frame')
    a = ap.parse_args()

    with open(a.file, 'rb') as f:
        h = HEADER.unpack(f.read(HEADER.size))
        magic, rom_sector, rom_size, frame_sector, last, fs, fmt, da, db, _, title, board = h
        if a.info or not a.frames:
            print('magic %s, ROM %d bytes at sector %d, frames from sector %d, last frame %d'
                  % (magic, rom_size, rom_sector, frame_sector, last))
            print('DSW A %02X, DSW B %02X, title %r' % (da, db, title.rstrip(b'\0').decode()))
            print('scoreboard %r' % board.decode())
        from PIL import Image
        for n in a.frames:
            f.seek(frame_sector * 512 + n * FRAME_BYTES)
            blk = f.read(FRAME_BYTES)
            if len(blk) < FRAME_BYTES:
                print('frame %d is past the end of the file' % n)
                continue
            num = struct.unpack_from('<I', blk, 4)[0]
            img = decode(blk)
            Image.fromarray(img).resize((640, 480), Image.NEAREST).save('%s%05d.png' % (a.o, n))
            print('frame %d (header says %d) -> %s%05d.png' % (n, num, a.o, n))


if __name__ == '__main__':
    main()
