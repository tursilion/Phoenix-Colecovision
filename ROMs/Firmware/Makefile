CP     := cp
RM     := rm -f
ROMGEN := romgen

DIRGIT := ../..
DIRPHX := ../../../ISE/Phoenix
DIRZX1 := ../../../ISE/ZX-Uno

.ONESHELL:

.PHONY: all clean loader merge merge-zxuno load load-zxuno

all: loader FIRMWARE.ROM

FIRMWARE.ROM: FIRMWARE.S80 PGT.BIN
	ORGASMIC $< $@

PGT.BIN: PGT.PNG
	SEX PGT $< $@

load: jtag.phoenix phoenix_top.merged.bit
	sudo jtag $<

load-zxuno: jtag.zxuno zxuno_top.merged.bit
	sudo jtag $<

clean:
	$(RM) *.ROM *.bit *.map *.lk *.noi *.bin *.ihx *.mem

loader: $(DIRGIT)/loaderrom.vhd loader.mem

merge: phoenix_top.merged.bit

merge-zxuno: zxuno_top.merged.bit

phoenix_top.merged.bit: loader.mem $(DIRPHX)/phoenix_top.bit
	data2mem -bm $(DIRGIT)/loaderrom_bd.bmm -bt $(DIRPHX)/phoenix_top.bit -bd $< tag avrmap.loaderrom -o b $@

zxuno_top.merged.bit: loader.mem $(DIRZX1)/zxuno_top.bit
	data2mem -bm $(DIRGIT)/loaderrom_bd.bmm -bt $(DIRZX1)/zxuno_top.bit -bd $< tag avrmap.loaderrom -o b $@

$(DIRGIT)/loaderrom.vhd: FIRMWARE.ROM
	$(ROMGEN) $< loaderrom 13 l r > $@

loader.mem: FIRMWARE.ROM
	$(ROMGEN) $< loaderrom 13 m r > $@
