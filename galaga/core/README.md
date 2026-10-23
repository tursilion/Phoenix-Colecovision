# Phoenix Galaga core

Namco's Galaga (1981) for the CollectorVision Phoenix. The ROMs are loaded
from the SD card at power-on. The core shell is the same as the Gyruss and
Time Pilot '84 cores (`../../gyruss/core`, `../../tp84/core`), but the
board is Namco's, so the game logic is new.

Status:

- **Simulation:**
  - It loads the ROMs and passes the game's power-on RAM and ROM test.
  - It runs the attract mode with sound.
  - It takes a coin and starts a game; the stage plays with shots,
    explosions and the score.
  - The rotated picture works.
- **ISE:** 72% of the LUTs, 9 of 32 block RAMs and 7 RAMB8s, with timing
  met.
- **Hardware:** works on the Phoenix.

## Using it

1. Copy the MAME ROM files, unzipped, to a folder on a FAT16 or FAT32 SD
   card:
   - `GALAGA` for the `galaga` set (Namco rev. B),
   - `GALAGAO` for `galagao` (Namco),
   - `GALAGAMW` for `galagamw` (Midway).

   Files in the root folder also work. The set needs `51xx.bin`, `54xx.bin`
   and the PROMs; they are in MAME's `galaga` set.
2. Install `build/CORE08.PHX` with the Phoenix boot loader.
3. Power up with the card inserted. The loader lists each file as it loads
   it, then the game starts.
   - The game then spends about 12 seconds on its own power-on RAM and ROM
     test (a black or garbled screen), and ends it with a short explosion
     noise.

| | ColecoVision | SNES pad | PS/2 keyboard |
|---|---|---|---|
| player 1 | port 1 stick | D-pad | arrows |
| fire | either fire button | A, B, X or Y | Z or X |
| player 2 (cocktail only) | port 2 stick and fires | | |
| coin | keypad 5 | Select | 5 |
| start 1 / 2 | keypad 1 / 2 | Start | 1 / 2 |
| rotate picture | keypad 0 | L or R | 0 |

The reset button or ESC restarts the game. Hold either for a second to load
it again. The picture starts in the game's native sideways orientation; the
rotate key switches to an upright picture and back.

The DIP switches are MAME's defaults for `galaga`, set in `loader/main.c`:

- 1 coin 1 credit, 3 lives, bonus at 20000, 70000 and every 70000.
- Easy difficulty, demo sounds on, upright cabinet.

## How it works

The design follows MAME's drivers: `galaga.cpp` and `galaga_video.cpp`, and
the device files `namco06`, `namco51`, `namco54`, `mb88xx`, `namco` (WSG),
`starfield_05xx` and `audio/galaga`.

- **CPU board** (`rtl/galaga_main.v`):
  - Three Z80s (tv80) at 3.07MHz. They share all the RAM through one port
    served round robin at 25MHz, three times faster than a Z80 bus cycle.
  - The 06xx interface: control register, NMI timer and chip selects.
  - The 51xx (inputs and coins) and the 54xx (explosion noise) run their
    real MCU programs (`51xx.bin`, `54xx.bin`) on `rtl/mb88.v`, an MB88xx
    core written after MAME's.
  - Interrupts, the latches and the DIP switches.
- **Video board** (`rtl/galaga_video.v`):
  - The picture is 288 x 224 at 6.144MHz (MAME's coordinates).
  - The 36 x 28 tile layer is fetched pixel by pixel.
  - The 64 sprites are drawn a line ahead into two line buffers.
  - The 05xx starfield is its 16-bit LFSR, as MAME models it.
- **Sound** (`rtl/galaga_sound.v`):
  - The 3-voice waveform generator.
  - The 54xx outputs go through their resistor DACs and three
    state-variable band-pass filters, a model of the op-amp filters.
  - Mixed at MAME's levels.
- **Clocks, frame lock, SRAM, rotation and video output**
  (`rtl/galaga_phoenix.v`):
  - The game runs at 59.52Hz, locked to the HDMI output: it waits at the
    end of each frame for HDMI line 10.
  - An 8-line buffer doubles the native picture to 576 x 448.
  - Rotated, frames are double-buffered in the SRAM and shown 448 x 480,
    turned 90 degrees clockwise.
- **Memory:**
  - The CPU ROMs are in the external SRAM: main CPU at 00000, sub CPU at
    04000, sound CPU at 05000.
  - The graphics and MCU ROMs are block RAM; the PROMs are LUT RAM.
- **Boot loader** (`loader/`, Z80 C with sdcc and Petit FatFs):
  - It runs on the main Z80.
  - It starts in the sprite ROM's block RAM, copies itself to the SRAM and
    continues from there.
  - It keeps its variables and stack in RAM 1 (8800) and its sector buffer
    in RAM 2 (9000). Its text goes to the video RAM (8000).

## Layout

- `rtl/galaga_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/galaga_phoenix.v`: clocks, frame lock, SRAM, loader registers, SPI
  and video output.
- The boards:
  - `rtl/galaga_main.v`, `galaga_video.v`, `galaga_sound.v`.
  - `rtl/mb88.v` for the 51xx and 54xx.
- `rtl/cv_pads.vhd`: the ColecoVision controllers.
- `rtl/tv80/`: tv80, MIT license.
- `rtl/galaga_boot.hex`: the loader, built from `loader/`.
- `sim/`: the Verilator testbench, with SRAM and SD card models.
- `build/`: the ISE command-line build. The output is `CORE08.PHX`, issue
  0x0101.

## Building

- **Core**: use ISE 14.7, the same way as the other cores:

      docker run --rm -v "$REPO":/workspace -v /path/to/Xilinx.lic:/root/.Xilinx/Xilinx.lic \
        -w /workspace/galaga/core/build docked-ise-147 make SHELL=/bin/bash

- **Loader**: needs sdcc 4.x. Run `make -C loader`.
- **Simulation**:
  1. Run `make gen` where Verilator is installed.
  2. Run `make VERILATOR_ROOT=...` with a recent g++.
  3. Run `make run`.

  The ROM set is read from `../../galaga`. The game's power-on test takes
  about 1000 frames.
  - `-DGA_SIM_TRACE` prints the three CPUs' PCs every frame.
  - `-DGA_SIM_FB` reports frame-buffer overruns in the rotated mode.
