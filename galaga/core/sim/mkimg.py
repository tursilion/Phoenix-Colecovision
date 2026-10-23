#!/usr/bin/env python3
"""Make a FAT32 SD card image for the simulation.

  mkimg.py IMAGE [DIR/]NAME=FILE ...

The volume is 64MB with 512-byte clusters (so Petit FatFs sees FAT32).
Files go in the root folder or in one level of folders (DIR/NAME).
"""

import struct
import sys

SECT = 512
TOTAL = 131072 + 2048            # sectors
RESERVED = 32
SPC = 1                          # sectors per cluster
FATSZ = 1024
NCLUST = TOTAL - RESERVED - 2 * FATSZ

DATA0 = RESERVED + 2 * FATSZ     # cluster 2


def dirent(name, attr, clus, size):
    base, ext = (name.split('.') + [''])[:2]
    return struct.pack('<8s3sBBBHHHHHHHI', base.ljust(8).encode(), ext.ljust(3).encode(),
                       attr, 0, 0, 0, 0, 0, clus >> 16, 0, 0, clus & 0xFFFF, size)


def main():
    img_path = sys.argv[1]
    tree = {}                    # folder ('' = root) -> [(name, data)]
    for x in sys.argv[2:]:
        n, p = x.split('=', 1)
        n = n.upper()
        d, _, n = n.rpartition('/')
        tree.setdefault(d, []).append((n, open(p, 'rb').read()))
    tree.setdefault('', [])

    fat = [0] * (NCLUST + 2)
    fat[0], fat[1] = 0x0FFFFFF8, 0x0FFFFFFF
    nxt = [2]
    blobs = []                   # (chain, data)

    def alloc(nbytes):
        nc = max(1, (nbytes + SECT * SPC - 1) // (SECT * SPC))
        chain = list(range(nxt[0], nxt[0] + nc))
        nxt[0] += nc
        for a, b in zip(chain, chain[1:]):
            fat[a] = b
        fat[chain[-1]] = 0x0FFFFFFF
        return chain

    root_chain = alloc(SECT * SPC)
    root = b''
    for d in sorted(k for k in tree if k):
        files = tree[d]
        dsize = (len(files) + 2) * 32
        dchain = alloc(dsize)
        ents = dirent('.', 0x10, dchain[0], 0) + dirent('..', 0x10, 0, 0)
        for name, data in files:
            ch = alloc(len(data))
            ents += dirent(name, 0x20, ch[0], len(data))
            blobs.append((ch, data))
        blobs.append((dchain, ents))
        root += dirent(d, 0x10, dchain[0], 0)
    for name, data in tree['']:
        ch = alloc(len(data))
        root += dirent(name, 0x20, ch[0], len(data))
        blobs.append((ch, data))
    blobs.append((root_chain, root))

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
        for chain, data in blobs:
            for i, c in enumerate(chain):
                part = data[i * SECT * SPC:(i + 1) * SECT * SPC]
                if part:
                    f.seek((DATA0 + (c - 2) * SPC) * SECT)
                    f.write(part)


if __name__ == '__main__':
    main()
