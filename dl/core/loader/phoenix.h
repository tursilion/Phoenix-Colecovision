/* Phoenix Dragon's Lair core: boot mode registers (see rtl/dl_phoenix.v). */

#ifndef PHOENIX_H
#define PHOENIX_H

#define REG(a) (*(volatile unsigned char *)(a))

#define PH_SPI_DATA   REG(0xC000)  /* R: received byte, W: transfer byte */
#define PH_CTRL       REG(0xC001)  /* W: b0 select, b2:1 speed; R: status */
#define PH_SRAM_A0    REG(0xC002)  /* W: SRAM address 7:0; R: b0 write pending */
#define PH_SRAM_A1    REG(0xC003)  /* W: SRAM address 15:8; R: b0 vertical blank */
#define PH_SRAM_A2    REG(0xC004)  /* W: SRAM address 18:16 */
#define PH_SRAM_DATA  REG(0xC005)  /* W: write, then address + 1 */
#define PH_JOY        REG(0xC006)  /* R: controls, active low (as C008) */
#define PH_SYS        REG(0xC007)  /* R: b0 start1 b1 start2 b2 coin1 b3 coin2, active low */
#define PH_LBA0       REG(0xC008)  /* W: disc base sector, little-endian */
#define PH_LBA1       REG(0xC009)
#define PH_LBA2       REG(0xC00A)
#define PH_LBA3       REG(0xC00B)
#define PH_SDHC       REG(0xC00C)  /* W: b0 block addressing */
#define PH_MAXF_LO    REG(0xC00D)  /* W: last frame */
#define PH_MAXF_HI    REG(0xC00E)
#define PH_DSW_A      REG(0xC00F)
#define PH_DSW_B      REG(0xC010)
#define PH_LED        REG(0xC011)  /* W: b0 error LED */
#define PH_START      REG(0xC01F)  /* W: start the game */

/* FAT checker: does a file's cluster chain run straight on? */
#define PH_CHK_SECT0  REG(0xC020)  /* W: FAT sector holding the first entry (4 bytes) */
#define PH_CHK_STATUS REG(0xC020)  /* R: b7 busy, b1 broken run, b0 card error */
#define PH_CHK_INDEX  REG(0xC024)  /* W: the entry's index in that sector */
#define PH_CHK_FAT16  REG(0xC025)  /* W: b0 2-byte entries */
#define PH_CHK_EXP0   REG(0xC026)  /* W: value of the first entry (4 bytes) */
#define PH_CHK_CNT0   REG(0xC02A)  /* W: entries to check (4 bytes) */
#define PH_CHK_START  REG(0xC02E)  /* W: start */
#define PH_CHK_BUSY   0x80
#define PH_CHK_BAD    0x02
#define PH_CHK_ERR    0x01

#define PH_TEXT       ((volatile unsigned char *)0xD000)  /* 40 x 30 overlay */
#define TEXT_COLS     40
#define TEXT_ROWS     30

#define PH_CTRL_SELECT   0x01
#define PH_CTRL_SLOW     0x00      /* speed 0 */
#define PH_CTRL_12M      0x02      /* speed 1 */
#define PH_CTRL_25M      0x04      /* speed 2 */

#define PH_STAT_BUSY     0x80
#define PH_STAT_CARD     0x40

/* PH_JOY bits (active low) */
#define JOY_UP     0x01
#define JOY_DOWN   0x02
#define JOY_LEFT   0x04
#define JOY_RIGHT  0x08
#define JOY_FIRE   0x10

/* PH_SYS bits (active low) */
#define SYS_START1 0x01
#define SYS_START2 0x02

#endif
