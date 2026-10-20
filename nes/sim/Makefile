# Verilator simulation of the Phoenix NES core.
#
#   make            build the simulator (obj_dir/Vnes_phoenix)
#   make test       boot the test cartridge from FAT16, FAT32 and MBR images
#                   and check the picture
#
# Needs mkfs.fat, python3 with pyfatfs (tools/python/setup.sh), cc65 (for
# testrom), and either verilator on the PATH or the docked-ise-147 Docker image:
# then Verilator runs in the image (its g++ is too old to compile the result)
# and the C++ is compiled here against tools/verilator.

ROOT           := $(abspath ../..)
VERILATOR      ?= $(shell command -v verilator)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
PYTHON    ?= $(if $(wildcard $(ROOT)/tools/python/venv/bin/python),$(ROOT)/tools/python/venv/bin/python,python3)
CL65      ?= cl65

RTL  := ../rtl
SRCS := $(RTL)/nes_phoenix.v $(RTL)/apu_filter.v $(RTL)/fpganes/nes.v $(RTL)/fpganes/game_loader.v xilinx_prims.v

SIM  := obj_dir/Vnes_phoenix

all: $(SIM)

VARGS := --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module nes_phoenix -I$(RTL)/fpganes \
	  -GBOOTROM_FILE='"$(RTL)/nes_boot.hex"' \
	  -GPALETTE_FILE='"$(RTL)/fpganes/nes_palette.txt"' \
	  $(SRCS) tb.cpp

$(SIM): $(SRCS) tb.cpp $(RTL)/nes_boot.hex
ifneq ($(VERILATOR),)
	$(VERILATOR) $(VARGS) --build -j 0
else
	docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/nes/sim $(DOCKER_IMAGE) verilator $(VARGS)
	$(MAKE) -C obj_dir -f Vnes_phoenix.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)
endif

testrom/testrom.nes: testrom/testrom.s testrom/testrom.cfg
	$(CL65) -t none -C testrom/testrom.cfg -o $@ $<
	rm -f testrom/testrom.o

sd_fat16.img: testrom/testrom.nes mksd.py
	$(PYTHON) mksd.py $@ fat16 GAME.NES=$<
sd_fat32.img: testrom/testrom.nes mksd.py
	$(PYTHON) mksd.py $@ fat32 TEST.NES=$<
sd_mbr.img: testrom/testrom.nes mksd.py
	$(PYTHON) mksd.py $@ fat32 --mbr GAME.NES=$<

# ppu.v loads this by bare name from the working directory.
oam_palette.txt: $(RTL)/fpganes/oam_palette.txt
	cp $< $@

sd_menu.img: testrom/testrom.nes mksd.py
	$(PYTHON) mksd.py $@ fat32 --mbr ZZZ.NES=$< AAA.NES=$< GAMES/TEST.NES=$< EMPTY/README.TXT=mksd.py

# The menu starts on the first entry; A (01) opens it.  sd_menu.img lists
# EMPTY/, GAMES/, AAA.NES, ZZZ.NES: Down (20) to GAMES/, A, then Down past
# ".." to TEST.NES, A.
test: $(SIM) oam_palette.txt sd_fat16.img sd_fat32.img sd_mbr.img sd_menu.img
	$(SIM) --sd sd_fat16.img --frames 100 --pad 50:01,52:00 --press-a 90 --check
	$(SIM) --sd sd_fat32.img --frames 100 --pad 60:01,62:00 --check
	$(SIM) --sd sd_mbr.img --frames 100 --pad 60:01,62:00 --check
	$(SIM) --sd sd_menu.img --frames 200 --pad 60:20,62:00,70:01,72:00,110:20,112:00,120:01,122:00 --check
	@echo "Back to the menu from the game, then start AAA.NES"
	$(SIM) --sd sd_menu.img --frames 300 --menu-reset 180 \
	  --pad 60:20,64:00,70:01,74:00,110:20,114:00,120:01,124:00,240:20,244:00,250:20,254:00,262:01,266:00 --check

clean:
	rm -rf obj_dir *.img *.ppm oam_palette.txt

.PHONY: all test clean
