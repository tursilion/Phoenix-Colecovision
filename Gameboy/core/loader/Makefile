# Phoenix Game Boy loader (SDCC, sm83).
# Output: gb_loader.bin (16K ROM image) and ../rtl/gb_loader.hex (for the HDL).

SDCC    ?= sdcc
SDAS    ?= sdasgb
MAKEBIN ?= makebin

CFLAGS  := -msm83 --opt-code-size --max-allocs-per-node 20000
LDFLAGS := -msm83 --no-std-crt0 --code-loc 0x0200 --data-loc 0xD000

CSRCS := main.c diskio.c font.c pff/pff.c
ASRCS := crt0.s spi.s
RELS  := $(ASRCS:.s=.rel) $(CSRCS:.c=.rel)

all: ../rtl/gb_loader.hex

%.rel: %.s
	$(SDAS) -plosgff $@ $<

%.rel: %.c phoenix.h pff/pff.h pff/pffconf.h pff/diskio.h
	$(SDCC) $(CFLAGS) -c -o $@ $<

gb_loader.ihx: $(RELS)
	$(SDCC) $(LDFLAGS) -o $@ $(RELS)

gb_loader.bin: gb_loader.ihx
	$(MAKEBIN) -s 16384 $< $@

../rtl/gb_loader.hex: gb_loader.bin bin2hex.py
	python3 bin2hex.py $< $@

clean:
	rm -f *.rel *.lst *.sym *.asm *.ihx *.map *.noi *.lk *.bin pff/*.rel pff/*.lst pff/*.sym pff/*.asm

.PHONY: all clean
