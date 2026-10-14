# Dragon's Lair (US Rev F2, `dl_f2_u1..u4`) — program analysis

The two disassemblies in `../disassembly/` are for **other** versions: set #1 prototype and
the Italian/Sidam board (Z80 CTC/SIO hardware). Neither matches F2 byte for byte. Everything
here comes from our own trace of the F2 image (`u1+u2+u3+u4` = 0000-7FFF).

Files:
- `dis.py`: recursive-descent Z80 disassembler (needs `pip install z80dis`), producing `lair.asm`
- `scenes.py`: decodes the scene/script tables, producing `scenes.txt`

All four ROM checksums match the values the diagnostics expect (0410-1FFF=F576, 2000=B863,
4000=ABED, 6000=B3E4).

## Memory map (as used by the code)

| Addr | R/W | Use |
|---|---|---|
| 0000-7FFF | R | ROM. Code at 0000-06CA (library), 1100-1FE5 (game); data at 1FE6-6D07 |
| A000-A7FF | RW | RAM (stack at A3FF) |
| C000 | R | AY-3-8910 data read (DIPs: reg 14 = DSW A → `A010`, reg 15 = DSW B → `A011`) |
| C008 | R | Controls, active low: b0 up, b1 down, b2 left, b3 right, b4 sword (up/down vs left/right pairing proven by the diagonals used in the scripts; left-vs-right order follows the MAME convention) |
| C010 | R | b0 START1, b1 START2, b2 COIN1, b3 COIN2, b6 LD-V1000 status strobe, b7 LD-V1000 command strobe / PR-7820 READY |
| C020 | R | Laserdisc status byte (LD-V1000: D0 = search done, 90 = search failed) |
| E000 / E010 | W | AY data / AY address latch |
| E008 | W | Misc latch (shadow `A020`): b4 coin counter, b5/b6/b7 laserdisc strobes |
| E020 | W | Laserdisc command byte |
| E030-E03F | W | LED digits: E038-E03D P1 score, E03E P1 lives, E030-E035 P2 score, E03F P2 lives, E036/E037 credits |

IRQ (IM 1, RST 38 → 1820): coin handling, the script countdowns, and the sound sequencer. The IRQ is
16 MHz / 8 / 65536 = 30.52 Hz (MAME, Daphne). At boot the code times the IRQ against a CPU loop and picks a
mode (`A001` b0/b3): a standard board gives mode 2 (loop count 0x15BA, shown on the P2 score digits), in which
the timers skip one IRQ in 0x1F (`A000`), so script timers count **ticks of 30.52 × 30/31 = 29.53 Hz**.
The disc's frame numbers count **film frames, 23.976 a second** (3:2 pulldown; Daphne/Hypseus run the disc at
that rate). So **1 tick = 23.976 / 29.53 = 0.812 disc frames**, which matches the ~0.815 measured from ~50
seamless (no-seek) jumps in the scripts. Space Ace skips one IRQ in 0x19 instead: 0.818 frames per tick.
To predict where the disc is: frame ≈ start_frame + 0.812 × ticks.

## Laserdisc drivers (DSW B bit 3 selects the player)
- Command table at **1100**: index 0-9 = digits `3F 0F 8F 4F 2F AF 6F 1F 9F 5F`, 0A=F7 SEARCH,
  0B=FD PLAY, 0C=FB STILL, 0D=DF, 0E=EF, 0F=F1, 10=F4/11=FC (audio channels), 12=A3, 13=A0
  (PR-7820 audio), 14=CD/15=CE/16=FA/17=E1/18=E0.
- `S0204` (index → `A021`), `S020F` (send). LD-V1000: sends FF then the command, with handshaking on C010 b6/b7.
  PR-7820: strobes E008 b6 using delay loops.
- `S012A` = seek: converts the 24-bit frame `A00B-A00D` to 5 BCD digits, sends digits+SEARCH, waits for
  D0. On a 90 it retries with frame+1. After 3 failures, a frame outside 0x64-0x7BD4 resets
  the CPU. If `A008` b4 is set it then sends PLAY (`S1C08`); `S1C18` seeks and holds a still frame.

## Script engine (the important part)

### Hierarchy
```
scene number (0-5D) --2108 table--> sequence-pointer table --[seq idx]--> sequence record
```
- `A00E` = current scene (bit 7 set), `A00F` = sequence index within it. `S15B4` loads one.
- A **goto byte** (`A012`, handled by `S1BE9`): bit 7 set means go to another scene/slot `(b&7F)`, sequence 0.
  Bit 7 clear means go to sequence `b` in the current scene.

