"""Spartan-6 configuration CRC (22-bit), derived empirically from ISE 14.7 bitstreams.
Per register write word: c = shl22(c) ^ ((reg << 16) | data), feedback taps 0x9081.
RCRC (CMD=7) clears it. Type-2 (FDRI) blocks are followed by a 2-word auto-CRC."""
import struct
P=0x9081; M=(1<<22)-1
def upd(c,reg,w):
    t=c>>21; c=((c<<1)&M)^(P if t else 0)
    return c^((reg<<16)|w)
def words(d):
    i=d.find(b'\xaa\x99\x55\x66'); p=i+4
    while p+2<=len(d):
        h=struct.unpack('>H',d[p:p+2])[0]; p+=2; t=h>>13
        if t==1:
            op=(h>>11)&3; reg=(h>>5)&0x3f; n=h&0x1f
            for k in range(n):
                if op==2: yield 'w',reg,struct.unpack('>H',d[p+2*k:p+2*k+2])[0],p+2*k
            p+=2*n
        elif t==2:
            reg=(h>>5)&0x3f; n=struct.unpack('>I',d[p:p+4])[0]; p+=4
            for k in range(n): yield 'w',reg,struct.unpack('>H',d[p+2*k:p+2*k+2])[0],p+2*k
            p+=2*n
            yield 'auto',reg,(struct.unpack('>H',d[p:p+2])[0]<<16)|struct.unpack('>H',d[p+2:p+4])[0],p
            p+=4
        elif h==0xffff: continue
        else: return
def check(d,fix=False,variant=0):
    """returns list of (kind, offset, computed, stored); with fix=True returns patched bytes too"""
    d=bytearray(d); c=0; out=[]; crcw=[]
    for kind,reg,w,off in list(words(bytes(d))):
        if kind=='auto':
            out.append(('auto',off,c,w))
            if fix: d[off:off+4]=struct.pack('>HH',c>>16,c&0xffff)
            continue
        if reg==5 and w==7: c=0; continue
        if reg==0:
            crcw.append(off)
            if len(crcw)==2:
                stored=(struct.unpack('>H',d[crcw[0]:crcw[0]+2])[0]<<16)|w
                out.append(('crc',off,c,stored))
                if fix: d[crcw[0]:crcw[0]+2]=struct.pack('>H',c>>16); d[crcw[1]:crcw[1]+2]=struct.pack('>H',c&0xffff)
                crcw=[]
            continue
        c=upd(c,reg,w)
    return out,bytes(d)
