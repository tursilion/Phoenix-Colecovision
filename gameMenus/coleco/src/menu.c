// Phoenix Menu
// Relies on FatFS
// Called from PhoenixBoot
// Created by Tursi/M.Brent
// Uses libti99Coleco
// Note: we have 24k now per the new memory layout, and 8k RAM at 0x6000 (during loader only, first 1k is real Coleco RAM)
//
// Intentional limitations:
// - Maximum filename length of 126 characters.
// - Maximum of 255 files in a folder (including subfolders)
// - Maximum path length of 512 characters
// - 7-bit ASCII clean filenames only (ie: no accents or unicode characters)

#include "memset.h"
#include "vdp.h"
#include "phoenix.h"
#include "f18a.h"
#include "kscan.h"
#include "fatFs/ff.h"			/* Obtains integer types */
#include "fatFs/diskio.h"		/* Declarations of disk functions */

// Color scheme
#define COLORLINE1      COLOR_MEDGREEN
#define COLORLINE2      COLOR_DKGREEN
#define COLORTEXT       COLOR_WHITE
#define COLORDIRECTORY  COLOR_LTBLUE
#define COLORBG         COLOR_LTGREEN
#define COLORHILITE     COLOR_MEDRED

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

#if 1
// debugger
extern void debug(const char *p);
#endif

// File structures
FATFS fatFs;
FIL fil;
DIR dir;
FILINFO finfo;
// I'm not sure if we need to reflect this in fatfs or if the working buffer
// is only per filename part...
char fullpath[512];                 // max path of 512 chars (folders + filename)
char path[512];                     // current directory only
unsigned char *sortedList[256];     // sorted pointers to filenames
unsigned char listSize = 0;         // number of elements in sortedList
unsigned char listOffset = 0;       // current list offset

volatile __sfr __at 0x00 debugPort;

// the thin lowercase m doesn't work, so this is a manual replacement
const unsigned char thinm[8] = {
    0,0, 0xf8, 0xa8, 0xa8, 0xa8, 0xa8, 0
};

// TODO: 24k not working right on hardware? Needs testing.

// structures for file access
// Each entry has:
//      Filename[127]
//      Byte for directory flag
// Note this is only enough room for 80 files in VDP,
// but if we use the 32k of RAM at 0x8000, we can fit 256. (32k/128)
// Alternate plans could be to use more than one page of
// data, or to pack the filenames rather than spacing
// them out 128 bytes each. (We could store a lookup
// table in VDP). But for now we'll just enforce the
// upper limit as a count.
unsigned char *lastFilename=0;  // using RAM version

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

// output a string at current location, stopping at end of string or end of cnt
void vdpStrOut(const char *p, unsigned cnt) {
    while ((*p >= ' ') && (cnt--)) {
        VDPWD = *(p++);
    }
}

// it's a strcpy that does NOT nul terminate, and stops at 127
// it DOES fill unused spots with NUL though
void mystrcpy(char *pDest, char *pSrc) {
    unsigned char cnt=127;
    while ((*pSrc)&&(cnt--)) {
        *(pDest++)=*(pSrc++);
    }
    while (cnt-- > 0) {
        *(pDest++) = 0;
    }
}

// simple strcmp (char return instead of int cause z80)
// this one also stops at 127 characters, since we allow
// for an unterminated name, and is case insensitive
char mystrcmp(const char *s1, const char *s2) {
    unsigned char cnt = 127;
    unsigned char c1,c2;
    while (cnt--) { 
        c1 = *s1;
        c2 = *s2;

        // make uppercase (with some sideeffects, but not in the valid charset)
        if (c1&0x40) c1&=0xdf;
        if (c2&0x40) c2&=0xdf;

        // turn underscore into a space for sorting
        if (c1 == '_') c1=' ';
        if (c2 == '_') c2=' ';

        // compare
        if (c1!=c2) break;
        if (!(*s1)) break;  // only need this test if they are BOTH NUL

        // next character
        ++s1; 
        ++s2; 
    }
    return (c1-c2);
}

