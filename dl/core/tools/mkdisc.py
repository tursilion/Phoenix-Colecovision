#!/usr/bin/env python3
"""Make a Phoenix laserdisc file (.LD) for the Dragon's Lair core.

A .LD file holds a header, the game ROM, and every disc frame from 0 to the
last one, each in a fixed 93-sector (47616-byte) block, so the core finds
frame f at sector frame_sector + 93 * f:

  sector 0      header (see HEADER below)
  sector 1...   game ROM (u1, u2, ... concatenated, up to 40K)
  frame_sector  frame 0, then frame 1, ...

Frame block:
  0x0000  header: "FRM", format, frame number (u32), sample count (u16)
  0x0200  palette, 256 x RGB565 little-endian
  0x0400  video: 320x240 as 80 x 60 cells of 4x4 pixels, row-major; each
          cell is 4 palette indices then 4 mask bytes (one per pixel row,
          2 bits per pixel, leftmost pixel in bits 1:0)
  0x9A00  audio: 2000 stereo samples (signed 16-bit L, R) = 1/23.976 s at
          47952Hz; disc audio channel 1 is left, channel 2 right

Disc frame numbers: the Dragon's Lair and Space Ace discs hold film with
3:2 pulldown, and their frame numbers count film frames, 23.976 a second
(Daphne/Hypseus use that rate for both).  The core's player advances them
with the same 3,2,3,2-field cadence.

Usage:

  mkdisc.py OUT.LD --rom u1 u2 ... --game lair|ace
            (--test | --framefile F | --video V [--audio A] [--offset N])

  --framefile F   a Daphne/Hypseus framefile (e.g. vldp_dl/lair/lair.txt):
                  each line "N file.m2v" starts a segment at disc frame N;
                  the audio is file.ogg next to it
  --video V       anything ffmpeg reads; its first frame is disc frame
                  --offset (default 1), its audio is --audio or its own
  --test          synthetic frames showing their frame number, and a tone

  Disc frame f of a segment starting at N shows video frame
  (f - N) * vfps / 23.976 (as Daphne/Hypseus; the Daphne .m2v files are
  23.976 fps, so that is frame f - N), and its audio is the 1/23.976 s at
  time (f - N) / 23.976.
  --last-frame N  last disc frame (default: from the video, or per game)
  --file-frames N write only frames 0..N-1 (the header still says
                  --last-frame); for simulation images
  --dsw-a/--dsw-b raw DIP switch bytes as the game reads them (default:
                  Hypseus's, with free play on)
  --coins         leave free play off (Lair then takes 2 coins a credit)
  --jobs N        encoder processes
  --slow-boot     keep the game's two 15.7 s power-on waits (by default
                  they are patched to 0.5 s each; the ROM is checked first)

Needs numpy and Pillow, and ffmpeg for --video.
"""

import argparse
import os
import re
import struct
import subprocess
import sys

import numpy as np

FRAME_SECTORS = 93
FRAME_BYTES = FRAME_SECTORS * 512
SAMPLES = 2000
AUDIO_RATE = 47952          # 2000 per frame at 24000/1001 frames per second
W, H = 320, 240
CW, CH = W // 4, H // 4     # cells

OFF_PALETTE = 0x200
OFF_VIDEO = 0x400
OFF_AUDIO = 0x9A00

GAMES = {
    # raw DIP bytes as the game reads them (Hypseus defaults, LD-V1000);
    # free = the free play bit, set in A for Lair, cleared in B for Ace
    'lair': dict(dsw_a=0x22, dsw_b=0xD8, free=('a', 0x10, 1), last=34000, title="DRAGON'S LAIR"),
    'ace':  dict(dsw_a=0x3D, dsw_b=0xFE, free=('b', 0x10, 0), last=40000, title='SPACE ACE'),
}

# Power-on waits: LD A,F0 / CALL S1BC9 waits A*2 IRQ ticks (15.7 s) for the
# player to spin up, twice.  Operand address, original, patched (16 ticks).
FASTBOOT = {
    'lair': [(0x121B, 0xF0, 0x08), (0x1235, 0xF0, 0x08)],
    'ace':  [(0x121B, 0xF0, 0x08), (0x123A, 0xF0, 0x08)],
}

BOARD = '1UP        L    CREDIT      2UP        L'

# Header layout (little-endian), must match loader/main.c
HEADER = struct.Struct('<8sIIIHBBBB6s32s40s')


