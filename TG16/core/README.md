# Phoenix PC Engine core

NEC's PC Engine and TurboGrafx-16 (HuCards) for the CollectorVision
Phoenix. The PC Engine itself (HuC6280 CPU with its sound, HuC6270 VDC,
HuC6260 VCE) comes from the
[MiSTer TurboGrafx16 core](https://github.com/MiSTer-devel/TurboGrafx16_MiSTer)
(commit 827d45f), cut down to fit. The menu and SD card loader run on the
PC Engine's own CPU.

Status:

- **Hardware:** Dragon Spirit, Salamander, Jamanoid and homebrew run, with
  sprites, text and sound. Dragon Spirit shows a little flicker halfway
  across its top line.
- **ISE:** 68% of the LUTs, 16 of 32 block RAMs (and 6 small ones),
  timing met (15.8ns of 23.3ns).

## Using it

1. Put `.PCE` HuCard images on a FAT16 or FAT32 SD card, in any folders.
   The menu shows 8.3 names. Images can be up to 448K, with or without a
   512-byte copier header. US images whose data bits are reversed are
   found and played the right way round.
2. Install `build/CORE11.PHX` with the Phoenix boot loader.
3. Power up with the card inserted and pick a game.

Menu: up and down move, left and right page through the list, I (or Run)
opens a folder or starts a game, and II goes up a folder.

In a game:

| PC Engine | ColecoVision controller | SNES pad | PS/2 keyboard |
|---|---|---|---|
| D-pad | stick | D-pad | arrows |
| I | left fire | A or X | X |
| II | right fire | B or Y | Z |
| Run | # | Start | Q |
| Select | * | Select | W |

Both ColecoVision ports work, as one player.

Rapid fire, like the TurboPad's switches: key 1 (keypad or keyboard, or
SNES L) steps button I through off, slow, fast and fastest; key 2 (or
SNES R) does the same for button II.
Off is the default, and the settings stay until power-off. As on the
TurboPad, the rate follows the game's pad reads: a held button reads
pressed and released every 4 reads (slow), 2 (fast) or 1 (fastest), which
is 7.5, 15 or 30 presses a second for a game that reads the pad once a
frame. The TurboPad has slow and fast; fastest is extra.

The reset button or ESC resets the game. Hold either for a second to go
back to the menu. Power cycle to change cores.

## Limits

- Images up to 448K: 512K and bigger HuCards (and Street Fighter II) don't
  fit, because the video RAM shares the SRAM.
- One player: no multitap.
- No SuperGrafx, CD-ROM, Arcade Card, Populous RAM or backup RAM.
- 16 sprites per line, like the real VDC (the MiSTer core's 64-sprite
  option is gone).
- The core runs at 59.52 frames per second instead of 59.83, locked to the
  640x480 HDMI output.

## How it works

- **Clocks.** The PC Engine runs from 12 x 3.58MHz = 42.95MHz. Here a
  DCM_CLKGEN makes 42.78MHz from 25MHz, so a PC Engine frame (263 lines of
  2730 clocks) is a little shorter than an HDMI frame. At the top of each
  frame a BUFGCE stops that clock until HDMI line 482, which keeps one PC
  Engine frame per HDMI frame.
- **Picture.** The VCE's line window (2160 clocks) is sampled every second
  clock, 1080 samples, so a dot is 2, 3 or 4 samples in its three dot
  clocks, and shown 640 wide. Lines 20-259 are each shown twice: 640 x 480.
  A 4-line buffer is enough, since a PC Engine line is just shorter than
  two HDMI lines.
- **Memory.** Work RAM (8K), the palette, the sprite table and the sprite
  line buffers are block RAM. The SRAM has the ROM from 00000 (up to 448K)
  and the VDC's 64K of video RAM at 70000. The VDC reads one 16-bit word
  per dot period (4, 6 or 8 clocks), and its address stays the same for the
  whole period, so the SRAM controller reads the two bytes in the period's
  clocks 2 and 3. The other clocks serve the VDC's writes (two clocks per
  byte, posted), the CPU's ROM reads (the CPU waits for them) and the
  loader. The SRAM pins come from I/O block registers (`rtl/tg16_phoenix.v`).
- **Loader.** At power-on the CPU runs a 16K block RAM ROM in ROM banks 0
  and 1: the loader (`loader/`, cc65), with an I/O window at $1800 of the
  I/O page (the CD's place): the SD card's SPI port and a forward engine
  that sends SD bytes to the SRAM. The menu is text on the VDC's background.
- **Changes to the MiSTer core** (`rtl/pce/`), to fit and to build with XST:
  - Only `pce_top.vhd`'s HuCard system is kept. Its video RAM and ROM are
    outside, and it exports the VCE's line and clock counters.
  - VDC (`huc6270.vhd`): the 560-pixel sprite flag vectors cost about
    5,700 LUTs. Sprites are now drawn last to first, so the first one ends
    on top without them. Sprite 0's collision uses a 32-pixel window, and
    the sprite frame grid (a debug view) is gone. The sprite line buffers
    are cleared through the drawing port, because XST dropped their second
    write port.
  - PSG (`psg.vhd`): the 4096 x 24 volume ROM is a 128-entry table times
    the sample (`psg_vol.vhd`). The channel record is split by the process
    that writes it, for GHDL. A 4-bit XOR on the 5-bit LFO sample is now
    5-bit.
  - Port maps take signals, not expressions (XST).

## Layout

- `rtl/tg16_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/tg16_phoenix.v`: the frame lock, controller mapping, loader I/O,
  SPI, the SRAM controller and the video output.
- `rtl/pce/`: the MiSTer core's files, changed as above, and `dpram.vhd`
  (block RAM for XST).
- `loader/`: the menu and loader (cc65 for the HuC6280), with Petit FatFs
  and the ColecoVision menu font.
- `sim/`: the Verilator testbench. The VHDL is turned into Verilog with
  Yosys + GHDL.
- `build/`: the ISE build. The output is `CORE11.PHX`, issue 0x0101.

## Building

- **Core.** Run `make` in `build/`. Without ISE installed, it runs each
  ISE tool in the docked-ise-147 Docker image.
- **Loader.** Run `make -C loader`. It needs cc65.
- **Simulation.**
  1. Run `make` in `sim/`. Verilator and Yosys run in the Docker image.
  2. Make a card with `make sd.img ROMS="GAME.PCE=path ..."`.
  3. Run it with `obj_dir/Vtg16_phoenix --sd sd.img --frames 300 --pad 29:01,31:00 --ppm out/f --ppm-every 30`.
     The `--pad` script presses SNES A at frame 29 to start the first file.
- **Gate-level simulation.** `sim/xstnet/` has the XST netlist of
  `pce_top` (`netgen -sim`) and Verilator models of the Spartan-6
  primitives it uses (`cells.v`), to run the netlist the way the FPGA does.
  It showed the sprites back after the line buffer fix.
