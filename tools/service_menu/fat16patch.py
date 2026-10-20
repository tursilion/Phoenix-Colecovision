"""FAT16 support + FAT fixes for the recovered Phoenix service menu ROM.

New code lives in the unused $2430-$3FFF area; five original entry points are diverted with JPs.
New RAM variables: $40C0-$40C9 (unused by the original code).

  $0571  MBR: pick the first FAT16/FAT32 partition entry instead of always entry 1
  $056D  partitionless volumes: clear the partition base, accept FAT16 as well as FAT32
  $05A0  boot sector type: accept "FAT16   " at 0x36 as well as "FAT32   " at 0x52
  $0605  FAT16 geometry: fixed root directory, 16-bit FAT size
  $06BE  find file: scan the FAT16 fixed root directory
  $081C  next cluster: 16-bit FAT entries for FAT16
  $087F  FAT32 end of chain: mask the top nibble, accept any 0x0FFFFFF7+ marker
  $0737/$06E3  FAT32 directory scan: also check the last sector of the root directory chain
"""
import re, sys
from skoolkit.z80 import Assembler

ORG = 0x2430
EQU = {
    'FATTYPE':  0x40C0,   # 0 = FAT32, 1 = FAT16
    'ROOTLO':   0x40C2,   # FAT16 root directory LBA (32-bit)
    'ROOTHI':   0x40C4,
    'ROOTSECS': 0x40C6,   # FAT16 root directory size in sectors
    'F16IDX':   0x40C8,   # FAT16 root scan sector index
    'DIRLAST':  0x40CA,   # FAT32 root scan reached the end of its cluster chain
    # original ROM entry points and variables
    'SDREAD':   0x0A86,   # hl=buffer, bcde=LBA -> carry on error
    'MEMCMP':   0x0CEC,   # hl,de,bc -> Z if equal
    'FOUND':    0x077D,   # matched directory entry at ix -> store start cluster/size, nc
    'PARTLO':   0x4083, 'PARTHI': 0x4085,
    'FATLO':    0x402E, 'FATHI':  0x4030,
    'NFATS':    0x4034,
    'FSZLO':    0x4035, 'FSZHI':  0x4037,
    'DATALO':   0x405B, 'DATAHI': 0x405D,
    'CLBLO':    0x400E, 'CLBHI':  0x4010,
    'RCLLO':    0x405F, 'RCLHI':  0x4061,
    'NAMEPTR':  0x4047,
    'CLUS':     0x407B,   # 32-bit cluster / FAT entry scratch ($407B-$407E)
}

