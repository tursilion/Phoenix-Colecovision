# Test cartridges for the simulation (SDCC): BIG512.GB, SAVE32.GB, SAVE8.GB.  LOGO is any Game Boy image,
# for the Nintendo logo in the header.

LOGO ?=

all: BIG512.GB SAVE32.GB

crt0.rel: crt0.s
	sdasgb -plosgff $@ $<
bigtest.rel: bigtest.c
	sdcc -msm83 -c -o $@ $<
bigtest.ihx: crt0.rel bigtest.rel
	sdcc -msm83 --no-std-crt0 --code-loc 0x0200 --data-loc 0xDE00 -o $@ $^
bigtest.bin: bigtest.ihx
	makebin -s 32768 $< $@
BIG512.GB: bigtest.bin mkbig.py
	python3 mkbig.py $< $(LOGO) $@

savetest.rel: savetest.c
	sdcc -msm83 -c -o $@ $<
savetest.ihx: crt0.rel savetest.rel
	sdcc -msm83 --no-std-crt0 --code-loc 0x0200 --data-loc 0xDE00 -o $@ $^
savetest.bin: savetest.ihx
	makebin -s 32768 $< $@
SAVE32.GB SAVE8.GB: savetest.bin mksave.py
	python3 mksave.py $< $(LOGO) .

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.GB

.PHONY: all clean
