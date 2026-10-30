/* Phoenix PC Engine core loader I/O window, at $1800 of the I/O page in
 * loader mode (see rtl/tg16_phoenix.v), and the PC Engine registers the
 * loader uses.  The VDC is used through its mirror at $0200: cc65 would
 * make $0000-$00FF zero page accesses, which go to RAM on the HuC6280. */

#ifndef PHOENIX_H
#define PHOENIX_H

#define IO(a) (*(volatile unsigned char *)(0x1800 + (a)))

#define PH_SPI_DATA   IO(0x00)  /* R: received byte, W: transfer byte */
#define PH_CTRL       IO(0x01)  /* W: control, R: status */
#define PH_LOAD_DATA  IO(0x02)  /* W: byte to the SRAM, address++ */
#define PH_START      IO(0x04)  /* W: start the game */
#define PH_LED        IO(0x05)  /* W: bit 0 error LED */
#define PH_FWD_LO     IO(0x06)  /* W: forward count, low byte */
#define PH_FWD_HI     IO(0x07)  /* W: forward count, high byte, starts */
#define PH_ADDR0      IO(0x08)  /* W: SRAM load address 7:0 */
#define PH_ADDR1      IO(0x09)  /* W: 15:8 */
#define PH_ADDR2      IO(0x0A)  /* W: 18:16 */
#define PH_SIZE_LO    IO(0x0B)  /* W: ROM size in K, 7:0 */
#define PH_SIZE_HI    IO(0x0C)  /* W: 11:8 */
#define PH_SWAP       IO(0x0D)  /* W: bit 0 the ROM's bits are reversed */
#define PH_KEY        IO(0x10)  /* R: keypad key, 0-9, 10 *, 11 #, $FF */
#define PH_SPI_NEXT   IO(0x15)  /* R: received byte, starts the next transfer */

/* PH_CTRL write bits */
#define PH_CTRL_SELECT   0x01  /* SD card selected */
#define PH_CTRL_SLOW     0x02  /* slow SPI clock, for card init */
#define PH_CTRL_DISCARD  0x04  /* forward engine skips bytes instead */

/* PH_CTRL read bits */
#define PH_STAT_BUSY     0x80  /* SPI, forward transfer or SRAM write in progress */
#define PH_STAT_CARD     0x40  /* card present */

#define ROM_MAX   0x70000UL    /* 448K: the video RAM is above */

/* PC Engine registers */
#define REG(a) (*(volatile unsigned char *)(a))
#define VDC_AR   REG(0x0200)   /* W: register number; R: status */
#define VDC_SR   REG(0x0200)
#define VDC_LO   REG(0x0202)
#define VDC_HI   REG(0x0203)
#define VCE_CR   REG(0x0400)
#define VCE_ALO  REG(0x0402)
#define VCE_AHI  REG(0x0403)
#define VCE_DLO  REG(0x0404)
#define VCE_DHI  REG(0x0405)
#define JOYPAD   REG(0x1000)

/* Buttons, from the joypad port */
#define PAD_I      0x01
#define PAD_II     0x02
#define PAD_SELECT 0x04
#define PAD_RUN    0x08
#define PAD_UP     0x10
#define PAD_RIGHT  0x20
#define PAD_DOWN   0x40
#define PAD_LEFT   0x80

#endif
