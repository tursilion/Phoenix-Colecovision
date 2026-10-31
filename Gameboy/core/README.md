# Phoenix Game Boy core

Nintendo's Game Boy and Game Boy Color for the CollectorVision Phoenix. The
Game Boy itself (CPU, video, sound, timer, GBC DMA) comes from the
[MiSTer Gameboy core](https://github.com/MiSTer-devel/Gameboy_MiSTer)
(commit f6796f3, 2026-09-21), with its open-source boot ROMs, which are
adapted from [SameBoy](https://github.com/LIJI32/SameBoy) (MIT license).
The menu and SD card loader run on the Game Boy's own CPU.

Status:

- **Hardware:** done. GB and GBC games, the menu, saves and the ROM cache
  for big images (up to 8M) work, and `CACHETST.GB` passes on both
  hardware types.
- **Simulation:** the menu works, and dmg-acid2 (on the original Game
  Boy hardware) and cgb-acid2 (on the GBC) show their test pictures
  correctly after the boot ROMs. The 512K test cartridge (`sim/tests/`)
  passes, and so does the 2M ROM cache test (`CACHETST.GB`, see Building)
  on both hardware types, with its GBC DMA reads.
- **ISE:** 87% of the LUTs, 30 of 32 block RAMs, timing met.

## Using it

1. Put `.GB` and `.GBC` (or `.CGB`) images on a FAT16 or FAT32 SD card, in
   any folders. The menu shows 8.3 names. Images can be up to 8M, for
   either Game Boy, with up to 128K of cartridge RAM. The SRAM holds the
   first 360K-512K of the ROM (it depends on the hardware and the
   cartridge RAM); a bigger image plays from the core's ROM cache, which
   reads the rest from the card as the game needs it (see Limits). Such an
   image must not be fragmented on the card ("FILE FRAGMENTED": copy it
   again, or to a freshly formatted card).
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

- Images up to 8M. The SRAM holds 488K of the ROM on the GBC hardware
  and 512K on the original, less with over 8K of cartridge RAM (on the
  GBC, 456K with 32K and 360K with 128K). When a game reads a part of a bigger ROM that
  isn't in the SRAM, the core reads that 8K from the SD card, in place of
  one not used lately. Meanwhile the CPU waits, as it does for the GBC's
  HDMA, while the picture, sound and timers go on. A read takes about
  10ms, so **the picture can flicker or jump for a frame during these
  loads**: the game misses its interrupts while it waits. Most come at
  scene changes; ROMs that fit in the SRAM never wait.
- If one of the GBC's DMAs reads a part of the ROM that isn't there, the
  whole Game Boy stops instead, and the lines it doesn't draw meanwhile
  show black for a frame or two (rare: games usually copy from ROM with
  DMA at scene changes).
- The LED blinks if a ROM cache read fails its CRC check; the part is read
  again. The SD card has to stay in while a big image is playing.
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
  8K of cartridge RAM. The loader fills the SRAM from the top: cartridge
  RAM over 8K (aligned to its size), the GBC's work RAM banks 2-7 (a 32K
  block, its first 8K unused), then as many 8K ROM pages as fit below.
- **ROM cache.** A 1024-entry table maps each 8K ROM page (8M) to its SRAM
  page, if it has one; a game starts with the pages that fit. On a miss
  the cache picks an SRAM page by the clock algorithm, unmaps the ROM page
  it held, reads the new one with one multi-sector read (CMD18 for 16
  sectors, then CMD12) at 8.4MHz, checks each sector's CRC16 (a bad one
  reads the page again), and maps it. A CPU read holds the CPU with the
  core's HDMA stop (`cpu_hold` in `gb.v`); a DMA read stops the clock
  enables instead (`freeze`), and the video output shows lines the Game
  Boy didn't draw in time black (each line buffer line has its line
  number). The loader gives the SD sector of each page, walking the file's
  cluster chain once (`pf_pages`, added to Petit FatFs). The SRAM controller
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
  the ROM cache, the SRAM controller and the video output.
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
     `TB_CACHE=frame` logs the ROM cache's state changes from that frame.
- **Cache test.** `make -C sim/tests/cachetest LOGO=any.gb` builds
  `CACHETST.GB`, a 2M MBC5 cartridge for either Game Boy. It reads random
  banks and then all of them, checks each 8K page's code and a 1K block
  of its data (a different block each pass), and on the GBC copies from
  random banks with DMA. It shows its counts, and for a bad page which
  page's data it had (HAS) and how many bytes differ from that page
  (DIFF: 0000 means a whole other page). It should show ALL OK and keep
  counting.
