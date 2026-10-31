# LED test core: the Phoenix ColecoVision core with port >5F, which lets a
# cart drive the board's LEDs (see ../README.md).  Built from ../../rtl
# except colecovision.vhd and phoenix_top.vhd, which are the copies in
# ../rtl.  Goes in slot 29 so the real ColecoVision core (slot 1) is kept.
#
#   make            synthesize, implement, merge the menu ROM, make the core file
#   make clean
#
# The core revision shown to users is the .PHX header "issue" (16-bit LE at
# offset 0x10, after the name).  Set it with: make CORE_ISSUE=1
#
# The game menu ROM is taken pre-built from $(BOOTROM) and merged into the
# loader block RAM with data2mem (see ../romloader.bmm), so the menu can be
# changed without re-running the implementation: delete $(TOP).merged.bit
# and run make again.
#
# Outputs (in this directory):
#   phoenix_top.bit          bitstream with the stub loader only
#   phoenix_top.merged.bit   with the menu ROM, for JTAG (iMPACT)
#   phoenix_top.merged.bin   raw bitstream
#   $(CORE_FILE)             for the Phoenix boot loader (SD card update)

ISE_SETTINGS ?= /opt/Xilinx/14.7/ISE_DS/settings64.sh
PART         := xc6slx16-2-csg324
TOP          := phoenix_top
CORE_FILE    ?= CORE29.PHX
CORE_NAME    := COLECO LED TEST
CORE_ISSUE   ?= 0

REPO    := ../..
RTL     := $(REPO)/rtl
UCF     := $(RTL)/phoenix.ucf
BMM     := $(RTL)/romloader.bmm
BOOTROM ?= $(REPO)/gameMenus/coleco/src/phoenixBoot.rom

VHDL := \
  $(RTL)/dcm_pll/clk_sys_pll.vhd \
  $(RTL)/HDMI/encoder.vhd \
  $(RTL)/HDMI/hdmidelay.vhd \
  $(RTL)/HDMI/hdmi.vhd \
  $(RTL)/HDMI/hdmi_out_xilinx.vhd \
  $(RTL)/t80/T80_Pack.vhd \
  $(RTL)/t80/T80_ALU.vhd \
  $(RTL)/t80/T80_MCode.vhd \
  $(RTL)/t80/T80_Reg.vhd \
  $(RTL)/t80/T80.vhd \
  $(RTL)/t80/T80se.vhd \
  $(RTL)/f18a/f18a_version.vhd \
  $(RTL)/f18a/f18a_single_port_ram.vhd \
  $(RTL)/f18a/f18a_vram.vhd \
  $(RTL)/f18a/f18a_color.vhd \
  $(RTL)/f18a/f18a_counters.vhd \
  $(RTL)/f18a/f18a_div32x16.vhd \
  $(RTL)/f18a/f18a_gpu.vhd \
  $(RTL)/f18a/f18a_cpu.vhd \
  $(RTL)/f18a/f18a_sprites.vhd \
  $(RTL)/f18a/f18a_tile_linebuf.vhd \
  $(RTL)/f18a/f18a_tiles.vhd \
  $(RTL)/f18a/f18a_vga_cont_640_60.vhd \
  $(RTL)/f18a/f18a_core.vhd \
  $(RTL)/f18a/f18a_top.vhd \
  $(RTL)/audio/sn76489_audio.vhd \
  $(RTL)/audio/ym2149_audio.vhd \
  $(RTL)/peripheral/cv_keys_pack.vhd \
  $(RTL)/peripheral/cv_ctrl.vhd \
  $(RTL)/peripheral/sdcard.vhd \
  $(RTL)/peripheral/ps2kbd_pkg.vhd \
  $(RTL)/peripheral/ps2kbd.vhd \
  $(RTL)/peripheral/keyboard.vhd \
  $(RTL)/peripheral/snespad/snespad_pack-p.vhd \
  $(RTL)/peripheral/snespad/snespad_comp-pack.vhd \
  $(RTL)/peripheral/snespad/snespad_ctrl.vhd \
  $(RTL)/peripheral/snespad/snespad_pad.vhd \
  $(RTL)/peripheral/snespad/snespad.vhd \
  $(RTL)/romloader.vhd \
  $(RTL)/rombios.vhd \
  $(RTL)/ext512x8sram.vhd \
  ../rtl/colecovision.vhd \
  ../rtl/phoenix_top.vhd

VERILOG := \
  $(RTL)/HDMI/hdmidataencoder.v \
  $(RTL)/cv_cache.v

# Bitstream options for the Phoenix multiboot loader, matching the shipped
# CORE01.PHX (ConfigRate 26, unused pins floating).
BITGEN_OPTS := \
  -g CRC:Enable \
  -g DonePipe:Yes \
  -g next_config_register_write:Enable \
  -g SPI_buswidth:1 \
  -g Binary:Yes \
  -g ConfigRate:26 \
  -g UnusedPin:Pullnone

