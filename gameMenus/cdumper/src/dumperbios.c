//******************************
// Dumper BIOS for Phoenix
// Created by Tursi/M.Brent
// Uses libti99Coleco - https://github.com/tursilion/libti99coleco - cef5a4dbef4bb873b088ca290c3592be8ebb69c4
// Note: we have 24k now per the new memory layout, and 8k RAM at 0x6000 (First 1k is true Coleco RAM)

#include "memset.h"
#include "vdp.h"
#include "phoenix.h"
#include "f18a.h"
#include "kscan.h"
#include "fatFs/ff.h"			/* Obtains integer types */
#include "fatFs/diskio.h"		/* Declarations of disk functions */

#define HEADERS__
#include "mattfont.c"
#include "dontcopy.c"
#include "dontcopymap.c"
#undef HEADERS__

// --- externs ---

// fast memcpy, since we don't need delays on the F18A
extern void vdpmemcpyfast(int pAddr, const unsigned char *pSrc, int cnt);
#define vdpmemcpy vdpmemcpyfast

// --- hardware ---
static volatile __sfr __at 0xc0 port3;  // joystick reset strobe

// macro for accessing ROM inline - this optimizes as you'd expect
#define pRom(x) *((volatile unsigned char*)(x))

// --- variables ---

// File structures
FATFS fatFs;
FIL fil;
DIR dir;
FILINFO finfo;

char path[512];
char adr[9];

// we assume that the f18a exists...
unsigned char f18a;

// --- static data ---

// new color table
static const unsigned char colorTable[] = {
	0x71,0x17,0x71,0xF1,0x17,0x1F,0x71,0x1F,
	0xF1,0xF1,0xF1,0xF1,0xF1,0xF1,0xF1,0x17,
	0xF1,0x71,0x17,0x17,0xF1,0xF1,0xF1,0x1F,
	0xF1,0xF1,0x1F,0xF1,0xF1,0xF1,0x71,0x10
};

// --- and functions... ---

// setting up standard screen modes - blanks the screen and returns the unblank command
// interrupts are also disabled. Unblank will re-enable them, too, write it to VDP_REG_MODE1
// this is a stripped down version out of libti99Coleco that doesn't set the sprite table or tracking variables
// A few registers also differ.
unsigned char my_set_graphics(unsigned char sprite_mode) {
	unsigned char unblank = VDP_MODE1_16K | VDP_MODE1_UNBLANK | VDP_MODE1_INT | sprite_mode;
	VDP_SET_REGISTER(VDP_REG_MODE1, VDP_MODE1_16K);		// no need to OR in the sprite mode for now
	VDP_SET_REGISTER(VDP_REG_MODE0, 0);
	VDP_SET_REGISTER(VDP_REG_SIT, 0x00);    // 0x0000
	VDP_SET_REGISTER(VDP_REG_CT, 64);       // 0x1000
	VDP_SET_REGISTER(VDP_REG_PDT, 0x01);    // 0x0800
	VDP_SET_REGISTER(VDP_REG_SAL, 14);      // 0x0700
	VDP_SET_REGISTER(VDP_REG_SDT, 0x03);    // 0x1800
	VDP_SET_REGISTER(VDP_REG_COL, ((COLOR_GRAY<<4)|COLOR_BLACK));
	return unblank;
}

// each index is about 50us (used by the SD access?)
void dly_50us(unsigned char n)
{
    // roughly 50us per loop
    // must be an even number of ex's to
    // not mess up the stack or HL
    while (n--) {
        __asm
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; 19 t-states
            ex (sp),hl      ; *8 = 152 t-states =~ 42.4uS, plus loop overhead
        __endasm;
    }
}

// delay for 'x' vblanks - zero will just clear any pending
// beware of calling this in a loop - if the time between calls
// is longer than a frame you will clear the pending vblank on
// entry and wait for another one (ie: you may wait a frame
// longer than you expect).
void waitVblanks(unsigned char cnt) {
    // clear any vblank we may have missed
    VDP_CLEAR_VBLANK;

    while (cnt-- > 0) {
    	// wait as instructed
    	VDP_WAIT_VBLANK_CRU;
    	VDP_CLEAR_VBLANK;
    }
}

