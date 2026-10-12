# Phoenix NES boot loader.  Needs cc65 (cl65) on the PATH, or CC65_HOME set.
# Output: nes_boot.bin (16K ROM image) and ../rtl/nes_boot.hex (for the HDL).

ifdef CC65_HOME
CL65 := $(CC65_HOME)/bin/cl65
else
CL65 := cl65
endif

CFLAGS := -t none -Oirs --cpu 6502
SRCS   := crt0.s main.c font.c diskio.c spi.s pff/pff.c

all: ../rtl/nes_boot.hex

nes_boot.bin: $(SRCS) boot.cfg phoenix.h pff/pff.h pff/pffconf.h pff/diskio.h
	$(CL65) $(CFLAGS) -C boot.cfg -m nes_boot.map -o $@ $(SRCS)

../rtl/nes_boot.hex: nes_boot.bin bin2hex.py
	python3 bin2hex.py $< $@

clean:
	rm -f nes_boot.bin nes_boot.map *.o pff/*.o

.PHONY: all clean
