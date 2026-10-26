# Verilator simulation of the Phoenix Intellivision core.
#
#   make                build the simulator (obj_dir/Vintv_phoenix)
#   make sd.img         SD card image with the cartridges in ROMS (a folder)
#   make run            boot, open the first file, run FRAMES frames,
#                       every 30th frame to out/
#
# The VHDL Intellivision (rtl/intv_core.vhd and rtl/intv/) is turned into
# Verilog with Yosys + GHDL, then everything runs in Verilator.  Without
# verilator on the PATH both run in the docked-ise-147 Docker image, and
# the C++ is compiled here against tools/verilator (the image's g++ 7.5 is
# too old for Verilator 5).
#
# The SD card needs the Intellivision BIOS: BIOS is the folder with
# exec.bin, grom.bin (and ecs.bin, sp0256-012.bin), put in INTV/.

ROOT           := $(abspath ../../..)
VERILATOR      ?= $(shell command -v verilator)
YOSYS          ?= $(shell command -v yosys)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
PYTHON    ?= $(if $(wildcard $(ROOT)/tools/python/venv/bin/python),$(ROOT)/tools/python/venv/bin/python,python3)
DOCKER    := docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/intellivision/core/sim $(DOCKER_IMAGE)

BIOS ?= ../..
RTL  := ../rtl
VHDL := $(RTL)/intv/base_pack.vhd $(RTL)/intv/cp1610_pack.vhd \
        $(RTL)/intv/cp1610.vhd $(RTL)/intv/snd.vhd $(RTL)/intv/stic.vhd \
        $(RTL)/intv/ivoice.vhd $(RTL)/intv/jlp.vhd \
        $(RTL)/intv_cart.vhd $(RTL)/intv_core.vhd
SRCS := $(RTL)/intv_phoenix.v $(RTL)/cpu6502/cpu.v $(RTL)/cpu6502/ALU.v gen/intv_core_syn.v

SIM  := obj_dir/Vintv_phoenix
FRAMES ?= 600
ROMS   ?=

all: $(SIM)

YOSYS_SCRIPT := ghdl --std=93c -fexplicit $(VHDL) -e intv_core; write_verilog -noattr gen/intv_core_syn.v

gen/intv_core_syn.v: $(VHDL)
	mkdir -p gen
ifneq ($(YOSYS),)
	$(YOSYS) -q -m ghdl -p "$(YOSYS_SCRIPT)"
else
	$(DOCKER) yosys -q -m ghdl -p "$(YOSYS_SCRIPT)"
endif

intv_boot.hex: $(RTL)/intv_boot.hex
	cp $< $@
font.hex: $(RTL)/font.hex
	cp $< $@

VARGS := --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module intv_phoenix $(VFLAGS) $(SRCS) tb.cpp

$(SIM): $(SRCS) tb.cpp intv_boot.hex font.hex
ifneq ($(VERILATOR),)
	$(VERILATOR) $(VARGS) --build -j 0
else
	$(DOCKER) verilator $(VARGS)
	$(MAKE) -C obj_dir -f Vintv_phoenix.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)
endif

BIOS_FILES := INTV/EXEC.BIN=$(BIOS)/exec.bin INTV/GROM.BIN=$(BIOS)/grom.bin \
              $(if $(wildcard $(BIOS)/ecs.bin),INTV/ECS.BIN=$(BIOS)/ecs.bin) \
              $(if $(wildcard $(BIOS)/sp0256-012.bin),INTV/SP0256-012.BIN=$(BIOS)/sp0256-012.bin)

sd.img: mksd.py
	$(PYTHON) mksd.py $@ fat32 $(BIOS_FILES) $(ROMS)

run: $(SIM) sd.img
	mkdir -p out
	$(SIM) --sd sd.img --frames $(FRAMES) --pad 55:20,57:00,60:01,62:00 --ppm out/f --ppm-every 30

clean:
	rm -rf obj_dir gen out *.img *.hex

.PHONY: all run clean
