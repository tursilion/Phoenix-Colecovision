/* Phoenix Intellivision core boot I/O window (see rtl/intv_phoenix.v). */

#ifndef PHOENIX_H
#define PHOENIX_H

#define PH_SPI_DATA   (*(volatile unsigned char *)0x5000) /* R: received byte, W: transfer byte */
#define PH_CTRL       (*(volatile unsigned char *)0x5001) /* W: control, R: status */
#define PH_LOAD_DATA  (*(volatile unsigned char *)0x5002) /* W: byte to the SRAM, address++ */
#define PH_CRC_RESET  (*(volatile unsigned char *)0x5003) /* W: reset the CRC */
#define PH_START      (*(volatile unsigned char *)0x5004) /* W: start the game */
#define PH_LED        (*(volatile unsigned char *)0x5005) /* W: bit 0 error LED */
#define PH_FWD_LO     (*(volatile unsigned char *)0x5006) /* W: forward count, low byte */
#define PH_FWD_HI     (*(volatile unsigned char *)0x5007) /* W: forward count, high byte, starts */
#define PH_ADDR0      (*(volatile unsigned char *)0x5008) /* W: SRAM load address 7:0 */
#define PH_ADDR1      (*(volatile unsigned char *)0x5009) /* W: 15:8 */
#define PH_ADDR2      (*(volatile unsigned char *)0x500A) /* W: 18:16 */
#define PH_PAGED_LO   (*(volatile unsigned char *)0x500B) /* W: paged zone mask 7:0 */
#define PH_PAGED_HI   (*(volatile unsigned char *)0x500C) /* W: 15:8, takes effect */
#define PH_OPTIONS    (*(volatile unsigned char *)0x500D) /* W: bit 0 swap controllers */
#define PH_EXT        (*(volatile unsigned char *)0x500E) /* W: bit 0 ECS, bit 1 JLP, bit 2 Intellivoice */
#define PH_TARGET     (*(volatile unsigned char *)0x500F) /* W: load target, TARGET_* */

#define TARGET_SRAM   0
#define TARGET_EXEC   1
#define TARGET_GROM   2
#define TARGET_ECS    3
#define TARGET_VOICE  4
#define TARGET_NONE   7  /* CRC only */
#define PH_BUTTONS    (*(volatile unsigned char *)0x5010) /* R: menu buttons */
#define PH_CRC        ((volatile unsigned char *)0x5011)  /* R: CRC-32, 4 bytes, low first */
#define PH_KEY        (*(volatile unsigned char *)0x5015) /* R: keypad key, 0-9, 10 *, 11 #, $FF */

#define TEXT          ((unsigned char *)0x4000)           /* 32 x 30 characters */

/* PH_CTRL write bits */
#define PH_CTRL_SELECT   0x01  /* SD card selected */
#define PH_CTRL_SLOW     0x02  /* slow SPI clock, for card init */
#define PH_CTRL_DISCARD  0x04  /* forward engine skips bytes instead */

/* PH_CTRL read bits */
#define PH_STAT_BUSY     0x80  /* SPI, forward transfer or SRAM write in progress */
#define PH_STAT_CARD     0x40  /* card present */
#define PH_STAT_VBLANK   0x20  /* HDMI vertical blank */

/* PH_BUTTONS bits */
#define PAD_A      0x01
#define PAD_B      0x02
#define PAD_SELECT 0x04
#define PAD_START  0x08
#define PAD_UP     0x10
#define PAD_DOWN   0x20
#define PAD_LEFT   0x40
#define PAD_RIGHT  0x80

#endif
