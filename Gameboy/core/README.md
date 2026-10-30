# Phoenix Game Boy core

Nintendo's Game Boy and Game Boy Color for the CollectorVision Phoenix. The
Game Boy itself (CPU, video, sound, timer, GBC DMA) comes from the
[MiSTer Gameboy core](https://github.com/MiSTer-devel/Gameboy_MiSTer)
(commit f6796f3, 2026-09-21), with its open-source boot ROMs, which are
adapted from [SameBoy](https://github.com/LIJI32/SameBoy) (MIT license).
The menu and SD card loader run on the Game Boy's own CPU.

Status:

- **Simulation:** the menu works, and dmg-acid2 (on the original Game
  Boy hardware) and cgb-acid2 (on the GBC) show their test pictures
  correctly after the boot ROMs. The 512K test cartridge (`sim/tests/`)
  passes: all 31 ROM banks, the 8K cartridge RAM and the work RAM.
- **ISE:** 78% of the LUTs, 28 of 32 block RAMs, timing met.
- **Hardware:** not tested yet.

## Using it

1. Put `.GB` and `.GBC` (or `.CGB`) images on a FAT16 or FAT32 SD card, in
   any folders. The menu shows 8.3 names. Images can be up to 512K:
   - Up to 256K: any game, with up to 128K of cartridge RAM.
   - Over 256K: the image fills the SRAM, so the game runs on the original
     Game Boy hardware, with up to 8K of cartridge RAM. Games for both
     Game Boys run without colour; Game Boy Color-only games of that size
     do not run.
2. Install `build/CORE10.PHX` with the Phoenix boot loader.
3. Power up with the card inserted and pick a game.

Menu: up and down move, left and right page through the list, A (or Start)
opens a folder or starts a game, and B goes up a folder.

- **Keypad 1, the hardware:** AUTO, GB or GBC. AUTO uses the cartridge
  header: Game Boy Color games, and the games for both, run on GBC
  hardware, the others on the original Game Boy. GB runs a game for both
  on the original Game Boy. GBC runs an original Game Boy game on GBC
  hardware, which colours it like a real Game Boy Color does.
- **Keypad 2, the colours** of games on the original Game Boy: grey,
  green, pocket or light.

On a SNES pad, L and R do what keypad 1 and 2 do.

In a game:

| Game Boy | ColecoVision controller | SNES pad | PS/2 keyboard |
|---|---|---|---|
| D-pad | stick | D-pad | arrows |
| A | left fire | A or X | X |
| B | right fire | B or Y | Z |
| Start | # | Start | Q |
| Select | * | Select | W |

Both ColecoVision ports work.

The reset button or ESC resets the game. Hold either for a second to go
back to the menu. Power cycle to change cores.

Cartridges: no mapper, MBC1, MBC2, MBC3 and MBC5 (and HuC1 as MBC1).

Saves: if a `.SAV` file with the game's name is next to it, it goes into
the cartridge RAM when the game starts. **To save, hold reset to go back to
the menu**: if the game changed its cartridge RAM, the menu writes it back
to the `.SAV` file ("GAME SAVED"). A short reset keeps the cartridge RAM,
like a real cartridge, but switching off in a game loses what it saved
since the game started. The menu cannot create files or make them bigger, so
a new game needs a `.SAV` file of its cartridge RAM's size first (for
example from an emulator, or a file of zeros: 8K, 32K, ...). Without one
the menu shows "NOT SAVED: NO .SAV".

## Limits

- Images up to 512K; over 256K only on the original Game Boy hardware and
  with at most 8K of cartridge RAM.
- Saves are written only on the way back to the menu, and only to an
  existing `.SAV` file.
- No MBC3 clock (it reads 0), no rumble, camera or other special
  cartridges, no Super Game Boy, no link cable.
- The core runs at 59.52 frames per second instead of 59.73, locked to the
  640x480 HDMI output.
- Colours are the raw GBC colours, without the LCD's colour correction.

## How it works

- **Clocks.** The Game Boy runs from 8 x 4.194MHz. Here a DCM_CLKGEN makes
  33.75MHz from 25MHz, slightly fast. At the top of each Game Boy frame a
  BUFGCE stops that clock until HDMI line 513, which keeps one Game Boy
  frame per HDMI frame. The picture is 160 x 144 pixels, each 10/3 HDMI
  pixels wide and high (3, 3 or 4): 533 x 480, centered, from an 8-line
  buffer.
- **Memory.** The video RAM, OAM, high RAM and boot ROMs are block RAM, and
  so are work RAM banks 0 and 1 (all of the original Game Boy's) and up to
  8K of cartridge RAM. The ROM is in the SRAM from 00000, up to 512K. With
  a ROM up to 256K the SRAM also holds the GBC's work RAM banks 2-7 (at
  42000) and cartridge RAM over 8K (at 60000). The SRAM controller
  alternates reads between the cartridge and the work RAM every clock, so
  the data follows the address within a few clocks (`rtl/gb_phoenix.v`).
- **Loader.** At power-on the Game Boy starts in CGB mode without its boot
  ROM, and the cartridge bus reads a 16K block RAM ROM: the loader
  (`loader/`, SDCC for the sm83). `$A000-$BFFF` is then an I/O window with
  the SD card's SPI port and a forward engine that sends SD bytes to the
  SRAM. The menu is drawn by the Game Boy's own video chip. To start a game
  the loader sets the mapper and the hardware, and the core resets the Game
  Boy with its boot ROM and the game's cartridge.
- **Saves.** The loader keeps a note of the `.SAV` file, its length and
  the CRC of what it loaded in 128 bytes of the I/O window that resets
  don't clear. Back in the menu the cartridge RAM is still there, so the
  loader takes its CRC again and, if it changed, writes it to the file
  with Petit FatFs (single-block SD writes).

## Layout

- `rtl/gb_phoenix_top.vhd`: the top level, with clocks, resets,
  controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/gb_phoenix.v`: the frame lock, controller mapping, loader I/O, SPI,
  the SRAM controller and the video output.
- `rtl/gb_cart.v`: the cartridge mappers.
- `rtl/gb/`: the MiSTer core's files.
  - `gb.v` has no savestates, cheats, Super Game Boy, MegaDuck or link
    port. Its work RAM is outside, its RAMs use clock enables instead of
    gated clocks, and it has a loader mode without the boot ROM.
  - `sprites.v` and `video.v` have small changes for XST and Verilator.
  - `ss_regs.v` replaces the savestate registers with their reset values.
  - `gb_boot.hex` is the CGB boot ROM (2304 bytes) and the DMG boot ROM
    (256 bytes).
  - The other files are unchanged, except a constant in `gbc_snd.vhd`.
- `loader/`: the menu and loader (SDCC), with Petit FatFs and the
  ColecoVision menu font.
- `sim/`: the Verilator testbench. The VHDL is turned into Verilog with
  Yosys + GHDL. `sim/tests/` builds BIG512.GB, a 512K MBC1 test cartridge
  (`make -C sim/tests LOGO=any.gb`, for the header's logo): black screen
  if its ROM banks, cartridge RAM and work RAM all check out. It also
  builds SAVE32.GB and SAVE8.GB, which fill their 32K or 8K of cartridge
  RAM with a pattern, to test the saves (`--menu-reset n` goes back to the
  menu at frame n, `--sd-out` writes the card image at the end).
- `build/`: the ISE build. The output is `CORE10.PHX`, issue 0x0101.

## Building

- **Core.** Run `make` in `build/`. Without ISE installed, it runs each
  ISE tool in the docked-ise-147 Docker image.
- **Loader.** Run `make -C loader`. It needs SDCC 4.2.
- **Simulation.**
  1. Run `make` in `sim/`. Verilator and Yosys run in the Docker image.
  2. Make a card with `make sd.img ROMS="GAME.GB=path ..."`.
  3. Run it with `obj_dir/Vgb_phoenix --sd sd.img --frames 330 --pad 35:01,37:00 --ppm out/f --ppm-every 30`.
     The `--pad` script presses SNES A at frame 35 to start the first file.
     `--key frame:n` presses ColecoVision keypad key n.
