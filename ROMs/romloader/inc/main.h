/**
 * Main header
 */

#ifndef _MAIN_H
#define _MAIN_H 1

#include <stdint.h>		// (u)intXX_t


#define GAME_NAME 		0x8024	// Company name/game title in a cartridge


// ==========================================================================
// Special Function Registers to designate IO Ports


//__sfr __at 0x56 STATUS;
//__sfr __at 0x55 CONFIG;
//__sfr __at 0x58 MACHID;

__sfr __at 0x56 SD_CTRL_PORT;		// SC-card control port
__sfr __at 0x57 SD_DATA_PORT;		// SC-card data port

__sfr __at 0x80 CONT_KEY_PORT;		// Write port to select keypad
__sfr __at 0xC0 CONT_JOY_PORT;		// Write port to select joystick
__sfr __at 0xFC CONT1_DATA_PORT;	// Read data from controller
__sfr __at 0xFF CONT2_DATA_PORT;	// Read data from controller

__sfr __at 0xBE VDP_DATA_PORT;		// VDP data port
__sfr __at 0xBF VDP_CTRL_PORT;		// VDP control port


// Read / write memory via direct addresses, example:
//   v = peek(8000);
//   poke(8002, v);
#define peek(A) (*(volatile uint16_t *)(A))
#define poke(A,V) *(volatile uint16_t *)(A)=(V)

#endif /* _MAIN_H */
