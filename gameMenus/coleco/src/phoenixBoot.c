// New Phoenix boot BIOS
// Created by Tursi/M.Brent
// Boot logo and SD menu
// Uses libti99Coleco
// Note: we have 16k now per the new memory layout, and 2k RAM at 0x6000 (during loader only)

#include "memset.h"
#include "vdp.h"
#include "phoenix.h"
#include "f18a.h"
#include "kscan.h"

#define HEADERS__
#include "newmap2.c"
#include "fatfont.c"
#include "thinfont.c"
#undef HEADERS__

// we assume that the f18a exists...
unsigned char f18a;
// cartridge string (we format it into here)
char copyright[65];

// menu function
extern void menu();

// name format: "DONKEY KONG/NINTENDO/1982"
// There is no explicit limit on the lengths of the first two strings
#define CART_NAME_INFO 0x8024

// trampoline to start the cart with the Coleco BIOS loaded
// This area (0x6000) seems untouched by the Coleco BIOS
static const unsigned char trampoline[] = {
    0xdb, 0x55,         // -        IN 0x55,A           DB55    swaps the BIOS - note RAM goes from 2k to 1k!
    0x31,0xb9,0x73,     // -        LD SP,0x73B9        31B973
    0x2a, 0x0a, 0x80,   // -        LD HL,[0x800A]      2A800A

//    0xC3,0x00,0x00,      // JP 0x0000 (reboot bios)

    0xe9                // -        JP [HL]             E9
};

// fade in for font
static const unsigned char fadein[] = { 
	COLOR_TRANS,
	COLOR_DKBLUE,
	COLOR_DKGREEN,
	COLOR_LTGREEN,
	COLOR_GRAY,
	COLOR_WHITE
};
static const char flicker[8] = {
	-1,-1,
	0,-1,0,-1,
	0,0
};

// hardware control
static volatile unsigned char * const pRom = (volatile unsigned char * const)0;	// access to memory
static volatile __sfr __at 0xc0 port3;  // joystick reset strobe

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

// same as textout, but shifts the text half a character to the right
void textouthalf(unsigned int vdp, const char *p) {
    unsigned char first = 1;
	while (*p) {
        unsigned i;
        VDP_SET_ADDRESS_WRITE(vdp);
        for (i=0; i<8; ++i) {
            unsigned c1,c2,out;
            unsigned int off1,off2;

            if (first) {
                c1 = 3;     // space is 3
                c2 = (*p)-' '+3;
            } else {
                c1 = (*p)-' '+3;
                if (*(p+1) == 0) {
                    c2 = 3;
                } else {
                    c2 = (*(p+1))-' '+3;
                }
            }
            off1 = c1*8+i;
            off2 = c2*8+i;

            out = (FATFONT[off1]<<4) | (FATFONT[off2]>>4);
            VDPWD = out;
        }
        vdp+=16;
        if (first) {
            first = 0;
        } else {
            ++p;
        }
	}
}

// fade in the phoenix part of the logo
void fadeInText() {
	unsigned char p = 0;
	unsigned char i;

    // in VDP for debug
    vdpmemcpy(0x1c18, "VDP", 3);

	// first turn off the colors - phoenix color sets are 3-12
	vdpmemset(gColor+3, 0x00, 10);
	
	// now copy the characters into place
	vdpmemcpy(gImage+(18*32), MD0+((18-1)*32), 4*32);

	// now we can fade it in with normal interrupt polling
	while (fadein[p++] != COLOR_WHITE) {
		// do a little interpolation with flicker
		for (i=0; i<8; ++i) {
			VDP_WAIT_VBLANK_CRU;
			VDP_CLEAR_VBLANK;
			vdpmemset(gColor+3, fadein[p+flicker[i]]<<4, 10);
		}
	}
}
void fadeInTextF18A() {
	unsigned char p = 0;
	unsigned char i;

    // in VDP for debug
    vdpmemcpy(0x1c18, "F18A", 4);

	// first set the color for white to black, we'll fade it in
	VDP_SET_REGISTER(0x2f, 0x8f);	// Reg 47, value: 1000 1111, DPM = 1, AUTO INC = 0, palreg 15.
	VDPWD = 0;
	VDPWD = 0;						// color is now black
	VDP_SET_REGISTER(0x2f, 0x00);	// Turn off the DPM mode

	// now set the phoenix color sets (3-12) to white on transparent
	vdpmemset(gColor+3, 0xf0, 10);
	
	// now copy the characters into place
	vdpmemcpy(gImage+(18*32), MD0+((18-1)*32), 4*32);

	// now we can fade it in with normal interrupt polling
	for (i=1; i<16; ++i) {
	    // turn DPM back on (auto-off after one reg when there's no auto-inc)
	    VDP_SET_REGISTER(0x2f, 0x8f);	// Reg 47, value: 1000 1111, DPM = 1, AUTO INC = 0, palreg 15.

        // set the color register
		VDPWD = i;	// red
		VDPWD = i | (i<<4);	// green and blue
		
		VDP_WAIT_VBLANK_CRU;
		VDP_CLEAR_VBLANK;
		VDP_WAIT_VBLANK_CRU;
		VDP_CLEAR_VBLANK;
		VDP_WAIT_VBLANK_CRU;
		VDP_CLEAR_VBLANK;
	}
}

