# Experimental service menu: FAT16 + FAT fixes ("X1")

Built from `../servicemenu_2nd_batch_console_only/SERVICE.PHX` (2nd batch boards only).
Only the menu's Z80 ROM (block RAM contents) and the bitstream CRCs differ; the FPGA logic,
pin setup and PHX header (name `SERVICE`, issue 1) are unchanged. SYSTEM INFO shows
`FIRMWARE: X1` instead of `A0`, so you can see which build is running.

| File | What |
|---|---|
| `SERVICE.PHX` | Experimental service menu for UPDATE SERVICE |
| `SERVICE_X1_jtag.bit` | Same bitstream for loading over JTAG into the FPGA only (volatile) |
| `service_rom_fat16.bin` | The patched 16K Z80 ROM |

## Changes (all in the SD/FAT code)

- **FAT16 support.** The original only accepts FAT32. A FAT16 card failed with error 3 (MBR) or
  error 9 (no partition table), which is how cards of 2 GB and smaller usually ship.
- **Partition choice.** The original always used MBR entry 1. Now the first FAT16/FAT32 entry
  (types 04, 06, 0B, 0C, 0E) is used, falling back to entry 1.
- **Partitionless volumes.** The partition base is now cleared explicitly instead of relying on RAM
  being zero.
- **FAT32 end-of-chain.** The original only accepted exactly 0x0FFFFFFF. With any other valid marker
  (0x0FFFFFF8-FE), a missing-file lookup ran off the end of the root directory and hung.
- **FAT32 root directory.** The original never checked the entries in the last sector of the root
  directory's cluster chain. A file listed there was "not found". With 1-sector clusters that is
  the whole last cluster, and it's likely on cards with many files.

The SD driver itself (init, clock, chip select) is untouched.

## Test results (Z80 emulator, real ROM code, SPI SD card model)

Mount, find `CORE01.PHX`, read all 920 sectors and compare; then look up a missing file.

| Image | Original A0 | X1 |
|---|---|---|
| FAT16, MBR | error 3 | OK |
| FAT16, no MBR | error 9 | OK |
| FAT16, 2nd partition, fragmented | error 2 | OK |
| FAT32, no MBR, entry in last dir cluster | not found | OK |
| FAT32, MBR, fragmented | OK | OK |
| FAT32, 2nd partition, 4K clusters | error 2 | OK |
| FAT32, end-of-chain 0x0FFFFFF8 | hangs | OK |
| FAT16 + FAT32 on SDSC (byte-addressed) cards | error 3 / OK | OK |

Re-run with `tools/service_menu/mkimages.py` and `matrix.py` (set up Python with `tools/python/setup.sh`;
needs `mkfs.fat`). The patch source is `tools/service_menu/fat16patch.py`.

## How it was rebuilt

`tools/bitstream/phxrom.py` writes the ROM into the 16 RAMB8 halves (bit k = site 11,9,19,2,18,8,3,24;
half 0 = $0000-$1FFF). `tools/bitstream/s6crc.py` then recomputes the Spartan-6 configuration CRC: 22 bits,
per word `c = shl(c) ^ (reg<<16 | data)`, taps 0x9081, plus the auto-CRC after each FDRI block.
It was derived from ISE references and reproduces the stored CRCs of every shipped bitstream.
Writing the original ROM back reproduces the original PHX byte for byte. `promgen` accepts the `.bit`.

## Testing safely

1. **JTAG first.** In iMPACT, boundary scan, program the FPGA (not the flash) with
   `SERVICE_X1_jtag.bit`. Check SYSTEM INFO shows X1, then INSTALL CORE from a FAT16 card. A power cycle
   brings back the flashed service menu.
2. Then UPDATE SERVICE with this `SERVICE.PHX` on one board.

## Recovery if a service core is bad

Flash: `0x000000` multiboot header, `0x001000` RECOVERY, `0x081000` SERVICE, `0x101000` CORE01 ...
(512K slots). The header sends the FPGA to SERVICE (`0x081100`) with RECOVERY (`0x001100`) as the
fallback image. RECOVERY is a backup service menu (red LED); use UPDATE SERVICE from it.

- **SERVICE fails to configure** (interrupted or corrupt write, bad CRC): falls back to RECOVERY.
- **SERVICE configures but the menu misbehaves:** no automatic fallback, since the hardware only
  checks the bitstream. This build keeps the original logic and only changes SD/FAT code, so the
  likely failure is SD loading, not booting. The way out is JTAG: load a known-good service `.bit`
  into the FPGA and run UPDATE SERVICE with the original `SERVICE.PHX`, or reprogram the flash
  (`base/PHOENIX.mcs` covers the first 2 MB: header, RECOVERY, SERVICE, CORE01, CORE02).
- Don't update RECOVERY with an experimental build. It is the safety net.