// wait for an SD card to be inserted (with screen blank)
void waitSDCard() {
    unsigned char debounce; // make sure card detect is stable if we see insertion

    debounce = 0;
    while (debounce < 2) {
        // Check for SD card periodically
        waitVblanks(2);

        // check for and debounce SD card detect
        if (disk_status() == STA_NODISK) {
            debounce = 0;
        } else {
            ++debounce;
        }
    }
}

// unRLE CPU to VDP handler
// Basic RLE compression applied to PAT0
// top two msbits are flags:
// 00 - run of zeros
// 01 - run of 0xff
// 10 - run of next char
// 11 - inline string
// least significant 6 bits are the length
// Warning: No sanity checking takes place
void unrle(unsigned int vdpAdr, unsigned char *pSrc, unsigned int rleCnt) {
    unsigned char *pEnd;
    
    VDP_SET_ADDRESS_WRITE(vdpAdr);
    pEnd = pSrc + rleCnt;

    while (pSrc < pEnd) {
        unsigned char cnt = *(pSrc++);
        unsigned char byte = 0;
        switch (cnt&0xc0) {
            case 0x00:
                // run of zeros
                byte = 0;
                break;

            case 0x40:
                // run of 0xffs
                byte = 0xff;
                break;

            case 0x80:
                // run of next byte
                byte = *(pSrc++);
                break;

            case 0xc0:
                // inline string (special case)
                cnt = (cnt & 0x3f) + 1;
                while (cnt--) {
                    VDPWD = *(pSrc++);
                }
                continue;
        }
        // all other cases come down here to be a run of bytes
        cnt = (cnt & 0x3f) + 1;
        while (cnt--) {
            VDPWD = byte;
        }
    }
}

// wrapper for kscan that reads both sticks
// this allows them to work at pretty much any time automatically
void readkeypad() {
    unsigned char ret;
    
    kscanfast(1);
    ret = KSCAN_KEY;
    if (ret == 0xff) {
        // try joystick 2
        kscanfast(2);
        ret = KSCAN_KEY;
    }
}

// text out to the sprite layer at the bottom of the screen
// VDP is the starting address in the sprite pattern table
// Sprites are stacked 2 vertical before each column, and 8 bytes per char
void textout(unsigned int vdp, const char *p) {
	while (*p) {
		unsigned char c = (*(p++))-' '+3;
        unsigned int off = c*8;
        vdpmemcpy(vdp, &FATFONT[off], 8);
        vdp+=16;
	}
}

// center a string on the sprite output lines
// String must be less than 256 characters. (Better be less than 32)
void centerString(unsigned char line, char *p) {
    unsigned int vdp = GSPRITEPAT + (line*8);
    unsigned char len = 0;
    char *pp = p;

    while (*pp) {
        ++pp;
        if (pp - p > 31) {
            *pp='\0';
            break;
        }
    }
    len = pp-p;
    vdp += (16-(len/2))*16;
    textout(vdp, p);
}

// just clears the first sprites, but that's fine
void clrscr() {
    // clear the sprite pattern table
    vdpmemset(GSPRITEPAT, 0, 64*8);
}

void makeFilename() {
    unsigned char cnt;
    unsigned char *p;
    unsigned int idx;

    // make a filename
    memcpy(path, "/AAAAAAAA.bin", 13);

    // lazy hash of the first 2k into the first 8 characters
    p = path+1;
    cnt = 0;
    for (idx=0x8000; idx<0x8800; ++idx) {
        *p += pRom(idx);
        while (*p > 'Z') *p-=26;  // lazy base 26 ;)
        while (*p < 'A') *p+=26;  // lazy base 26 ;)
        ++p;
        ++cnt;
        if (cnt >= 8) {
            cnt = 0;
            p=path+1;
        }
    }

	// first line of the 3rd sprite output (top right)
	// path[1] so that we skip the '/', we only have 12 chars
    textout(GSPRITEPAT+64*8, &path[1]);
}

