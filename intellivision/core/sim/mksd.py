#!/usr/bin/env python3
"""Make an SD card image for the simulation.

    mksd.py out.img fat16|fat32 [--mbr] [--cluster-kb n] [--size-mb n] NAME=file ...

Needs mkfs.fat and the pyfatfs Python package.
"""
import os
import struct
import subprocess
import sys
import tempfile

from pyfatfs.PyFatFS import PyFatFS


def main():
    out, fat = sys.argv[1], sys.argv[2]
    mbr = '--mbr' in sys.argv[3:]
    cluster = []
    if '--cluster-kb' in sys.argv:
        kb = int(sys.argv[sys.argv.index('--cluster-kb') + 1])
        cluster = ['-s', str(kb * 2)]
    files = [a.split('=', 1) for a in sys.argv[3:] if '=' in a]

    size_mb = 64 if fat == 'fat32' else 32
    if '--size-mb' in sys.argv:
        size_mb = int(sys.argv[sys.argv.index('--size-mb') + 1])
    with tempfile.TemporaryDirectory() as tmp:
        part = os.path.join(tmp, 'part.img')
        subprocess.run(['mkfs.fat', '-F', fat[3:]] + cluster + ['-C', part, str(size_mb * 1024)],
                       check=True, stdout=subprocess.DEVNULL)
        fs = PyFatFS(part)
        for name, src in files:
            if '/' in name:
                fs.makedirs('/' + name.rsplit('/', 1)[0], recreate=True)
            with open(src, 'rb') as f:
                fs.writebytes('/' + name, f.read())
        fs.close()
        with open(part, 'rb') as f:
            data = f.read()

    if mbr:
        start = 2048
        entry = struct.pack('<B3sB3sII', 0, b'\0\0\0', 0x0C if fat == 'fat32' else 0x06,
                            b'\0\0\0', start, len(data) // 512)
        sector0 = bytearray(512)
        sector0[446:462] = entry
        sector0[510:512] = b'\x55\xAA'
        data = bytes(sector0) + bytes(512 * (start - 1)) + data

    with open(out, 'wb') as f:
        f.write(data)


if __name__ == '__main__':
    main()
