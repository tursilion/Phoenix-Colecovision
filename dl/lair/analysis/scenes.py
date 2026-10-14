import sys
rom = open(sys.argv[1], 'rb').read()
w = lambda a: rom[a] | rom[a+1] << 8

INPUT = {0: 'SWORD', 1: 'UP', 2: 'DOWN', 4: 'LEFT', 8: 'RIGHT', 5: 'UP+LEFT', 9: 'UP+RIGHT', 6: 'DOWN+LEFT', 0xA: 'DOWN+RIGHT'}
SCORE = [w(0x209A + 2*i) for i in range(16)]

# Disc frames per script tick.  The disc's frame numbers count film frames,
# 24000/1001 a second; a tick is an IRQ (16MHz/8/65536 = 30.5176Hz) except
# that the calibration's mode 2 (a standard board) skips one IRQ in 31.
# (Lair: 0.8118.  Matches the ~0.815 measured from seamless jumps.)
TICK = (24000 / 1001) / (16e6 / 8 / 65536) * 31 / 30
def fr(start, ticks):
    return start + int(round(TICK * ticks))
def frange(h):
    if h['h4'] & 0x10:
        return '%5d (still)' % h['frame']
    return '%5d-%-5d  ' % (h['frame'], max(h['frame'], fr(h['frame'], h['timeout']) - 1))

def tgt(t):
    if t == 0xFF: return '--'
    if t & 0x80: return 'SCENE %02X' % (t & 0x7F)
    return 'seq %d' % t

def parse_seq(a):
    """Return (actions, header, end_addr)."""
    acts = []
    while rom[a] & 0x80:
        b0, b1 = rom[a], rom[a+1]; a += 2
        n = ((b0 >> 5) & 3) + 1
        targets = list(rom[a:a+n]); a += n
        fl = None
        if b0 & 0x10:
            fl = rom[a]; a += 1
        nph = b1 & 3
        cnt = list(rom[a:a+nph+1]); a += nph + 1
        acts.append(dict(b0=b0, b1=b1, inp=b0 & 0xF, targets=targets, flags=fl, cnt=cnt))
    h = rom[a:a+7]
    hdr = dict(h0=h[0], next=h[1], timeout=h[2] | h[3] << 8, h4=h[4], frame=h[5] | h[6] << 8)
    return acts, hdr, a + 7

def fmt_seq(idx, a):
    acts, h, end = parse_seq(a)
    o = []
    f0 = []
    if h['h0'] & 0x10: f0.append('DEATH')
    if h['h0'] & 0x20: f0.append('AFTERDEATH')
    if h['h0'] & 0x40: f0.append('ATTRACT')
    if h['h0'] & 0x80: f0.append('h0.7')
    sc = SCORE[h['h0'] & 0xF]
    f4 = []
    for b, nm in [(0, 'cheat-ok'), (1, 'b1'), (2, 'b2'), (3, 'b3'), (4, 'STILL'), (5, 'b5'), (6, 'b6'), (7, 'NOSEEK')]:
        if h['h4'] & (1 << b): f4.append(nm)
    o.append(('  seq %2d @%04X  frame %s timeout %4d -> %-9s score %4d  %-21s' % (
        idx, a, frange(h), h['timeout'], tgt(h['next']), sc,
        ' '.join(f0 + (['[' + ' '.join(f4) + ']'] if f4 else [])))).rstrip())
    for ac in acts:
        # window schedule
        t = 0
        sched = []
        t += ac['cnt'][0]
        sel = ac['b1'] >> 2
        for ph in range(1, len(ac['cnt'])):
            k = sel & 3; sel >>= 2
            dest = ac['targets'][k] if k < len(ac['targets']) else None
            dl = ''
            if ac['flags'] is not None and dest is not None:
                bit = 7 if k == 0 else 6 if k == 1 else 5
                if ac['flags'] & (1 << bit): dl = '(wait)'
            sched.append('%3d-%-3d %-13s %-15s' % (t, t + ac['cnt'][ph], '[%d-%d]' % (fr(h['frame'], t), fr(h['frame'], t + ac['cnt'][ph]) - 1), (tgt(dest) if dest is not None else '?') + (' ' + dl if dl else '')))
            t += ac['cnt'][ph]
        o.append(('      %-10s  %s' % (INPUT.get(ac['inp'], 'in%X' % ac['inp']), '  '.join(sched))).rstrip())
    return o, end

ptab = 0x2108
first = w(ptab)
nscenes = (first - ptab) // 2
out = []
for s in range(nscenes):
    sp = w(ptab + 2*s)
    if sp == 0:
        out.append('SCENE %02X: (none)' % s); continue
    # number of sequences: up to next scene table start (heuristic: until a pointer value < 0x2100 or beyond)
    # find seq table length = min over all scene pointers greater than sp
    lim = min([w(ptab + 2*t) for t in range(nscenes) if w(ptab + 2*t) > sp] + [0x8000])
    seqs = []
    a = sp
    while a < lim:
        p = w(a)
        if not (0x2000 <= p < 0x8000): break
        seqs.append(p)
        if p > sp: lim = min(lim, p)
        a += 2
    out.append('SCENE %02X @%04X  (%d seqs)' % (s, sp, len(seqs)))
    for i, p in enumerate(seqs):
        o, _ = fmt_seq(i, p)
        out += o
print('\n'.join(out))
