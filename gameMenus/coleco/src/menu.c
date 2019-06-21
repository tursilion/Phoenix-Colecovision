// Phoenix Menu
// Relies on FatFS
// Called from PhoenixBoot
// Created by Tursi/M.Brent
// Uses libti99Coleco
// Note: we have 16k now per the new memory layout, and 2k RAM at 0x6000 (during loader only)
// TODO: Remember, we have to turn the physical cartridge off before we have RAM in the top 32k

#include "memset.h"
#include "vdp.h"
#include "phoenix.h"
#include "f18a.h"
#include "kscan.h"
#include "fatFs/ff.h"			/* Obtains integer types */
#include "fatFs/diskio.h"		/* Declarations of disk functions */

// we assume that the f18a exists...
extern unsigned char f18a;
extern const unsigned char FATFONT[];

// hardware control
static volatile unsigned char * const pRom = (volatile unsigned char * const)0;	// access to memory
extern void waitVblanks(unsigned char cnt);  // clear and wait for blanks
extern void startTitle();       // start with no init
extern void runCartHeader(void (*mycenter)(unsigned char, char*));  // starts the cart with info
                                                                    // pass a center string function
// these are only valid until we take down the Phoenix screen - print on the sprite layer
extern void textout(unsigned int vdp, const char *p);
extern void textouthalf(unsigned int vdp, const char *p);

// File structures
FATFS fatFs;
FIL fil;
DIR dir;
FILINFO finfo;
char path[128];     // max path of 128 chars

// todo: filename length of 128 chars, max overall path of 512 chars
// TODO: 24k not working right on hardware, wrong bitstream probably

// structures for file access
// Each entry has:
//      Filename[127]
//      Byte for directory flag
// Note this is only enough room for 80 files in VDP,
// but if we use the 32k of RAM at 0x8000, we can fit 160.
// Alternate plans could be to use more than one page of
// data, or to pack the filenames rather than spacing
// them out 128 bytes each. (We could store a lookup
// table in VDP). But for now we'll just enforce the
// upper limit as a count.
unsigned int lastFilename=0;        // lastVDP address with a filename

// each index is about 50us
void dly_50us(unsigned char n)
{
    // very, very roughly 50us per index
    volatile int delay=n;
    while (delay--) { ++delay; --delay; }
}

// clear the sprite layer
void cleartextout() {
    vdpmemset(gSpritePat, 0, 16*4*8);
}

// it's a strcpy that does NOT nul terminate, and stops at 127
void mystrcpy(char *pDest, char *pSrc) {
    unsigned char cnt=127;
    while ((*pSrc)&&(cnt--)) {
        *(pDest++)=*(pSrc++);
    }
}

// read the directory ('path') into expansion RAM starting at 0x8000
// this RAM is currently free for use, when we load a cartridge, then
// it will get overwritten
void readDir() {
    phRAMBankSelect = 1;    // first 32k bank
    lastFilename = 0x8000;  // no files loaded yet

    // add the ".." folder
    if (path[0]) {
        memset((void*)0x8000, ' ', 127);
        pRom[0x8000]='.';
        pRom[0x8001]='.';
        pRom[0x807f] = 1;   // directory
        lastFilename = 0x8008;
    }

    // Each entry has:
    //      Filename[127]
    //      Byte for directory flag
    // TODO: we can free some space if we remove altname[] from finfo (and most of the other parameters)
    if (FR_OK == f_opendir(&dir, path)) {
        while (FR_OK == f_readdir(&dir, &finfo)) {
            if (finfo.fname[0] == '\0') break;
            memset((void*)lastFilename, ' ', 127);
            mystrcpy((char*)lastFilename, finfo.fname);
            if (finfo.fattrib & AM_DIR) {
                pRom[lastFilename+127] = 1;
            } else {
                pRom[lastFilename+127] = 0;
            }
            lastFilename += 128;
            if (disk_status() == STA_NODISK) break;
        }
    }
}

// run the menu itself
#define BLANK_TIME 5400    // about 3 minutes @ 30hz
void menu() {
    // check if the SD card is present
nocard:
    cleartextout();
    // TODO: remove the drive index from the commands that take one...
    if (disk_status() == STA_NODISK) {
        int cntDown;    // used to count down to screen blank timeout
        unsigned char debounce; // make sure card detect is stable if we see insertion

        // - If card can't be accessed:
        // -    put up     Insert SD or turn system
        //              off before inserting cartridge
                            // row    col
        textout(gSpritePat+(0*8)+(4*16), "Insert SD or turn system");
        textout(gSpritePat+(1*8)+(1*16), "off before inserting cartridge");

        cntDown = BLANK_TIME;
        debounce = 0;
        while (debounce < 2) {
            // -    Check for SD card periodically
            // -    When detected, jump back to the 'reading SD card' line
            waitVblanks(2);

            // countdown screen timeout
            if (--cntDown == 0) {
                // blank the screen, cause all 9918 systems seem to
                VDP_SET_REGISTER(VDP_REG_MODE1, 0xA2);  // 16k, int, 16x16 spr

                // wait for any input to clear it
                for (;;) {
                    joystfast(1);
                    if ((KSCAN_JOYY)||(KSCAN_JOYX)) break;

                    joystfast(2);
                    if ((KSCAN_JOYY)||(KSCAN_JOYX)) break;
                    
                    kscanfast(0);
                    if (KSCAN_KEY != 0xff) break;

                    // even SD insert - no need to sleep here
                    if (disk_status() != STA_NODISK) break;
                }

                // re-enable the screen
                VDP_SET_REGISTER(VDP_REG_MODE1, 0xE2);  // as above, plus unblank
                cntDown = BLANK_TIME;
                debounce = 0;
            }

            // check for and debounce SD card detect
            if (disk_status() == STA_NODISK) {
                debounce = 0;
            } else {
                ++debounce;
            }
        }
    }

    // - put up 'reading SD card' on status line
    cleartextout();
	textouthalf(gSpritePat+(1*8)+(8*16), "READING SD CARD");
	
    // - Set directory to root (note there are no relative directories!)
    path[0]='\0';
    f_mount(&fatFs, path, 0);   // always succeeds with these options

    // - Read directory (with long filenames), store filenames in VDP
    readDir();
    if (disk_status() == STA_NODISK) goto nocard;

    // - Clear screen and sprites
    vdpmemset(0, ' ', 768);
    vdpchar(0x300, 0xd0);

    // - Load arcade font
    vdpmemcpy(0x0800+29*8, FATFONT, 94*8);

    // - Display list of titles
    // - wait for user selection (up/down move, left/right page, fire select)
    // - if selection is directory:
    // -    clear screen
    // -    display 'reading SD card' in center of screen
    // -    jump back to directory read
    // - if selection is file:
    // -    read first block into cartridge space
    // -    if 55AA or AA55 is detected, we have a valid ROM:
    // -        read in the rest
    // -        set the mappers appropriately
    // -        jump to "execute title" as above
    // -    read EOF-16k block to next free memory, as test
    // -    if 55AA or AA55 is detected, we have a megacart:
    // -        read in the rest
    // -        set the mappers appropriately
    // -        jump to "execute title" as above
    
    // TODO: other cartridge banking types? Megacart only for now.



}

