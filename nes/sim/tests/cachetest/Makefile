# NES ROM cache test cartridge (cc65): CACHETST.NES, MMC3, 512K PRG + 256K CHR.

CL65 ?= cl65

all: CACHETST.NES

cachetest.bin: crt0.s main.c page.s cache.cfg
	$(CL65) -t none -Oirs --cpu 6502 -C cache.cfg -m cache.map -o $@ crt0.s main.c page.s

CACHETST.NES: cachetest.bin mkcache.py ../../../loader/font.c
	python3 mkcache.py $< ../../../loader/font.c $@

clean:
	rm -f *.o cachetest.bin cache.map CACHETST.NES

.PHONY: all clean
