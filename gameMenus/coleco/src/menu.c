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

// color scheme for menu - this allows easy customization
// we can use an F18A palette to make these any colors we want
// COLORHILITE should pulse a little using palette color cycling
// menu F18 palette values - 12 bit format 0000RRRR GGGGBBBB
const unsigned int MENU_PALETTE[] = {
	0x0000,0x0000,  // unchanged transparent and black just for comfort (white is also unchanged
    0x0000,         // line 1
    0x0010,         // line 2
    0x0eee,         // text
    0x044e,         // directory
    0x0000,         // background
    0x0900          // hilite
    // we don't need to define the rest
};

// Color scheme - these will be redefined by palette above
#define COLORLINE1      2
#define COLORLINE2      3
#define COLORTEXT       4
#define COLORDIRECTORY  5
#define COLORBG         6
#define COLORHILITE     7

// how long to sit idle before blanking (on no SD card or cartridge)
#define BLANK_TIME 5400    // about 3 minutes @ 30hz

// we assume that the f18a exists...
extern unsigned char f18a;
extern const unsigned char FATFONT[];

// hardware control
static volatile unsigned char * const pRom = (volatile unsigned char * const)0;	// access to memory
extern void waitVblanks(unsigned char cnt);  // clear and wait for blanks
extern void startTitle();       // start with no init
extern void runCartHeader(void (*mycenter)(unsigned char, char*));  // starts the cart with info
                                                                    // pass a center string function
// sprite layer updates (yes, text mode sprites!)
extern void textout(unsigned int vdp, const char *p);
extern void textouthalf(unsigned int vdp, const char *p);
extern void waitVblanks(unsigned char cnt);

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
unsigned char listSelect = 0;       // current selection index
unsigned char repeatTimeout = 45;   // number of frames before autorepeat

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

// wait for joystick key to be released
// there's a timeout to provide a crude auto-repeat
void waitRelease(unsigned char j) {
    for (;;) {
        joystfast(j);
        if ((KSCAN_JOYY == 0) && (KSCAN_JOYX == 0)) {
            repeatTimeout = 45;     // hold this long before next repeat starts
            break;
        } else {
            --repeatTimeout;
            if (repeatTimeout == 0) {
                repeatTimeout = 5;  // faster repeat if you keep holding
                break;
            }
            // VDP vblank wait
            waitVblanks(1);
        }
    }
}

// display the list of titles
void drawTitles() {
    unsigned char idx;
    unsigned int vdp = gImage;
    unsigned int atvdp = gColor;

    for (idx = listOffset; idx < listOffset+24; ++idx) {
        unsigned char *ptr;

        if (idx >= listSize) {
            // draw a blank line with text attribute
            if (idx&1) {
                vdpmemset(atvdp , (COLORTEXT<<4) | COLORLINE2, 40);
            } else {
                vdpmemset(atvdp , (COLORTEXT<<4) | COLORLINE1, 40);
            }
            atvdp+=40;
            // write a blank line
            VDP_SET_ADDRESS_WRITE(vdp);
            vdp+=40;
            vdpStrOut("", 40);
        } else {
            ptr = sortedList[idx];

            if (ptr[127] != 0) {
                // change the attributes to include directory
                if (idx&1) {
                    vdpmemset(atvdp , (COLORDIRECTORY<<4) | COLORLINE2, 40);
                } else {
                    vdpmemset(atvdp , (COLORDIRECTORY<<4) | COLORLINE1, 40);
                }
            } else {
                // text attributes (we have to rewrite it in case it was previous a dir)
                if (idx&1) {
                    vdpmemset(atvdp , (COLORTEXT<<4) | COLORLINE2, 40);
                } else {
                    vdpmemset(atvdp , (COLORTEXT<<4) | COLORLINE1, 40);
                }
            }
            atvdp+=40;

            // this will stop at the directory flag byte or end of the line
            // TODO: we should scroll the currently selected title so long filenames are readable
            VDP_SET_ADDRESS_WRITE(vdp);  // 32 graphics mode, 40 text mode
            vdp+=40;
            vdpStrOut(ptr, 40);
        }
    }
}

