Service Menu Fixes:

- Firmware version changed to X1
- Support FAT16 as well as FAT32
- Supports first FAT partition instead of assuming it's partition 1
- two potential FAT32 hangs fixed
- one potential 'can't find' file bug fixed (requires a lot of files)

Installing:

======================================================================================
PLEASE DO NOT LOAD THIS AS A DESPERATION FIX. IT WILL NOT FIX WHATEVER YOU ARE SEEING.
======================================================================================

*** THIS IS EXPERIMENTAL ***

Unlike a Core, this is the boot system of the Phoenix. I don't recommend changing it - it's substantially simpler to just format your SD card with FAT32.

I am NOT CERTAIN of the recovery process if it fails. You may end up having to ship your Phoenix to me to recover it. I live in Canada, and that may be pricey.

Be aware it's only tested on my original developer unit. Rev 2 is not confirmed, but is expected to be configured correctly.

So my recommendation is DO NOT PROCEED.

*** THIS IS EXPERIMENTAL ***

Proceeding? Okay then!

- You /must/ use a FAT32 formatted SD card. The original Service menu can't read anything else. That's why we're doing this.
- Use the '#' to get to the service menu, and #3 to UPDATE SERVICE. Then just wait. When it reboots, go back into the service menu and hit #5 for SYSTEM INFO, and the firmware should now read X1.

It should now read FAT16 as well as FAT32 cards. That's the only gain.

  +----------------------------------------------------------------------+
  ¦                 Card layout                 ¦ Original A0 ¦    X1    ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT16 with MBR (1 GB card)                  ¦ error 3     ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT16, no MBR                               ¦ error 9     ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT16 on second partition                   ¦ error 2     ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT32, file listed in last directory sector ¦ not found   ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT32 on second partition                   ¦ error 2     ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT32, other end-of-file marker             ¦ hangs       ¦ reads OK ¦
  +---------------------------------------------+-------------+----------¦
  ¦ FAT32 cases that already worked             ¦ OK          ¦ still OK ¦
  +----------------------------------------------------------------------+

