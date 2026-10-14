import sys
rom = open(sys.argv[1], 'rb').read()
w = lambda a: rom[a] | rom[a+1] << 8
INPUT = {0: 'FIRE', 1: 'UP', 2: 'DOWN', 4: 'LEFT', 8: 'RIGHT', 5: 'UP+LEFT', 9: 'UP+RIGHT', 6: 'DOWN+LEFT', 0xA: 'DOWN+RIGHT'}
SCORE = [2 * w(0x2115 + 2*i) for i in range(16)]
PTAB, NSC = 0x2183, (0x21C5 - 0x2183) // 2

# Disc frames per script tick.  The disc's frame numbers count film frames,
# 24000/1001 a second; a tick is an IRQ (16MHz/8/65536 = 30.5176Hz) except
# that the calibration's mode 2 (a standard board) skips one IRQ in 25.
# (Space Ace: 0.8184.  Matches the ~0.815 measured from seamless jumps.)
TICK = (24000 / 1001) / (16e6 / 8 / 65536) * 25 / 24
def fr(start, ticks):
    return start + int(round(TICK * ticks))
def frange(h):
    if h['h4'] & 0x10:
        return '%5d (still)' % h['frame']
    return '%5d-%-5d  ' % (h['frame'], max(h['frame'], fr(h['frame'], h['timeout']) - 1))

def tgt(t):
    if t == 0xFF: return '--'
    if t & 0x80: return 'SLOT %02X' % (t & 0x7F)
    return 'seq %d' % t

def parse_seq(a):
    acts = []
    while rom[a] & 0x80:
        b0, b1 = rom[a], rom[a+1]; a += 2
        n = ((b0 >> 5) & 3) + 1
        targets = list(rom[a:a+n]); a += n
        fl = None
        if b0 & 0x10: fl = rom[a]; a += 1
        nph = b1 & 3
        cnt = list(rom[a:a+nph+1]); a += nph + 1
        acts.append(dict(b0=b0, b1=b1, inp=b0 & 0xF, targets=targets, flags=fl, cnt=cnt))
    h = rom[a:a+7]; a += 7
    hdr = dict(h0=h[0], next=h[1], timeout=h[2] | h[3] << 8, h4=h[4], frame=h[5] | h[6] << 8)
    if hdr['h4'] & 0x20: hdr['alt'] = (rom[a], rom[a+1]); a += 2
    if hdr['h4'] & 0x40: hdr['skip'] = (rom[a], rom[a+1]); a += 2
    if hdr['h4'] & 0x01: hdr['cadet_resume'] = rom[a]; a += 1
    return acts, hdr, a

def fmt_seq(idx, a):
    acts, h, end = parse_seq(a)
    f0 = [nm for b, nm in [(4, 'DEATH'), (5, 'AFTERDEATH'), (6, "ATTRACT"), (7, 'h0.7')] if h['h0'] & (1 << b)]
    f4 = [nm for b, nm in [(1, 'b1'), (2, 'BR-A'), (3, 'BR-B'), (4, 'STILL'), (7, 'NOSEEK')] if h['h4'] & (1 << b)]
    ex = ''
    if 'alt' in h: ex += ' revisit A->%s B->%s' % (tgt(h['alt'][0]), tgt(h['alt'][1]))
    if 'skip' in h: ex += ' captain/ace->scene %02X seq %d' % (h['skip'][0] & 0x7F, h['skip'][1])
    if 'cadet_resume' in h: ex += ' cadet-resume=%02X' % h['cadet_resume']
    o = [('  seq %2d @%04X  frame %s timeout %4d -> %-9s score %4d  %-21s %s' % (
        idx, a, frange(h), h['timeout'], tgt(h['next']), SCORE[h['h0'] & 0xF],
        ' '.join(f0 + (['[' + ' '.join(f4) + ']'] if f4 else [])), ex.strip())).rstrip()]
    for ac in acts:
        t = ac['cnt'][0]; sel = ac['b1'] >> 2; sched = []
        for ph in range(1, len(ac['cnt'])):
            k = sel & 3; sel >>= 2
            dest = ac['targets'][k] if k < len(ac['targets']) else None
            dl = ''
            if ac['flags'] is not None and dest is not None:
                if ac['flags'] & (1 << (7 if k == 0 else 6 if k == 1 else 5)): dl = '(wait)'
            sched.append('%3d-%-3d %-13s %-15s' % (t, t + ac['cnt'][ph], '[%d-%d]' % (fr(h['frame'], t), fr(h['frame'], t + ac['cnt'][ph]) - 1), (tgt(dest) if dest is not None else '?') + (' ' + dl if dl else '')))
            t += ac['cnt'][ph]
        o.append(('      %-10s  %s' % (INPUT.get(ac['inp'], 'in%X' % ac['inp']), '  '.join(sched))).rstrip())
    return o

out = []
names = ['Cadet', 'Captain', 'Space Ace']
for sk in range(3):
    p = w(0x21C5 + 2*sk); l = []
    while rom[p] != 0xFF: l.append('%02X' % (rom[p] & 0x7F)); p += 1
    out.append('%-9s slot order: %s' % (names[sk], ' '.join(l)))
for i in range(0x13):
    a = 0x20A8 + 4*i; p = w(a); f = rom[a+2]
    ch = ' '.join('%02X' % (x & 0x7F) for x in rom[p:p+(f & 7)+1]) if p else '-'
    out.append('slot %02X: flags %02X scenes %s' % (i, f, ch))
out.append('score table (x2): ' + ' '.join(str(s) for s in SCORE))
allp = [w(PTAB + 2*t) for t in range(NSC)]
for s in range(NSC):
    sp = allp[s]
    lim = min([p for p in allp if p > sp] + [0xA000]); seqs = []; a = sp
    while a < lim:
        p = w(a)
        if not (0x2000 <= p < 0xA000): break
        seqs.append(p)
        if p > sp: lim = min(lim, p)
        a += 2
    out.append('SCENE %02X @%04X  (%d seqs)' % (s, sp, len(seqs)))
    for i, p in enumerate(seqs): out += fmt_seq(i, p)
print('\n'.join(out))
