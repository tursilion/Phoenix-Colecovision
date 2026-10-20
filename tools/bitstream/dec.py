"""Dump the block RAM contents of a Phoenix XC6SLX16 bitstream.

    python dec.py CORE.PHX [outdir]

Prints a summary of every RAMB16 site in frame order and, with outdir, writes each non-empty
site's 2048 data bytes + 256 parity bytes as site_NN.bin (RAMB16 INIT/INITP bit order).
A RAMB8 half of site s holds INIT bits (a // 16) * 32 + half * 16 + a % 16.

Works on .PHX (256-byte header), .bin, and .bit files. bram_map.pkl maps INIT bit -> bit within
a site's 18-frame slice; it was measured from ISE reference builds.
"""
import os, pickle, sys, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import s6crc

HERE = os.path.dirname(os.path.abspath(__file__))
INV = pickle.load(open(os.path.join(HERE, 'bram_map.pkl'), 'rb'))
FRAME = 130                 # bytes per frame
FIRST = 2976                # first BRAM frame within the FDRI data


def fdri_offset(d):
    """file offset of the first FDRI data word"""
    i = d.find(b'\xaa\x99\x55\x66')
    for kind, reg, w, off in s6crc.words(d[i - 16 if i >= 16 else 0:]):
        if kind == 'w' and reg == 3:
            return off + (i - 16 if i >= 16 else 0)
    raise ValueError('no FDRI data')


def decode(d):
    base = fdri_offset(d)
    out = []
    for s in range(32):
        sl = d[base + (FIRST + 18 * s) * FRAME:base + (FIRST + 18 * s + 18) * FRAME]
        bit = lambda q: (sl[q >> 3] >> (7 - (q & 7))) & 1
        v = [bit(INV[p]) for p in range(18432)]
        data = bytes(sum(v[b * 8 + k] << k for k in range(8)) for b in range(2048))
        par = bytes(sum(v[16384 + b * 8 + k] << k for k in range(8)) for b in range(256))
        out.append((data, par))
    return out


if __name__ == '__main__':
    d = open(sys.argv[1], 'rb').read()
    outdir = sys.argv[2] if len(sys.argv) > 2 else None
    if outdir:
        os.makedirs(outdir, exist_ok=True)
    for s, (data, par) in enumerate(decode(d)):
        if any(data) or any(par):
            print('site %2d  md5 %s  nonzero data %4d  parity %3d  %s' % (
                s, hashlib.md5(data + par).hexdigest()[:8], sum(1 for x in data if x),
                sum(1 for x in par if x), data[:16].hex()))
            if outdir:
                open(os.path.join(outdir, 'site_%02d.bin' % s), 'wb').write(data + par)
