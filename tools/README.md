# tools

Everything needed to rebuild, simulate and inspect the Phoenix cores and the service menu, apart from
the Xilinx ISE installer (6.5 GB) and its license file. The older Windows utilities (`bin2phx`,
`data2mem`, ...) are in `../Utils`.

| Folder | What |
|---|---|
| `docker/` | Dockerfile for the `docked-ise-147` image: ISE 14.7 + OSS CAD Suite 2023-10-03 (Verilator 5.017, Yosys, GHDL) |
| `verilator/` | Verilator 5.017 include tree from that image, for compiling simulations on the host |
| `python/` | `requirements.txt`, wheels for Python 3.11 / x86-64 Linux, `setup.sh` (makes `python/venv`) |
| `bitstream/` | Spartan-6 bitstream tools: packet dump + CRC check, BRAM dump, service menu ROM read/write |
| `service_menu/` | FAT16 patch for the service menu ROM and its Z80-emulator test harness |
| `audio/` | Spectrum analysis of simulated NES audio |

## Setup

```sh
tools/python/setup.sh                 # Python packages, offline from the wheels
sudo apt install dosfstools           # mkfs.fat, for SD card images
```

Docker image (needed for ISE builds and for running Verilator):

```sh
git clone https://github.com/I-A-S/Docked-ISE-147     # or use tools/docker/
# put Xilinx_ISE_DS_Lin_14.7_1015_1.tar in Resources/, then:
docker build -t docked-ise-147 .
```

ISE needs `Xilinx.lic` mounted at `/root/.Xilinx/Xilinx.lic`. The current copy is
`/home/tursi/Docked-ISE-147/Xilinx.lic`, and it is deliberately not in the repo. `nes/build` and `rtl/build`
run every ISE tool through the image automatically. If your shell isn't in the `docker` group yet, use
`sg docker -c make`.

## NES simulation

`cd nes/sim && make && make test`. Without `verilator` on the PATH, the Makefile runs Verilator in
the Docker image and compiles the C++ on the host against `tools/verilator`: the image's g++ 7.5 is
too old for Verilator 5. The testbench can record audio and script controller input:

```sh
obj_dir/Vnes_phoenix --sd card.img --frames 2300 \
    --pad 60:01,62:00,400:08,404:00,1660:08,1664:00 \
    --wav out --ppm frame --ppm-every 30
python ../../tools/audio/analyze.py out 1800:2300:title     # tones, energy above 24 kHz
```

(`nes/sim/mksd.py card.img fat32 BIONIC.NES=../BIONIC.NES` makes the card. That command line is
the Bionic Commando whine reproduction.)

## Bitstream tools (`bitstream/`)

| Command | |
|---|---|
| `python parse.py FILE.PHX` | configuration packets (COR, watchdog, multiboot, FDRI blocks) and CRC check |
| `python dec.py FILE.PHX [outdir]` | contents of all 32 RAMB16 sites |
| `python phxrom.py read SERVICE.PHX rom.bin` | the service menu's 16K Z80 ROM (2nd batch build) |
| `python phxrom.py write SERVICE.PHX rom.bin OUT.PHX` | put a ROM back and recompute the CRCs |

`s6crc.py` is the Spartan-6 configuration CRC. It's 22 bits: per register write
`c = shl(c) ^ (reg << 16 | data)` with taps 0x9081, and RCRC clears it. Each FDRI block is followed by
a 2-word auto-CRC. It was derived from ISE reference builds and reproduces the CRC of every shipped
bitstream checked so far. `bram_map.pkl` maps BRAM INIT bits to frame bits, measured the same way.

## Service menu (`service_menu/`)

```sh
python fat16patch.py svc.rom svc_fat16.rom      # assemble the patch (source is in the script)
python mkimages.py                              # FAT16/FAT32 test cards -> images/ (~600 MB)
python matrix.py                                # original vs patched ROM on every card
python ../bitstream/phxrom.py write \
    ../../gameMenus/service/servicemenu_2nd_batch_console_only/SERVICE.PHX svc_fat16.rom SERVICE.PHX
```

`svc.rom` is the original ROM recovered from the 2nd batch `SERVICE.PHX`, also saved as
`gameMenus/service/servicemenu_2nd_batch_console_only/service_rom_recovered.bin` with a disassembly.
