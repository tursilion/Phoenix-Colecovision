"""Read or replace the 16K service menu ROM inside SERVICE.PHX (2nd batch build) and fix the bitstream CRCs.

Layout (recovered): 8 RAMB16 sites, each split into two RAMB8 halves of 8Kx1.
  data bit k comes from site SITES[k]; half 0 = ROM $0000-$1FFF, half 1 = $2000-$3FFF
  RAMB8 bit a  ->  RAMB16 INIT bit (a // 16) * 32 + half * 16 + a % 16
  RAMB16 INIT bit p  ->  bit INV[p] (MSB first) of that site's 18-frame slice
  site s slice starts at FDRI byte (2976 + 18 * s) * 130; FDRI data starts at file offset 256 + 168
"""
import pickle, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import s6crc

HERE = os.path.dirname(os.path.abspath(__file__))
INV = pickle.load(open(os.path.join(HERE, 'bram_map.pkl'), 'rb'))
SITES = [11, 9, 19, 2, 18, 8, 3, 24]
FDRI = 256 + 168
FRAME = 130


def bitpos(k, addr):
    s = SITES[k]
    half, a = addr >> 13, addr & 0x1FFF
    p = (a // 16) * 32 + half * 16 + a % 16
    q = INV[p]
    return FDRI + (2976 + 18 * s) * FRAME + q // 8, 7 - (q % 8)


def read_rom(phx):
    rom = bytearray(16384)
    for addr in range(16384):
        v = 0
        for k in range(8):
            byte, bit = bitpos(k, addr)
            v |= ((phx[byte] >> bit) & 1) << k
        rom[addr] = v
    return bytes(rom)


def write_rom(phx, rom):
    phx = bytearray(phx)
    for addr in range(16384):
        for k in range(8):
            byte, bit = bitpos(k, addr)
            if (rom[addr] >> k) & 1:
                phx[byte] |= 1 << bit
            else:
                phx[byte] &= ~(1 << bit) & 0xFF
    body = phx[256:]
    _, fixed = s6crc.check(bytes(body), fix=True)
    phx[256:] = fixed
    return bytes(phx)


def crc_ok(phx):
    r, _ = s6crc.check(phx[256:])
    return all(c == s for _, _, c, s in r), r


if __name__ == '__main__':
    cmd = sys.argv[1]
    if cmd == 'read':
        open(sys.argv[3], 'wb').write(read_rom(open(sys.argv[2], 'rb').read()))
    elif cmd == 'write':
        out = write_rom(open(sys.argv[2], 'rb').read(), open(sys.argv[3], 'rb').read())
        open(sys.argv[4], 'wb').write(out)
        print('CRCs', crc_ok(out))
