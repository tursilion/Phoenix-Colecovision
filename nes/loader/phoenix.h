/* Phoenix NES core boot I/O window, present only in boot mode. */

#ifndef PHOENIX_H
#define PHOENIX_H

#define PH_SPI_DATA   (*(volatile unsigned char *)0x5000) /* R: received byte, W: transfer byte */
#define PH_CTRL       (*(volatile unsigned char *)0x5001) /* W: control, R: status */
#define PH_LOAD_DATA  (*(volatile unsigned char *)0x5002) /* W: byte to the ROM loader */
#define PH_LOAD_RESET (*(volatile unsigned char *)0x5003) /* W: reset the ROM loader */
#define PH_START      (*(volatile unsigned char *)0x5004) /* W: start the game */
#define PH_LED        (*(volatile unsigned char *)0x5005) /* W: bit 0 error LED */
#define PH_FWD_LO     (*(volatile unsigned char *)0x5006) /* W: forward count, low byte */
#define PH_FWD_HI     (*(volatile unsigned char *)0x5007) /* W: forward count, high byte, starts */

/* PH_CTRL write bits */
#define PH_CTRL_SELECT   0x01  /* SD card selected */
#define PH_CTRL_SLOW     0x02  /* slow SPI clock, for card init */
#define PH_CTRL_DISCARD  0x04  /* forward engine skips bytes instead */

/* PH_CTRL read bits */
#define PH_STAT_BUSY     0x80  /* SPI or forward transfer in progress */
#define PH_STAT_CARD     0x40  /* card present */
#define PH_STAT_ERROR    0x02  /* ROM loader rejected the header */
#define PH_STAT_DONE     0x01  /* ROM loader has the whole file */

#endif
