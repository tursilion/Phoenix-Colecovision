CP = cp
RM = rm -f
CC = sdcc
AS = sdasz80
LD = sdcc
H2B = hex2bin
ROMGEN = romgen

SDIR = src
IDIR = inc
ODIR = obj

CFLAGS = -mz80 --opt-code-size --fomit-frame-pointer -I$(IDIR) -I..
LDFLAGS = -mz80 --code-loc 0x0100 --data-loc 0x6000 --no-std-crt0

_OBJS = crt0.rel main.rel vdp.rel mmc.rel joy.rel fat.rel
OBJS = $(patsubst %,$(ODIR)/%,$(_OBJS))

.ONESHELL:

.PHONY: all clean loader merge merge-zxuno load-zxuno

load-zxuno: jtag.zxuno zxuno_top.merged.bit
	sudo jtag $<

all: loader

clean:
	$(RM) $(ODIR)/* *.map *.lk *.noi *.bin *.ihx *.mem

loader: ../../src/rom/loaderrom.vhd loader.mem

merge: CollectorvisionFPGA_top.merged.bit

merge-zxuno: zxuno_top.merged.bit

CollectorvisionFPGA_top.merged.bit: loader.mem
	data2mem -bm ../../src/rom/loaderrom_bd.bmm -bt ../../synth/CollectorvisionFPGA/CollectorvisionFPGA_top.bit -bd $< tag avrmap.loaderrom -o b $@

zxuno_top.merged.bit: loader.mem
	data2mem -bm ../../src/rom/loaderrom_bd.bmm -bt ../../synth/zxuno/zxuno_top.bit -bd $< tag avrmap.loaderrom -o b $@

../../src/rom/loaderrom.vhd: loader.pad.bin
	$(ROMGEN) $< loaderrom 13 l r > $@

loader.mem: loader.pad.bin
	$(ROMGEN) $< loaderrom 13 m r > $@

loader.pad.bin: loader.bin
	pad $< $@ 8192 255

loader.bin: loader.ihx

loader.ihx: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

#dir:
#	if not exist obj mkdir obj

$(ODIR)/%.rel: $(SDIR)/%.s
	$(AS) -o $@ $<

$(ODIR)/%.rel: $(SDIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.bin: %.ihx
	$(H2B) -e bin $<