// animate the Phoenix logo up
void displayLogo() {
	int idx;
	unsigned int off;
	
	// set the logo color to dark red - logo color sets are 13-31
	vdpmemset(gColor+13, COLOR_DKRED<<4, 19);

	// the logo graphics occupy from roms 1 to 16
	// we'll just draw from bottom up
	for (idx = 16; idx > 0; --idx) {
		VDP_WAIT_VBLANK_CRU;
		VDP_CLEAR_VBLANK;
		VDP_WAIT_VBLANK_CRU;
		VDP_CLEAR_VBLANK;
		off = (idx-1)*32;
		vdpmemcpy(gImage+off, MD0+off, 32);
	}
}

// center a string on the sprite output lines
// takes half-characters into account and calls 
// the appropriate function. String must be less
// than 256 characters. (Better be less than 32)
void centerString(unsigned char line, char *p) {
    unsigned int vdp = gSpritePat + (line*8);
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

    if (len&1) {
        // odd offset
        textouthalf(vdp-16, p);
    } else {
        // even offset
        textout(vdp, p);
    }
}

// start whatever is configured at 0x8000
void startTitle() {
    // - execute title
    // -    disable screen and interrupts
    VDP_SET_REGISTER(VDP_REG_MODE1, VDP_MODE1_16K);

    // -    reset F18A
    reset_f18a();

    // the RAM located at 0x6000 is the original ColecoVision 1k
    // but unlike the Coleco BIOS, we /must/ access at 0x6000, not
    // one of the later mirrors.

    // -    prepare system as per original BIOS:
    // -        In test mode, it doesn't do ANYTHING, it just jumps to the cart immediately (must honor to avoid pointers)
    // We don't have to check both bytes because we already did that
    if (pRom[0x8000] == 0xaa) {
        // do the system init

        // -        Otherwise, it turns off the sound chip (already done)
        // -        Init the random number generator
        // -            LD HL, 0x33
        // -            LD [RAND_NUM], HL  (0x73c8)
        pRom[0x63c8] = 0x33;

        // -        Init the controller BIOS
        // -            CALL CONTROLLER_INIT (0x1105)
        // -                OUT [STRB_RST_PORT],A  (0xc0, A last contained 0xff)
        port3 = 0xff;

        // This block takes a user-specified RAM address from 0x8008,
        // and starting 2 bytes after that point, it zeroes 10 bytes
        // It also zeros 20 bytes starting at 0x7307
        // -                XOR A             (A = 0)
        // -                LD IX,[CONTROLLER_MAP] (0x8008)
        // -                INC IX
        // -                INC IX
        // -                LD IY,DBNCE_BUFF  (0x7307)
        // -                LD B,NUM_DEV*2    (NUM_DEV=5, value=10)
        // -              CINIT1
        // -                LD [IX+0],A
        // -                INC IX
        // -                LD [IY+0],A
        // -                INC IY
        // -                LD [IY+0],A
        // -                INC IY
        // -                DEC B
        // -                JR NZ,CINIT1
        {
            unsigned int *pDst = (unsigned int*)(*((unsigned int*)0x8008));
            memset(pDst, 0, 10);
            memset((void*)0x7307, 0, 20);
        }

        // This part just zeros a few fixed addresses
        // -                LD [SPIN_SW0_CT],A  (0x73eb)
        // -                LD [SPIN_SW1,CT],A  (0x73ec)
        // -                LD [S0_C0],A    (0x73ee)
        // -                LD [S0_C1],A    (0x73ef)
        // -                LD [S1_C0],A    (0x73f0)
        // -                LD [S1_C1],A    (0x73f1)
        // -                RET
        memset((void*)0x73eb, 0, 6);

        // -        Clear defer writes
        // -            LD A,FALSE
        // -            LD [DEFER_WRITES],A  (0x73c6)
        pRom[0x63c6] = 0;

        // -        Disable sprite mux
        // -            LD [MUX_SPRITES],A  (0x73c7)
        pRom[0x63c7] = 0;

        // -        Clear Video RAM
        // -            LD HL,0
        // -            LD DE,16384
        // -            LD A,0
        // -            CALL FILL_VRAM  (0x1804)
        // -                LD C,A
        // -                LD A,l
        // -                OUT [MODE_1_PORT],A
        // -                LD A,H
        // -                OR 0x40
        // -                OUT [MODE_1_PORT],A
        // -                LD A,C
        // -                OUT [MODE_0_PORT],A
        // -                DEC DE
        // -                LD A,D
        // -                OR E
        // -                JR NZ,FILL
        vdpmemset(0, 0, 16384);

        // -                CALL READ_REGISTER (0x1fdc)
        // -                    IN A,[CTRL_PORT] (0xbf) // Read VDP Status
        // -                    RET
        // -                RET
        {
            volatile unsigned char x = VDPST;
        }

        // -        Set VDP to mode 1 (display off)
        // -            CALL MODE_1 (0x18E9)
        // -                LD B,0      // reg
        // -                LD C,0      // value
        // -                CALL WRITE_REGISTER (0x1fd9->1CCA)
        // -                    LD A,C
        // -                    OUT [CTRL_PORT],A       // value
        // -                    LD A,B
        // -                    ADD A,0x80
        // -                    OUT [CTRL_PORT],A       // register number
        // -                    LD A,B
        // -                    CP 0
        // -                    JR NZ,NOT_REG_0
        // -                    LD A,C
        // -                    LD [VDP_MODE_WORD],A    // copy reg 0 to 0x73c3
        // -                  NOT_REG_0:
        // -                    LD A,B
        // -                    CP 1
        // -                    JR NZ,NOT_REG_1
        // -                    LD A,C
        // -                    LD [VDP_MODE_WORD+1],A  // copy reg 1 to 0x73c4
        // -                  NOT_REG_1:
        // -                    RET
        VDP_SET_REGISTER(0, 0);
        pRom[0x63c3] = 0;

        // -                LD B,1
        // -                LD C,0x80
        // -                CALL WRITE_REGISTER (0x1fd9->1CCA)
        VDP_SET_REGISTER(1, 0x80);
        pRom[0x63c4] = 0x80;

        // -                LD A,2          // (SIT) table code (0=sprite name, 1=sprite gen, 2=pattern name, 3=pattern gen, 4=color)
        // -                LD HL,0x1800    // VRAM address
        // -                CALL INIT_TABLE  (0x1fb8->1B1D) (this function is horrible!)
        // -                    LD C,A
        // -                    LD B,0
        // -                    LD IX,VRAM_ADDR_TABLE (0x73F2)
        // -                    ADD IX,BC
        // -                    ADD IX,BC       // add index*2
        // -                    LD [IX+0],L     // save VRAM address in table at 0x73F2
        // -                    LD [IX+1],H     // This is the part that really matters (besides setting the register)
        // -                    LD A,[VDP_MODE_WORD] (0x73c3 as set above)
        // -                    BIT 1,A
        // -                    JR Z,INIT_TABLE80
        // -                    LD A,C              // this is a big special case block for bitmap mode
        // -                    CP 3                // check generator table
        // -                    JR Z,CASE_OF_GEN    
        // -                    CP 4
        // -                    JR Z,CASE_OF_COLOR
        // -                    JR INIT_TABLE80
        // -                  CASE_OF_GEN:
        // -                    LD B,4              // VDP reg 4
        // -                    LD A,L              // check which 8k boundary
        // -                    OR H
        // -                    JR NZ,CASE_OF_GEN10
        // -                    LD C,3              // value to write for 0x0000
        // -                    JR INIT_TABLE90
        // -                  CASE_OF_GEN10:
        // -                    LD C,7              // value to write for 0x2000
        // -                    JR INIT_TABLE90
        // -                  CASE_OF_COLOR:
        // -                    LD B,3              // VDP reg 3
        // -                    LD A,L
        // -                    OR H
        // -                    JR NZ,CASE_OF_CLR10
        // -                    LD C,0x7f           // value for 0x0000
        // -                    JR INIT_TABLE90
        // -                  CASE_OF_CLR10
        // -                    LD C,0xff           // value for 0x2000
        // -                    JR INIT_TABLE90
        // -                  INIT_TABLE80
        // -                    LD IY,BASE_FACTORS  // this is the normal math code for non-bitmap
        // -                    ADD IY,BC
        // -                    ADD IY,BC
        // -                    LD A,[IY+0]         // get shift count from table
        // -                    LD B,[IY+1]         // get register number from table
        // -                  DIVIDE:
        // -                    SRL H
        // -                    RR L
        // -                    DEC A
        // -                    JR NZ,DIVIDE
        // -                    LD C,L              // get value for register into C
        // -                  INIT_TABLE90:
        // -                    CALL REG_WRITE      // write the register
        // -                    RET
        // -                  BASE_FACTORS:
        // -                    DEFB 7,5,11,6,10,2,11,4,6,3
        // (So, SIT = 0x1800, and store at 73F2+2*2
        VDP_SET_REGISTER(VDP_REG_SIT, 0x1800/0x400);
        pRom[0x63f2+2*2] = 0x00;
        pRom[0x63f2+2*2+1] = 0x18;

        // -                LD A,4          // color table
        // -                LD HL,0x2000
        // -                CALL INIT_TABLE  (0x1fb8)
        // (So, CT = 0x2000, and store at 73F2+4*2
        VDP_SET_REGISTER(VDP_REG_CT, 0x2000/0x40);
        pRom[0x63f2+4*2] = 0x00;
        pRom[0x63f2+4*2+1] = 0x20;

        // -                LD A,3          // pattern generator (PDT)
        // -                LD HL,0
        // -                CALL INIT_TABLE  (0x1fb8)
        // (So, PDT = 0x0000, and store at 73F2+3*2
        VDP_SET_REGISTER(VDP_REG_PDT, 0x0000/0x800);
        pRom[0x63f2+3*2] = 0x00;
        pRom[0x63f2+3*2+1] = 0x00;

        // -                LD A,0          // sprite name table (SAL)
        // -                LD HL,0x1B00
        // -                CALL INIT_TABLE  (0x1fb8)
        // (So, SAL = 0x1B00, and store at 73F2+0*2
        VDP_SET_REGISTER(VDP_REG_SAL, 0x1B00/0x80);
        pRom[0x63f2+0*2] = 0x00;
        pRom[0x63f2+0*2+1] = 0x1B;

        // -                LD A,1          // sprite generator (SDT)
        // -                LD HL,0x3800
        // -                CALL INIT_TABLE  (0x1fb8)
        // (So, SDT = 0x3800, and store at 73F2+1*2
        VDP_SET_REGISTER(VDP_REG_SDT, 0x3800/0x800);
        pRom[0x63f2+1*2] = 0x00;
        pRom[0x63f2+1*2+1] = 0x38;

        // -                LD B,7
        // -                LD C,0
        // -                CALL WRITE_REGISTER (0x1fd9)    // black screen
        // -                RET
        VDP_SET_REGISTER(7, 0);

        // -        Load character set
        // -            CALL LOAD_ASCII (0x1927)
        // -                LD HL,ASC_TABLE (0x158b)    // 0x158B starts with 0x1D (copyright symbol)
        // -                LD DE,0x1d                  // first character index
        // -                LD IY,96                    // number of chars
        // -                LD A,3                      // table code (0=sprite name, 1=sprite gen, 2=pattern name, 3=pattern gen, 4=color)
        // -                CALL PUT_VRAM (0x1fbe->1C27)
        // -                    (This has lots of special cases, but I can just hard code the results)
        vdpmemcpy(0x0000+0x1d*8, (void*)COLECO_FONT_ADR, 96*8);

        // -                LD HL,SPACE (0x15a3)        // also copies space into character #0
        // -                LD DE,0
        // -                LD IY,1
        // -                LD A,3                      // pattern table
        // -                CALL PUT_VRAM
        // -                RET
        vdpmemcpy(0x0000, (void*)(COLECO_FONT_ADR+3*8), 8);      // space is after copyright, T, and M
    }

    // Don't use the stack or RAM variables anymore if we can help it. In particular there
    // are tables at 0x73b9 we mustn't mess with, or some carts will crash

    // after the above, NMI interrupts are disabled
    // -    load init code to RAM and continue from there
    // -    swap BIOS in
    // -    jump to cartridge startup vector
    // -        IN 0x55,A           DB55
    // -        LD HL,[0x800A]      2A800A
    // -        JP [HL]             E9
    memcpy((void*)0x6000, trampoline, sizeof(trampoline));
    ((void(*)())0x6000)();  // never returns

    // TODO: game oddities
    // Cabbage Patch Kids hangs on player startup
    // Illusions truncates the copyright part of the text
    // Ken Unston Poker just hangs
    // 


    // Coleco BIOS Startup (Donkey Kong):
    // af   8042   af_  FFFF    CPU
    // bc   0180   bc_  FFFF
    // de   0000   de_  FFFF
    // hl   8048   hl_  FFFF
    // ix   73F6   iy   1C01
    // r    10     i    00
    // memp 0000   pc   8048
    //
    //VDP0  00     VDP  0180
    //VDP1  80     GROM 0000 (0000.0)
    //VDP2  06    VDPST C4
    //VDP3  80      PC  8048
    //VDP4  00      SP  73B9
    //VDP5  36      F   42
    //VDP6  07     Bank 00030003
    //VDP7  00     DSR  FFFF
    //
    // SIT  1800
    // SDT  3800   SAL  1B00
    // PDT  0000   Size 0800
    //  CT  2000   Size 0020

    // Phoenix BIOS Startup:
    // af   0064   af_  FFFF    CPU
    // bc   FFFF   bc_  FFFF
    // de   124F   de_  FFFF
    // hl   8048   hl_  FFFF
    // ix   73F9   iy   7057
    // r    22     i    00
    // memp 0000   pc   8048
    //
    //VDP0  00     VDP  0008
    //VDP1  80     GROM 0000 (0000.0)
    //VDP2  06    VDPST 90
    //VDP3  80      PC  8048
    //VDP4  00      SP  73B9
    //VDP5  36      F   64
    //VDP6  07     Bank 00030003
    //VDP7  00     DSR  FFFF
    //
    // SIT  1800
    // SDT  3800   SAL  1B00
    // PDT  0000   Size 0800
    //  CT  2000   Size 0020

}

