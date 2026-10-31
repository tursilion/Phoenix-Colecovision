# Verilator simulation of the ColecoVision core with the ROM cache.
#
#   make             gen/cv.v (GHDL + Yosys) and obj_dir/Vsim_top
#   make menu.hex    the menu ROM, from gameMenus/coleco/src/phoenixBoot.rom
#
# The F18A and the menu ROM block RAM are replaced by vdp_spy.v and
# rom_sim.v (f18a_stub.vhd, romloader_stub.vhd).  Tools run in the
# docked-ise-147 Docker image; the C++ is compiled here against
# tools/verilator.

ROOT           := $(abspath ../../..)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
DOCKER := docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/rtl/sim/core $(DOCKER_IMAGE)

R := /w/rtl
VHDL := $(R)/t80/T80_Pack.vhd $(R)/t80/T80_ALU.vhd $(R)/t80/T80_MCode.vhd $(R)/t80/T80_Reg.vhd \
        $(R)/t80/T80.vhd $(R)/t80/T80se.vhd $(R)/audio/sn76489_audio.vhd $(R)/audio/ym2149_audio.vhd \
        $(R)/peripheral/cv_keys_pack.vhd $(R)/peripheral/cv_ctrl.vhd $(R)/peripheral/sdcard.vhd \
        $(R)/rombios.vhd $(R)/ext512x8sram.vhd /w/rtl/sim/core/f18a_stub.vhd \
        /w/rtl/sim/core/romloader_stub.vhd $(R)/colecovision.vhd
VSRC := gen/cv.v ../../cv_cache.v vdp_spy.v rom_sim.v sim_top.v

SIM := obj_dir/Vsim_top

all: $(SIM) menu.hex

gen/cv.v: ../../colecovision.vhd f18a_stub.vhd romloader_stub.vhd
	mkdir -p gen
	$(DOCKER) bash -c 'export PATH=/opt/oss-cad-suite/bin:$$PATH; yosys -q -m ghdl -p "ghdl --std=08 -fsynopsys -frelaxed $(VHDL) -e colecovision; write_verilog -noattr gen/cv.v"'
	python3 fixbus.py $@

menu.hex: ../../../gameMenus/coleco/src/phoenixBoot.rom
	python3 -c "import sys; d=open('$<','rb').read(); open('$@','w').write('\n'.join('%02x' % b for b in d) + '\n')"

$(SIM): $(VSRC) tb.cpp
	$(DOCKER) verilator --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style --top-module sim_top $(VSRC) tb.cpp
	$(MAKE) -C obj_dir -f Vsim_top.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)

clean:
	rm -rf obj_dir gen menu.hex

.PHONY: all clean
