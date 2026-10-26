# Phoenix Intellivision core

Mattel's Intellivision for the CollectorVision Phoenix. The CPU (CP1610),
the video chip (STIC) and the sound chip (AY-3-8914) come from the
[MiSTer Intellivision core](https://github.com/MiSTer-devel/Intv_MiSTer)
by Grabulosaure (release 20261001). The menu and SD card loader
come from the Phoenix NES core.

Status:

- **Simulation:** the menu lists the card and loads a game. DKINTY.BIN
  (Donkey Kong Arcade, .BIN + .CFG) runs its title screen.
- **ISE:** about 40% of the LUTs and 16 of 32 block RAMs, with timing met.
- **Hardware:** the menu works.

## Using it

1. Put cartridge images on a FAT16 or FAT32 SD card, in any folders:
   - `.BIN`, `.INT` or `.ITV` raw images. A `.CFG` file with the same name
     gives the memory map, as in jzintv.
   - `.ROM` Intellicart images.

   Without a `.CFG` file, the core looks the image's CRC up in the MiSTer
   core's list of games with unusual memory maps. Any other image gets the
   usual map: $5000-$6FFF, then $D000 and $F000. The menu shows 8.3 names,
   so give the `.BIN` and `.CFG` files short names. Long names can get
   different `~1` endings.
2. Install `build/CORE09.PHX` with the Phoenix boot loader.
3. Power up with the card inserted and pick a game.

Menu: the stick moves, left and right page through the list, the left fire
button (or #) opens a folder or starts a game, and the right fire button
(or *) goes up a folder. Keypad 0 swaps the controller ports. On a SNES
pad, A or Start opens, B goes back and Select swaps.

In a game:

| Intellivision | ColecoVision controller | SNES pad | PS/2 keyboard |
|---|---|---|---|
| disc | stick (8 directions) | D-pad | arrows |
| top action buttons | left fire | Y or X | Z |
| lower left action button | right fire | B | X |
| lower right action button | both fire buttons | A | Z and X |
| keypad 0-9 | keypad 0-9 | L = 1, R = 2 | 0-9 |
| clear / enter | * / # | Select / Start | W / Q |

By default ColecoVision port 1 is player 1, the Intellivision's left
controller. Port 2 is the right controller. The SNES pad and the keyboard
also act as player 1. Keypad 0 in the menu swaps the ports.

The reset button or ESC resets the game. Hold either for a second to go
back to the menu. Power cycle to change cores.

## Limits

- No ECS, Intellivoice or JLP. The hardware has room for them, but they
  are not added yet.
- Images up to about 250K words (with any cartridge RAM). Intellicart
  bank switching is not supported. Page switching with jzintv
  `PAGE n` mappings is supported.
- NTSC only. The core runs at 59.52 frames per second instead of 59.92,
  locked to the 640x480 HDMI output.

## How it works

- **Clocks.** The Intellivision normally runs at 12 x 3.58MHz. Here a
  DCM_CLKGEN makes 42.857MHz from 25MHz, slightly fast. At the top of each
  frame a BUFGCE stops that clock until HDMI line 517. That keeps one
  Intellivision frame per HDMI frame, and an 8-line buffer shows each
  Intellivision line on two HDMI lines. The picture is 190 x 240 STIC
  pixels (with the border), each 3 x 2 HDMI pixels: 570 x 480, centered.
- **Memory.** The system RAMs, GRAM, GROM and EXEC are block RAM. The
  EXEC and GROM are built in from `exec.bin` and `grom.bin`.
  The cartridge is in the SRAM, with a page table at SRAM 7E000 that the
  loader writes (`rtl/intv_cart.vhd`).
- **Loader.** A 6502 (Arlet Ottens' core) runs from a 16K block RAM ROM
  in boot mode. It uses Petit FatFs and a forward engine that sends SD bytes
  to the SRAM and through a CRC-32 (`loader/`, the I/O map is at the top of
  `rtl/intv_phoenix.v`).

## Layout

- `rtl/intv_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/intv_phoenix.v`: the frame lock, controller mapping, boot CPU and
  I/O, SPI, the SRAM controller and the video output.
- `rtl/intv_core.vhd`: the Intellivision. `rtl/intv_cart.vhd` is the
  cartridge.
- `rtl/intv/`: the MiSTer core's files.
  - `cp1610.vhd` is the original without its trace code.
  - `stic.vhd` has no ECS, Intellivoice, JLP or CFG parser, uses built-in
    ROMs, and has a pixel output.
  - `snd.vhd`, `cp1610_pack.vhd` and `base_pack.vhd` are unchanged.
- `rtl/cpu6502/`: Arlet Ottens' 6502.
- `rtl/cv_pads.vhd`: the ColecoVision controllers (same as Galaga's).
- `tools/mkroms.py`: makes the EXEC/GROM VHDL package and the menu font
  from the BIOS files at build time. The BIOS is not kept in the repository.
- `loader/`: the menu and loader (cc65).
- `sim/`: the Verilator testbench. The VHDL is turned into Verilog with
  Yosys + GHDL.
- `build/`: the ISE build. The output is `CORE09.PHX`, issue 0x0101.

## Building

The Intellivision BIOS (`exec.bin`, 8K, and `grom.bin`, 2K) must be in
`intellivision/` (or pass `BIOS=dir`).

- **Core.** Run `make` in `build/`. Without ISE installed, it runs each
  ISE tool in the docked-ise-147 Docker image.
- **Loader.** Run `make -C loader`. It needs cc65.
- **Simulation.**
  1. Run `make` in `sim/`. Verilator and Yosys run in the Docker image.
  2. Make a card with
     `make sd.img ROMS="GAME.BIN=path GAME.CFG=path"`.
  3. Run it with `obj_dir/Vintv_phoenix --sd sd.img --frames 300 --pad 25:01,27:00 --ppm out/f --ppm-every 30`.
     The `--pad` script presses SNES A at frame 25 to start the first file.

  Build with `make VFLAGS=+define+INTV_SIM_TRACE` to print the CPU's bus
  addresses.
