#!/usr/bin/env python3
"""Make a FAT32 SD card image holding files, each stored contiguously, for
the simulation.

  mkimg.py IMAGE NAME=FILE ... [--frag NAME]

The volume is 64MB with 512-byte clusters (131072 clusters, so Petit FatFs
sees FAT32).  Files go in the root folder, one after the other.  --frag
splits that file's cluster chain in two (to test the loader's check).
Prints the first sector of each file.
"""

import struct
import sys

SECT = 512
TOTAL = 131072 + 2048            # sectors
RESERVED = 32
SPC = 1                          # sectors per cluster
NCLUST = 131072 - 2048
FATSZ = (NCLUST + 2) * 4 // SECT + 1
DATA0 = RESERVED + 2 * FATSZ     # cluster 2


def main():
    img_path = sys.argv[1]
    files, frag = [], set()
    args = sys.argv[2:]
    while args:
        x = args.pop(0)
        if x == '--frag':
            frag.add(args.pop(0).upper())
        else:
            n, p = x.split('=', 1)
            files.append((n.upper(), open(p, 'rb').read()))

    fat = [0] * (NCLUST + 2)
    fat[0], fat[1] = 0x0FFFFFF8, 0x0FFFFFFF
    fat[2] = 0x0FFFFFFF                       # root directory, one cluster
    nxt = 3
    entries = b''
    placed = []
    for name, data in files:
        nc = max(1, (len(data) + SECT * SPC - 1) // (SECT * SPC))
        chain = list(range(nxt, nxt + nc))
        nxt += nc
        if name in frag and nc > 2:
            # move the second half of the file 16 clusters further on
            h = nc // 2
            chain = chain[:h] + [c + 16 for c in chain[h:]]
            nxt += 16
        for a, b in zip(chain, chain[1:]):
            fat[a] = b
        fat[chain[-1]] = 0x0FFFFFFF
        base, ext = (name.split('.') + [''])[:2]
        de = struct.pack('<8s3sBBBHHHHHHHI', base.ljust(8).encode(), ext.ljust(3).encode(),
                         0x20, 0, 0, 0, 0, 0, chain[0] >> 16, 0, 0, chain[0] & 0xFFFF, len(data))
        entries += de
        placed.append((name, chain, data))
        print('%s: first sector %d, %d bytes%s' % (name, DATA0 + (chain[0] - 2) * SPC, len(data),
                                                    ' (fragmented)' if name in frag else ''))

    bs = bytearray(SECT)
    bs[0:3] = b'\xEB\x58\x90'
    bs[3:11] = b'PHXSIM  '
    struct.pack_into('<HBHBHHBHHHII', bs, 11, SECT, SPC, RESERVED, 2, 0, 0, 0xF8, 0, 63, 255, 0, TOTAL)
    struct.pack_into('<IHHIHH', bs, 36, FATSZ, 0, 0, 2, 1, 6)
    bs[64] = 0x80
    bs[66] = 0x29
    struct.pack_into('<I', bs, 67, 0x12345678)
    bs[71:82] = b'PHOENIX    '
    bs[82:90] = b'FAT32   '
    bs[510:512] = b'\x55\xAA'

    fsinfo = bytearray(SECT)
    struct.pack_into('<I', fsinfo, 0, 0x41615252)
    struct.pack_into('<I', fsinfo, 484, 0x61417272)
    struct.pack_into('<II', fsinfo, 488, 0xFFFFFFFF, 0xFFFFFFFF)
    fsinfo[510:512] = b'\x55\xAA'

    fatb = struct.pack('<%dI' % len(fat), *fat)
    with open(img_path, 'wb') as f:
        f.truncate(TOTAL * SECT)
        f.seek(0); f.write(bs)
        f.seek(SECT); f.write(fsinfo)
        f.seek(6 * SECT); f.write(bs)
        for k in range(2):
            f.seek((RESERVED + k * FATSZ) * SECT); f.write(fatb)
        f.seek(DATA0 * SECT); f.write(entries)
        for name, chain, data in placed:
            for i, c in enumerate(chain):
                part = data[i * SECT * SPC:(i + 1) * SECT * SPC]
                if part:
                    f.seek((DATA0 + (c - 2) * SPC) * SECT)
                    f.write(part)


if __name__ == '__main__':
    main()
