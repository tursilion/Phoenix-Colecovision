# Space Ace (Rev A3, `sa_a3_u1..u5`) — program analysis

Read `../../lair/analysis/NOTES.md` first. Space Ace runs a **modified copy of the Dragon's Lair F2
engine** on the same board. The library at 0000-06D4 and the IRQ/coin/sound/LED/laserdisc code are nearly identical. The
action-entry format and the window logic are the same. This file covers only the differences.

Files: `ace.asm` (disassembly), `ace_scenes.txt` (all scripts decoded), `ace_scenes.py`, `dis.py`.
Image = u1..u5 concatenated = 0000-9FFF (40K, five 8K ROMs). All five self-test checksums match
(0410-1FFF=F50B, 2000=358E, 4000=903D, 6000=C771, 8000=C6DC).

## Layout
- 0000: `LD HL,E03F / LD (HL),CC / JP 1147` (lights the skill lamps at reset). IRQ = RST 38 → 18C4.
- Code 1144-2058. Data 2059-9D3F. The scene table at **2183** holds 33 scenes (00-20) and is not in address order.
  Scene 00 (attract) lives at 9CD4 in u5.
- Constants block 2059 (still frames: 2059 coin/insert, 205B, 2065-2069), 206D attract scene (80), 206E start slot (81).

## Hardware/DIP differences from Lair (from code)
- Laserdisc select: **DSW B (`A011`) b0**: 0 = LD-V1000, 1 = PR-7820 (Lair used b3). The frame sanity range is 0-0x9088.
- Diagnostics: AY reg 15 b7, **active low** (`A011` b7 = 0 → 0314).
- Lives: DSW A b1 selects 3 or 5 (C3/C5). Free play is `A011` b4 (inverted). Coinage is `A010` b0 (inverted).
- A life is only deducted when `A011` b5 **and** `A011` b3 are both set, with no cheat. The cheat is C008==E9 (down+left+fire),
  checked only in sequences with h0 b6.
- The frame tick drops one IRQ in 0x19/0x99 (Lair: 0x1F/0xFF). On a standard board (mode 2, 0x19) a tick is
  23.976 / (30.52 × 24/25) = **0.818 disc frames** (Lair: 0.812), which `ace_scenes.py` uses.
- Score values are table 2115 **×2**: 0,6,104,402,500,600,1000,1400,1554,1600,2000,2006,3000,3004,3968,4002.
- Inputs as in Lair: 0 FIRE (Energize), 1 UP, 2 DOWN, 4 LEFT, 8 RIGHT, 5/9/6/A diagonals. Ace uses all 8 directions heavily.
- C008 b5/b6/b7 = the three **skill buttons**. The skill lamps are LED outputs E03E/E03D/E03B (pattern CC).