void sortDir() {
    // Hooray for lots of RAM all of a sudden!
    // Since we are building the sort from scratch, we can
    // use a per-element insertion rather than worrying about
    // being fancy. Fast Z80 moves SHOULD be inserted by SDCC
    // for the memmove calls.
    // Extra rules: directories before non-directories
    // The ".." folder is handled special and is not in the list.
    unsigned char *ptr = (unsigned char*)0x8000;
    listSize = 0;

    debug("Sorting...");

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

// wait for an SD card to be inserted (with screen blank)
void waitSDCard() {
    int cntDown;    // used to count down to screen blank timeout
    unsigned char debounce; // make sure card detect is stable if we see insertion

    debug("No SD card");

    // - If card can't be accessed:
    // -    put up     Insert SD or turn system
    //              off before inserting cartridge
                    // row    col
    cleartextout();
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

// draw the highlight on the current selection
void drawSelect() {
    unsigned int adr;
    unsigned char attr;

    adr = listSelect - listOffset;     // row on screen
    adr *= 40;      // multiply for offset
    adr += gColor;  // index into attribute table

    attr = vdpreadchar(adr);            // get the current attribute (for text color)
    attr = (attr&0xf0) | COLORHILITE;    // highlight the background
    
    vdpmemset(adr, attr, 40);           // write out the whole line the same
}

// erase the highlight on the current selection
void undrawSelect() {
    unsigned char bg;
    unsigned int adr;
    unsigned char attr;

    adr = listSelect - listOffset;     // row on screen
    // while we have the row, calculate which background to use
    if (adr & 1) {
        // odd row
        bg = COLORLINE2;
    } else {
        bg = COLORLINE1;
    }
    adr *= 40;      // multiply for offset
    adr += gColor;  // index into attribute table

    attr = vdpreadchar(adr);   // get the current attribute (for text color)
    attr = (attr&0xf0) | bg;    // highlight the background
    vdpmemset(adr, attr, 40);  // write out the whole line the same
}

// handle the user input to the menu
// returns:
//   0 = card was removed
//   1 = user made a selection
//  -1  = user paged the directory (redraw needed)
char getUserSelection() {
    unsigned char j;
    int cntDown = BLANK_TIME;

    // draw the selection bar
    drawSelect();
    // make sure both joysticks are released
    waitRelease(1);
    waitRelease(2);

    // start the loop
    for (;;) {
        // if we lose the SD card, abort
        if (disk_status() == STA_NODISK) {
            return 0;
        }

        // VDP vblank wait
        waitVblanks(1);

        // scan the joysticks (both work)
        for (j=1; j<3; j++) {
            joystfast(j);

            if (KSCAN_JOYY == JOY_UP) {
                if (listSelect > 0) {
                    undrawSelect();     // clear the highlight
                    --listSelect;       // count down
                    if (listSelect < listOffset) {
                        listOffset--;
                        return -1;      // request redraw
                    }
                    drawSelect();
                }
                waitRelease(j);
                cntDown = BLANK_TIME;
                continue;
            }

            if (KSCAN_JOYY == JOY_DOWN) {
                if (listSelect < listSize-1) {
                    undrawSelect();
                    ++listSelect;
                    if (listSelect > listOffset+23) {
                        listOffset++;
                        return -1;      // request redraw
                    }
                    drawSelect();
                }
                waitRelease(j);
                cntDown = BLANK_TIME;
                continue;
            }

            if (KSCAN_JOYX == JOY_RIGHT) {
                if (listOffset+23 < listSize-1) {
                    // page ahead, restrict to 8-bits
                    unsigned char add = listSize-1-listOffset;
                    if (add < 24) {
                        listOffset += add;
                        listSelect = listOffset;
                    } else {
                        listOffset += 24;
                        listSelect += 24;
                    }
                    return -1;          // request redraw
                } else {
                    undrawSelect();
                    listSelect = listSize-1;
                    drawSelect();
                }
                waitRelease(j);
                cntDown = BLANK_TIME;
                continue;
            }
            if (KSCAN_JOYX == JOY_LEFT) {
                if (listOffset > 0) {
                    // page back, restrict to 8 bits
                    if (listOffset < 24) {
                        listOffset = 0;
                        listSelect = 0;
                    } else {
                        listOffset -=24;
                        listSelect -=24;
                    }
                    return -1;          // request redraw
                } else {
                    undrawSelect();
                    listSelect = 0;
                    drawSelect();
                }
                waitRelease(j);
                cntDown = BLANK_TIME;
                continue;
            }

            // check fire button
            kscanfast(j);
            if (KSCAN_KEY != 0xff) {
                return 1;   // selected
            }
        }   // next joystick

        // check if it's time to blank the screen
        --cntDown;
        if (cntDown <= 0) {
            // yes, it is
            VDP_SET_REGISTER(1, 0xb2);    // disable video

            // any keypress to clear it
            for (;;) {
                joystfast(1);
                if ((KSCAN_JOYY)||(KSCAN_JOYX)) break;

                joystfast(2);
                if ((KSCAN_JOYY)||(KSCAN_JOYX)) break;
                    
                kscanfast(0);
                if (KSCAN_KEY != 0xff) break;
            }

            VDP_SET_REGISTER(1, 0xf2);    // restore video
            cntDown = BLANK_TIME;
            continue;
        }

        // and repeat
    }
}



// run the menu itself
// this function is long and uses gotos. Don't look if you're academic in nature :)
void menu() {
    // check if the SD card is present
nocard:
    cleartextout();

    if (disk_status() == STA_NODISK) {
        waitSDCard();
        // on return, we must have an SD card to read!
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

dirLoop:
    // - Read directory (with long filenames), store filenames in VDP
    readDir();
    if (disk_status() == STA_NODISK) goto nocard;
    debug("Finished read dir...");

    // - Clear sprites
    cleartextout();

    // - Sort list
    sortDir();

    // - Load default font
    vdpmemcpy(0x0800+29*8, FATFONT, 94*8);

    // start at the top
    listOffset = 0;     // top of display
    listSelect = 0;     // user selected index

    // turn off the screen
    VDP_SET_REGISTER(1, 0x80);

    // set up for per-character attributes (the color table is now a per-character color in text mode)
    VDP_SET_REGISTER(50,0x02);
#if 0
    // (these are the same as the main screen)
    // Move the color table to 0x1000
    VDP_SET_REGISTER(3, 64);
    gColor = 0x1000;
    // Move the sprite table to 0x700
    VDP_SET_REGISTER(5, 14);
    gSprite = 0x700;
    // Move the sprite descriptor table to 0x1800
    VDP_SET_REGISTER(6, 3);
    gSpritePat = 0x1800;
#endif

    // background color to match the color scheme
    VDP_SET_REGISTER(7, COLORBG);

    debug("Drawing...");

    // turn off the screen (again on first entry)
    VDP_SET_REGISTER(1, 0x80);

    // - Clear screen (for text mode)
    vdpmemset(gImage, ' ', 960);

    // load the new palette
    loadpal_f18a(MENU_PALETTE, 8);

    // set text mode
    VDP_SET_REGISTER(1,0xf2);

    // - Display list of titles
    drawTitles();

    // - wait for user selection (up/down move, left/right page, fire select)
    for (;;) {
        if (getUserSelection() >= 0) {
            // either user selected, or card was removed
            break;
        }

        // and if the user paged (or scrolled), then redraw
        drawTitles();
    }

    // in the event that the SD card was removed, jump back up
    if (disk_status() == STA_NODISK) {
        // - Clear screen (for text mode)
        vdpmemset(gImage, ' ', 960);
        // go back to nocard loop
        goto nocard;
    }




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