SRC = r"""
; ---- $0571 replacement: choose a FAT partition from the MBR ----------------
pickpart:
    ld ix,$61be
    ld b,4
pp_loop:
    ld a,(ix+4)
    cp $0b
    jr z,pp_found
    cp $0c
    jr z,pp_found
    cp $04
    jr z,pp_found
    cp $06
    jr z,pp_found
    cp $0e
    jr z,pp_found
    ld de,16
    add ix,de
    djnz pp_loop
    ld ix,$61be          ; nothing recognised: fall back to entry 1 like the original
pp_found:
    ld e,(ix+8)
    ld d,(ix+9)
    ld c,(ix+10)
    ld b,(ix+11)
    ld (PARTLO),de
    ld (PARTHI),bc
    ld hl,$6000
    jp $0584             ; original: call SDREAD on the volume boot record

; ---- $056D replacement: sector 0 is itself a FAT16/FAT32 boot sector -------
nopart:
    ld hl,0
    ld (PARTLO),hl
    ld (PARTHI),hl
    jp $058a

; ---- $05A0 replacement: identify FAT32 or FAT16 -----------------------------
fstype:
    xor a
    ld (FATTYPE),a
    ld hl,$6052
    ld de,$1f22          ; "FAT32   "
    ld bc,8
    call MEMCMP
    jp z,$05b2
    ld hl,$6036
    ld de,$1f1a          ; "FAT16   "
    ld bc,8
    call MEMCMP
    jr nz,fs_bad
    ld a,1
    ld (FATTYPE),a
    jp $05b2
fs_bad:
    ld a,3
    scf
    ret

; ---- $0605 replacement: FAT16 geometry --------------------------------------
geom:
    ld a,(FATTYPE)
    and a
    jr nz,geom16
    ld hl,($6011)        ; FAT32: replay the overwritten instruction
    jp $0608
geom16:
    ld a,($6015)         ; media byte, same table as the original
    ld hl,$0e2c
    ld bc,9
    cpir
    jr z,g16_media_ok
    ld a,8
    scf
    ret
g16_media_ok:
    ld hl,($6016)        ; sectors per FAT (16-bit)
    ld a,h
    or l
    jr nz,g16_fsz_ok
    ld a,9
    scf
    ret
g16_fsz_ok:
    ld (FSZLO),hl
    ld hl,0
    ld (FSZHI),hl
    ld (RCLLO),hl        ; no root cluster on FAT16
    ld (RCLHI),hl
    ; root LBA = FAT base + nFATs * sectors per FAT
    ld hl,(FATLO)
    ld (ROOTLO),hl
    ld hl,(FATHI)
    ld (ROOTHI),hl
    ld a,(NFATS)
    and a
    jr z,g16_nofat
    ld b,a
g16_mul:
    ld hl,(ROOTLO)
    ld de,(FSZLO)
    add hl,de
    ld (ROOTLO),hl
    ld hl,(ROOTHI)
    ld de,0
    adc hl,de
    ld (ROOTHI),hl
    djnz g16_mul
g16_nofat:
    ; root sectors = (root entries + 15) / 16
    ld hl,($6011)
    ld a,h
    or l
    jr nz,g16_root_ok
    ld a,6
    scf
    ret
g16_root_ok:
    ld de,15
    add hl,de
    ld b,4
g16_div:
    srl h
    rr l
    djnz g16_div
    ld (ROOTSECS),hl
    ; data base = root LBA + root sectors
    ex de,hl
    ld hl,(ROOTLO)
    add hl,de
    ld (DATALO),hl
    ld (CLBLO),hl
    ld hl,(ROOTHI)
    ld de,0
    adc hl,de
    ld (DATAHI),hl
    ld (CLBHI),hl
    and a
    ret

; ---- $06BE replacement: find a file -----------------------------------------
find:
    ld (NAMEPTR),hl
    ld a,(FATTYPE)
    and a
    jr nz,find16
    ld (DIRLAST),a       ; FAT32: original cluster-chain directory scan
    jp $06c1
find16:
    ld hl,0
    ld (F16IDX),hl
f_sector:
    ld hl,(F16IDX)
    ld de,(ROOTSECS)
    and a
    sbc hl,de
    jr nc,f_none
    ld hl,(ROOTLO)
    ld de,(F16IDX)
    add hl,de
    ex de,hl
    ld hl,(ROOTHI)
    ld bc,0
    adc hl,bc
    ld b,h
    ld c,l
    ld hl,$6000
    call SDREAD
    ret c
    ld ix,$6000
    ld b,16
f_entry:
    push bc
    ld a,(ix+0)
    and a
    jr z,f_none_pop      ; end of directory
    cp $e5
    jr z,f_next          ; deleted
    ld a,(ix+$0b)
    and $18
    jr nz,f_next         ; volume label or directory (LFN entries have bit 3 set too)
    push ix
    pop hl
    ld de,(NAMEPTR)
    ld bc,11
    call MEMCMP
    jr nz,f_next
    pop bc
    jp FOUND
f_next:
    ld de,32
    add ix,de
    pop bc
    djnz f_entry
    ld hl,(F16IDX)
    inc hl
    ld (F16IDX),hl
    jr f_sector
f_none_pop:
    pop bc
f_none:
    scf
    ret

; ---- FAT32 directory scan: still check the last sector of the chain ---------
; The original looks up the next cluster right after reading a sector and gives up
; on end-of-chain before scanning that sector's entries.
dir_last:                ; $0737 jp m target: end of chain reached
    ld a,1
    ld (DIRLAST),a
    jp $0746             ; scan the sector already in the buffer
dir_sec:                 ; $06E3: about to read the next directory sector
    ld a,(DIRLAST)
    and a
    jr nz,f_none
    ld hl,($4012)        ; replay the overwritten instruction
    jp $06e6

; ---- $081C replacement: next cluster ----------------------------------------
next:
    ld a,(FATTYPE)
    and a
    jr nz,next16
    ld hl,(CLUS)         ; FAT32: replay the overwritten instruction
    jp $081f
next16:
    ld a,(CLUS+1)        ; FAT sector = FAT base + cluster / 256
    ld e,a
    ld d,0
    ld hl,(FATLO)
    add hl,de
    ex de,hl
    ld hl,(FATHI)
    ld bc,0
    adc hl,bc
    ld b,h
    ld c,l
    ld hl,$6400
    call SDREAD
    ret c
    ld a,(CLUS)
    ld l,a
    ld h,0
    add hl,hl
    ld de,$6400
    add hl,de
    ld e,(hl)
    inc hl
    ld d,(hl)
    ld (CLUS),de
    ld hl,0
    ld (CLUS+2),hl
    ld a,d               ; 0x0000/0x0001 (free/reserved) or >= 0xFFF7: stop
    or a
    jr nz,n16_hi
    ld a,e
    cp 2
    jr c,n16_end
    jr n16_more
n16_hi:
    cp $ff
    jr nz,n16_more
    ld a,e
    cp $f7
    jr nc,n16_end
n16_more:
    xor a
    ret
n16_end:
    ld a,$ff
    and a
    ret

; ---- $087F replacement: FAT32 end of chain ----------------------------------
eoc32:
    ld a,(CLUS+3)
    and $0f
    ld (CLUS+3),a
    cp $0f
    jr nz,e32_more
    ld a,(CLUS+2)
    cp $ff
    jr nz,e32_more
    ld a,(CLUS+1)
    cp $ff
    jr nz,e32_more
    ld a,(CLUS)
    cp $f7
    jr c,e32_more
    ld a,$ff
    and a
    ret
e32_more:
    xor a
    ret
"""