## Skill select (S1FB5, run at game start)
Waits 0x79 ticks (~3.3 s) while blinking the lamps. Cadet / Captain / Space Ace = 0/1/2, stored in player+0xA4
(A0D4 for P1, A0DC for P2; P1's choice is used for both). A timeout gives Cadet.

## Level order: a fixed list per skill, then a 2-way slot pick
- **21C5** → per-skill slot list (FF-terminated), copied to **A080** (`S1D66`). The per-player pointer is A0D0/A0D8.
  (This is the A070→A080 move fixed in A3, see `../sa.txt`.)
  ```
  Cadet     : 02 03 10 05 09 0A 0B 11 0E 0D
  Captain   : 0F 03 04 05 07 09 0A 0B 11 0E 0D
  Space Ace : 0F 03 04 05 06 07 08 09 0A 0B 0C 0E 0D
  ```
  The game starts at slot 01 (scene 01, the intro). After each cleared scene `S1DAB` takes `*ptr++`.
- **20A8** slot table (4 bytes: ptr, flags, -): slot n → 2 alternative scenes
  `01:{01} 02:{02 03} 03:{04 05} 04:{06 07} 05:{08 09} 06:{0A 0B} 07:{0C 0D} 08:{0E 0F} 09:{10 11}
   0A:{12 13} 0B:{14 15} 0C:{16 17} 0D:{18} 0E:{19 1A}(flags b3 → always first) 0F:{1B 1C} 10:{1D 1E} 11:{1F 20}`
  Each pair is a scene and its **mirror image**. They are separate footage on the disc (e.g. 02 starts at 2986, 03 at 4238),
  and every left/right move is swapped between them. Their frame ranges overlap only because they share death clips.
  `S1E24` picks one at random (R & 1) on the first visit and records it in the bitmap A060+slot / A090+slot.
  A revisit reuses the same pick.
  1B/1C, 1D/1E and 1F/20 are variants of 02/03, 06/07 and 16/17 for particular skill lists.
  18 is the final scene (Borf).
- There is no "+0x2A hard scene" scheme and no Lair-style random pools of 3.

## Sequence header: extended
The header is the same 7 bytes as Lair, followed by optional bytes selected by h4:
```
h4 b5 → +2 bytes IY+7/IY+8 : "revisit" targets for branch A / branch B
h4 b6 → +2 bytes IY+9/IY+10: Captain/Ace extension → (scene, seq)
h4 b0 → +1 byte (Cadet only) : checkpoint, written to player+7 (resume seq after death)
h4 b2 / b3 : branch-A / branch-B marker (recorded into the slot bitmap bits 2/3)
h4 b3 + STILL : uses an alternate still command (S02B4)
h0 b6 : attract/idle sequence (inputs not scanned; start buttons polled; cheat check)
```
- **Checkpoints (Cadet)**: when you die you replay the **same scene**, starting from seq `player+7`.
  player+7 is reset to 1 when a scene is entered and moved forward by checkpoint bytes. Lair instead advances you to the next slot.
- **Captain/Ace extension (`S1F57`)**: when a sequence with h4 b6 ends and skill ≥ 1, play continues at (IY+9 scene, IY+10 seq).
  If that is the same scene it continues without a seek. These are the extra segments Cadet skips.
  Exceptions: scenes 0C/0D for Captain and 04/05 for Ace.
- **Energize branch memory (`S1F14`)**: the first time through, the branch marker of the path taken
  (Dexter vs. Ace) is saved. When the scene is replayed, the game jumps directly to IY+7 (A) or IY+8 (B).

## Death flow (h0 b4 DEATH, h0 b5 AFTERDEATH)
Every DEATH clip in a scene targets seq N, and seq N and N+1 are both AFTERDEATH clips (about 50 ticks each):
- lives left → after the DEATH clip, **seq N** plays (152C), then the engine switches player or restarts at the resume seq.
- no player has lives left → the engine plays **seq N+1** instead (1544: A00F++ then play, repeated until a clip with b5), which is the game-over clip.
- this player is out but the other player has lives → no extra clip; play switches to the other player.
The targets written on N and N+1 (e.g. 33 → 33) are never followed; they are only filler.
Reaching an AFTERDEATH clip through normal play (14C2) sets lives to 0, which ends the game.

## Skill tightens the windows (A016)
For every action entry that has a wait-flags byte (the correct moves), the parser computes
`cut = min(last_window_len - 8, k * m)`, where k = skill (+1 once player is "hard") and m = 3 (or 2 if `A010` b3).
The header timeout is then treated as expired when it reaches `cut` instead of 0.
So Captain/Space Ace lose the tail of the final window.
"Hard" (player+5 b4) is set after 4 (or 6, `A010` b2) scenes cleared in a row at skill ≥ 1. A death resets the count (player+0xA5).

## Feedback sounds
A correct (accepted) input sets `A00A` b4. When the next sequence loads, the engine plays sound 1, or sound 2 if that sequence is a death.
Lair played sound 1 immediately.