def header(rom_size, frame_sector, last_frame, dsw_a, dsw_b, title):
    h = HEADER.pack(b'PHXDISC1', 1, rom_size, frame_sector, last_frame,
                    FRAME_SECTORS, 0, dsw_a, dsw_b, b'\0' * 6,
                    title.encode('ascii', 'replace')[:31].ljust(32, b'\0'),
                    BOARD.encode().ljust(40, b' '))
    return h.ljust(512, b'\0')


# ---------------------------------------------------------------------------
# Frame encoding

def rgb565(pal):
    p = np.asarray(pal, dtype=np.uint16)
    v = ((p[:, 0] >> 3) << 11) | ((p[:, 1] >> 2) << 5) | (p[:, 2] >> 3)
    return v.astype('<u2').tobytes()


def pack_frame(f, palette, colors, masks, audio):
    """palette: 256x3 uint8; colors: (60,80,4) uint8 indices; masks: (60,80,4)
    uint8; audio: (2000,2) int16."""
    blk = bytearray(FRAME_BYTES)
    blk[0:12] = struct.pack('<3sBIH2x', b'FRM', 0, f, SAMPLES)
    blk[OFF_PALETTE:OFF_PALETTE + 512] = rgb565(palette)
    cells = np.concatenate([colors, masks], axis=2).astype(np.uint8)
    blk[OFF_VIDEO:OFF_VIDEO + CW * CH * 8] = cells.tobytes()
    a = np.asarray(audio, dtype='<i2').reshape(-1)
    blk[OFF_AUDIO:OFF_AUDIO + a.size * 2] = a.tobytes()
    return bytes(blk)


def encode_image(rgb):
    """rgb: (240,320,3) uint8 -> palette (256,3), colors (60,80,4), masks (60,80,4).

    A 256-colour palette for the frame (median cut), then for every 4x4
    cell four palette colours chosen by a small k-means on the cell's pixels,
    and each pixel mapped to the nearest of the four."""
    from PIL import Image

    img = Image.fromarray(rgb, 'RGB')
    q = img.quantize(256, method=Image.Quantize.MEDIANCUT, dither=Image.Dither.NONE)
    pal = np.array(q.getpalette()[:768], dtype=np.uint8).reshape(-1, 3)
    if len(pal) < 256:
        pal = np.vstack([pal, np.zeros((256 - len(pal), 3), np.uint8)])
    palf = pal.astype(np.float32)

    px = rgb.astype(np.float32).reshape(CH, 4, CW, 4, 3).transpose(0, 2, 1, 3, 4).reshape(CH * CW, 16, 3)
    # initial centroids: pixels at luminance quartiles
    lum = px @ np.array([0.299, 0.587, 0.114], np.float32)
    order = np.argsort(lum, axis=1)
    pick = order[:, [0, 5, 10, 15]]
    cen = np.take_along_axis(px, pick[:, :, None], axis=1)
    for _ in range(4):
        d = ((px[:, :, None, :] - cen[:, None, :, :]) ** 2).sum(-1)       # (n,16,4)
        a = d.argmin(-1)
        for k in range(4):
            m = (a == k)
            cnt = m.sum(1)
            s = (px * m[:, :, None]).sum(1)
            upd = cnt > 0
            cen[upd, k] = s[upd] / cnt[upd, None]
    # centroids to palette entries
    d = ((cen[:, :, None, :] - palf[None, None, :, :]) ** 2).sum(-1)      # (n,4,256)
    idx = d.argmin(-1)                                                    # (n,4)
    cols = palf[idx]                                                      # (n,4,3)
    d = ((px[:, :, None, :] - cols[:, None, :, :]) ** 2).sum(-1)          # (n,16,4)
    sel = d.argmin(-1).astype(np.uint8).reshape(-1, 4, 4)                 # (n,row,x)
    masks = sel[:, :, 0] | (sel[:, :, 1] << 2) | (sel[:, :, 2] << 4) | (sel[:, :, 3] << 6)
    return pal, idx.astype(np.uint8).reshape(CH, CW, 4), masks.astype(np.uint8).reshape(CH, CW, 4)


# ---------------------------------------------------------------------------
# Test frames: the frame number in big digits, a colour per frame, a moving
# bar, and a tone whose pitch steps every 10 frames (cells are solid, so this
# is fast).

DIGITS = {
    '0': ['111', '101', '101', '101', '111'], '1': ['010', '110', '010', '010', '111'],
    '2': ['111', '001', '111', '100', '111'], '3': ['111', '001', '111', '001', '111'],
    '4': ['101', '101', '111', '001', '001'], '5': ['111', '100', '111', '001', '111'],
    '6': ['111', '100', '111', '101', '111'], '7': ['111', '001', '001', '001', '001'],
    '8': ['111', '101', '111', '101', '111'], '9': ['111', '101', '111', '001', '111'],
}