// read the directory ('path') into expansion RAM starting at 0x8000
// this RAM is currently free for use, when we load a cartridge, then
// it will get overwritten
void readDir() {
    debug("Reading dir...");

    lastFilename = (unsigned char*)0x8000;  // no files loaded yet

    // Each entry has:
    //      Filename[127]
    //      Byte for directory flag
    // TODO: we can free some space if we remove altname[] from finfo (and most of the other parameters)
    //       in ff_getfileinfo this is done, we can just only populate the long name, altname is the short
    if (FR_OK == f_opendir(&dir, path)) {
        debug("Opened directory...");
        debug(path);

        while (FR_OK == f_readdir(&dir, &finfo)) {
            // just in case the return code wasn't enough
            if (disk_status() == STA_NODISK) {
                debug("Exitting directory because SD removed");
                return;
            }

            // parse the file information
            if (finfo.fname[0] == '\0') {
                debug("Empty filename received, end of directory");
                break;      // end of directory
            }

            // save it off
            memset(lastFilename, ' ', 127);
            mystrcpy(lastFilename, finfo.fname);
            if (finfo.fattrib & AM_DIR) {
                debugPort='*';
                *(lastFilename+127) = 1;
            } else {
                *(lastFilename+127) = 0;
                debugPort=' ';
            }
            debug(finfo.fname);
            lastFilename += 128;
            // we can go up to 0xffff, but if we wrap around we're done
            // to be paranoid for now, I'm going to stop at 255
            if (lastFilename >= (unsigned char*)0xff80) {
                debug("Out of RAM to store filenames");
                break;
            }
        }

        f_closedir(&dir);
    }
}

