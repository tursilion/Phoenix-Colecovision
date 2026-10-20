"""List the configuration packets of a Spartan-6 bitstream and check its CRCs.

    python parse.py file [header_bytes]

header_bytes defaults to 256 for .PHX files and 0 otherwise. Prints every register write
(COR1/COR2, watchdog, multiboot GENERAL1-5, ...), the size of each frame-data block, and
whether the stored auto-CRC and CRC words match a recomputation (see s6crc.py).
"""
import os, struct, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import s6crc

REG = {0: 'CRC', 1: 'FAR_MAJ', 2: 'FAR_MIN', 3: 'FDRI', 4: 'FDRO', 5: 'CMD', 6: 'CTL', 7: 'MASK',
       8: 'STAT', 9: 'LOUT', 10: 'COR1', 11: 'COR2', 12: 'PWRDN', 13: 'FLR', 14: 'IDCODE',
       15: 'CWDT', 16: 'HC_OPT', 18: 'CSBO', 19: 'GEN1', 20: 'GEN2', 21: 'GEN3', 22: 'GEN4',
       23: 'GEN5', 24: 'MODE', 25: 'PU_GWE', 26: 'PU_GTS', 27: 'MFWR', 28: 'CCLK_FREQ',
       29: 'SEU_OPT', 30: 'EXP_SIGN', 31: 'RDBK_SIGN', 32: 'BOOTSTS', 33: 'EYE_MASK', 34: 'CBC_REG'}
CMD = {0: 'NULL', 1: 'WCFG', 2: 'MFW', 3: 'LFRM', 4: 'RCFG', 5: 'START', 7: 'RCRC', 8: 'AGHIGH',
       10: 'GRESTORE', 11: 'SHUTDOWN', 13: 'DESYNC', 14: 'IPROG'}

path = sys.argv[1]
hdr = int(sys.argv[2]) if len(sys.argv) > 2 else (256 if path.upper().endswith('.PHX') else 0)
raw = open(path, 'rb').read()
if hdr:
    print('header: %r issue %d' % (raw[:16].rstrip(b' \0').decode('latin-1'),
                                  struct.unpack_from('<H', raw, 16)[0]))
d = raw[hdr:]

block = None
pending = []
for kind, reg, w, off in s6crc.words(d):
    if kind == 'auto':
        print('  FDRI block: %d words (%d frames) ending at %d' % (block[1], block[1] // 65, off))
        block = None
        continue
    if reg == 3:                                     # frame data: summarise, don't list
        block = (off, (block[1] + 1) if block else 1)
        continue
    pending.append((reg, w))
    if reg in (14, 30, 1, 0) and len([p for p in pending if p[0] == reg]) < 2:
        continue                                     # two-word registers
    vals = ' '.join('%04x' % v for _, v in pending)
    name = REG.get(reg, str(reg))
    if reg == 5:
        vals += ' (%s)' % CMD.get(pending[-1][1], '?')
    print('  %-9s %s' % (name, vals))
    pending = []

ok = True
for kind, off, calc, stored in s6crc.check(d)[0]:
    good = calc == stored
    ok &= good
    print('  %s at %d: stored %06x computed %06x %s' % (kind, off, stored, calc, 'ok' if good else 'MISMATCH'))
print('CRCs %s' % ('all valid' if ok else 'INVALID'))
