/* Phoenix ColecoVision ROM cache test (SDCC, Z80).
 *
 * Built twice (mkcart.py):
 *   CACHE1M.ROM  a 1M MegaCart: 64 16K banks; this program is in the last
 *                one, fixed at $8000; a bank is selected at $C000 by reading
 *                $FFC0 + bank.
 *   CACHE2M.SGM  a 2M SGM image: 256 8K pages; this program is page 0,
 *                fixed at $8000; pages are selected at $A000, $C000, $E000
 *                by writing $FFFC, $FFFD, $FFFE.
 *
 * Each 8K ROM page p (the image's 8K page number) starts with LD A,p / RET,
 * and the rest is a pattern of the page and the offset.  $9000 has the
 * 16-bit sum of each 1K block of each page.  The core keeps 480K of the
 * image in the SRAM and reads the rest from the SD card, so most pages
 * here come through the ROM cache.
 *
 * The test maps random pages, then all of them, sums a 1K block of each
 * (the pass picks which: eight passes check every byte) and calls its code.
 * It counts and shows the errors, and for the last bad page which page's
 * data it had (HAS) and how many bytes differ from that page (DIFF: 0000
 * means a whole other page).  It runs until reset.
 */

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned long DWORD;

__sfr __at 0xBE VDP_DATA;
__sfr __at 0xBF VDP_CTRL;

#define MEM(a) (*(volatile BYTE *)(a))
#define SUMS ((const WORD *)0x9000)     /* page p's 1K block b at SUMS[8p + b] */

#ifdef SGM
#define TITLE   "2M SGM, 256 8K PAGES"
#define FIRST   1                       /* page 0 is this program */
#define PAGES   256
#else
#define TITLE   "1M MEGACART, 64 BANKS"
#define FIRST   0
#define PAGES   126                     /* 126, 127: the fixed bank */
#endif

extern const BYTE font[];               /* font.c: ASCII 32-122 */
WORD page_sum(WORD addr, WORD len);
BYTE page_call(WORD addr);

static void vdp_reg(BYTE r, BYTE v)
{
    VDP_CTRL = v;
    VDP_CTRL = 0x80 | r;
}

static void vdp_addr(WORD a)
{
    VDP_CTRL = (BYTE)a;
    VDP_CTRL = (BYTE)(a >> 8) | 0x40;
}

/* Graphics I: names at $1800, colours $2000, patterns $0000 */
static void put(BYTE col, BYTE row, const char *s)
{
    vdp_addr(0x1800 + (WORD)row * 32 + col);
    while (*s)
        VDP_DATA = *s++;
}

static const char hexd[] = "0123456789ABCDEF";

static void hex(BYTE col, BYTE row, DWORD v, BYTE digits)
{
    char s[9];
    BYTE i;
    for (i = 0; i < digits; ++i) {
        s[digits - 1 - i] = hexd[(BYTE)v & 15];
        v >>= 4;
    }
    s[digits] = 0;
    put(col, row, s);
}

static void screen_init(void)
{
    const BYTE *f = font;
    WORD i;

    vdp_reg(1, 0x80);                   /* 16K, display off */
    vdp_reg(0, 0x00);
    vdp_reg(2, 0x06);
    vdp_reg(3, 0x80);
    vdp_reg(4, 0x00);
    vdp_reg(5, 0x36);
    vdp_reg(6, 0x07);
    vdp_reg(7, 0xF4);
    vdp_addr(0x0000);
    for (i = 0; i < 32 * 8; ++i)
        VDP_DATA = 0;
    for (i = 0; i < 91 * 8; ++i)
        VDP_DATA = *f++;
    vdp_addr(0x2000);
    for (i = 0; i < 32; ++i)
        VDP_DATA = 0xF4;                /* white on dark blue */
    vdp_addr(0x1800);
    for (i = 0; i < 768; ++i)
        VDP_DATA = ' ';
    vdp_addr(0x1B00);
    VDP_DATA = 0xD0;                    /* no sprites */
    put(2, 1, "PHOENIX COLECO CACHE TEST");
    put(2, 2, TITLE);
    put(2, 5, "PASSES");
    put(2, 6, "PAGES");
    put(2, 8, "DATA ERRORS");
    put(2, 9, "CODE ERRORS");
    put(2, 11, "LAST BAD PAGE");
    put(2, 12, "  SUM / WANT");
    put(2, 13, "  BAD BYTES");
    put(2, 14, "  HAS / DIFF");
    put(2, 16, "STATUS");
    vdp_reg(1, 0xC0);                   /* display on */
}

