# Command-line ISE 14.7 build of the Phoenix NES core.
#
#   make            synthesize, implement, and make the bitstream and core file
#   make loader     rebuild the boot loader ROM (needs cc65)
#   make clean
#
# ISE_SETTINGS points at ISE's settings script.  The core file goes to
# $(CORE_FILE); its slot number is in the name.
#
# Outputs (in this directory):
#   nes_phoenix_top.bit   for JTAG (iMPACT)
#   nes_phoenix_top.bin   raw bitstream
#   $(CORE_FILE)          for the Phoenix boot loader (SD card update)

ISE_SETTINGS ?= /opt/Xilinx/14.7/ISE_DS/settings64.sh
PART         := xc6slx16-2-csg324
TOP          := nes_phoenix_top
CORE_FILE    ?= CORE04.PHX
CORE_NAME    := NES
CORE_ISSUE   ?= 0

REPO := ../..
RTL  := $(REPO)/rtl
NRTL := ../rtl
UCF  := $(RTL)/phoenix.ucf

VHDL := \
  $(RTL)/dcm_pll/clk_sys_pll.vhd \
  $(RTL)/HDMI/encoder.vhd \
  $(RTL)/HDMI/hdmidelay.vhd \
  $(RTL)/HDMI/hdmi.vhd \
  $(RTL)/HDMI/hdmi_out_xilinx.vhd \
  $(RTL)/peripheral/ps2kbd_pkg.vhd \
  $(RTL)/peripheral/ps2kbd.vhd \
  $(RTL)/peripheral/keyboard.vhd \
  $(RTL)/peripheral/snespad/snespad_pack-p.vhd \
  $(RTL)/peripheral/snespad/snespad_comp-pack.vhd \
  $(RTL)/peripheral/snespad/snespad_ctrl.vhd \
  $(RTL)/peripheral/snespad/snespad_pad.vhd \
  $(RTL)/peripheral/snespad/snespad.vhd \
  $(NRTL)/cv_pads.vhd \
  $(NRTL)/nes_phoenix_top.vhd

VERILOG := \
  $(RTL)/HDMI/hdmidataencoder.v \
  $(NRTL)/nes_phoenix.v \
  $(NRTL)/apu_filter.v \
  $(NRTL)/fpganes/nes.v \
  $(NRTL)/fpganes/game_loader.v

# fpganes's nes.v includes these.
VINCLUDES := $(wildcard $(NRTL)/fpganes/*.v)

# Loaded with $readmemh by bare name, so they must be in the XST directory.
MEMFILES := nes_boot.hex nes_palette.txt oam_palette.txt

# Bitstream options for the Phoenix multiboot loader.  These reproduce the
# configuration words of the shipped ColecoVision core (CORE01.PHX), which
# differ slightly from Utils/src_bin2phx/README.md: no Reset_on_err, the
# default watchdog (0xFFFF), and DonePipe.
BITGEN_OPTS := \
  -g CRC:Enable \
  -g DonePipe:Yes \
  -g next_config_register_write:Disable \
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

nes_boot.hex: $(NRTL)/nes_boot.hex
	cp $< $@
nes_palette.txt: $(NRTL)/fpganes/nes_palette.txt
	cp $< $@
oam_palette.txt: $(NRTL)/fpganes/oam_palette.txt
	cp $< $@

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
	  '-vlgincdir {"$(NRTL)/fpganes"}' \
	  > $@.new
	cmp -s $@.new $@ && rm $@.new || mv $@.new $@

$(TOP).ngc: $(TOP).prj $(TOP).xst $(VHDL) $(VERILOG) $(VINCLUDES) $(MEMFILES)
	mkdir -p xst_tmp xst_hdp
	$(ISE) xst -ifn $(TOP).xst -ofn $(TOP).syr

$(TOP).ngd: $(TOP).ngc $(UCF)
	$(ISE) ngdbuild -p $(PART) -uc $(UCF) $(TOP).ngc $@

$(TOP)_map.ncd: $(TOP).ngd
	$(ISE) map -p $(PART) -w -ol high -pr b -o $@ $< $(TOP).pcf

$(TOP).ncd: $(TOP)_map.ncd
	$(ISE) par -w -ol high $< $@ $(TOP).pcf
	$(ISE) trce -v 3 -u 10 $@ $(TOP).pcf -o $(TOP).twr

$(TOP).bit: $(TOP).ncd
	$(ISE) bitgen -w $(BITGEN_OPTS) $< $@ $(TOP).pcf

$(TOP).bin: $(TOP).bit

bin2phx: $(REPO)/Utils/src_bin2phx/bin2phx.c
	gcc -Wall -O2 -o $@ $<

$(CORE_FILE): $(TOP).bit bin2phx FORCE
	./bin2phx $(TOP).bin $@ $(CORE_NAME) $(CORE_ISSUE)

loader:
	$(MAKE) -C ../loader

clean:
	rm -rf xst_tmp xst_hdp _xmsgs xlnx_auto_0_xdb *.prj *.xst *.syr *.ngc *.ngr *.lso \
	  *.ngd *.bld *.ncd *.pcf *.map *.mrp *.ngm *.par *.pad *.unroutes *.xpi *.ptwx \
	  *.twr *.twx *.bgn *.drc *.bit *.bin *.xml *.xrpt *.html *.csv *.txt \
	  *_pad.* *.PHX bin2phx $(MEMFILES) webtalk.log usage_statistics_webtalk.html

FORCE:

.PHONY: all loader clean FORCE
