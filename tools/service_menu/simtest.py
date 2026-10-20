"""Run the service menu's own SD/FAT code (mount $053C, find $06BE, read $07B8) in a Z80 emulator
against disk images, with an SPI SD card model on ports $60 (CS) / $61 (data)."""
import sys, z80

class SDCard:
    def __init__(self, img, sdhc=True):
        self.img = img; self.sdhc = sdhc
        self.cs = False; self.cmd = []; self.out = []; self.idle = True; self.acmd = False

    def ctrl(self, v):
        self.cs = not (v & 1)
        if not self.cs:
            self.cmd = []

    def xfer(self, b):
        r = self.out.pop(0) if self.out else 0xFF
        if not self.cs:
            return 0xFF
        if not self.cmd and (b & 0xC0) != 0x40:
            return r
        self.cmd.append(b)
        if len(self.cmd) == 6:
            self.command(self.cmd[0] & 0x3F, int.from_bytes(bytes(self.cmd[1:5]), 'big'))
            self.cmd = []
        return r

    def command(self, n, arg):
        acmd, self.acmd = self.acmd, False
        r1 = 0x01 if self.idle else 0x00
        resp = [0xFF]                          # Ncr = 1
        if n == 0:
            self.idle = True; resp.append(0x01)
        elif n == 8:
            resp += [r1, 0, 0, 1, 0xAA] if self.sdhc else [0x05]
        elif n == 55:
            self.acmd = True; resp.append(r1)
        elif n == 41 and acmd:
            self.idle = False; resp.append(0x00)
        elif n == 1:
            self.idle = False; resp.append(0x00)
        elif n == 58:
            resp += [r1, 0xC0 if self.sdhc else 0x80, 0xFF, 0x80, 0x00]
        elif n == 16:
            resp.append(r1)
        elif n == 17:
            lba = arg if self.sdhc else arg // 512
            data = self.img[lba * 512:(lba + 1) * 512].ljust(512, b'\0')
            resp += [0x00, 0xFF, 0xFF, 0xFE] + list(data) + [0x12, 0x34]
            self.reads.append(lba)
        else:
            resp.append(0x04)
        self.out = resp
    reads = []

class Machine:
    def __init__(self, rom, img, sdhc=True):
        self.m = z80.Z80Machine()
        self.sd = SDCard(img, sdhc)
        mem = bytearray(0x10000)
        mem[0:len(rom)] = rom
        self.m.set_memory_block(0, bytes(mem))
        self.m.set_input_callback(self.inp)
        self.m.set_output_callback(self.outp)

    def inp(self, port):
        p = port & 0xFF
        if p == 0x61:
            return self.sd.xfer(0xFF)
        return 0xFF

    def outp(self, port, value):
        p = port & 0xFF
        if p == 0x60:
            self.sd.ctrl(value)
        elif p == 0x61:
            self.sd.xfer(value)

    def call(self, addr, hl=0, limit=200_000_000):
        m = self.m
        m.sp = 0x7F00
        m.set_memory_block(0x7F00, b'\x00\xff')  # return address $FF00
        m.set_memory_block(0xFF00, b'\x76')      # halt
        m.halted = False
        m.hl = hl; m.pc = addr
        ticks = 0
        while m.pc not in (0xFF00, 0xFF01):
            m.ticks_to_stop = 1_000_000
            m.run(); ticks += 1_000_000
            if ticks > limit:
                raise RuntimeError('timeout in call %04x, pc=%04x' % (addr, m.pc))
        return m.f & 1, m.a

    def mem(self, a, n):
        return bytes(self.m.memory[a:a + n])

    def poke(self, a, data):
        self.m.set_memory_block(a, data)

def load(rom, img, name83, size, sdhc=True):
    """returns (status string, file bytes or None)"""
    mc = Machine(rom, img, sdhc)
    c, a = mc.call(0x053C)
    if c:
        return 'mount error %d' % a, None
    mc.poke(0x7000, name83)
    c, a = mc.call(0x06BE, hl=0x7000)
    if c:
        return 'file not found', None
    data = bytearray()
    for _ in range((size + 511) // 512):
        mc.poke(0x4049, (0x6200).to_bytes(2, 'little'))
        mc.call(0x07B8)
        data += mc.mem(0x6200, 512)
    return 'ok', bytes(data[:size])

if __name__ == '__main__':
    rom = open(sys.argv[1], 'rb').read()
    img = open(sys.argv[2], 'rb').read()
    print(load(rom, img, sys.argv[3].encode().ljust(11), int(sys.argv[4]))[0])