// start a hardware cartridge
void startCartridge() {
#if 0
	// Now the BIOS data is RO, (maybe not available)
    // - check if joystick UP is held down
    // - if yes
    // -     load standard Coleco font into BIOS (should be safe)
    // - else if not
    // -     load CollectorVision arcade font into BIOS
    joystfast(KSCAN_MODE_LEFT);   // read left joystick
    if (KSCAN_JOYY != JOY_UP) {
        vdpmemcpy(0x1c30, "thin font", 9);
        memcpy((char*)COLECO_FONT_ADR, THINFONT, SIZE_OF_THINFONT);
    } else {
        vdpmemcpy(0x1c30, "fat font", 8);
        memcpy((char*)COLECO_FONT_ADR, FATFONT, SIZE_OF_FATFONT);
    }
#endif

    // debug
    vdpmemcpy(0x1c20, "starting cart", 13);

    // - set the mappers for real cart (should already be set)
    phBankingScheme = PH_BANK_CART | PH_UPPER_CART;

    // start the cart
    startTitle();
}

// display the cartridge copyright information, then start it
void runCartHeader(void (*mycenter)(unsigned char, char*)) {
    // - read and display the cartridge name & copyright on the status line
    // String at 0x8024 is GAME_NAME/OWNER/COPYRIGHT
    // OWNER is displayed first and often includes "presents"
    // GAME NAME is on the second line and may include TM (0x1e, 0x1f)
    // COPYRIGHT is /always/ 4 digits. The font has a copyright symbal at 0x1d
    // 
    // Filter OWNER to remove "PRESENTS " (watch for leading spaces, watch for no trailing space before end of string (ie: /PRESENTS/)
    // 
    // Then do : OWNER GAME_NAME cYYYY
    // Remove leading, trailing, and duplicate spaces.
    // Split at 32 chars.
    // Remove leading and trailing spaces again, and center.
    // Adjust center for half space
    // we have a maximum of 32 chars per field.

    unsigned char *p = (unsigned char*)CART_NAME_INFO;
    unsigned char *o = copyright;
    const unsigned char *sk = "PRESENTS ";
    unsigned char *pYr;
    int cntdown = 32;

    // clear the buffer
    memset(copyright, 0, sizeof(copyright));

    // treat any 0 bytes in the cart fields as space (ie: Video Hustler)

    // first find the owner and copy that out, though skip if it starts with 'PRESENTS'
    while ((*p != '/')&&(--cntdown > 0)) ++p;
    if (cntdown == 0) {
        // never mind - malformed string
        startCartridge();   // never returns
    }
    ++p;
    // skip leading spaces
    cntdown = 32;
    while ((*p == ' ')&&(--cntdown > 0)) {
        ++p;
    }
    
    // copy out, skipping 'PRESENTS ' if there
    cntdown = 32;
    while ((*p != '/')&&(--cntdown > 0)) {
        if (0 != sk) {
            if (*p == *sk) {
                ++cntdown;
                ++sk;
                ++p;
                continue;
            } else {
                // no more skipping after the first char
                sk = 0;
            }
        }
        *(o++) = *(p++);
    }
    // save the pointer off for later
    pYr = p;

    // we know we could not have copied too many characters
    *(o++)=' ';

    // okay, now we have "OWNER ", back up and get GAME_NAME
    p = (unsigned char*)CART_NAME_INFO;

    // skip leading spaces
    cntdown = 32;
    while ((*p == ' ')&&(--cntdown > 0)) {
        ++p;
    }

    // check how many characters we have left - we need to save
    // six for the " c1982" part
    cntdown = 64-(o-copyright)-6;

    // now just copy until the slash
    while ((*p != '/')&&(--cntdown > 0)) {
        *(o++) = *(p++);
    }

    // now we are supposed to have enough room to finish it off
    // make sure we have the copyright year at pYr (we might have stopped early)
    cntdown = 32;
    while ((*pYr != '/')&&(--cntdown > 0)) {
        ++pYr;
    }
    if (*pYr == '/') {
        // we found it!
        ++pYr;

        *(o++) = ' ';
        *(o++) = 0x1d;  // (C)
        *(o++) = *(pYr++);
        *(o++) = *(pYr++);
        *(o++) = *(pYr++);
        *(o++) = *(pYr++);
        *(o) = '\0';
    }

    // now from copyright to o-1, replace any 0 bytes with space
    while (--o >= copyright) {
        if (*o == 0) *o=' ';
    }

    // make positive it's NUL terminated, just in case
    copyright[64]='\0';

    // now we have the string, remove leading spaces
    while (copyright[0] == ' ') {
        memmove(copyright, copyright+1, sizeof(copyright)-1);
    }

    // search for and remove duplicate spaces
    p = copyright;
    while (*p) {
        if ((*p == ' ') && (*(p+1) == ' ')) {
            memmove(p, p+1, sizeof(copyright)-(p-copyright)-1);
        } else {
            ++p;
        }
    }

    // we should be able to just search backwards for the first non-zero byte
    p = copyright + sizeof(copyright) - 1;
    while ((p >= copyright) && (*p == '\0')) {
        --p;
    }

    // Okay, good. Conveniently, p now points to the end of the string, so check how long it is
    if (p-copyright > 31) {
        // we need to display a first string, find a space to truncate at
        p = copyright+30;
        while ((p > copyright) && (*p != ' ')) {
            --p;
        }
        // if, somehow, we didn't find a space, we're just going to deal with it.
        // it shouldn't have happened!
        *p = '\0';
        mycenter(0, copyright);
        ++p;
        mycenter(1, p);
    } else {
        // it all fits, use the lower line cause it looks better with the gap
        mycenter(1, copyright);
    }

    // - wait 5 seconds, allow abort
    cntdown = 300;
    while (cntdown-- > 0) {
        kscanfast(1);   // read left joystick fire button
        if (KSCAN_KEY == JOY_FIRE) break;

	    VDP_WAIT_VBLANK_CRU;
	    VDP_CLEAR_VBLANK;
    }

    // - start cartridge
    startCartridge();
}

