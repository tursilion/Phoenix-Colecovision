# Phoenix PC Engine loader (cc65, HuC6280).
# Output: tg16_loader.bin (16K, $C000-$FFFF) and ../rtl/tg16_loader.hex (for
# the HDL, in ROM bank order).

CL65   ?= cl65
CFLAGS := -t none -Oirs --cpu huc6280
SRCS   := crt0.s main.c font.c diskio.c spi.s pff/pff.c

all: ../rtl/tg16_loader.hex

tg16_loader.bin: $(SRCS) boot.cfg phoenix.h pff/pff.h pff/pffconf.h pff/diskio.h
	$(CL65) $(CFLAGS) -C boot.cfg -m tg16_loader.map -o $@ $(SRCS)

../rtl/tg16_loader.hex: tg16_loader.bin bin2hex.py
	python3 bin2hex.py $< $@

clean:
	rm -f tg16_loader.bin tg16_loader.map *.o pff/*.o

.PHONY: all clean
