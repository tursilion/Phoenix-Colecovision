# Phoenix Time Pilot '84 core

Konami's Time Pilot '84 (1984) for the CollectorVision Phoenix. The ROMs are
loaded from the SD card at power-on. It is built the same way as the Gyruss
core (`../../gyruss/core`), and the board hardware is closely related.

Status:

- **Simulation:** it loads the ROMs, passes the game's power-on RAM and ROM
  test on both 6809s, and runs the title, score table and attract demo with
  sound.
- **ISE:** 86% of the LUTs, 28 of 32 block RAMs and 4 RAMB8s, with timing
  met.
- **Hardware:** works, coins included.

## Using it

1. Copy the MAME ROM files, unzipped, to a folder `TP84` (set 1, `tp84`) or
   `TP84A` (set 2, `tp84a`) on a FAT16 or FAT32 SD card. Files in the root
   folder also work. Set 3 (`tp84b`) has a different memory map and is not
   supported.
2. Install `build/CORE07.PHX` with the Phoenix boot loader.
3. Power up with the card inserted. The loader lists each file as it loads
   it, then the game starts.

| | ColecoVision | SNES pad | PS/2 keyboard |
|---|---|---|---|
| player 1 | port 1 stick | D-pad | arrows |
| fire 1 / fire 2 | left / right fire | B or Y / A or X | Z / X |
| player 2 | port 2 stick and fires | | |
| coin | keypad 5 | Select | 5 |
| start 1 / 2 | keypad 1 / 2 | Start | 1 / 2 |
| rotate picture | keypad 0 | L or R | 0 |

The reset button or ESC restarts the game. Hold either for a second to load
it again. The picture starts in the game's native sideways orientation; the
rotate key switches to an upright picture and back, as in the Gyruss core.

The DIP switches are MAME's defaults for `tp84`: 1 coin 1 credit, 3 lives,
upright cabinet, bonus at 20000 and every 60000, hard difficulty (the US
default), demo sounds on. They are set in `loader/main.c`.

## How it works

- **The main board** (`rtl/tp84_main.v`) is a Verilog-2001 port of Ace's
  TimePilot84_CPU.sv from the MiSTer core (MIT license).
  - It uses the same Konami custom chip models as Gyruss: 082 (timing), 083
    (pixel shifters), 502 and 503 (sprites).
  - There are two tile layers: the scrolling playfield and the status
    columns.
  - Sprites are 16x16.
  - The palette is 12-bit, from three colour PROMs.
- **CPUs:** two 6809s at 1.54 MHz, both John Kent's cpu09 clocked by an
  enable at the falling edge of E. The main CPU's E falls as h[1:0] goes
  from 10 to 11, and the sub CPU's as it goes from 00 to 01.
- **The sound board** (`rtl/tp84_sound.v`):
  - Z80 at 3.58 MHz.
  - Three SN76489A-type PSGs at 1.79 MHz (`rtl/sn76489.v`, written after
    MAME's Y2404 model).
  - The switchable RC filters are not modelled.
- **Clocks, frame lock, SRAM, rotation and video output** (`rtl/tp84_phoenix.v`):
  the same as Gyruss.
  - The PCB blanks the last 3 pixels of each 256-pixel line; the line
    buffer keeps a blank bit for them.
- **Memory:**
  - The CPU ROMs are in the external SRAM: main CPU at 00000, sub CPU at
    08000, sound CPU at 0C000.
  - The graphics ROMs and PROMs are block RAM and LUT RAM.
- **Boot loader** (`loader/`, Z80 C with sdcc and Petit FatFs):
  - It runs on the sound Z80, since the main CPU is a 6809.
  - It starts in the tile ROM's block RAM, copies itself to the SRAM and
    continues from there.
  - It keeps its variables and stack in the sound RAM (4000) and its sector
    buffer in the shared RAM (5000). Its text goes to the status-column
    video RAM (8400).

## Layout

- `rtl/tp84_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/tp84_phoenix.v`: clocks, frame lock, SRAM, loader registers, SPI and
  video output.
- `rtl/tp84_main.v`, `tp84_sound.v`, `sn76489.v`: the boards.
- `rtl/cv_pads.vhd`: the ColecoVision controllers.
- Vendored cores:
  - `rtl/tv80/`: tv80, MIT license.
  - `rtl/cpu09/`: cpu09, GPL. It is MiSTer-X's version, with the clock edge
    changed.
- `rtl/tp84_boot.hex`: the loader, built from `loader/`.
- `sim/`: the Verilator testbench, with SRAM and SD card models.
- `build/`: the ISE command-line build. The output is `CORE07.PHX`, issue
  0x0101.

## Building

- **Core**: use ISE 14.7, the same way as the other cores:

      docker run --rm -v "$REPO":/workspace -v /path/to/Xilinx.lic:/root/.Xilinx/Xilinx.lic \
        -w /workspace/tp84/core/build docked-ise-147 make SHELL=/bin/bash

- **Loader**: needs sdcc 4.x. Run `make -C loader`.
- **Simulation**: the same as Gyruss.
  - Run `make gen` where Verilator and Yosys with the GHDL plugin are
    installed.
  - Then run `make VERILATOR_ROOT=...` with a recent g++.
  - The ROM set is read from `../../tp84`.