### Sequence record format
Zero or more **action entries**, each starting with a byte that has bit 7 set:
```
b0: 1 nn f iiii   nn = (#targets-1), f = a wait-flags byte is present, iiii = input
                  input: 0 SWORD, 1 UP, 2 DOWN, 4 LEFT, 8 RIGHT, 5 UL, 9 UR, 6 DL, A DR
b1: ssssss pp     pp = number of windows; ss = 2-bit target selector for window 1,2,3
targets[nn+1]     goto bytes (FF = ignore)
[flags]           b7/b6/b5 = "wait" for target 0/1/2
counters[pp+1]    counter0 = delay before the first window; counter1.. = window lengths (ticks)
```
Then a 7-byte **header** (first byte has bit 7 clear):
```
h0  b0-3 score index (table 209A: 0,49,124,251,379,495,915,1326,1939,2191,2675,3255,3551,4026,4750,5000)
    b4 DEATH sequence (leaving it runs life-loss/player-switch), b5 AFTERDEATH (see "Death flow" below), b6 attract
h1  goto when the timeout expires (usually a death)
h2,h3 timeout in ticks (16-bit)
h4  b0 cheat combo allowed (C008==EA: up+left+sword → A00A b0, no life loss)
    b4 STILL (search + hold, no PLAY)   b7 NOSEEK (disc keeps playing into next seq)
h5,h6 start frame number (16-bit)
```
Action entries are unpacked to RAM at A0E0, A0F0, … (16 bytes each), and the header follows them (pointed to by IY).
The IRQ counts the active window counters down. `S16BD` polls inputs: `S1C7D` sets an edge bit
(A040 = sword, A040+n = direction n). For each entry it finds the current window. If that input is
newly pressed, it plays sound 1 and takes the selected target. With the **wait** flag the jump is
held until the entry's windows run out, and then made **without a seek** (seamless footage). Without it,
the jump is immediate, which is typically a death. A press that matches no entry plays sound 2 (feedback buzz).
When the header timeout reaches 0 the engine takes `h1`.

Convention in every gameplay scene: seq 0 = normal entry, seq 1 = lead-in used after a death
(this then flows into seq 2, a copy of seq 0), then the move chain, death sequences, and a tail. See `scenes.txt`.

### Scene numbering
- 00-29 normal. **2A-53 = the same disc segments with harder (shorter) windows**. The engine adds 0x2A when
  DSW A b2 (always hard) is set, or once the player has cleared 5 (or 9, DSW B b4) scenes (`S1FA7`).
- 54-58 = alternate scripts for 11/15/1A/12/1B. `L003B` picks them at random sometimes, on hard, when DSW A b1=0.
  59-5D are their hard versions, used in the replay list.
- 25 = attract (frames 194-323). 00 = the P1 opening (P2 starts at slot 1).

### Level slots: scripts exit to *slots*, not scenes
A "SCENE xx" exit inside a script is a **slot** 0-D, looked up in the table at 2035 (4 bytes: ptr, flags, reset):
```
0:{00} 1:{03 0B 11} 2:{0D 18 16} 3:{1F 0F 19} 4:{26 27 26} 5:{22 23 21} 6:{09 17 1A}
7:{08 0A 15} 8:{01 02 05} 9:{06 07 0C} A:{04 10 12} B:{0E 13 1D} C:{1C 20 1B} D:{14 1E 24} (sequential)
```
`S1CC3` / `S1DC3` pick a not-yet-played member at random (using the R register), with per-player
bitmaps at A060+slot (P1) and A090+slot (P2). Slot D is played in order: 14 → 1E → 24 (24 = the finale).

### Death flow (h0 b4 DEATH, h0 b5 AFTERDEATH)
A wrong move or timeout jumps to a DEATH clip. When it ends, the engine stops following targets and runs its own death code.
Every DEATH clip in a scene points at the same AFTERDEATH clip. That clip is the scene's **game-over clip**,
and it is only played if no player has lives left (loop at 1526-153F: play, then stop at the first clip with b5).
Otherwise there is no extra clip: the engine switches player or restarts directly. The AFTERDEATH clip's own target (→ seq 0) is never used.
Reaching an AFTERDEATH clip through normal play (14BD) also ends the game.

### Death and finale rules
- On death: lives--, the failed scene goes into a replay list (player+0x90, 8 bytes). The player
  resumes at the **next slot** (player+6 + 1), not the same scene. In engineering mode the same scene is replayed.
- On reaching scene 24/4E (`S1F14`), every scene in the replay list must be cleared before the finale plays.
- Buy-in/continue still frames at checkpoints 14/1E/24 (table 201D) when DSW A b6 is set (`S1E1E`).

## Player block (DE = A030 for P1, A038 for P2)
+0 resume goto byte, +1 lives (C0|n; b7 active, b6 first entry), +2..+4 score (24-bit binary),
+5 flags (b1 extra-scene, b2 replay phase, b4 hard, b5 finale reached, b6 died, b7 death pending),
+6 current slot, +7 scenes-cleared counter.

## DIPs (inferred from code. Names are tentative)
DSW A (`A010`): b0 coinage, b1 0 = enable extra scenes, b2 always hard, b3 engineering mode
(start scene from DSW B, infinite lives, START1 replays scene), b4 free play, b5 3/5 lives,
b6 pay-as-you-go/buy-in, b7 diagnostics (checked in IRQ → 030D).
DSW B (`A011`): b0 attract sound 1-in-8, b1 attract sound always, b2 unlimited lives, b3 LD-V1000(1)/PR-7820(0),
b4 hard after 9 vs 5, b5/b6 buy-in behaviour, b7 disables hard mode and extras.

## Other
- Diagnostics (030D): RAM 55/AA test, ROM checksums, AY tone test, LED test, input test. Results are shown by
  seeking to frames 0x99-0xBC (the disc holds test-result frames), then frame 0x189A.
- Sound: `S1A9B(n)` starts AY sequence n from table 20BA, and `S19FA` steps it in the IRQ.
