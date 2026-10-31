# ROM cache test cartridge (SDCC): CACHETST.GB, 2M MBC5.  LOGO is any Game
# Boy image, for the Nintendo logo in the header.

LOGO ?=

all: CACHETST.GB

%.rel: %.s
	sdasgb -plosgff $@ $<
%.rel: %.c
	sdcc -msm83 -c -o $@ $<
cachetest.ihx: crt0.rel main.rel page.rel font.rel
	sdcc -msm83 --no-std-crt0 --code-loc 0x0200 --data-loc 0xC000 -o $@ $^
cachetest.bin: cachetest.ihx
	makebin -s 16384 $< $@
CACHETST.GB: cachetest.bin mkcache.py
	python3 mkcache.py $< $(LOGO) $@

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.GB

.PHONY: all clean
