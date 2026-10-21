# Phoenix Gyruss core

Konami's Gyruss (1983) for the CollectorVision Phoenix. The ROMs are loaded
from the SD card at power-on.

Status:

- **Simulation:** it loads the ROMs, runs the power-on test, the title
  screen and the attract demo with sound, and takes a coin and a start into
  stage 1.
- **ISE:** 92% of the LUTs and 31 of 32 block RAMs, with timing met.
- **Hardware:** works, both pictures, and the loader loaded 5 times out of 5.
- **Picture:** the game's native sideways picture by default. Keyboard 0,
  SNES L or R, or keypad 0 switch to an upright picture and back.

## Using it

1. Copy the MAME ROM files, unzipped, to a folder `GYRUSSCE` (the Centuri
   set, `gyrussce`) or `GYRUSS` (the Konami set, `gyruss`) on a FAT16 or
   FAT32 SD card. Files in the root folder also work.
2. Install `build/CORE06.PHX` with the Phoenix boot loader.
3. Power up with the card inserted. The loader lists each file as it loads
   it, which takes a few seconds. Then the game starts.

If a file is missing or has the wrong size, the loader shows its name and
the LED lights.

| | ColecoVision | SNES pad | PS/2 keyboard |
|---|---|---|---|
| player 1 | port 1 stick and either fire | D-pad, A B X Y | arrows, Z or X |
| player 2 | port 2 stick and fire | | |
| coin | keypad 5 | Select | 5 |
| start 1 / 2 | keypad 1 / 2 | Start | 1 / 2 |
| rotate picture | keypad 0 | L or R | 0 |

The reset button or ESC restarts the game. Hold either for a second to load
it again. Power-cycle to change cores.

The DIP switches are MAME's defaults for `gyruss`: 1 coin 1 credit, 3 lives,
upright cabinet, difficulty 5 (average), demo sounds and music on. They are
set in `loader/main.c`.

## How it works

- **The main board** (`rtl/gyruss_main.v`) is a Verilog-2001 port of Ace's
  Gyruss model from the MiSTer core (MIT license). It models the Konami
  custom chips the way the PCB uses them:
  - 082: video timing.
  - 501: Z80 bus sharing with the video.
  - 083: pixel shifters.
  - 502 and 503: sprites, with a two-bank line buffer.
- **CPUs:**
  - The main Z80 runs at 3.07 MHz (tv80).
  - The KONAMI-1 encrypted 6809 runs at 1.54 MHz. This is John Kent's cpu09
    with MiSTer-X's opcode input, changed to clock on the rising edge. The
    cycle-accurate mc6809 alone was 48% of the LX16.
- **The sound board** (`rtl/gyruss_sound.v`):
  - Z80 at 3.58 MHz.
  - Five AY-3-8910s at 1.79 MHz. They share one engine in `rtl/ay5x.v`, which
    follows MikeJ's YM2149 model. Five separate cores would not fit.
  - An 8039 (T48) that plays samples through an 8-bit DAC.
  - The PCB's switchable RC filters on AY 1 and 2 are not modelled.
- **Clocks and frame lock** (`rtl/gyruss_phoenix.v`):
  - Everything runs from 25 MHz with clock enables.
  - The main board's 12.288 MHz enable is 768 out of every 1590 clocks. A
    frame is then 240 clocks shorter than a 640x480 HDMI frame. The board
    waits at the end of each frame until the HDMI output reaches line 486.
  - The game therefore runs at 59.52 Hz, against 60.6 Hz on the PCB.
  - Native picture (the default): the 256x224 frame goes through an 8-line buffer and is
    shown doubled (512x448) and centred.
  - Rotated picture: the frame is turned 90 degrees
    clockwise to 224x256.
    - Each frame is written into one of two frame buffers in the SRAM (at
      40000 and 50000). The other, finished one is shown, so there is no
      tearing, at the cost of one frame of delay.
    - Each HDMI line is prefetched from the SRAM into the line buffer during
      the line before. It shows one source column, pixels doubled to 448
      wide and centred.
    - The 256 columns are spread over the 480 lines, a 15/8 scale. Some
      columns show on one line instead of two.
- **Memory:**
  - The CPU ROMs are in the external SRAM.
    - A CPU's read is made when its address changes, with the address out on
      one clock and the data in on the next.
    - Writes take two clocks: an ODDR2 in the top level pulses WE in the
      second half of the first one.
    - Priority: CPU reads, then writes (the loader's and the frame
      buffer's), then the display line prefetch.
  - The graphics ROMs, the 8039 ROM and the PROMs are block RAM and LUT RAM.
  - The core uses 31 of the 32 block RAMs.
- **Boot loader** (`loader/`, Z80 C with sdcc and Petit FatFs):
  - It runs on the main Z80 from the tile ROM's block RAM. That RAM is
    initialized with the loader.
  - It first copies itself to the SRAM and continues from that copy, so
    that the tile ROM can be loaded over it.
  - Its screen is a text overlay drawn from the video RAM.
  - It reads the card at 6.25 MHz. It retries a failed sector read 5 times
    and a failed file 3 times.

## Layout

- `rtl/gyruss_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/gyruss_phoenix.v`: clocks, frame lock, SRAM, loader registers, SPI and
  video output, including the rotation.
- `rtl/gyruss_main.v`, `gyruss_sound.v`, `ay5x.v`: the boards.
- `rtl/cv_pads.vhd`: the ColecoVision controllers.
- Vendored cores:
  - `rtl/tv80/`: tv80, MIT license.
  - `rtl/cpu09/`: cpu09, GPL. It is MiSTer-X's version, with the clock edge
    changed.
  - `rtl/t48/`: T48, BSD-style license.
- `rtl/gyruss_boot.hex`: the loader, built from `loader/`.
- `rtl/font64.hex`: the overlay font, characters 0x20-0x5F of the Coleco menu
  font.
- `sim/`: the Verilator testbench, with SRAM and SD card models.
- `build/`: the ISE command-line build. The output is `CORE06.PHX`, issue
  0101.

## Building

- **Core**: use ISE 14.7, the same way as the other cores:

      docker run --rm -v "$REPO":/workspace -v /path/to/Xilinx.lic:/root/.Xilinx/Xilinx.lic \
        -w /workspace/gyruss/core/build docked-ise-147 make SHELL=/bin/bash

- **Loader**: needs sdcc 4.x. Run `make -C loader`.
- **Simulation**:
  - Generate the C++ where Verilator and Yosys with the GHDL plugin are
    installed, for example inside the docked-ise-147 image: `make gen`.
  - Compile it with a recent g++ by running `make VERILATOR_ROOT=...`. The
    image's g++ 7 is too old for its Verilator.
  - Then run `make run`.
  - `--rot frame,...` toggles the rotation at those frames.
  - GHDL cannot convert the T48, so the 8039 is a silent stub in simulation.
