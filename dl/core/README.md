# Phoenix laserdisc core (Dragon's Lair, Space Ace)

The Cinematronics Dragon's Lair board (Z80, AY-3-8910, LED scoreboard,
Pioneer LD-V1000 laserdisc player) for the Phoenix, with the laserdisc
replaced by a disc file on the SD card.

Status: Dragon's Lair (F2) and Space Ace (A3) both play in simulation,
with synthetic test-disc frames:

- The boot menu loads the disc file.
- The game boots and calibrates its timing.
- Attract mode runs, and Start begins a game.
- The game searches into the scenes, scores and loses lives.
- Video, disc audio and AY sound all play.

ISE builds it with timing met: 50% LUTs, 15 of 32 block RAMs. It has not
been tried on hardware yet.

## How it works

- **Board** (`rtl/dl_phoenix.v`):
  - Z80 at 4 MHz ([tv80](https://github.com/hutch31/tv80)).
  - AY-3-8910 at 2 MHz ([jt49](https://github.com/jotego/jt49)), whose
    ports read the DIP switches.
  - IRQ at 30.52 Hz (16 MHz / 8 / 65536), as in MAME and Daphne.
  - The U.S. memory map, mirrors included.
  - The game ROM (up to 40K) is in the SRAM. The Z80 has priority there,
    and a read is served well within a T-state, so there are no wait
    states.
- **Laserdisc** (`rtl/ldv1000.v`): the LD-V1000 as the Daphne/Hypseus
  model sees it.
  - Commands are written to E020; the status is read from C020.
  - The status and command strobes come once per 59.94 Hz field.
  - While playing, the frame number advances after 3 fields, then 2, then
    3, then 2. The Dragon's Lair and Space Ace discs hold film with 3:2
    pulldown, and their frame numbers count film frames, so they advance
    at 23.976 per second. Daphne and Hypseus use the same rate.
  - Searches report 0x50 and then 0xD0 once the frame has been read from
    the card.
- **Streaming** (`rtl/sd_stream.v`):
  - A search opens a multi-block read (CMD18) at the frame and reads whole
    frames into 8 frame slots in the SRAM, up to 7 frames ahead.
  - When the slots are full it stops clocking between blocks. A new search
    sends CMD12.
  - SCLK is 25 MHz: an ODDR2 pulse in the second half of each 25 MHz
    clock, with MISO sampled on the falling clock edge.
  - A frame is 46.5 KB (93 sectors), so play needs 1.14 MB/s; the engine
    reads about 2.5 MB/s.
- **Video** (`rtl/video.v`):
  - 640x480 HDMI, showing the 320x240 frame doubled in both directions.
  - Frames are coded as 4x4 cells: 4 colours from a 256-colour palette per
    frame, plus 2 bits per pixel. The decoder only does lookups.
  - A 40x30 text overlay carries the boot menu and, in game, the
    scoreboard row with the cabinet's 16 LED digits.
- **Audio** (`rtl/disc_audio.v`):
  - Each frame carries 2000 stereo samples (1/23.976 s at 47.952 kHz).
  - Playback is continuous, and follows the player's frame number only
    after a search or a jump.
  - Each channel is muted by the player's audio commands.
  - The AY is mixed in.
- **Boot loader** (`loader/`, Z80 C with sdcc and Petit FatFs):
  - Runs from a 24K block RAM in boot mode and lists the `.LD` files.
  - Checks that the chosen file is contiguous on the card. A hardware FAT
    checker in `sd_stream.v` reads the file's FAT entries in one
    multi-block read at 25 MHz and checks each as it streams past. That's
    about 0.1 s for a full disc file on a card with 32 KB clusters, and
    under a second even with 4 KB clusters.
  - Copies the game ROM to the SRAM.
  - Passes the file's first frame sector, the last frame and the DIP
    switches to the core, then starts the game.

## Making a disc file

```
tools/mkdisc.py LAIR.LD --game lair --rom dl_f2_u1.bin dl_f2_u2.bin dl_f2_u3.bin dl_f2_u4.bin \
    --framefile .../vldp_dl/lair/lair.txt
tools/mkdisc.py ACE.LD  --game ace  --rom sa_a3_u1.bin ... sa_a3_u5.bin \
    --framefile .../vldp_dl/ace/ace.txt
```

- `--framefile`:
  - Takes a Daphne/Hypseus framefile. Each `N file.m2v` line starts a
    segment at disc frame N, and the audio is the `.ogg` of the same name.
  - Daphne's Lair m2v starts at frame 151, and Ace's at frame 2.
  - Disc frame f shows video frame f − N, the same as Hypseus, because
    the files run at the disc's 23.976 fps.
  - Its audio is the 1/23.976 s that starts at (f − N) / 23.976 s.
- `--video V [--audio A] [--offset N]`: does the same for one video file,
  which starts at disc frame N.
- Encoding takes about 0.2 s per frame per CPU core. A full Lair disc
  takes about 15 minutes on 24 cores.
- `--test`: synthetic frames that show their frame number, with a tone.
  This makes a full-size test disc in seconds, for bring-up without the
  video.
- `--dsw-a` and `--dsw-b`:
  - Set the raw DIP bytes as the game reads them.
  - The defaults are Hypseus's (Lair 22/D8, Ace 3D/FE), with free play
    turned on. Both select the LD-V1000.
  - `--coins` turns free play off.
- Fast boot is on by default:
  - The games' two 15.7 s power-on waits, which give the player time to
    spin up, are patched to 0.5 s each. Attract mode then starts about 5 s
    after the menu, and most of that is the game timing its IRQ.
  - The ROM is checked before it's patched.
  - `--slow-boot` keeps the original waits.
- `tools/ldview.py FILE.LD 1234` decodes frame 1234 to a PNG exactly as
  the core does.

Copy the `.LD` files to a FAT16 or FAT32 card. A freshly formatted card is
best, because the loader refuses fragmented files.

## Controls

|                   | ColecoVision  | SNES pad  | PS/2 keyboard |
|---                |---            |---        |---            |
| stick             | stick         | D-pad     | arrows        |
| sword / energize  | either fire   | A, B      | Z, X          |
| start 1 / 2       | keypad 1 / 2  | Start / - | 1 / 2         |
| coin              | keypad * or 3 | Select    | 3             |
| Ace skill (cadet, captain, ace) | keypad 4 5 6 | X Y L | 4 5 6 |
| scoreboard on/off | keypad 0      | R         | 0             |
| reset             | reset button  |           | ESC           |

Hold reset (or ESC) for a second to go back to the menu.

In the menu:

- Up/Down move, and Left/Right page.
- Fire or Start 1 opens.
- Start 2 goes up a folder.

With `--slow-boot`, the game waits about 35 s after a reset before it
shows anything, like the real machine while its player spins up.

## Layout

- `rtl/dl_phoenix_top.vhd`: the top level, with clocks, resets, the SD
  clock ODDR2, controllers and HDMI. It uses the shared `rtl/phoenix.ucf`.
- `rtl/cv_pads_dl.vhd`: reads both ColecoVision controllers, including the
  keypads.
- `rtl/dl_phoenix.v`, `ldv1000.v`, `sd_stream.v`, `video.v`,
  `disc_audio.v`: the core.
- `rtl/tv80/` and `rtl/jt49/`: vendored, see `rtl/UPSTREAM.txt`.
  - `tv80/tv80e.v` is tv80s with a clock enable.
- `rtl/dl_boot.hex` and `rtl/font.hex`: generated by `loader/`.
- `tools/`: the disc file maker and viewer.
- `sim/`: the Verilator testbench, with SRAM and SD card (CMD17/18/12)
  models.
  - The testbench makes up test-disc frames from the first frame's sector
    on, so a small image can stand in for the whole disc.
- `build/`: the ISE command-line build. The default core file is
  `CORE05.PHX`.

## Building

- **Core:** use ISE 14.7, the same way as the NES core:

      docker run --rm -v "$REPO":/workspace -v /path/to/Xilinx.lic:/root/.Xilinx/Xilinx.lic -w /workspace/dl/core/build docked-ise-147 make

- **Boot loader and font:** these need sdcc 4.x, and are only rebuilt
  after changing `loader/`:

      make -C loader

- **Simulation:** needs Verilator 5 and Python with numpy and Pillow. The
  ROMs are read from `../lair` and `../ace`.

      cd sim
      make sd_lair.img && make
      obj_dir/Vdl_phoenix --sd sd_lair.img --frame0 2116 --frames 1500 --ppm out/f --ppm-every 15 \
        --pad 50:02:0,53:00:0,60:10:0,63:00:0,900:00:1,912:00:0

  - `--frame0` is the first sector of LAIR.LD (printed by `mkimg.py`) plus
    65.
  - `--pad` moves to LAIR.LD in the menu, opens it, and presses Start at
    video frame 900.
  - For Space Ace, use `--frame0 2290` with `--pad 50:10:0,53:00:0`,
    because ACE.LD is the first entry in the menu.
  - `--patch addr=val` changes game ROM bytes after loading.
