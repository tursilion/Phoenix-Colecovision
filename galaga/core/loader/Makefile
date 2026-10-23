# Phoenix Galaga core boot loader (sdcc, Z80).
# Output: galaga_boot.bin (8K, the sprite ROM block RAM's initial contents)
# and ../rtl/galaga_boot.hex.

SDCC   ?= sdcc
SDAS   ?= sdasz80
MAKEBIN ?= makebin

CFLAGS := -mz80 --opt-code-size --std-sdcc11
OBJS   := crt0.rel spi.rel main.rel diskio.rel pff.rel

all: ../rtl/galaga_boot.hex

%.rel: %.s
	$(SDAS) -plosgff $@ $<

main.rel: main.c phoenix.h loader.h pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@
diskio.rel: diskio.c phoenix.h loader.h pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@
pff.rel: pff/pff.c pff/pff.h pff/diskio.h pff/pffconf.h
	$(SDCC) $(CFLAGS) -c $< -o $@

galaga_boot.ihx: $(OBJS)
	$(SDCC) -mz80 --no-std-crt0 --code-loc 0x0200 --data-loc 0x8800 -o $@ $(OBJS)
	@python3 -c "import re,sys; m=open('galaga_boot.map').read(); \
	  ends=[int(a,16)+int(l,16) for n,a,l in re.findall(r'^(_CODE|_INITIALIZER|_GSINIT|_GSFINAL|_HOME)\s+([0-9A-F]{8})\s+([0-9A-F]{8})',m,re.M)]; \
	  e=max(ends); print('boot code ends at %04X' % e); sys.exit(e > 0x2000)"

galaga_boot.bin: galaga_boot.ihx
	$(MAKEBIN) -s 8192 $< $@

../rtl/galaga_boot.hex: galaga_boot.bin bin2hex.py
	python3 bin2hex.py $< $@

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin *.rst

.PHONY: all clean
