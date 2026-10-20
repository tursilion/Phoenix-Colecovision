"""Build SD card test images: FAT16/FAT32, with and without an MBR, extra partitions,
many root entries (multi-sector directory), and a fragmented target file."""
import os as _os
_os.chdir(_os.path.dirname(_os.path.abspath(__file__)))   # images/ and the ROMs live next to this script
import os, subprocess, random, struct
from pyfatfs.PyFatFS import PyFatFS

OUT = 'images'
os.makedirs(OUT, exist_ok=True)
random.seed(1)
PAYLOAD = bytes(random.getrandbits(8) for _ in range(471040))   # full PHX slot size
open(os.path.join(OUT, 'payload.bin'), 'wb').write(PAYLOAD)

def mkfs(path, mb, fat, spc, hidden=0):
    if os.path.exists(path):
        os.remove(path)
    subprocess.run(['mkfs.fat', '-C', '-F', str(fat), '-s', str(spc), '-h', str(hidden), path, str(mb * 1024)],
                   check=True, capture_output=True)

def populate(path, fragment=False):
    fs = PyFatFS(path, preserve_case=True)
    for i in range(40):                         # push the target past the first directory sector
        with fs.openbin('/Some long file name %02d.txt' % i, 'wb') as f:
            f.write(b'x' * (100 + i * 700))
    if fragment:                                # leave holes so the target is not contiguous
        for i in range(0, 40, 2):
            fs.remove('/Some long file name %02d.txt' % i)
    with fs.openbin('/CORE01.PHX', 'wb') as f:
        f.write(PAYLOAD)
    fs.close()

def with_mbr(fsimg, start_lba, ptype, extra_first=None):
    body = open(fsimg, 'rb').read()
    mbr = bytearray(512)
    entries = []
    if extra_first:                             # a non-FAT partition in slot 1
        entries.append((0x83, 2048, extra_first))
    entries.append((ptype, start_lba, len(body) // 512))
    for i, (t, lba, n) in enumerate(entries):
        e = 0x1BE + 16 * i
        mbr[e + 4] = t
        mbr[e + 8:e + 16] = struct.pack('<II', lba, n)
    mbr[510:512] = b'\x55\xaa'
    img = bytearray(mbr) + bytes(start_lba * 512 - 512) + body
    return bytes(img)

cases = {}
# FAT16 partitionless and partitioned (the failing 1 GB card is MBR + FAT16)
mkfs('t.img', 32, 16, 4);              populate('t.img');                cases['fat16_nombr'] = open('t.img', 'rb').read()
mkfs('t.img', 32, 16, 4, hidden=2048); populate('t.img');                cases['fat16_mbr'] = with_mbr('t.img', 2048, 0x06)
mkfs('t.img', 32, 16, 8, hidden=8192); populate('t.img', fragment=True); cases['fat16_part2_frag'] = with_mbr('t.img', 8192, 0x0E, extra_first=4096)
# FAT32
mkfs('t.img', 64, 32, 1);              populate('t.img');                cases['fat32_nombr'] = open('t.img', 'rb').read()
mkfs('t.img', 64, 32, 1, hidden=2048); populate('t.img', fragment=True); cases['fat32_mbr_frag'] = with_mbr('t.img', 2048, 0x0C)
mkfs('t.img', 300, 32, 8, hidden=8192); populate('t.img');              cases['fat32_part2'] = with_mbr('t.img', 8192, 0x0B, extra_first=4096)
os.remove('t.img')

# FAT32 whose end-of-chain marker is 0x0FFFFFF8 instead of 0x0FFFFFFF
img = bytearray(cases['fat32_mbr_frag'])
base = 2048 * 512
rsv, nf, fsz = struct.unpack_from('<H', img, base + 14)[0], img[base + 16], struct.unpack_from('<I', img, base + 36)[0]
fat = base + rsv * 512
n = 0
for off in range(fat + 12, fat + fsz * 512, 4):
    if struct.unpack_from('<I', img, off)[0] == 0x0FFFFFFF:
        for k in range(nf):
            struct.pack_into('<I', img, off + k * fsz * 512, 0x0FFFFFF8)
        n += 1
cases['fat32_eoc_fff8'] = bytes(img)

for k, v in cases.items():
    open(os.path.join(OUT, k + '.img'), 'wb').write(v)
    print(k, len(v) // 1024 // 1024, 'MB')
