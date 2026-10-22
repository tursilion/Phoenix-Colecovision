/* Phoenix Time Pilot '84 core: boot mode registers (see rtl/tp84_phoenix.v). */

#ifndef PHOENIX_H
#define PHOENIX_H

#define REG(a) (*(volatile unsigned char *)(a))

#define PH_SPI_DATA   REG(0xC000)  /* R: received byte, W: transfer byte */
#define PH_CTRL       REG(0xC001)  /* W: b0 select, b1 fast; R: status */
#define PH_LOAD_A0    REG(0xC002)  /* W: load address 7:0; R: b0 SRAM write pending */
#define PH_LOAD_A1    REG(0xC003)  /* W: load address 15:8; R: b0 vertical blank */
#define PH_LOAD_A2    REG(0xC004)  /* W: load address 17:16 */
#define PH_LOAD_DATA  REG(0xC005)  /* W: write, then address + 1 */
#define PH_P1         REG(0xC006)  /* R: player 1, active low */
#define PH_SYS        REG(0xC007)  /* R: system inputs, active low */
#define PH_DSW1       REG(0xC008)
#define PH_DSW2       REG(0xC009)
#define PH_LED        REG(0xC00B)  /* W: b0 error LED */
#define PH_EXEC_SRAM  REG(0xC00C)  /* W: b0 run from the SRAM copy */
#define PH_START      REG(0xC00F)  /* W: start the game */

#define PH_TEXT       ((volatile unsigned char *)0x8400)  /* 32 x 28 text */
#define TEXT_COLS     32
#define TEXT_ROWS     28

#define PH_CTRL_SELECT   0x01
#define PH_CTRL_SLOW     0x00
#define PH_CTRL_FAST     0x02

#define PH_STAT_BUSY     0x80
#define PH_STAT_CARD     0x40

#endif