TEST_PALETTE = np.zeros((256, 3), np.uint8)
for i in range(16):
    TEST_PALETTE[i] = [(i & 1) * 255, ((i >> 1) & 1) * 255, ((i >> 2) & 1) * 255] if i < 8 else \
                      [80 + (i & 1) * 175, 80 + ((i >> 1) & 1) * 175, 80 + ((i >> 2) & 1) * 175]
TEST_PALETTE[16] = [40, 40, 40]


def test_frame(f):
    grid = np.full((CH, CW), 16, np.uint8)            # dark grey
    grid[:, (f * 2) % CW] = 1 + (f % 7)               # moving bar
    s = '%05d' % f
    scale = 3
    x0, y0 = (CW - (len(s) * 4 - 1) * scale) // 2, (CH - 5 * scale) // 2
    for n, ch in enumerate(s):
        for r, row in enumerate(DIGITS[ch]):
            for c, bit in enumerate(row):
                if bit == '1':
                    x = x0 + (n * 4 + c) * scale
                    y = y0 + r * scale
                    grid[y:y + scale, x:x + scale] = 15  # white
    grid[0:2, :] = 8 + (f % 8)                        # colour strip per frame
    colors = np.repeat(grid[:, :, None], 4, axis=2)
    masks = np.zeros((CH, CW, 4), np.uint8)
    t = (np.arange(SAMPLES) + f * SAMPLES) / AUDIO_RATE
    freq = 220.0 * (1 + (f // 10) % 4)
    tone = (np.sin(2 * np.pi * freq * t) * 6000).astype(np.int16)
    audio = np.stack([tone, tone], axis=1)
    return pack_frame(f, TEST_PALETTE, colors, masks, audio)


def black_frame(f):
    z = np.zeros((CH, CW, 4), np.uint8)
    return pack_frame(f, np.zeros((256, 3), np.uint8), z, z, np.zeros((SAMPLES, 2), np.int16))


# ---------------------------------------------------------------------------
# Video input

DISC_FPS = 24000 / 1001


def video_fps(path):
    out = subprocess.run(['ffprobe', '-v', 'error', '-select_streams', 'v:0', '-show_entries',
                          'stream=r_frame_rate', '-of', 'csv=p=0', path],
                         stdout=subprocess.PIPE, text=True).stdout.strip()
    m = re.search(r'(\d+)/(\d+)', out)
    if not m:
        raise SystemExit('cannot read the frame rate of %s' % path)
    return int(m.group(1)) / int(m.group(2))


def ffmpeg_frames(path, count, deint):
    """The first count frames of the video, scaled to 320x240."""
    vf = ('yadif,' if deint else '') + 'scale=%d:%d:flags=area' % (W, H)
    p = subprocess.Popen(['ffmpeg', '-v', 'error', '-i', path, '-vf', vf, '-vsync', 'passthrough',
                          '-frames:v', str(count), '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-'],
                         stdout=subprocess.PIPE)
    n = W * H * 3
    got = 0
    while got < count:
        b = p.stdout.read(n)
        if len(b) < n:
            break
        got += 1
        yield np.frombuffer(b, np.uint8).reshape(H, W, 3)
    p.stdout.close()
    p.wait()


def ffmpeg_audio(path):
    p = subprocess.run(['ffmpeg', '-v', 'error', '-i', path, '-vn', '-f', 's16le', '-ac', '2',
                        '-ar', str(AUDIO_RATE), '-'], stdout=subprocess.PIPE)
    return np.frombuffer(p.stdout, '<i2').reshape(-1, 2)


def read_framefile(path):
    """Segments (first disc frame, video path, audio path or None)."""
    base = os.path.dirname(os.path.abspath(path))
    lines = [l.strip() for l in open(path) if l.strip()]
    root = os.path.join(base, lines[0])
    segs = []
    for l in lines[1:]:
        n, f = l.split(None, 1)
        v = os.path.join(root, f)
        a = os.path.splitext(v)[0] + '.ogg'
        segs.append((int(n), v, a if os.path.exists(a) else None))
    return sorted(segs)


def _encode_job(rgb):
    return encode_image(rgb)


def write_segment(out, start, end, vpath, apath, deint, jobs, report):
    """Disc frames start..end-1 from one video (and audio) file."""
    from multiprocessing import Pool

    vfps = video_fps(vpath)
    ratio = vfps / DISC_FPS                  # video frames per disc frame
    n = end - start
    vidx = [int((k * ratio) + 1e-6) for k in range(n)]
    need = vidx[-1] + 1
    print('%s: %.3f fps, disc frames %d-%d from video frames 0-%d'
          % (vpath, vfps, start, end - 1, need - 1), file=sys.stderr)

    audio = None
    if apath:
        audio = ffmpeg_audio(apath)
        if len(audio) == 0:
            audio = None

    k = 0
    with Pool(jobs) as pool:
        for j, enc in enumerate(pool.imap(_encode_job, ffmpeg_frames(vpath, need, deint), chunksize=4)):
            pal, colors, masks = enc
            while k < n and vidx[k] == j:
                if audio is not None:
                    s = audio[k * SAMPLES:(k + 1) * SAMPLES]
                    if len(s) < SAMPLES:
                        s = np.vstack([s, np.zeros((SAMPLES - len(s), 2), np.int16)])
                else:
                    s = np.zeros((SAMPLES, 2), np.int16)
                f = start + k
                out.write(pack_frame(f, pal, colors, masks, s))
                if f % 500 == 0:
                    report(f)
                k += 1
    return start + k                         # the first frame not written


# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('out')
    ap.add_argument('--rom', nargs='+', required=True)
    ap.add_argument('--game', choices=GAMES, required=True)
    ap.add_argument('--test', action='store_true')
    ap.add_argument('--framefile')
    ap.add_argument('--video')
    ap.add_argument('--audio')
    ap.add_argument('--offset', type=int, default=1)
    ap.add_argument('--deinterlace', action='store_true')
    ap.add_argument('--last-frame', type=int)
    ap.add_argument('--file-frames', type=int)
    ap.add_argument('--dsw-a', type=lambda s: int(s, 0))
    ap.add_argument('--dsw-b', type=lambda s: int(s, 0))
    ap.add_argument('--coins', action='store_true')
    ap.add_argument('--slow-boot', action='store_true')
    ap.add_argument('--title')
    ap.add_argument('--jobs', type=int, default=os.cpu_count())
    a = ap.parse_args()

    if not a.test and not a.video and not a.framefile:
        ap.error('need --test, --framefile or --video')
    g = GAMES[a.game]
    rom = b''.join(open(r, 'rb').read() for r in a.rom)
    if len(rom) > 0xA000:
        ap.error('ROM over 40K')
    if not a.slow_boot:
        rom = bytearray(rom)
        if all(rom[ad] == old for ad, old, _ in FASTBOOT[a.game]):
            for ad, _, new in FASTBOOT[a.game]:
                rom[ad] = new
            print('fast boot: power-on waits patched', file=sys.stderr)
        else:
            print('fast boot: ROM not recognised, power-on waits left alone', file=sys.stderr)
        rom = bytes(rom)
    rom_sectors = (len(rom) + 511) // 512
    frame_sector = 1 + rom_sectors

    dsw = {'a': g['dsw_a'], 'b': g['dsw_b']}
    if not a.coins:
        which, bit, val = g['free']
        dsw[which] = (dsw[which] | bit) if val else (dsw[which] & ~bit)
    if a.dsw_a is not None:
        dsw['a'] = a.dsw_a
    if a.dsw_b is not None:
        dsw['b'] = a.dsw_b

    last = a.last_frame or g['last']
    nfile = a.file_frames if a.file_frames is not None else last + 1

    with open(a.out, 'wb') as out:
        out.write(header(len(rom), frame_sector, last, dsw['a'], dsw['b'],
                         a.title or g['title']))
        out.write(rom.ljust(rom_sectors * 512, b'\xff'))

        if a.test:
            for f in range(nfile):
                out.write(test_frame(f))
                if f % 1000 == 0:
                    print('frame %d' % f, file=sys.stderr)
            return

        # Real video: segments from a framefile, or one video; frames
        # before, between and after them are black.
        if a.framefile:
            segs = [(n, v, au) for n, v, au in read_framefile(a.framefile)]
        else:
            segs = [(a.offset, a.video, a.audio or a.video)]
        report = lambda f: print('frame %d' % f, file=sys.stderr)
        f = 0
        for i, (n, v, au) in enumerate(segs):
            nxt = segs[i + 1][0] if i + 1 < len(segs) else nfile
            nxt = min(nxt, nfile)
            while f < min(n, nfile):
                out.write(black_frame(f))
                f += 1
            if f < nxt:
                f = write_segment(out, f, nxt, v, au, a.deinterlace, a.jobs, report)
        while f < nfile:
            out.write(black_frame(f))
            f += 1


if __name__ == '__main__':
    main()
