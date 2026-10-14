# Phoenix Dragon's Lair core boot loader (sdcc, Z80).
# Output: dl_boot.bin (24K image of the boot RAM) and ../rtl/dl_boot.hex.
# Also makes the overlay font, ../rtl/font.hex.
#
# Code and constants must end below 0x4000 (the buffers in loader.h start
# there); the link checks it.

SDCC   ?= sdcc
SDAS   ?= sdasz80
MAKEBIN ?= makebin

CFLAGS := -mz80 --opt-code-size --std-sdcc11
OBJS   := crt0.rel spi.rel main.rel diskio.rel pff.rel

all: ../rtl/dl_boot.hex ../rtl/font.hex

%.rel: %.s
	$(SDAS) -plosgff $@ $<

main.rel: main.c phoenix.h loader.h pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@
diskio.rel: diskio.c phoenix.h loader.h pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@
pff.rel: pff/pff.c pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@

dl_boot.ihx: $(OBJS)
	$(SDCC) -mz80 --no-std-crt0 --code-loc 0x0200 --data-loc 0xA000 -o $@ $(OBJS)
	@python3 -c "import re,sys; m=open('dl_boot.map').read(); \
	  ends=[int(a,16)+int(l,16) for n,a,l in re.findall(r'^(_CODE|_INITIALIZER|_GSINIT|_GSFINAL|_HOME)\s+([0-9A-F]{8})\s+([0-9A-F]{8})',m,re.M)]; \
	  e=max(ends); print('boot code ends at %04X' % e); sys.exit(e > 0x4000)"

dl_boot.bin: dl_boot.ihx
	$(MAKEBIN) -s 24576 $< $@

../rtl/dl_boot.hex: dl_boot.bin bin2hex.py
	python3 bin2hex.py $< $@

../rtl/font.hex: font_src.c mkfont.py
	python3 mkfont.py $< $@

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.rst

.PHONY: all clean
