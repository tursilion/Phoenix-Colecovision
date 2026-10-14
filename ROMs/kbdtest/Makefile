# PS/2 keyboard test cartridge (8K) for the Phoenix ColecoVision core.
# Needs pasmo (Debian/Ubuntu package "pasmo") and python3.

PASMO ?= pasmo

all: kbdtest.rom

font.inc: mkfont.py
	python3 mkfont.py $@

kbdtest.rom: kbdtest.asm font.inc
	$(PASMO) kbdtest.asm $@ kbdtest.sym

clean:
	rm -f kbdtest.rom kbdtest.sym font.inc

.PHONY: all clean