// just puts an address on the screen for progress reporting
// this can be much more than 64k, so need two inputs
// This now goes on the 4th sprite line at top right, so
// we need to build a text buffer
void displayAddress(unsigned int val, unsigned int val2) {
	unsigned char idx;
	
    adr[0] = ((val >> 12) & 0x0f) + '0';
    adr[1] = ((val >> 8) & 0x0f) + '0';
    adr[2] = ((val >> 4) & 0x0f) + '0';
    adr[3] = (val & 0x0f) + '0';

    adr[4] = ((val2 >> 12) & 0x0f) + '0';
    adr[5] = ((val2 >> 8) & 0x0f) + '0';
    adr[6] = ((val2 >> 4) & 0x0f) + '0';
    adr[7] = (val2 & 0x0f) + '0';
    adr[8] = 0;
    
    // fixup for hex letters
    for (idx = 0; idx < 8; ++idx) {
		if (adr[idx] > '9') adr[idx]+=7;	// 7 is the difference between : and A
	}

    // output at top right, second line, 2 characters in
    textout(GSPRITEPAT+64*8+8+16*2, adr);
}

unsigned char dump32k() {
    FRESULT res;
    UINT cnt;

    centerString(0, "Dumping 32k...");
    makeFilename();

    res = f_open(&fil, path, FA_WRITE | FA_CREATE_ALWAYS);
    if (FR_OK != res) {
        clrscr();
        centerString(0, "Failed to open output file");
        return 0;
    }

    displayAddress(0,0);
    res = f_write(&fil, (unsigned char*)0x8000, 16384, &cnt);
    if ((res != FR_OK) || (cnt != 16384)) {
        f_close(&fil);
        clrscr();
        centerString(0, "Failed to write output file");
        displayAddress(res, cnt);
        return 0;
    }

    displayAddress(0,0x4000);
    res = f_write(&fil, (unsigned char*)0xC000, 16384, &cnt);
    if ((res != FR_OK) || (cnt != 16384)) {
        f_close(&fil);
        clrscr();
        centerString(0, "Failed to write output file");
        displayAddress(res, cnt);
        return 0;
    }

    displayAddress(0,0x8000);
    f_close(&fil);
    return 1;
}

unsigned char dumpMegacart() {
    unsigned int adr1, adr2, bank;
    unsigned char x;
    FRESULT res;
    UINT cnt;

    centerString(0, "Dumping Megacart...");
    makeFilename();

    res = f_open(&fil, path, FA_WRITE | FA_CREATE_ALWAYS);
    if (FR_OK != res) {
        clrscr();
        centerString(0, "Failed to open output file");
        return 0;
    }

    // megacarts bank all banks (including the fixed one), so we
    // can page 16k at a time and just pull them out in order
    // address 0xffc0 through 0xffff do the banking for up to 1MB
    adr1=0;
    adr2=0;
    bank=0xffc0;
    memset(path, 0xff, 64);	// used to fill

    // we're done on the last bank
    while (bank != 0xffff) {
        displayAddress(adr1, adr2);
        x = *(volatile unsigned char *)bank;    // force the bank switch

		// we can't pull a full 16k because the last 64 bytes are used
		// for the actual paging. EXCEPT for the last bank which is the
		// fixed bank at 0x8000 when running.
        res = f_write(&fil, (unsigned char*)0xC000, 16384-64, &cnt);
        if ((res != FR_OK) || (cnt != 16384-64)) {
            f_close(&fil);
            clrscr();
            centerString(0, "Failed to write output file");
            displayAddress(res, cnt);
            return 0;
        }
        // now the padding
        res = f_write(&fil, path, 64, &cnt);
        if ((res != FR_OK) || (cnt != 64)) {
            f_close(&fil);
            clrscr();
            centerString(0, "Failed to write output file");
            displayAddress(res, cnt);
            return 0;
        }

        adr2 += 0x4000;
        if (adr2 == 0) ++adr1;
        ++bank;
    }
    // manually dump the last bank from 0x8000 so we don't trigger the paging
    displayAddress(adr1, adr2);
	res = f_write(&fil, (unsigned char*)0x8000, 16384, &cnt);
	if ((res != FR_OK) || (cnt != 16384)) {
		f_close(&fil);
		clrscr();
		centerString(0, "Failed to write output file");
		displayAddress(res, cnt);
		return 0;
	}

    displayAddress(0x10,0);
    f_close(&fil);
    return 1;
}

