/* Phoenix NES ROM cache test (cc65).
 *
 * An MMC3 cartridge with 512K of PRG and 256K of CHR (mkcache.py), so the
 * core keeps 32 of the 64 PRG pages in the SRAM and reads the others from
 * the SD card.  Each 8K PRG page p starts with LDA #p / LDX #0 / RTS, and
 * the rest is a pattern of the page and the offset.  This program is in
 * the last page ($E000), with the 16-bit byte sum of each 1K block of each
 * page at $FA00.
 *
 * The test maps random pages, then all of them, at $8000 or $A000, sums a
 * 1K block of each (the pass picks which, so eight passes check every
 * byte) and calls its code.  Each pass also copies 256-byte blocks of
 * random pages to the sprite memory with the sprite DMA (screen off), which
 * makes the core freeze the NES instead of holding the CPU, and reads them
 * back.  It counts and shows the errors, and for the last bad page which
 * page's data it had (HAS) and how many bytes differ from that page (DIFF:
 * 0000 means a whole other page).  It runs until reset.
 */

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned long DWORD;

#define REG(a) (*(volatile BYTE *)(a))
#define PPUCTRL   REG(0x2000)
#define PPUMASK   REG(0x2001)
#define PPUSTATUS REG(0x2002)
#define OAMADDR   REG(0x2003)
#define OAMDATA   REG(0x2004)
#define PPUSCROLL REG(0x2005)
#define PPUADDR   REG(0x2006)
#define PPUDATA   REG(0x2007)
#define OAMDMA    REG(0x4014)
#define MMC3_SEL  REG(0x8000)
#define MMC3_DATA REG(0x8001)

#define SUMS ((const WORD *)0xFA00)     /* page p's 1K block b at SUMS[8p + b] */
#define PAGES 63                        /* tested: 0-62 (63 has the sums) */

WORD __fastcall__ page_sum(BYTE hi);
BYTE __fastcall__ page_call(BYTE hi);

static void wait_vblank(void)
{
    while (!(PPUSTATUS & 0x80))
        ;
}

static void ppu_addr(WORD a)
{
    PPUADDR = (BYTE)(a >> 8);
    PPUADDR = (BYTE)a;
}

static void put(BYTE col, BYTE row, const char *s)
{
    ppu_addr(0x2000 + (WORD)row * 32 + col);
    while (*s)
        PPUDATA = *s++;
}

static void ppu_done(void)
{
    ppu_addr(0);
    PPUSCROLL = 0;
    PPUSCROLL = 0;
}

static const char hexd[] = "0123456789ABCDEF";

/* Shown in the next vertical blank */
static void hex(BYTE col, BYTE row, DWORD v, BYTE digits)
{
    char s[9];
    BYTE i;
    for (i = 0; i < digits; ++i) {
        s[digits - 1 - i] = hexd[(BYTE)v & 15];
        v >>= 4;
    }
    s[digits] = 0;
    wait_vblank();
    put(col, row, s);
    ppu_done();
}

static void text(BYTE col, BYTE row, const char *s)
{
    wait_vblank();
    put(col, row, s);
    ppu_done();
}

/* MMC3 bank register r = v */
static void mmc3(BYTE r, BYTE v)
{
    MMC3_SEL = r;
    MMC3_DATA = v;
}

static void screen_init(void)
{
    WORD i;
    BYTE j;

    PPUCTRL = 0;
    PPUMASK = 0;
    wait_vblank();
    wait_vblank();
    /* CHR: the font in the first 4K (mkcache.py) */
    mmc3(0, 0); mmc3(1, 2); mmc3(2, 4); mmc3(3, 5); mmc3(4, 6); mmc3(5, 7);
    ppu_addr(0x3F00);
    for (j = 0; j < 32; ++j)
        PPUDATA = (j & 3) == 0 ? 0x01 : 0x30;
    ppu_addr(0x2000);
    for (i = 0; i < 1024; ++i)
        PPUDATA = (i < 960) ? ' ' : 0;
    put(3, 2, "PHOENIX NES CACHE TEST");
    put(3, 3, "512K PRG, 256K CHR, MMC3");
    put(3, 6, "PASSES");
    put(3, 7, "PAGES");
    put(3, 9, "DATA ERRORS");
    put(3, 10, "CODE ERRORS");
    put(3, 11, "DMA ERRORS");
    put(3, 13, "LAST BAD PAGE");
    put(3, 14, "  SUM / WANT");
    put(3, 15, "  BAD BYTES");
    put(3, 16, "  HAS / DIFF");
    put(3, 18, "STATUS");
    ppu_done();
    wait_vblank();
    PPUMASK = 0x0A;
}

