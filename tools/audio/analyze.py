"""Spectra of the simulated NES audio: raw APU output (390.625 kHz block averages) and the
48 kHz stream as the HDMI encoder samples it.  Usage: analyze.py prefix f0:f1:label ..."""
import sys, wave
import numpy as np

FPS = 60.0988
CPU = 25e6 * 89400 / 420000 / 3          # APU/CPU rate in this core (1.7738 MHz)

def rd(f):
    w = wave.open(f)
    return np.frombuffer(w.readframes(w.getnframes()), dtype='<i2').astype(float), w.getframerate()

def spectrum(x, r):
    x = x - x.mean()
    X = np.abs(np.fft.rfft(x * np.hanning(len(x)))) * 2 / (len(x) * 0.5)
    return np.fft.rfftfreq(len(x), 1 / r), X

def peaks(f, X, lo, hi, n=4):
    m = (f >= lo) & (f < hi)
    idx = np.nonzero(m)[0]
    out = []
    for i in idx[np.argsort(X[idx])[::-1]]:
        if all(abs(f[i] - f[j]) > 300 for j in out):
            out.append(i)
        if len(out) == n:
            break
    return out

prefix = sys.argv[1]
raw, rr = rd(prefix + '_raw.wav')
s48, r48 = rd(prefix + '_48k.wav')
for spec in sys.argv[2:]:
    f0, f1, label = spec.split(':', 2)
    f0, f1 = int(f0), int(f1)
    x = raw[int(f0 / FPS * rr):int(f1 / FPS * rr)]
    y = s48[int(f0 / FPS * r48):int(f1 / FPS * r48)]
    f, X = spectrum(x, rr)
    fy, Y = spectrum(y, r48)
    tot = (X ** 2).sum() or 1e-12
    print('== %s (frames %d-%d): raw rms %.0f, %.1f%% of AC power above 24 kHz' %
          (label, f0, f1, x.std(), 100 * (X[f > 24000] ** 2).sum() / tot))
    for i in peaks(f, X, 20, 190000):
        tri = CPU / 32 / f[i] - 1
        print('   raw  %8.0f Hz  amp %7.0f   (triangle period would be %.2f)' % (f[i], X[i], tri))
    for i in peaks(fy, Y, 20, 24000):
        print('   48k  %8.0f Hz  amp %7.0f' % (fy[i], Y[i]))
