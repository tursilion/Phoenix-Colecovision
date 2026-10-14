# Verilator simulation of the Phoenix Dragon's Lair core.
#
#   make             build the simulator (obj_dir/Vdl_phoenix)
#   make lair        boot Dragon's Lair from a simulated card with a test disc
#
# The game ROMs are not part of the repository: LAIR_ROMS and ACE_ROMS point
# at them (u1..u4 / u1..u5).

VERILATOR ?= verilator
PYTHON    ?= python3

RTL  := ../rtl
SRCS := $(RTL)/dl_phoenix.v $(RTL)/ldv1000.v $(RTL)/sd_stream.v $(RTL)/video.v \
        $(RTL)/disc_audio.v $(wildcard $(RTL)/tv80/*.v) $(wildcard $(RTL)/jt49/*.v)

SIM  := obj_dir/Vdl_phoenix

LAIR_ROMS ?= $(addprefix ../../lair/dl_f2_u,$(addsuffix .bin,1 2 3 4))
ACE_ROMS  ?= $(addprefix ../../ace/sa_a3_u,$(addsuffix .bin,1 2 3 4 5))

all: $(SIM)

$(SIM): $(SRCS) tb.cpp $(RTL)/dl_boot.hex $(RTL)/font.hex
	$(VERILATOR) --cc --exe --build -j 0 -O3 -Wno-fatal -Wno-lint -Wno-style \
	  --top-module dl_phoenix -DDL_SIM_TRACE -DDL_SIM_CHECK \
	  -GBOOTROM_FILE='"$(RTL)/dl_boot.hex"' -GFONT_FILE='"$(RTL)/font.hex"' \
	  $(SRCS) tb.cpp

# Disc files with the header, the ROM and only frame 0; the testbench makes
# up the frames (test pattern) from the first frame's sector on.
lair.ld: ../tools/mkdisc.py
	$(PYTHON) ../tools/mkdisc.py $@ --rom $(LAIR_ROMS) --game lair --test --file-frames 1
ace.ld: ../tools/mkdisc.py
	$(PYTHON) ../tools/mkdisc.py $@ --rom $(ACE_ROMS) --game ace --test --file-frames 1

sd_lair.img: lair.ld ace.ld mkimg.py
	$(PYTHON) mkimg.py $@ LAIR.LD=lair.ld ACE.LD=ace.ld > sd_lair.txt
	cat sd_lair.txt

clean:
	rm -rf obj_dir *.img *.ld *.ppm *.png *.wav sd_*.txt

.PHONY: all clean