/* The byte at offset o of page p */
static BYTE want(BYTE p, WORD o)
{
    switch (o) {
    case 0: return 0xA9;
    case 1: return p;
    case 2: return 0xA2;
    case 3: return 0x00;
    case 4: return 0x60;
    }
    return (BYTE)(p * 0x9D) ^ (BYTE)((BYTE)o * 0x3B) ^ (BYTE)((BYTE)(o >> 8) * 0x55);
}

/* Bytes 5-$1FFF of the 8K at hi * 256 that differ from page p's */
static WORD count_bad(BYTE p, BYTE hi)
{
    const BYTE *q;
    BYTE bm = (BYTE)(p * 0x9D), hm, acc, lo, j;
    WORD n = 0;

    for (j = 0; j < 0x20; ++j) {
        hm  = bm ^ (BYTE)(j * 0x55);
        lo  = j ? 0 : 5;
        acc = lo * 0x3B;
        q   = (const BYTE *)(((WORD)(hi + j) << 8) | lo);
        do {
            if (*q != (BYTE)(hm ^ acc))
                ++n;
            ++q;
            acc += 0x3B;
        } while (++lo);
    }
    return n;
}

static WORD rnd = 0xACE1;

static BYTE next_page(void)
{
    BYTE p;
    do {
        rnd = (rnd >> 1) ^ (-(rnd & 1) & 0xB400);
        p = (BYTE)rnd & 63;
    } while (p >= PAGES);
    return p;
}

static DWORD passes, pages;
static WORD data_err, code_err, dma_err;

static void show_counts(void)
{
    hex(18, 6, passes, 8);
    hex(18, 7, pages, 8);
    hex(18, 9, data_err, 4);
    hex(18, 10, code_err, 4);
    hex(18, 11, dma_err, 4);
}

/* A bad page p at hi * 256 (block blk summed): work out everything, then
 * show it */
static void show_bad(BYTE p, BYTE hi, BYTE blk, WORD sum)
{
    BYTE has = *(const BYTE *)(((WORD)hi << 8) + 1);
    WORD bad = count_bad(p, hi);
    WORD diff = count_bad(has & 63, hi);

    hex(18, 13, p, 2);
    hex(18, 14, sum, 4);
    hex(23, 14, SUMS[8 * p + blk], 4);
    hex(18, 15, bad, 4);
    hex(18, 16, has, 2);
    hex(23, 16, diff, 4);
}

/* Page p at $8000 (window 0, R6) or $A000 (R7) */
static void test_page(BYTE p, BYTE window)
{
    BYTE hi = window ? 0xA0 : 0x80, blk = (BYTE)passes & 7, r;
    WORD sum, want_sum;

    mmc3(window ? 7 : 6, p);
    sum = page_sum(hi + 4 * blk);
    want_sum = SUMS[8 * p + blk];
    r = page_call(hi);
    ++pages;
    if (sum != want_sum || r != p) {
        if (sum != want_sum)
            ++data_err;
        if (r != p)
            ++code_err;
        show_bad(p, hi, blk, sum);
    }
}

/* Sprite DMA from 8 random pages at $C000 (PRG mode 1), screen off */
static void test_dma(void)
{
    BYTE i, k, p, v, bad;
    WORD o;

    wait_vblank();
    PPUMASK = 0;
    for (i = 0; i < 8; ++i) {
        p = next_page();
        k = (BYTE)rnd & 31;             /* 256-byte block */
        mmc3(0x46, p);                  /* PRG mode 1: R6 at $C000 */
        OAMADDR = 0;
        OAMDMA = 0xC0 + k;
        mmc3(0x06, 0);                  /* back to mode 0 */
        bad = 0;
        for (o = 0; o < 256; ++o) {
            OAMADDR = (BYTE)o;
            v = OAMDATA;
            if (v != (want(p, ((WORD)k << 8) + o) & ((o & 3) == 2 ? 0xE3 : 0xFF)))
                bad = 1;
        }
        if (bad)
            ++dma_err;
    }
    ppu_done();
    wait_vblank();
    PPUMASK = 0x0A;
}

void main(void)
{
    BYTE k, p;

    screen_init();
    for (;;) {
        /* 64 random pages, then all of them */
        for (k = 0; k < 64 + PAGES; ++k) {
            p = k < 64 ? next_page() : k - 64;
            test_page(p, k & 1);
            if ((k & 15) == 0)
                show_counts();
        }
        test_dma();
        ++passes;
        show_counts();
        text(18, 18, (data_err | code_err | dma_err) ? "ERRORS" : "ALL OK");
    }
}