HOOKS = [  # (address, original bytes that must be there, replacement source)
    (0x0571, '21 00 60', 'jp pickpart'),
    (0x056D, '3e 09 37 c9', 'jp nopart\nnop'),
    (0x055D, '28 2b', 'jr z,$056d'),          # partitionless FAT32 goes through nopart too
    (0x05A0, '21 52 60', 'jp fstype'),
    (0x0605, '2a 11 60', 'jp geom'),
    (0x06BE, '22 47 40', 'jp find'),
    (0x081C, '2a 7b 40', 'jp next'),
    (0x087F, '21 7b 40', 'jp eoc32'),
    (0x0737, 'fa b6 07', 'jp m,dir_last'),
    (0x06E3, '2a 12 40', 'jp dir_sec'),
    (0x0EC6, '41 30', 'defm "X1"'),           # SYSTEM INFO: "FIRMWARE: X1" marks this build
]


KEYWORDS = set('a b c d e h l i r af bc de hl sp ix iy ixh ixl iyh iyl nz z nc po pe p m'.split())


def assemble(src, org, labels):
    asm = Assembler()
    lines = []
    for raw in src.splitlines():
        line = raw.split(';')[0].strip()
        if line:
            lines.append(line)
    def subst(op):
        def rep(m):
            w = m.group(0)
            if w in labels:
                return '$%04x' % labels[w]
            if w in EQU:
                return '$%04x' % EQU[w]
            return w
        op = re.sub(r'\b[A-Za-z_][A-Za-z0-9_]*\+\d+\b', lambda m: '$%04x' % ((labels.get(m.group(0).split('+')[0]) or EQU[m.group(0).split('+')[0]]) + int(m.group(0).split('+')[1])) if m.group(0).split('+')[0] in labels or m.group(0).split('+')[0] in EQU else m.group(0), op)
        return re.sub(r'\b[A-Za-z_][A-Za-z0-9_]*\b', rep, op)
    out = bytearray()
    for passno in (1, 2):
        out = bytearray()
        addr = org
        for line in lines:
            if line.endswith(':'):
                labels[line[:-1]] = addr
                continue
            op = subst(line)
            if passno == 1:
                op = re.sub(r'\$[0-9a-f]{4}', lambda m: m.group(0), op)
            code = asm.assemble(op, addr)
            if not code:
                if passno == 1:   # unresolved forward label: assume a 3-byte absolute or 2-byte relative
                    mnem, _, args = op.partition(' ')
                    args = re.sub(r'\b[a-z_][a-z0-9_]*\b', lambda m: m.group(0) if m.group(0) in KEYWORDS else '$%04x' % addr, args)
                    code = asm.assemble(mnem + ' ' + args, addr)
                if not code:
                    sys.exit('cannot assemble: %r -> %r' % (line, op))
            out += bytes(code)
            addr += len(code)
    return bytes(out)


def build(rom):
    rom = bytearray(rom)
    labels = {}
    code = assemble(SRC, ORG, labels)
    end = ORG + len(code)
    assert end <= 0x4000 and all(b == 0xFF for b in rom[ORG:end]), 'patch area not free'
    rom[ORG:end] = code
    for addr, orig, src in HOOKS:
        want = bytes.fromhex(orig)
        assert rom[addr:addr + len(want)] == want, 'unexpected bytes at %04x' % addr
        patch = assemble(src, addr, labels)
        assert len(patch) <= len(want), 'hook at %04x too long' % addr
        rom[addr:addr + len(patch)] = patch
    return bytes(rom), labels, end


if __name__ == '__main__':
    rom, labels, end = build(open(sys.argv[1], 'rb').read())
    open(sys.argv[2], 'wb').write(rom)
    print('patch code %04x-%04x (%d bytes)' % (ORG, end - 1, end - ORG))
    for k, v in sorted(labels.items(), key=lambda x: x[1]):
        print('  %-12s %04x' % (k, v))
