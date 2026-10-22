# Verilator simulation of the Phoenix Time Pilot '84 core.
#
#   make             build the simulator (obj_dir/Vtp84_phoenix)
#   make sd.img      SD card image with the ROM set in TP84/
#   make run         boot and run 600 frames, every 30th frame to out/
#
# Needs Verilator 5 and Yosys with the GHDL plugin (the OSS CAD Suite, also
# in the docked-ise-147 image).  The ROMs are read from ROMSET.

VERILATOR ?= verilator
PYTHON    ?= python3
ROMSET    ?= ../../tp84

RTL  := ../rtl
SRCS := $(RTL)/tp84_phoenix.v $(RTL)/tp84_main.v $(RTL)/tp84_sound.v $(RTL)/sn76489.v \
        $(wildcard $(RTL)/tv80/*.v) obj_vhdl/cpu09.v

SIM  := obj_dir/Vtp84_phoenix

all: $(SIM)

obj_vhdl/cpu09.v: $(RTL)/cpu09/cpu09.vhd vhdl2v.sh
	./vhdl2v.sh

tp84_boot.hex: $(RTL)/tp84_boot.hex
	cp $< $@
font64.hex: $(RTL)/font64.hex
	cp $< $@

# Two steps, so the C++ can be compiled with another compiler than the one
# next to Verilator (the docked-ise-147 image's g++ 7 is too old):
#   make gen              (where Verilator is)
#   make VERILATOR_ROOT=... (anywhere with a recent g++ and Verilator's
#                          include/ and bin/ directories)
gen: obj_dir/Vtp84_phoenix.mk

obj_dir/Vtp84_phoenix.mk: $(SRCS) tb.cpp tp84_boot.hex font64.hex
	$(VERILATOR) --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module tp84_phoenix $(SRCS) tb.cpp
	touch $@

$(SIM): obj_dir/Vtp84_phoenix.mk tb.cpp
	$(MAKE) -C obj_dir -f Vtp84_phoenix.mk

sd.img: mkimg.py
	$(PYTHON) mkimg.py $@ $(foreach f,$(wildcard $(ROMSET)/*),TP84/$(notdir $(f))=$(f))

run: $(SIM) sd.img
	mkdir -p out
	$(SIM) --sd sd.img --frames 600 --ppm out/f --ppm-every 30 --wav out/audio.wav

clean:
	rm -rf obj_dir obj_vhdl out *.img *.hex

.PHONY: all gen run clean