unsigned char dumpSgm() {
    unsigned int adr1, adr2;
    unsigned char bank;
    FRESULT res;
    UINT cnt;

    centerString(0, "Dumping SGM...");
    makeFilename();

    // supposedly this thing works like so:
    // There is onboard flash for save game
    // Three 8k ROM banks
    //      FFFC, FFFD, FFFE to select the last three 8k banks.
    //      First 8k is fixed to the first bank of ROM.
    //      FFFF enables/disabled flash write capability
    //      then it uses the standard flash writing command/data as per the datasheet
    // A little clarification... these four addresses are the only ones used.
    // PROBABLY writes. FFFF is PROBABLY a direct interface to whatever flash chip.
    // Opcode says:
    // Very flexible bank-switch capable cartridge. Support 1Mbit to 8Mbit ROMs. 
    // 2 possible configurations, 4 programmable banks (up to 2Mbit ROMs), or 3 programmables 
    // banks and 1 fixed (up to 8Mbit). Support 1kbit to 1Mbit (128 bytes to 128kbytes) save memory.
    // that would give a maximum size of 2MB in theory, though he wrote 8Mbit which is 1MB,
    // with 2Mbit possible in the 4 programmable bank mode. Why would it be different?
    // 256 * 8k = 2MB... but then, he wrote that before he actually created the circuit.
    // We can probably assume, for a start, that the 4-paged banks approach never happened,
    // or at least hasn't happened to date, and just page the whole cart through the second
    // 8k block. :)

    centerString(0, "Dumping SuperGameCart...");
    makeFilename();

    res = f_open(&fil, path, FA_WRITE | FA_CREATE_ALWAYS);
    if (FR_OK != res) {
        clrscr();
        centerString(0, "Failed to open output file");
        return 0;
    }

    adr1=0;
    adr2=0;
    bank=0;

    // we're done when bank rolls over
    do {
        displayAddress(adr1, adr2);
        *(volatile unsigned char *)0xfffc = bank;    // force the bank switch - data at 0xA000

		// Since we are below the bank registers, we can pull all 8k
        res = f_write(&fil, (unsigned char*)0xA000, 8192, &cnt);
        if ((res != FR_OK) || (cnt != 8192)) {
            f_close(&fil);
            clrscr();
            centerString(0, "Failed to write output file");
            displayAddress(res, cnt);
            return 0;
        }

        adr2 += 0x2000;
        if (adr2 == 0) ++adr1;
        ++bank;
    } while (bank != 0);

    displayAddress(0x20,0);
    f_close(&fil);
    return 1;
}


