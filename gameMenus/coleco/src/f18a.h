// reset the F18A back to stock 9918A mode
void reset_f18a();
// re-lock the F18A (1.6 or later)
// do this after the reset, if desired
void lock_f18a();
// unlock the F18A (if present)
// test if an F18A is installed
// unlocks and returns 1 if yes, 0 if not
// corrupts 12 bytes at 0x1c00
unsigned char test_f18a();
// load a palette into the F18A
// data format is 12-bit 0RGB (4 bits each gun)
void loadpal_f18a(unsigned int *ptr, unsigned char cnt);

// define for the useScanlines variable
#define SCANLINES_ON 0x04
