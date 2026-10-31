/* Phoenix Game Boy core loader I/O window, at $A000 in loader mode (see
 * rtl/gb_phoenix.v), and the Game Boy registers the loader uses. */

#ifndef PHOENIX_H
#define PHOENIX_H

#define IO(a) (*(volatile unsigned char *)(0xA000 + (a)))

#define PH_SPI_DATA   IO(0x00)  /* R: received byte, W: transfer byte */
#define PH_CTRL       IO(0x01)  /* W: control, R: status */
#define PH_LOAD_DATA  IO(0x02)  /* W: byte to the SRAM, address++ */
#define PH_CRC_RESET  IO(0x03)  /* W: reset the CRC */
#define PH_START      IO(0x04)  /* W: start the game */
#define PH_LED        IO(0x05)  /* W: bit 0 error LED */
#define PH_FWD_LO     IO(0x06)  /* W: forward count, low byte */
#define PH_FWD_HI     IO(0x07)  /* W: forward count, high byte, starts */
#define PH_ADDR0      IO(0x08)  /* W: SRAM load address 7:0 */
#define PH_ADDR1      IO(0x09)  /* W: 15:8 */
#define PH_ADDR2      IO(0x0A)  /* W: 18:16, bit 3 cartridge RAM block RAM */
#define PH_MAPPER     IO(0x0B)  /* W: MAP_* */
#define PH_ROM_MASK   IO(0x0C)  /* W: 16K banks - 1, bits 7:0 */
#define PH_ROM_MASK8  IO(0x0D)  /* W: bit 0: bit 8 */
#define PH_RAM        IO(0x0E)  /* W: bits 3:0 8K banks - 1, bit 6 block RAM, bit 7 has RAM */
#define PH_MODE       IO(0x0F)  /* W: bit 0 GBC, bit 1 fast boot, bits 3:2 DMG palette */
#define PH_KEY        IO(0x10)  /* R: keypad key, 0-9, 10 *, 11 #, $FF */
#define PH_CRC        ((volatile unsigned char *)0xA011)  /* R: CRC-32, low first */
#define PH_SPI_NEXT   IO(0x15)  /* R: received byte, starts the next transfer */
#define PH_MEM        IO(0x16)  /* R: byte at the load address, address++ */
#define PH_SLOTS      IO(0x17)  /* W: ROM cache: SRAM pages (8K) for the ROM */
#define PH_PAGE_LO    IO(0x18)  /* W: ROM cache: ROM page for PH_ARG, bits 7:0 */
#define PH_PAGE_HI    IO(0x19)  /* W: bits 9:8 */
#define PH_ARG        ((volatile unsigned char *)0xA01A)  /* W: its SD argument, low first; the 4th byte stores it */
#define PH_WRAM_BASE  IO(0x1E)  /* W: SRAM address bits 18:15 of the GBC work RAM */
#define PH_CRAM_BASE  IO(0x1F)  /* W: SRAM address bits 18:13 of the cartridge RAM */
#define PH_KEEP       ((unsigned char *)0xA080)  /* 128 bytes kept across resets */

#define MAP_NONE 0
#define MAP_MBC1 1
#define MAP_MBC2 2
#define MAP_MBC3 3
#define MAP_MBC5 4

/* PH_CTRL write bits */
#define PH_CTRL_SELECT   0x01  /* SD card selected */
#define PH_CTRL_SLOW     0x02  /* slow SPI clock, for card init */
#define PH_CTRL_DISCARD  0x04  /* forward engine skips bytes instead */

/* PH_CTRL read bits */
#define PH_STAT_BUSY     0x80  /* SPI, forward transfer or SRAM write in progress */
#define PH_STAT_CARD     0x40  /* card present */

/* Load addresses: the SRAM, and the 8K cartridge RAM block RAM */
#define SRAM_ROM   0x00000UL
#define SRAM_TOP   0x80000UL
#define BRAM_CRAM  0x80000UL
#define ROM_MAX    0x800000UL  /* 8M */
#define PAGE       0x2000UL    /* ROM cache page */

/* Game Boy registers */
#define REG(a) (*(volatile unsigned char *)(a))
#define P1    REG(0xFF00)
#define LCDC  REG(0xFF40)
#define LY    REG(0xFF44)
#define VBK   REG(0xFF4F)
#define HDMA1 REG(0xFF51)
#define HDMA2 REG(0xFF52)
#define HDMA3 REG(0xFF53)
#define HDMA4 REG(0xFF54)
#define HDMA5 REG(0xFF55)
#define BCPS  REG(0xFF68)
#define BCPD  REG(0xFF69)

/* Buttons, from the joypad register */
#define PAD_A      0x01
#define PAD_B      0x02
#define PAD_SELECT 0x04
#define PAD_START  0x08
#define PAD_RIGHT  0x10
#define PAD_LEFT   0x20
#define PAD_UP     0x40
#define PAD_DOWN   0x80

#endif
