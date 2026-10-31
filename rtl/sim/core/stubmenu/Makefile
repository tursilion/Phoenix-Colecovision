# The stub menu (SDCC Z80): menu.hex for the simulation's loader ROM.
#   make IMG_BLOCKS=32 IMG_SGM=0
IMG_BLOCKS ?= 32
IMG_SGM    ?= 0
all: ../menu.hex
crt0.rel: crt0.s
	sdasz80 -plosgff $@ $<
main.rel: main.c FORCE
	sdcc -mz80 --std-sdcc99 -DIMG_BLOCKS=$(IMG_BLOCKS) -DIMG_SGM=$(IMG_SGM) -DPRELOADED -c -o $@ $<
stub.ihx: crt0.rel main.rel
	sdcc -mz80 --no-std-crt0 --code-loc 0x0100 --data-loc 0x7000 -o $@ $^
stub.bin: stub.ihx
	makebin -s 24576 $< $@
../menu.hex: stub.bin
	python3 -c "d=open('stub.bin','rb').read(); open('$@','w').write('\n'.join('%02x' % b for b in d) + '\n')"
FORCE:
.PHONY: all FORCE
