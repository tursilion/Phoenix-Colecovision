import sys, re
from z80dis import z80
OP = z80.OP
OT = z80.OPER_TYPE

rom = open(sys.argv[1], 'rb').read()
entries = [int(x, 16) for x in sys.argv[2].split(',')]
extra_names = {}
if len(sys.argv) > 3:
    for line in open(sys.argv[3]):
        line = line.split('#')[0].strip()
        if not line: continue
        a, n = line.split(None, 1)
        extra_names[int(a, 16)] = n.strip()

code = {}      # addr -> (len, text, decoded)
labels = set(entries)
calls = set(entries)
todo = list(entries)
xref = {}
while todo:
    pc = todo.pop()
    while 0 <= pc < len(rom) and pc not in code:
        d = z80.decode(rom[pc:pc+4], pc)
        if d.status != z80.DECODE_STATUS.OK:
            break
        code[pc] = d
        nxt = pc + d.len
        op = d.op
        tgt = None
        for t, v in d.operands:
            if t == OT.ADDR:
                tgt = v
        if op in (OP.JP, OP.JR, OP.CALL, OP.DJNZ, OP.RST) and tgt is None and op == OP.RST:
            tgt = d.operands[0][1]
        if op == OP.RST:
            tgt = d.operands[0][1]
        if tgt is not None and op in (OP.JP, OP.JR, OP.CALL, OP.DJNZ, OP.RST):
            labels.add(tgt)
            xref.setdefault(tgt, set()).add(pc)
            if op in (OP.CALL, OP.RST):
                calls.add(tgt)
            todo.append(tgt)
        cond = any(t == OT.COND for t, v in d.operands)
        if op in (OP.JP, OP.JR) and not cond:
            break
        if op in (OP.RET, OP.RETI, OP.RETN) and not cond:
            break
        if op == OP.HALT:
            pass
        pc = nxt

def name(a):
    if a in extra_names: return extra_names[a]
    return ('S%04X' if a in calls else 'L%04X') % a

def fmt(d, pc):
    s = z80.disasm(d)
    # replace hex addresses with labels
    def rep(m):
        v = int(m.group(0), 16)
        if v in labels and v in code:
            return name(v)
        return '%04Xh' % v if v > 0xff else '%02Xh' % v
    s = re.sub(r'0x[0-9a-fA-F]+', rep, s)
    return s

out = []
pc = 0
while pc < len(rom):
    if pc in code:
        d = code[pc]
        if pc in labels:
            x = ''
            if pc in xref:
                x = '   ; xref ' + ' '.join('%04X' % a for a in sorted(xref[pc])[:8])
            out.append('')
            out.append(name(pc) + ':' + x)
        b = ' '.join('%02X' % c for c in rom[pc:pc+d.len])
        out.append('%04X  %-12s  %s' % (pc, b, fmt(d, pc)))
        pc += d.len
    else:
        st = pc
        while pc < len(rom) and pc not in code and pc - st < 16:
            pc += 1
        chunk = rom[st:pc]
        asc = ''.join(chr(c) if 32 <= c < 127 else '.' for c in chunk)
        out.append('%04X  db %-48s ; %s' % (st, ' '.join('%02X' % c for c in chunk), asc))
print('\n'.join(out))
sys.stderr.write('code bytes: %d\n' % sum(d.len for d in code.values()))
