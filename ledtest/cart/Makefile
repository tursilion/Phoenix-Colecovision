# Phoenix LED test cartridge (SDCC 4.2, Z80): LEDTEST.ROM, a plain 32K cart.

SDCC := sdcc -mz80 --std-sdcc99
LINK := --no-std-crt0 --code-loc 0x8020 --data-loc 0x7000

all: LEDTEST.ROM

crt0.rel: crt0.s
	sdasz80 -plosgff $@ $<
%.rel: %.c
	$(SDCC) -c -o $@ $<

ledtest.ihx: crt0.rel main.rel font.rel
	$(SDCC) $(LINK) -o $@ $^

# The 32K at $8000, padded with $FF
LEDTEST.ROM: ledtest.ihx
	makebin -s 65536 $< ledtest.bin
	python3 -c "import sys; d=open('ledtest.bin','rb').read()[0x8000:]; open('$@','wb').write(d)"

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.ROM

.PHONY: all clean
