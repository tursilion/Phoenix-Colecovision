// F18A interface functions

#include <vdp.h>
#include "f18a.h"

// fast memcpy, since we don't need delays on the F18A
extern void vdpmemcpyfast(int pAddr, const unsigned char *pSrc, int cnt);
#define vdpmemcpy vdpmemcpyfast

// configuration so we can force it after a reset
// NOTE: This is NOT a flag, it's written directly to register >32
// We need this cause of our text-attribute-mode menu. So write bit >04
// to enable the scanlines. Kind of hacky and badly named but I need the ROM space.
unsigned char useScanlines = 0;     // takes in real time but we need it after a reset
// stored in phoenixBoot.c - whether to allow 4 sprite flicker or not
extern unsigned char useFlicker;

// default F18 palette values
const unsigned int DEFAULT_PALETTE[] = {
	0x0000,0x0000,0x02C3,0x05D6,0x054F,0x076F,0x0D54,0x04EF,
	0x0F54,0x0F76,0x0DC3,0x0ED6,0x02B2,0x0C5C,0x0CCC,0x0FFF
};

// default GPU program for testing
const unsigned char GPUTEST[] = {
	0x02,0x00,0x12,0x34,	//	LI R0,0x1234
	0xC8,0x00,0x1C,0x10,	//	MOV R0,@0x1C10
	0x03,0x40,				//	IDLE
	0x00,0x00				//	DATA 0x0000
};

// you should use test_f18a rather than call this directly
void unlock_f18a() {
	VDP_SET_REGISTER(0x39, 0x1c);	// VR1/57, value 00011100, write once (corrupts VDPR1)
	VDP_SET_REGISTER(0x39, 0x1c);	// write again (unlocks enhanced mode)
}

// lock F18A if unlocked (1.6 or later)
void lock_f18a() {
	// reset the F18A to defaults (except palette, requires 1.6)
	VDP_SET_REGISTER(0x32, 0x80); 	// VR2/50, value 10000000
									// reset and lock F18A, or corrupt R2
	VDP_SET_REGISTER(0x39, 0x00);	// VR1/57, value 00000000
									// write once (corrupts VDPR1)
}

// This will corrupt the registers if it's not
// an F18A, so after calling this, reset the VDP with lock_f18a
// Note that this, by necessity, unlocks the F18A if it was locked.
void reset_f18a() {
    // If for nothing else, the palette reset requires us to be unlocked
    unlock_f18a();

    // stop the GPU and then Reset (no harm if it's not F18)
	VDP_SET_REGISTER(0x38, 0);	// stop the GPU -- this does stop the GPU

	// force F18A back to palette number 0
	VDP_SET_REGISTER(0x18, 0);	// V24 = 0 (palette 0 for sprites and tiles)
	
    // reload the default palette
	loadpal_f18a(DEFAULT_PALETTE, 16);

	// reset the status register to 0
	VDP_SET_REGISTER(0x0f, 00);	// V15 = 0 - read SR0 again

    // reset the sprite flicker count to whatever is set
    if (useFlicker) {
        VDP_SET_REGISTER(0x1e, 4); // stop sprite is #4
    } else {
        VDP_SET_REGISTER(0x1e, 32); // stop sprite is #32
    }

    // update the scanlines setting (we default to off no matter the existing default right now)
    // TODO: scanline setting expected to move to the core select menu, so we can remove all this
    // code that touches useScanlines at that point.
    VDP_SET_REGISTER(0x32, useScanlines);

	// wait for an interrupt (or, if VDPST2 is active, RUNNING to clear)
	while (VDPST & 0x80) {
		VDP_SAFE_DELAY();
	}

    // the above is all needed on older versions of the F18A,
    // on most recent versions just this will do it all (except palette)
    VDP_SET_REGISTER(0x32, 0x80);
}

// load a small test program and see if the GPU is available
// corrupts 12 bytes at 0x1c00
// This does the unlock for you!
unsigned char test_f18a() {
	VDP_SET_REGISTER(0x32, 0x80);	// VR2/50, value 10000000
									// reset and lock F18A, or corrupt R2
    unlock_f18a();

	// If we are not on the F18A, then R1 is screwed up now, that's okay
	vdpmemcpy(0x1c00, GPUTEST, 12);	// copy program (and zero 0x1c10)
	
	// Start the GPU program, pause, then check the result
	VDP_SET_REGISTER(0x36, 0x1c);	// MSB of GPU program
	VDP_SET_REGISTER(0x37, 0x00);	// LSB of GPU program (starts execution)

	VDP_SAFE_DELAY();				// any delay here is sufficient, the GPU is way faster than us

	VDP_SET_ADDRESS(0x1c10);		// check the data address, which we initialized to 0
	if (VDPRD != 0x12) {
		// incorrect byte
		return 0;
	}
	if (VDPRD != 0x34) {
		// strange to fail here...
		return 0;
	}
	
	// if we get here, it's all good
	return 1;
}

// load an F18A palette from ptr (16-bit words, little endian)
// data format is 12-bit 0RGB color.
void loadpal_f18a(unsigned int *ptr, unsigned char cnt) {
	VDP_SET_REGISTER(0x2f, 0xc0);	// Reg 47, value: 1100 0000, DPM = 1, AUTO INC = 1, palreg 0.       

	while (cnt-- > 0) {
		VDPWD = ptr[0]>>8;
		// normally we would need a delay here, but not on the F18A
		VDPWD = ptr[0]&0xff;
		ptr++;
	}

	VDP_SET_REGISTER(0x2f, 0x00);	// Turn off the DPM mode
}
