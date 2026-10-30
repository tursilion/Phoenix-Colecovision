# Verilator simulation of the Phoenix Game Boy core.
#
#   make                build the simulator (obj_dir/Vgb_phoenix)
#   make sd.img         SD card image with the games in ROMS (NAME=file ...)
#
# The VHDL parts (the CPU and the sound) are turned into Verilog with
# Yosys + GHDL, then everything runs in Verilator.  Without verilator on
# the PATH both run in the docked-ise-147 Docker image, and the C++ is
# compiled here against tools/verilator (the image's g++ 7.5 is too old
# for Verilator 5).

ROOT           := $(abspath ../../..)
VERILATOR      ?= $(shell command -v verilator)
YOSYS          ?= $(shell command -v yosys)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
PYTHON    ?= $(if $(wildcard $(ROOT)/tools/python/venv/bin/python),$(ROOT)/tools/python/venv/bin/python,python3)
DOCKER    := docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/Gameboy/core/sim $(DOCKER_IMAGE)

RTL  := ../rtl
GB   := $(RTL)/gb
T80  := $(GB)/T80
VHDL := $(GB)/bus_savestates.vhd $(GB)/reg_savestates.vhd \
        $(T80)/T80_Pack.vhd $(T80)/T80_ALU.vhd $(T80)/T80_MCode.vhd \
        $(T80)/T80_Reg.vhd $(T80)/T80.vhd $(T80)/GBse.vhd $(GB)/gbc_snd.vhd
SRCS := $(RTL)/gb_phoenix.v $(RTL)/gb_cart.v $(GB)/gb.v $(GB)/video.v \
        $(GB)/sprites.v $(GB)/sprites_extra.v $(GB)/sprites_extra_store.v \
        $(GB)/timer.v $(GB)/hdma.v $(GB)/link.v $(GB)/ss_regs.v gen/gb_vhdl.v

SIM  := obj_dir/Vgb_phoenix
ROMS ?=

all: $(SIM)

GHDL_OPTS := --std=08 -fsynopsys -frelaxed
YOSYS_SCRIPT := ghdl $(GHDL_OPTS) $(VHDL) -e GBse; \
                ghdl $(GHDL_OPTS) $(VHDL) -e gbc_snd; \
                write_verilog -noattr gen/gb_vhdl.v

gen/gb_vhdl.v: $(VHDL)
	mkdir -p gen
ifneq ($(YOSYS),)
	$(YOSYS) -q -m ghdl -p "$(YOSYS_SCRIPT)"
else
	$(DOCKER) yosys -q -m ghdl -p "$(YOSYS_SCRIPT)"
endif

gb_loader.hex: $(RTL)/gb_loader.hex
	cp $< $@
gb_boot.hex: $(GB)/gb_boot.hex
	cp $< $@

VARGS := --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module gb_phoenix $(VFLAGS) $(SRCS) tb.cpp

$(SIM): $(SRCS) tb.cpp gb_loader.hex gb_boot.hex
ifneq ($(VERILATOR),)
	$(VERILATOR) $(VARGS) --build -j 0
else
	$(DOCKER) verilator $(VARGS)
	$(MAKE) -C obj_dir -f Vgb_phoenix.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)
endif

sd.img: mksd.py
	$(PYTHON) mksd.py $@ fat32 $(ROMS)

clean:
	rm -rf obj_dir gen out *.img *.hex

.PHONY: all clean
