# Phoenix Intellivision core

Mattel's Intellivision for the CollectorVision Phoenix. The CPU (CP1610),
the video chip (STIC) and the sound chip (AY-3-8914) come from the
[MiSTer Intellivision core](https://github.com/MiSTer-devel/Intv_MiSTer)
by Grabulosaure (release 20261001), with the ECS, the Intellivoice and the
JLP extensions. The menu and SD card loader come from the Phoenix NES core.

Status:

- **Simulation:** the menu lists the card and loads a game. DKINTY.BIN
  (Donkey Kong Arcade, .BIN + .CFG) runs its title screen.
- **ISE:** 76% of the LUTs, 28 of 32 block RAMs, 4 RAMB8s and 14 DSPs,
  with timing met.
- The BIOS comes from the SD card. In simulation the core loads it and
  runs DKINTY (with and without the ECS) and B-17 Bomber with speech.
- **Hardware:** the base console works (DKINTY). The ECS, Intellivoice and
  JLP are not tested on hardware yet.

## Using it

1. Put the Intellivision BIOS in a folder `INTV` on a FAT16 or FAT32 SD
   card (or in its root):

   | ROM | size | CRC-32 | needed |
   |---|---|---|---|
   | EXEC | 8K | CBCE86F7 | yes |
   | GROM | 2K | 683A4158 | yes |
   | ECS | 24K | EA790A06 | for ECS games |
   | Intellivoice (SP0256-012) | 2K | 0DE7579D | for speech |

   The core finds them by size and CRC, so any file names work, for example
   `exec.bin`, `grom.bin`, `ecs.bin` and `sp0256-012.bin`. A file whose
   CRC differs (another EXEC or GROM version) is used if it is named
   `EXEC.BIN`, `GROM.BIN`, `ECS.BIN` or `IVOICE.BIN`. The menu's
   `BIOS:` line shows what it found. Without the ECS ROM the ECS stays
   off; without the Intellivoice ROM there is no Intellivoice.
2. Put cartridge images on a FAT16 or FAT32 SD card, in any folders:
   - `.BIN`, `.INT` or `.ITV` raw images. A `.CFG` file with the same name
     gives the memory map, as in jzintv.
   - `.ROM` Intellicart images.

   Without a `.CFG` file, the core looks the image's CRC up in the MiSTer
   core's list of games with unusual memory maps. Any other image gets the
   usual map: $5000-$6FFF, then $D000 and $F000. The menu shows 8.3 names,
   so give the `.BIN` and `.CFG` files short names. Long names can get
   different `~1` endings.
3. Install `build/CORE09.PHX` with the Phoenix boot loader.
4. Power up with the card inserted and pick a game.

Menu: the stick moves, left and right page through the list, the left fire
button (or #) opens a folder or starts a game, and the right fire button
(or *) goes up a folder. Keypad 0 swaps the controller ports. Keypad 1
and 2 set the ECS and the JLP to AUTO, ON or OFF. On a SNES pad, A or Start
opens, B goes back, Select swaps, and L and R set the ECS and the JLP.

## Extensions

- **Intellivoice** (speech, for example B-17 Bomber, Space Spartans): always
  on. It sits at $0080-$0081, where other games never look.
- **ECS** (Entertainment Computer System): it adds a ROM, 2K of RAM, a second
  sound chip and the computer keyboard. It conflicts with games that use
  $2000, $4000-$47FF, $7000 or $E000 for themselves. So it is only on for a
  game whose `.CFG` file has `ecs = 1` (or `ecs_compat` 2 or 3) in `[vars]`,
  or when the menu has it set to ON. The PS/2 keyboard is the ECS keyboard.
  The keyboard's digits then no longer work as the hand controller keypad,
  and ESC still resets the game. The ECS's extra hand controller ports are
  not connected.
- **JLP**: homebrew cartridge hardware. It has 8K words of RAM at
  $8040-$9F7F, a multiply/divide unit, a CRC unit and a random number
  generator at $9F80-$9FFF. It is on for `jlp = 1` (or more, or
  `jlp_compat` 2 or 3) in `[vars]`, or when the menu has it set to ON. It
  has no flash: games see no save rows, so saving does nothing.

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

- No JLP save games (flash), no ECS hand controllers 3 and 4, no
  Keyboard Component.
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
- **Memory.** The system RAMs, GRAM, GROM, EXEC, ECS ROM and RAM, and the
  Intellivoice ROM are block RAM. The loader writes the ROMs from the SD
  card at power-on: the forward engine has a load target (`$500F`), and
  the ROMs' CPU ports are their load ports while the CPU is in reset. The
  JLP RAM is in the SRAM,
  mapped by the loader.
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
  - `stic.vhd` has no Intellicart registers or CFG parser, uses built-in
    ROMs, sends only the JLP registers to `jlp.vhd`, and has a pixel output.
  - `ivoice.vhd` has a load port for the SP0256 ROM and is rewritten in a few
    places for XST.
  - `jlp.vhd` has no RAM or flash.
  - `snd.vhd`, `cp1610_pack.vhd` and `base_pack.vhd` are unchanged.
- `rtl/cpu6502/`: Arlet Ottens' 6502.
- `rtl/cv_pads.vhd`: the ColecoVision controllers (same as Galaga's).
- `rtl/font.hex`: the menu font, the Intellivision's characters (the first
  768 bytes of the GROM, ASCII 32-127).
- `loader/`: the menu and loader (cc65).
- `sim/`: the Verilator testbench. The VHDL is turned into Verilog with
  Yosys + GHDL.
- `build/`: the ISE build. The output is `CORE09.PHX`, issue 0x0101.

## Building

The core contains no Intellivision BIOS. The simulation's SD card images
take it from `intellivision/` (or `BIOS=dir`): `exec.bin`, `grom.bin`, and
optionally `ecs.bin` and `sp0256-012.bin`.

- **Core.** Run `make` in `build/`. Without ISE installed, it runs each
  ISE tool in the docked-ise-147 Docker image.
- **Loader.** Run `make -C loader`. It needs cc65.
- **Simulation.**
  1. Run `make` in `sim/`. Verilator and Yosys run in the Docker image.
  2. Make a card with
     `make sd.img ROMS="GAME.BIN=path GAME.CFG=path"`.
  3. Run it with `obj_dir/Vintv_phoenix --sd sd.img --frames 330 --pad 55:20,57:00,60:01,62:00 --ppm out/f --ppm-every 30`.
     The `--pad` script presses SNES Down at frame 55 (past `INTV/`) and A at
     frame 60 to start the first file.

  Build with `make VFLAGS=+define+INTV_SIM_TRACE` to print the CPU's bus
  addresses.
