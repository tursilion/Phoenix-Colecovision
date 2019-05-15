/**
 * Main header
 */

#ifndef _MAIN_H
#define _MAIN_H 1

#include <stdint.h>		// int8_t, uint8_t, int16_t, uint16_t


#define GAME_NAME 		0x8024


// ==========================================================================
// Special Function Registers to designate IO Ports

//__sfr __at 0x56 STATUS;
//__sfr __at 0x55 CONFIG;
//__sfr __at 0x58 MACHID;

__sfr __at 0x56 SD_CTRL_PORT;	// SC-card control port
__sfr __at 0x57 SD_DATA_PORT;	// SC-card data port

__sfr __at 0xBE VDP_DATA_PORT;	// VDP data port
__sfr __at 0xBF VDP_CTRL_PORT;	// VDP control port


// Read / write memory via direct addresses, example:
//   v = peek(8000);
//   poke(8002, v);
#define peek(A) (*(volatile uint16_t *)(A))
#define poke(A,V) *(volatile uint16_t *)(A)=(V)

#endif /* _MAIN_H */