// main loop
int main() {
	unsigned char x,idx,col;

    // I'm told we don't need to mute the AY or the SEX, and reset also turns off the SGM.

	// we must do this first - in case the user was running F18A software
	// and pressed reset, otherwise old settings will still be active.
    // If the F18A wasn't active, this will corrupt registers, but that's okay.
    // NOTE: Phoenix F18A gets a reset on reset too, but it does NOT reset the palette
	reset_f18a();

    // test for a cartridge with the no logo requirement
    // note that startCartridge still does a lot of initialization,
    // in case it needs to undo the F18A setup for the menu later.
    if ((pRom[0x8000]==0x55)&&(pRom[0x8001]==0xaa)) {
        startCartridge();    // never returns
    }

    // then test if the F18A is actually present - it should be!!
    // We'll do what we can if it's not working
    f18a = test_f18a();
    if (f18a) {
        // ask the F18A to turn off the sprite limit
        VDP_SET_REGISTER(0x33, 32); // stop sprite is #32
    }
	
	// set_graphics leaves the screen disabled so the user can load character sets,
	// and returns the value to set in VDPR1 to enable it
	x = set_graphics(VDP_SPR_16x16);
	col = (COLOR_GRAY<<4)|COLOR_BLACK;
	VDP_SET_REGISTER(VDP_REG_COL, col);
     
	// move the sprite pattern table so it does not overlap the character patterns
	VDP_SET_REGISTER(VDP_REG_SDT, 0x02);
	gSpritePat = 0x1000;
    // clear the sprite pattern table
    vdpmemset(gSpritePat, 0, 256*8);
	// set up 16 mag 3 sprites to give us two lines of bitmapped text at the bottom of the screen
    // this part won't work if the F18A isn't present, but I'm okay with that.
    // Why sprites? Oh, why not? Could use the BML but that's not implemented in Classic99
    // Debug is easier this way.
    VDP_SET_ADDRESS_WRITE(gSprite);
    for (idx=0; idx<16; ++idx) {
        VDPWD = 22*8-2; // Y
        VDP_SAFE_DELAY;             // technically, I don't really need the delays cause the F18A is fast enough...
        VDPWD = idx*16; // X
        VDP_SAFE_DELAY;             // just good practice I guess
        VDPWD = idx*4;  // char
        VDP_SAFE_DELAY;
        VDPWD = 15;     // color
        VDP_SAFE_DELAY;
    }
    VDPWD = 0xd0;      // terminator
    
    // clear the screen
	vdpmemset(gImage, 0x18, 768);
	// set the color table to white on transparent
	vdpmemset(gColor, 0xF0, 32);

	// load the character patterns
	//vdpmemcpy(gPattern, PAT0, 8*256);                 // raw data
    //unrle(gPattern, PAT0, SIZE_OF_PAT0RLE);           // RLE full character set
    unrle(gPattern+25*8, PAT0, SIZE_OF_PAT0RLE-147);    // hand counted offsets to skip unused

	// turn the screen on
	VDP_SET_REGISTER(VDP_REG_MODE1, x);

    // clear any vblank we may have missed
    VDP_CLEAR_VBLANK;

	// wait for the first two vblanks
	VDP_WAIT_VBLANK_CRU;
	VDP_CLEAR_VBLANK;
	VDP_WAIT_VBLANK_CRU;
	VDP_CLEAR_VBLANK;

	// enable the F18A here if we have it
	if (f18a) {
		// F18A available
		fadeInTextF18A();
	} else {
		// no F18A (but we have a flicker fade)
		// I'm not sure why we would do this non-F18A mode
		// It's mostly for test purposes.
		fadeInText();
	}
    displayLogo();

    // Now that the fancy part is done, we can get to work on the real stuff.

    // Check for a cartridge plugged in with the logo header
    if ((pRom[0x8000]==0xaa)&&(pRom[0x8001]==0x55)) {
        runCartHeader(centerString);    // never returns
    }

    // If no cartridge
    // call the menu - never returns
    menu();

	return 0;
}
