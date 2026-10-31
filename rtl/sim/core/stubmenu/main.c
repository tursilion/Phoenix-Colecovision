/* Stub of the Coleco menu's MegaCart / SGM loader, for the simulation.
 *
 * The image is at sector IMG_SECT of a raw card (no FAT), IMG_BLOCKS 16K
 * blocks long, SGM if IMG_SGM.  Like loadMegacartRom(): the last 480K (or
 * all of a smaller image) goes to the top of the SRAM through the 32K RAM
 * banks, the ROM cache gets every 8K page's sector (port >5C, then a read
 * of the page's first sector; port >5D, then its last), the mask and the
 * banking scheme are set, and the game starts from the 1K RAM (IN A,(>55)
 * then JP to the start address at >800A).
 */

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned long DWORD;

__sfr __at 0x54 phRAMBankSelect;
__sfr __at 0x55 phBankingScheme;
__sfr __at 0x56 phSDControl;
__sfr __at 0x57 phSDData;
__sfr __at 0x59 phCartMask;
__sfr __at 0x5C phCachePage;
__sfr __at 0x5D phCacheCheck;
__sfr __at 0x5E phCacheStatus;

#ifndef IMG_SECT
#define IMG_SECT   2048UL
#endif
#ifndef IMG_BLOCKS
#define IMG_BLOCKS 32
#endif
#ifndef IMG_SGM
#define IMG_SGM    0
#endif

#define MEM(a) (*(volatile BYTE *)(a))

static BYTE spi(BYTE b) { phSDData = b; return phSDData; }

/* One sector (CMD17) to dst; with dst 0 only the command (the ROM cache
 * takes the sector from it) */
static void read_sector(DWORD s, BYTE *dst)
{
    WORD i;
    BYTE r;
    phSDControl = 0;                    /* select, fast */
    spi(0xFF);
    phSDData = 0x51;
    phSDData = (BYTE)(s >> 24);
    phSDData = (BYTE)(s >> 16);
    phSDData = (BYTE)(s >> 8);
    phSDData = (BYTE)s;
    phSDData = 0x01;
    if (!dst) {
        phSDControl = 1;
        spi(0xFF);
        return;
    }
    do { r = phSDData; } while (r == 0xFF);
    do { r = phSDData; } while (r != 0xFE);
    for (i = 0; i < 512; ++i) {
        r = phSDData;
        if (dst) *dst++ = r;
    }
    r = phSDData; r = phSDData;         /* CRC */
    phSDControl = 1;                    /* deselect */
    spi(0xFF);
}

/* The 1K RAM start code: IN A,(>55) / LD HL,(>800A) / JP (HL) */
static const BYTE start_code[] = { 0xDB, 0x55, 0x2A, 0x0A, 0x80, 0xE9 };

void main(void)
{
    BYTE n = IMG_BLOCKS, page, i;
    DWORD s = IMG_SECT;
    WORD k;

    /* load: the last 480K (30 16K blocks) at the top of the SRAM (the
     * testbench's --preload does it) */
    phBankingScheme = 0x01 | 0x00;      /* MegaCart, upper internal RAM */
#ifndef PRELOADED
    if (n > 30) {
        s += (DWORD)(n - 30) * 32;
        n = 30;
    }
    page = 15 - ((n - 1) >> 1);
    phRAMBankSelect = page;
    k = (n & 1) ? 0x4000 : 0;
    for (;;) {
        read_sector(s++, (BYTE *)(0x8000 + k));
        k += 512;
        if (k == 0x8000) {
            if (++page > 15) break;
            phRAMBankSelect = page;
            k = 0;
        }
    }
#endif

    /* the ROM cache's page map */
    if (IMG_BLOCKS > 30) {
        i = 0;
        do {
            phCachePage = i;
            read_sector(IMG_SECT + (DWORD)i * 16, 0);
            phCacheCheck = i;
            read_sector(IMG_SECT + (DWORD)i * 16 + 15, 0);
        } while (++i != (BYTE)(IMG_BLOCKS * 2));
        phCacheStatus = 0;
        if (phCacheStatus & 1)
            for (;;) ;                  /* fragmented: stop */
    }

    phCartMask = IMG_SGM ? IMG_BLOCKS * 2 - 1 : IMG_BLOCKS - 1;
    phBankingScheme = IMG_SGM ? (0x02 | 0x10) : (0x01 | 0x10);
    phRAMBankSelect = 1;

    for (i = 0; i < sizeof(start_code); ++i)
        MEM(0x6000 + i) = start_code[i];
    ((void (*)(void))0x6000)();
}
