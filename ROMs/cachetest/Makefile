# ColecoVision ROM cache test images (SDCC 4.2, Z80): CACHE1M.ROM (1M
# MegaCart) and CACHE2M.SGM (2M SGM).

SDCC := sdcc -mz80 --std-sdcc99
LINK := --no-std-crt0 --code-loc 0x8020 --data-loc 0x7000

all: CACHE1M.ROM CACHE2M.SGM

crt0.rel: crt0.s
	sdasz80 -plosgff $@ $<
page.rel: page.s
	sdasz80 -plosgff $@ $<
font.rel: font.c
	$(SDCC) -c -o $@ $<
main_mc.rel: main.c
	$(SDCC) -c -o $@ $<
main_sgm.rel: main.c
	$(SDCC) -DSGM -c -o $@ $<

megacart.ihx: crt0.rel main_mc.rel page.rel font.rel
	$(SDCC) $(LINK) -o $@ $^
sgm.ihx: crt0.rel main_sgm.rel page.rel font.rel
	$(SDCC) $(LINK) -o $@ $^
%.bin: %.ihx
	makebin -s 65536 $< $@

CACHE1M.ROM CACHE2M.SGM: megacart.bin sgm.bin mkcart.py
	python3 mkcart.py megacart.bin sgm.bin CACHE1M.ROM CACHE2M.SGM

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.ROM *.SGM

.PHONY: all clean