/* Bytes 3-$1FFF of the 8K at addr that differ from page p's (on a
 * MegaCart the last 64 bytes at $E000 are not read: reading $FFC0-$FFFF
 * switches the bank) */
static WORD count_bad(BYTE p, WORD addr)
{
    const BYTE *q;
    BYTE bm = (BYTE)(p * 0x9D), hm, acc, lo, j;
    WORD n = 0;

    for (j = 0; j < 0x20; ++j) {
        hm  = bm ^ (BYTE)(j * 0x55);
        lo  = j ? 0 : 3;
        acc = lo * 0x3B;
        q   = (const BYTE *)(addr + ((WORD)j << 8) + lo);
        do {
#ifndef SGM
            if (addr == 0xE000 && j == 0x1F && lo >= 0xC0)
                break;
#endif
            if (*q != (BYTE)(hm ^ acc))
                ++n;
            ++q;
            acc += 0x3B;
        } while (++lo);
    }
    return n;
}

static WORD rnd;

static BYTE next_page(void)
{
    WORD p;
    do {
        rnd = (rnd >> 1) ^ (-(rnd & 1) & 0xB400);
        p = rnd & 0xFF;
    } while (p < FIRST || p >= PAGES);
    return (BYTE)p;
}

static DWORD passes, pages;
static WORD data_err, code_err;

static void show_counts(void)
{
    hex(17, 5, passes, 8);
    hex(17, 6, pages, 8);
    hex(17, 8, data_err, 4);
    hex(17, 9, code_err, 4);
}

/* Map page p; its address */
static WORD map_page(BYTE p, BYTE k)
{
#ifdef SGM
    BYTE w = k % 3;                     /* $A000, $C000, $E000 */
    MEM(0xFFFC + w) = p;
    return 0xA000 + ((WORD)w << 13);
#else
    (void)k;
    MEM(0xFFC0 + (p >> 1));             /* reading selects the bank */
    return (p & 1) ? 0xE000 : 0xC000;
#endif
}

static void test_page(BYTE p, BYTE k)
{
    WORD addr = map_page(p, k), sum, want_sum, len = 1024;
    BYTE blk = (BYTE)passes & 7, r, has;

#ifndef SGM
    if (addr == 0xE000 && blk == 7)
        len = 1024 - 64;                /* not $FFC0-$FFFF */
#endif
    sum = page_sum(addr + ((WORD)blk << 10), len);
    want_sum = SUMS[8 * (WORD)p + blk];
    r = page_call(addr);
    ++pages;
    if (sum != want_sum || r != p) {
        if (sum != want_sum)
            ++data_err;
        if (r != p)
            ++code_err;
        /* work everything out, then show it */
        has = MEM(addr + 1);
        hex(17, 11, p, 2);
        hex(17, 12, sum, 4);
        hex(22, 12, want_sum, 4);
        hex(17, 13, count_bad(p, addr), 4);
        hex(17, 14, has, 2);
        hex(22, 14, count_bad(has, addr), 4);
    }
}

void main(void)
{
    WORD k;

    rnd = 0xACE1;
    passes = pages = 0;
    data_err = code_err = 0;
    screen_init();
    for (;;) {
        /* 128 random pages, then all of them */
        for (k = 0; k < 128 + PAGES - FIRST; ++k) {
            test_page(k < 128 ? next_page() : (BYTE)(k - 128 + FIRST), (BYTE)k);
            if ((k & 15) == 0)
                show_counts();
        }
        ++passes;
        show_counts();
        put(17, 16, (data_err | code_err) ? "ERRORS" : "ALL OK");
    }
}
