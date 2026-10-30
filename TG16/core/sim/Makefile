# Verilator simulation of the Phoenix PC Engine core.
#
#   make                build the simulator (obj_dir/Vtg16_phoenix)
#   make sd.img         SD card image with the games in ROMS (NAME=file ...)
#
# The VHDL PC Engine (rtl/pce) is turned into Verilog with Yosys + GHDL,
# then everything runs in Verilator.  Without verilator on the PATH both
# run in the docked-ise-147 Docker image, and the C++ is compiled here
# against tools/verilator (the image's g++ 7.5 is too old for Verilator 5).

ROOT           := $(abspath ../../..)
VERILATOR      ?= $(shell command -v verilator)
YOSYS          ?= $(shell command -v yosys)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
PYTHON    ?= $(if $(wildcard $(ROOT)/tools/python/venv/bin/python),$(ROOT)/tools/python/venv/bin/python,python3)
DOCKER    := docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/TG16/core/sim $(DOCKER_IMAGE)

RTL  := ../rtl
PCE  := $(RTL)/pce
VHDL := $(addprefix $(PCE)/,HUC6280_PKG.vhd psg_vol.vhd dpram.vhd AddSubBCD.vhd \
        HUC6280_ALU.vhd HUC6280_AG.vhd HUC6280_MC.vhd HUC6280_CPU.vhd psg.vhd \
        HUC6280.vhd huc6260.vhd huc6270.vhd pce_top.vhd)
SRCS := $(RTL)/tg16_phoenix.v gen/pce_vhdl.v

SIM  := obj_dir/Vtg16_phoenix
ROMS ?=

all: $(SIM)

GHDL_OPTS := --std=08 -fsynopsys -frelaxed
YOSYS_SCRIPT := ghdl $(GHDL_OPTS) $(VHDL) -e pce_top; \
                write_verilog -noattr gen/pce_vhdl.v

gen/pce_vhdl.v: $(VHDL)
	mkdir -p gen
ifneq ($(YOSYS),)
	$(YOSYS) -q -m ghdl -p "$(YOSYS_SCRIPT)"
else
	$(DOCKER) yosys -q -m ghdl -p "$(YOSYS_SCRIPT)"
endif

tg16_loader.hex: $(RTL)/tg16_loader.hex
	cp $< $@

VARGS := --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module tg16_phoenix $(VFLAGS) $(SRCS) tb.cpp

$(SIM): $(SRCS) tb.cpp tg16_loader.hex
ifneq ($(VERILATOR),)
	$(VERILATOR) $(VARGS) --build -j 0
else
	$(DOCKER) verilator $(VARGS)
	$(MAKE) -C obj_dir -f Vtg16_phoenix.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)
endif

sd.img: mksd.py
	$(PYTHON) mksd.py $@ fat32 $(ROMS)

clean:
	rm -rf obj_dir gen out *.img *.hex

.PHONY: all clean
