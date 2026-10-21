# Command-line ISE 14.7 build of the Phoenix Gyruss core.
#
#   make            synthesize, implement, and make the bitstream and core file
#   make loader     rebuild the boot loader (needs sdcc)
#   make clean
#
# ISE_SETTINGS points at ISE's settings script.  The core file goes to
# $(CORE_FILE); its slot number is in the name.
#
# Outputs (in this directory):
#   gyruss_phoenix_top.bit    for JTAG (iMPACT)
#   gyruss_phoenix_top.bin    raw bitstream
#   $(CORE_FILE)          for the Phoenix boot loader (SD card update)

ISE_SETTINGS ?= /opt/Xilinx/14.7/ISE_DS/settings64.sh
PART         := xc6slx16-2-csg324
TOP          := gyruss_phoenix_top
CORE_FILE    ?= CORE06.PHX
CORE_NAME    := GYRUSS
CORE_ISSUE   ?= 0101

REPO := ../../..
RTL  := $(REPO)/rtl
NRTL := ../rtl
UCF  := $(RTL)/phoenix.ucf

T48 := t48_pack-p.vhd t48_tb_pack-p.vhd alu_pack-p.vhd cond_branch_pack-p.vhd \
  dmem_ctrl_pack-p.vhd pmem_ctrl_pack-p.vhd decoder_pack-p.vhd t48_comp_pack-p.vhd \
  t48_core_comp_pack-p.vhd alu.vhd bus_mux.vhd clock_ctrl.vhd cond_branch.vhd db_bus.vhd \
  decoder.vhd dmem_ctrl.vhd generic_ram_ena.vhd int.vhd p1.vhd p2.vhd pmem_ctrl.vhd psw.vhd \
  timer.vhd t48_core.vhd t8039_notri.vhd

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
  $(NRTL)/cpu09/cpu09.vhd \
  $(addprefix $(NRTL)/t48/,$(T48)) \
  $(NRTL)/gyruss_phoenix_top.vhd

VERILOG := \
  $(RTL)/HDMI/hdmidataencoder.v \
  $(NRTL)/gyruss_phoenix.v \
  $(NRTL)/gyruss_main.v \
  $(NRTL)/gyruss_sound.v \
  $(NRTL)/ay5x.v \
  $(wildcard $(NRTL)/tv80/*.v)

VINCLUDES :=

# Loaded with $readmemh by bare name, so they must be in the XST directory.
MEMFILES := gyruss_boot.hex font64.hex

# Bitstream options for the Phoenix multiboot loader.  These reproduce the
# configuration words of the shipped ColecoVision core (CORE01.PHX), which
# differ slightly from Utils/src_bin2phx/README.md: no Reset_on_err, the
# default watchdog (0xFFFF), and DonePipe.
BITGEN_OPTS := \
  -g CRC:Enable \
  -g DonePipe:Yes \
  -g next_config_register_write:Enable \
  -g SPI_buswidth:1 \
  -g Binary:Yes \
  -g ConfigRate:26 \
  -g UnusedPin:Pullnone

ISE = . $(ISE_SETTINGS) > /dev/null &&

all: $(CORE_FILE)

gyruss_boot.hex: $(NRTL)/gyruss_boot.hex
	cp $< $@
font64.hex: $(NRTL)/font64.hex
	cp $< $@

$(TOP).prj: Makefile
	rm -f $@
	for f in $(VHDL); do echo "vhdl work \"$$f\"" >> $@; done
	for f in $(VERILOG); do echo "verilog work \"$$f\"" >> $@; done

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
	  > $@

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

$(CORE_FILE): $(TOP).bit bin2phx
	./bin2phx $(TOP).bin $@ $(CORE_NAME) $(CORE_ISSUE)

loader:
	$(MAKE) -C ../loader

clean:
	rm -rf xst_tmp xst_hdp _xmsgs xlnx_auto_0_xdb *.prj *.xst *.syr *.ngc *.ngr *.lso \
	  *.ngd *.bld *.ncd *.pcf *.map *.mrp *.ngm *.par *.pad *.unroutes *.xpi *.ptwx \
	  *.twr *.twx *.bgn *.drc *.bit *.bin *.xml *.xrpt *.html *.csv *.txt \
	  *_pad.* *.PHX bin2phx $(MEMFILES) webtalk.log usage_statistics_webtalk.html

.PHONY: all loader clean
