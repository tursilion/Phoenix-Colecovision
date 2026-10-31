# Phoenix NES core

A NES core for the Phoenix, based on [fpganes](https://github.com/strigeus/fpganes)
by Ludvig Strigeus (GPLv2).

Status: proven on V1 hardware. The ROM cache for big games (PRG over the
SRAM's room, up to 1M) is new: it passes in simulation (the test
cartridge in `sim/tests/cachetest`) and has not been run on hardware yet.

## Using it

1. Put `.NES` files (iNES format) on a FAT16 or FAT32 SD card, in any
   folders.
2. Install the core file (`build/CORE04.PHX` by default) with the Phoenix boot
   loader, like the other cores.
3. Power up with the card inserted. The menu lists the folders and `.NES`
   files of the current folder, folders first, sorted by name (up to 256
   entries per folder).

Menu: Up/Down move, Left/Right page, A or Start opens a folder or starts a
game, B goes up a folder.

In a game:

| | NES A | NES B | Start | Select | D-pad |
|---|---|---|---|---|---|
| ColecoVision controller, port 1 / 2 (player 1 / 2) | left fire | right fire | # | * | stick |
| SNES pad (player 1) | A or X | B or Y | Start | Select | D-pad |
| PS/2 keyboard (player 1) | X | Z | Q | W | arrows |

Player 1's inputs are combined, so the SNES pad, the keyboard and the
controller in port 1 all work at the same time.

The reset button or ESC restarts the game; hold either for a second to go
back to the menu. Power-cycle to change cores.

Problems show on the menu's bottom line (and light the LED): no card, cannot
read the card or folder, read error, not an iNES file, too big (PRG over 1M
or CHR over 256K), the core rejected the file, or the file is fragmented on
the card (only matters for games that use the ROM cache: copy the file
again, or to a freshly formatted card).

## Limits

- PRG up to 1M and CHR up to 256K. The SRAM keeps all of the CHR (8K for
  CHR RAM) and as much PRG as fits beside it: 504K with CHR RAM, 256K with
  256K of CHR. A bigger PRG (Kirby's Adventure: 512K + 256K) plays from the
  ROM cache: when the game reads PRG that isn't in the SRAM, the core
  reads that 8K from the SD card, in place of PRG not used lately, while
  the CPU waits (the picture and sound go on). A read takes about 10ms, so
  **the picture can flicker or jump for a frame during these loads**: the
  game misses its interrupts while it waits. Most come at scene changes;
  games that fit never wait. If a DMA (DMC samples, sprite DMA) reads PRG
  that isn't there, the whole NES stops instead, and the lines it misses
  show black for a frame. The LED blinks if a cache read fails its CRC
  check (it is read again). The SD card has to stay in.
- Cartridge RAM is 8K.
- Mappers: what fpganes supports (0, 1, 2, 3, 4, 5, 7, 9, 11, 13, 15, 28,
  34, 41, 47, 64, 66, 68, 69, 71, 79, 105, 113, 118, 119, 158, 228, 232, 234).
- No trainers and no four-screen mirroring.
- The NES runs about 1% slow (59.5 frames per second), locked to the 640x480
  HDMI output.
- Loading takes well under a second for small games and up to about 5 s for
  512K files (10 s for 768K). Most of that is the 6502 loader's per-sector
  overhead in Petit FatFs.

## Layout

- `rtl/nes_phoenix_top.vhd` – top level: clocks, resets, controllers, HDMI.
  Same ports as `rtl/phoenix_top.vhd`, so it uses `rtl/phoenix.ucf`.
- `rtl/cv_pads.vhd` – reads both ColecoVision controllers (stick and keypad
  halves) as NES pads.
- `rtl/nes_phoenix.v` – the glue: NES clock enable and frame lock, memory
  (SRAM and block RAM), the ROM cache, the boot I/O window, and video. The
  comment at the top describes the design and the boot I/O registers.
  The cache reads a page with one multi-sector read (CMD18, then CMD12)
  at 12.5MHz and checks each sector's CRC16. A PRG page starts 16 bytes
  into a sector (the iNES header), so it reads 17 sectors and keeps
  bytes 16 to 8207. The CPU hold is a `cpu_hold` input on fpganes's
  `NES` (beside the DMAs' `pause_cpu`).
- `rtl/fpganes/` – fpganes, vendored. See `UPSTREAM.txt` for the changes.
- `rtl/nes_boot.hex` – the boot loader ROM, generated from `loader/`.
- `loader/` – 6502 boot loader and menu (cc65), using Petit FatFs. The font
  (`font.c`) is the Coleco menu's.
- `sim/` – Verilator testbench with SRAM and SD card models, and a test
  cartridge.
- `build/` – ISE command-line build.

## Building

**Core** (ISE 14.7 for Linux, for example the
[Docked-ISE-147](https://github.com/I-A-S/Docked-ISE-147) Docker image):

    docker run --rm -v "$REPO":/workspace -v /path/to/Xilinx.lic:/root/.Xilinx/Xilinx.lic \
      -w /workspace/nes/build docked-ise-147 make CORE_FILE=CORE04.PHX

or, with ISE installed locally, `make ISE_SETTINGS=.../settings64.sh` in
`build/`. This makes `nes_phoenix_top.bit` (JTAG) and the core file. The
bitstream options reproduce the configuration words of the ColecoVision
core's `CORE01.PHX` (see the comment in `build/Makefile`).

**Boot loader** (only after changing `loader/`; needs cc65):

    cd loader
    make CC65_HOME=/path/to/cc65

**Simulation** (needs Verilator, cc65, `mkfs.fat`, and Python with `pyfatfs`):

    cd sim
    make test

`sim/vhdl/cv_pads_tb.vhd` tests the controller scanner with GHDL (VHDL-2008):
`ghdl -a --std=08 ../../rtl/cv_pads.vhd cv_pads_tb.vhd && ghdl -e --std=08
cv_pads_tb && ghdl -r --std=08 cv_pads_tb`.

**Cache test**: `make -C sim/tests/cachetest` builds `CACHETST.NES` (MMC3,
512K PRG + 256K CHR, so half the PRG comes from the cache). It reads
random PRG pages and then all of them, checks each page's code and a 1K
block of its data (a different block each pass), and copies blocks of
random pages to the sprite memory by DMA. It shows its counts, and for a
bad page which page's data it had (HAS) and how many bytes differ from
that page (DIFF: 0000 means a whole other page). It should show ALL OK and
keep counting. The testbench prints the cache's fills and freezes.

`obj_dir/Vnes_phoenix --sd image --frames n --ppm prefix` runs any SD image
and writes frames as PPM files (`ppm2png.py` converts them). Building with
`-DNES_SIM_TRACE` prints the frame lock; `-DNES_SIM_PROFILE` samples the
loader's CPU addresses.