# ISE tools come from ISE_SETTINGS when ISE is installed; otherwise each
# tool runs in the docked-ise-147 Docker image with the repo mounted.
ifneq ($(wildcard $(ISE_SETTINGS)),)
ISE = . $(ISE_SETTINGS) > /dev/null &&
else
ISE_IMAGE ?= docked-ise-147
ISE_LIC   ?= $(HOME)/Docked-ISE-147/Xilinx.lic
REPO_ABS  := $(abspath $(REPO))
ISE = docker run --rm -u 0 -v $(REPO_ABS):/workspace \
  -v $(ISE_LIC):/root/.Xilinx/Xilinx.lic \
  -w /workspace/$(patsubst $(REPO_ABS)/%,%,$(CURDIR)) $(ISE_IMAGE)
endif

all: $(CORE_FILE)

# Only replaced when the contents change, so editing the Makefile (e.g. for
# the issue number) doesn't re-run synthesis.
$(TOP).prj: Makefile
	rm -f $@.new
	for f in $(VHDL); do echo "vhdl work \"$$f\"" >> $@.new; done
	for f in $(VERILOG); do echo "verilog work \"$$f\"" >> $@.new; done
	cmp -s $@.new $@ && rm $@.new || mv $@.new $@

$(TOP).xst: Makefile
	printf '%s\n' \
	  'set -tmpdir xst_tmp' \
	  'set -xsthdpdir xst_hdp' \
	  'run' \
	  '-ifn $(TOP).prj' \
	  '-ofn $(TOP)' \
	  '-ofmt NGC' \
	  '-p $(PART)' \
	  '-top $(TOP)' \
	  '-opt_mode Speed' \
	  '-opt_level 1' \
	  > $@.new
	cmp -s $@.new $@ && rm $@.new || mv $@.new $@

$(TOP).ngc: $(TOP).prj $(TOP).xst $(VHDL) $(VERILOG)
	mkdir -p xst_tmp xst_hdp
	$(ISE) xst -ifn $(TOP).xst -ofn $(TOP).syr

# The BMM names the loader block RAMs; par writes the placed $(TOP)_bd.bmm.
$(TOP).ngd: $(TOP).ngc $(UCF) $(BMM)
	cp $(BMM) $(TOP).bmm
	$(ISE) ngdbuild -p $(PART) -uc $(UCF) -bm $(TOP).bmm $(TOP).ngc $@

$(TOP)_map.ncd: $(TOP).ngd
	$(ISE) map -p $(PART) -w -ol high -pr b -o $@ $< $(TOP).pcf

$(TOP).ncd: $(TOP)_map.ncd
	$(ISE) par -w -ol high $< $@ $(TOP).pcf
	$(ISE) trce -v 3 -u 10 $@ $(TOP).pcf -o $(TOP).twr

$(TOP).bit $(TOP)_bd.bmm: $(TOP).ncd
	$(ISE) bitgen -w $(BITGEN_OPTS) $< $(TOP).bit $(TOP).pcf

makemem: $(REPO)/Utils/src_makemem/makemem.c
	gcc -Wall -O2 -o $@ $<
bit2bin: $(REPO)/Utils/src_bit2bin/bit2bin.c
	gcc -Wall -O2 -o $@ $<
bin2phx: $(REPO)/Utils/src_bin2phx/bin2phx.c
	gcc -Wall -O2 -o $@ $<

phoenixBoot.mem: $(BOOTROM) makemem
	./makemem m $< $@

$(TOP).merged.bit: $(TOP).bit $(TOP)_bd.bmm phoenixBoot.mem
	$(ISE) data2mem -bm $(TOP)_bd.bmm -bt $(TOP).bit \
	  -bd phoenixBoot.mem tag phoenix.loader -o b $@

$(TOP).merged.bin: $(TOP).merged.bit bit2bin
	./bit2bin $< $@

$(CORE_FILE): $(TOP).merged.bin bin2phx FORCE
	./bin2phx $< $@ "$(CORE_NAME)" $(CORE_ISSUE)

clean:
	rm -rf xst_tmp xst_hdp _xmsgs xlnx_auto_0_xdb *.prj *.xst *.syr *.ngc *.ngr *.lso \
	  *.ngd *.bld *.ncd *.pcf *.map *.mrp *.ngm *.par *.pad *.unroutes *.xpi *.ptwx \
	  *.twr *.twx *.bgn *.drc *.bit *.bin *.bmm *.mem *.xml *.xrpt *.html *.csv *.txt \
	  *_pad.* *.PHX makemem bit2bin bin2phx webtalk.log *.xwbt

FORCE:

.PHONY: all clean FORCE