// This is where we start!
int main() {
	unsigned char idx,x;

    // disable interrupt processing
    VDP_INT_DISABLE;

    // we expect VRAM to be cleared out
    vdpmemset(0, 0, 16384);

	// we must do this first - in case the user was running F18A software
	// and pressed reset, otherwise old settings will still be active.
    // If the F18A wasn't active, this will corrupt registers, but that's okay.
    // NOTE: Phoenix F18A gets a reset on reset too, but it does NOT reset the palette
    // This will reset, and then test if the F18A is actually present - it should be!!
    f18a = test_f18a();

    // ask the F18A to turn off the sprite limit
    VDP_SET_REGISTER(0x1e, 32); // stop sprite is #32
	
	// set_graphics leaves the screen disabled so the user can load character sets,
	// and returns the value to set in VDPR1 to enable it
    // Warning: in the menu.c we assume this value is 0xE2
	x = my_set_graphics(VDP_SPR_16x16);

    // clear the sprite pattern table
    vdpmemset(GSPRITEPAT, 0, 256*8);
	// set up 16 mag 3 sprites to give us two lines of bitmapped text at the bottom of the screen
    // this part won't work if the F18A isn't present, but I'm okay with that.
    // Why sprites? Oh, why not? Could use the BML but that's not implemented in Classic99
    // Debug is easier this way.
    VDP_SET_ADDRESS_WRITE(GSPRITE);
    for (idx=0; idx<16; ++idx) {
        // F18A doesn't need delays between writes
        VDPWD = 22*8-2; // Y
        VDPWD = idx*16; // X
        VDPWD = idx*4;  // char
        VDPWD = 15;     // color
    }
    // now write six more to give us an 12x2 area at top right for counting and status
    for (idx=0; idx<6; ++idx) {
        // F18A doesn't need delays between writes
        VDPWD = 7; // Y
        VDPWD = idx*16+20*8; // X
        VDPWD = idx*4+64;    // char
        VDPWD = 15;          // color
    }
    VDPWD = 0xd0;      // terminator
    
	// load the map
	vdpmemset(0, 0, 32);	// clear first row, we load down one row
	unrle(32, DONTCOPYMAP, SIZE_OF_DONTCOPYMAP);
	// load the gfx
	unrle(0x800, DONTCOPY, SIZE_OF_DONTCOPY);
	// set the color table
	vdpmemcpy(0x1000, colorTable, 32);

	// turn the screen on
	VDP_SET_REGISTER(VDP_REG_MODE1, x);

	// wait for the first two vblanks
    waitVblanks(2);

loop:
    // - set the mappers for real cart (should already be set)
    phBankingScheme = PH_BANK_CART | PH_UPPER_CART;
    // clear ALL sprites (only place)
    vdpmemset(GSPRITEPAT, 0, 256*8);

    clrscr();
    centerString(0, "Insert cartridge...");
    centerString(1, "(better with power off)");
    // wait for cartridge
    while ((pRom(0x8000) != 0xaa) && (pRom(0x8000) != 0x55)) {
        waitVblanks(30);
    }

    // now wait for an SD card
    clrscr();
    centerString(0, "insert SD card");
    waitSDCard();

    clrscr();
    if (FR_OK != f_mount(&fatFs, "", 1)) {
        centerString(0, "Failed to mount SD");
        goto waitloop;
    }
    if (fatFs.fs_type != FS_FAT32) {
        // there's something broken in the FAT16 write support - not sure if
        // it's my fault or in the lib itself. It corrupts the card though.
        // FAT32 seems okay.
        centerString(0, "Only FAT32 cards supported");
        goto waitloop;
    }

                 //  12345678901234567890123456789012
    centerString(0, "Press 1 to dump 32k, 2 to dump");
    centerString(1, "Megacart, or 3 to dump SGM");
    KSCAN_KEY = 0xff;
    while ((KSCAN_KEY!='1')&&(KSCAN_KEY!='2')&&(KSCAN_KEY!='3')) {
        readkeypad();
        if (disk_status() == STA_NODISK) {
            goto loop;
        }
    }

    clrscr();
    switch (KSCAN_KEY) {
        case '1': if (!dump32k()) goto waitloop; break;
        case '2': if (!dumpMegacart()) goto waitloop; break;
        case '3': if (!dumpSgm()) goto waitloop; break;
    }

    clrscr();
    centerString(0, "** DONE **");

waitloop:
    centerString(1, "Press 0 to restart");
    KSCAN_KEY = 0xff;
    while (KSCAN_KEY != '0') {
        readkeypad();
    }
    goto loop;

	return 0;
}
	
