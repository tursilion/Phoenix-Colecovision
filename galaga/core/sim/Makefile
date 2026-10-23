# Verilator simulation of the Phoenix Galaga core.
#
#   make             build the simulator (obj_dir/Vgalaga_phoenix)
#   make sd.img      SD card image with the ROM set in GALAGA/
#   make run         boot and run 600 frames, every 30th frame to out/
#
# Needs Verilator 5 (the OSS CAD Suite, also in the docked-ise-147 image).
# The ROMs are read from ROMSET.

VERILATOR ?= verilator
PYTHON    ?= python3
ROMSET    ?= ../../galaga

RTL  := ../rtl
SRCS := $(RTL)/galaga_phoenix.v $(RTL)/galaga_main.v $(RTL)/galaga_video.v \
        $(RTL)/galaga_sound.v $(RTL)/mb88.v $(wildcard $(RTL)/tv80/*.v)

SIM  := obj_dir/Vgalaga_phoenix

all: $(SIM)

galaga_boot.hex: $(RTL)/galaga_boot.hex
	cp $< $@
font64.hex: $(RTL)/font64.hex
	cp $< $@

# Two steps, so the C++ can be compiled with another compiler than the one
# next to Verilator (the docked-ise-147 image's g++ 7 is too old):
#   make gen              (where Verilator is)
#   make VERILATOR_ROOT=... (anywhere with a recent g++ and Verilator's
#                          include/ and bin/ directories)
gen: obj_dir/Vgalaga_phoenix.mk

obj_dir/Vgalaga_phoenix.mk: $(SRCS) tb.cpp galaga_boot.hex font64.hex
	$(VERILATOR) --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module galaga_phoenix $(SRCS) tb.cpp
	touch $@

$(SIM): obj_dir/Vgalaga_phoenix.mk tb.cpp
	$(MAKE) -C obj_dir -f Vgalaga_phoenix.mk

sd.img: mkimg.py
	$(PYTHON) mkimg.py $@ $(foreach f,$(wildcard $(ROMSET)/*),GALAGA/$(notdir $(f))=$(f))

run: $(SIM) sd.img
	mkdir -p out
	$(SIM) --sd sd.img --frames 600 --ppm out/f --ppm-every 30 --wav out/audio.wav

clean:
	rm -rf obj_dir obj_vhdl out *.img *.hex

.PHONY: all gen run clean
