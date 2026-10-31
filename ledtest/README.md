# Coleco LED test core (slot 29)

A copy of the ColecoVision core with one extra I/O port, `>5F`, so a cart
can drive the board's two LEDs. It goes in slot 29 (`CORE29.PHX`), so the
real ColecoVision core in slot 1 is not changed.

## The LEDs (schematic `DOCs/FPGACV_mini6.pdf`)
- **D24, green**, FPGA pin D14 (`led_o`): 3.3V - 330R - pin - LED - GND.
  `'Z'` = on, `'0'` = off. Never drive `'1'`. The cores light it during
  reset; the Coleco core also lights it in the menu and on cache errors.
- **D6, RGB**, pins B16/A16/C15 (red/green/blue): common anode at 3.3V,
  200R per colour. A colour is lit when its pin is `'0'`. Every core drives
  `"001"`, a steady yellow.

## Port >5F
| Bits | Write | 
|---|---|
| 1-0 | LED: 00/11 = normal, 01 = off, 10 = on |
| 7 | 1 = override the RGB LED with bits 6/5/4 |
| 6-4 | red, green, blue (1 = lit) |

Reading returns the value written. Reset sets `>00` (both normal).

## Files
- `rtl/colecovision.vhd`, `rtl/phoenix_top.vhd`: the core's two files with
  the port added. Everything else builds from `../rtl`. To pick up later
  core changes, re-apply the port to fresh copies (`diff` these against
  `../rtl`: only the `>5F` / `dbg_led` / `rgb` lines differ).
- `build/Makefile`: `make` builds `CORE29.PHX` (ISE in Docker, like
  `rtl/build`).
- `cart/`: `LEDTEST.ROM`, a plain 32K cart (SDCC 4.2: `make`).

## The cart
Keypad on either controller, or the PS/2 number keys:

| Key | |
|---|---|
| 1 / 2 / 3 / 4 | LED normal / off / on / blink (1 Hz) |
| 5 | RGB normal (yellow) |
| 6 / 7 / 8 | toggle red / green / blue |
| 9 | cycle the 8 RGB colours, one a second |
| 0 | both normal |
| * / # | both off / both on (white) |

The screen shows whether the core has the port (`PORT >5F SUPPORT YES`),
the value written and read back, and each LED's state.