// run the menu itself
#define BLANK_TIME 5400    // about 3 minutes @ 30hz
void menu() {
    // check if the SD card is present
nocard:
    cleartextout();
    if (disk_status() == STA_NODISK) {
        int cntDown;    // used to count down to screen blank timeout
        unsigned char debounce; // make sure card detect is stable if we see insertion

        debug("No SD card");

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
    debug("Reading SD Card");
	
    // - Set directory to root (note there are no relative directories!)
    path[0]='/';
    path[1]=0;
    if (FR_OK != f_mount(&fatFs, "", 1)) goto nocard;
    debug("Finished mount...");

    // activate RAM at the cartridge space so we have somewhere to store data
    phBankingScheme = PH_BANK_MEGACART | PH_UPPER_INTRAM;
    // select the first non-SGM RAM page
    phRAMBankSelect = 2;    // first 32k bank

    // TODO: how do we do a 32k cartridge ROM? We need a non-banked ROM. Maybe replace the RAM mode?

dirLoop:
    // - Read directory (with long filenames), store filenames in VDP
    readDir();
    if (disk_status() == STA_NODISK) goto nocard;
    debug("Finished read dir...");

    // - Clear sprites
    vdpchar(0x300, 0xd0);

    // - Sort list (or just create a sorted index for speed?)
    // Hooray for lots of RAM all of a sudden!
    // Since we are building the sort from scratch, we can
    // use a per-element insertion rather than worrying about
    // being fancy. Fast Z80 moves SHOULD be inserted by SDCC
    // for the memmove calls.
    // Extra rules: directories before non-directories
    // The ".." folder is handled special and is not in the list.
    debug("Sorting...");
    {
        unsigned char *ptr = (unsigned char*)0x8000;
        listSize = 0;
        while (ptr < lastFilename) {
            unsigned char idx;
            // whereever this loop exits, that's where we store it
            for (idx = 0; idx < listSize; ++idx) {
                unsigned char *ptr2;
                ptr2 = sortedList[idx];

                // if we are a file comparing to a directory, continue
                if ((*(ptr+127) == 0) && (*(ptr2+127) != 0)) continue;

                // if we are a directory comparing to a file, stop here
                if ((*(ptr+127) != 0) && (*(ptr2+127) == 0)) break;

                // otherwise, if we have a lower filename, stop here
                // equal shouldn't happen, but if it does it will sort after
                if (mystrcmp(ptr, ptr2) < 0) break;
            }

            // if necessary, move the data out of the way
            if (idx < listSize) {
                // overlapping move - can the Z80 solve that?
                memmove(&sortedList[idx+1], &sortedList[idx], (listSize-idx)*2);
            }
            
            // store this element
            sortedList[idx] = ptr;

            // the list will now be larger
            ++listSize;

            // next filename
            ptr += 0x80;
        }
    }

#if 0
    // - Load arcade font (looks bad in text mode)
    //    vdpmemcpy(0x0800+29*8, FATFONT, 94*8);
#endif

#if 1
    // we need to hack the font a bit for text mode
    // is readable but very square and runs together
    {
        int idx;
        const unsigned char *p = FATFONT;   // CPU font address
        VDP_SET_ADDRESS_WRITE(0x800+29*8);  // start of VDP address
        idx = 94*8;
        while (idx-- > 0) {
            unsigned char c = *(p++);
            // make it 6 pixels wide (this pattern took a lot of experimentation, but came out!)
            c = ((c&0x70)<<1) | ((c&0x0c)<<1);
            VDPWD = c;
        }
        // lowercase m is the only character that doesn't work, so we do it manually
        vdpmemcpy(0xb68, thinm, 8);
    }
#endif
    // TODO: just use the TI font with lowercase from libti99Coleco?

    // start at the top
    listOffset = 0;

    // turn off the screen
    VDP_SET_REGISTER(1, 0x80);

    // set up for per-character attributes (the color table is now a per-character color in text mode)
    VDP_SET_REGISTER(50,0x02);
    // Move the sprite table to 0x700
    VDP_SET_REGISTER(5, 14);
    gSprite = 0x700;
    // Move the color table to 0x1000
    VDP_SET_REGISTER(3, 64);
    gColor = 0x1000;

    // background color to match the color scheme
    VDP_SET_REGISTER(7, COLORBG);

    // - make sure sprites are disabled (just in case)
    vdpchar(gSprite, 0xd0);

listLoop:
    debug("Drawing...");

    // turn off the screen (again on first entry)
    VDP_SET_REGISTER(1, 0x80);

    // - Clear screen (including extra for text mode)
    vdpmemset(gImage, ' ', 960);
    // - set up the text mode attributes (white on striped)

    {
        unsigned char idx;
        int vdp = gColor;
        for (idx = 0; idx<24; idx+=2) {
            vdpmemset(vdp, (COLORTEXT<<4) | COLORLINE1, 40);
            vdp+=40;
            vdpmemset(vdp, (COLORTEXT<<4) | COLORLINE2, 40);
            vdp+=40;
        }
    }

    // set text mode
    VDP_SET_REGISTER(1,0xf2);

    // - Display list of titles
    {
        unsigned char idx;
        unsigned int vdp = 0;
        for (idx = listOffset; idx < listOffset+24; ++idx) {
            unsigned char *ptr;

            if (idx >= listSize) break;

            ptr = sortedList[idx];

            if (ptr[127] != 0) {
                // change the attributes to include directory
                int vdp = gColor + idx*40;
                if (idx&1) {
                    vdpmemset(vdp, (COLORDIRECTORY<<4) | COLORLINE2, 40);
                } else {
                    vdpmemset(vdp, (COLORDIRECTORY<<4) | COLORLINE1, 40);
                }
            }

            // this will stop at the directory flag byte or end of the line
            // TODO: we should scroll the currently selected title so long filenames are readable
            VDP_SET_ADDRESS_WRITE(vdp);  // 32 graphics mode, 40 text mode
            vdp+=40;
            vdpStrOut(ptr, 40);
        }
    }

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

    debug("Nothing else coded yet...\x7f"); // 7f triggers a breakpoint
}

