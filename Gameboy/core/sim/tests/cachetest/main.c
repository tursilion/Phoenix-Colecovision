/* Phoenix Game Boy ROM cache test (SDCC, sm83).
 *
 * A 2M MBC5 cartridge (mkcache.py): each 16K bank n (1-127) is two 8K
 * pages.  Each page starts with LD A,n / RET (n | $80 in the second
 * half), and the rest is a pattern of the bank and the offset.  Bank 0
 * has this program and, at $3000, the 16-bit byte sum of each 1K block of
 * each page.  Each visit sums one block of the page (the pass picks
 * which), so eight passes check every byte.
 *
 * The test maps random banks, then all of them in order, sums both pages
 * and calls their code.  On a Game Boy Color it also copies 16-byte blocks
 * from random banks to the video RAM with the GBC's DMA (with the LCD
 * off), which makes the ROM cache freeze the Game Boy instead of holding
 * the CPU.  It counts and shows the errors, and for the last bad page the
 * page whose data it had (HAS) and how many bytes differ from that page
 * (DIFF): 0000 means a whole other page.  It runs until reset.
 */

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned long DWORD;

#define REG(a) (*(volatile BYTE *)(a))
#define LCDC  REG(0xFF40)
#define LY    REG(0xFF44)
#define BGP   REG(0xFF47)
#define VBK   REG(0xFF4F)
#define HDMA1 REG(0xFF51)
#define HDMA2 REG(0xFF52)
#define HDMA3 REG(0xFF53)
#define HDMA4 REG(0xFF54)
#define HDMA5 REG(0xFF55)
#define BCPS  REG(0xFF68)
#define BCPD  REG(0xFF69)

#define SUMS ((const WORD *)0x3000)     /* page p's 1K block b's sum at SUMS[8p + b] */
#define BANKS 128

extern const BYTE font[];               /* font.c: ASCII 32-122 */
WORD page_sum(BYTE hi);
BYTE page_call(BYTE hi);

BYTE boot_a;                            /* crt0: $11 on a Game Boy Color */

static void wait_vbl(void)
{
    while (LY != 144)
        ;
}

static void put(BYTE col, BYTE row, const char *s)
{
    volatile BYTE *p = (volatile BYTE *)(0x9800 + (WORD)row * 32 + col);
    while (*s)
        *p++ = *s++;
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
    wait_vbl();
    put(col, row, s);
}

static void screen_init(void)
{
    volatile BYTE *p;
    const BYTE *f = font;
    WORD i;

    wait_vbl();
    LCDC = 0;
    for (p = (volatile BYTE *)(0x8000 + 32 * 16), i = 0; i < 91 * 8; ++i) {
        *p++ = *f;
        *p++ = *f++;
    }
    for (p = (volatile BYTE *)0x9800, i = 0; i < 0x400; ++i)
        *p++ = ' ';
    BGP = 0xFC;                         /* 0 white, 3 black */
    BCPS = 0x80;
    BCPD = 0xFF; BCPD = 0x7F;           /* white */
    BCPD = 0x00; BCPD = 0x00;
    BCPD = 0x00; BCPD = 0x00;
    BCPD = 0x00; BCPD = 0x00;           /* black */
    put(1, 0, "GB CACHE TEST");
    put(1, 1, boot_a == 0x11 ? "GBC, 2M MBC5" : "GB, 2M MBC5");
    put(0, 3, "PASSES");
    put(0, 4, "PAGES");
    put(0, 6, "DATA ERR");
    put(0, 7, "CODE ERR");
    put(0, 8, "DMA ERR");
    put(0, 10, "LAST BAD");
    put(0, 11, "SUM/WANT");
    put(0, 12, "BAD BYTES");
    put(0, 13, "HAS/DIFF");
    put(0, 15, "STATUS");
    LCDC = 0x91;
}

/* The byte at offset o (0-$1FFF) of page p */
static BYTE want(BYTE p, WORD o)
{
    BYTE n = p >> 1, hhi = ((p & 1) << 5) | (BYTE)(o >> 8);
    if (o == 0) return 0x3E;
    if (o == 1) return (p & 1) ? n | 0x80 : n;
    if (o == 2) return 0xC9;
    return (BYTE)(n * 0x9D) ^ (BYTE)((BYTE)o * 0x3B) ^ (BYTE)(hhi * 0x55);
}

/* Bytes 3-$1FFF of the 8K at hi * 256 that differ from page p's */
static WORD count_bad(BYTE p, BYTE hi)
{
    const BYTE *q = (const BYTE *)((WORD)hi << 8);
    BYTE bm = (BYTE)((p >> 1) * 0x9D), hm, acc, lo, j;
    WORD n = 0;

    for (j = 0; j < 0x20; ++j) {
        hm  = bm ^ (BYTE)(((BYTE)((p & 1) << 5) | j) * 0x55);
        lo  = j ? 0 : 3;
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

static WORD rnd;                        /* (crt0 does not initialize data) */

static BYTE next_bank(void)
{
    BYTE b;
    do {
        rnd = (rnd >> 1) ^ (-(rnd & 1) & 0xB400);
        b = (BYTE)rnd & (BANKS - 1);
    } while (b == 0);
    return b;
}

static void bank(BYTE b)
{
    REG(0x2000) = b;
    REG(0x3000) = 0;
}

static DWORD passes, pages;
static WORD data_err, code_err, dma_err;

static void show_counts(void)
{
    hex(10, 3, passes, 8);
    hex(10, 4, pages, 8);
    hex(10, 6, data_err, 4);
    hex(10, 7, code_err, 4);
    hex(10, 8, dma_err, 4);
}

/* A bad page p, mapped at hi * 256 (block blk summed): work out
 * everything, then show it */
static void show_bad(BYTE p, BYTE hi, BYTE blk, WORD sum)
{
    BYTE has = *(const BYTE *)(((WORD)hi << 8) + 1);
    BYTE hp = (BYTE)(((has & 0x7F) << 1) | (has >> 7));
    WORD bad = count_bad(p, hi);
    WORD diff = count_bad(hp, hi);

    hex(10, 10, p, 2);
    hex(10, 11, sum, 4);
    hex(15, 11, SUMS[8 * p + blk], 4);
    hex(10, 12, bad, 4);
    hex(10, 13, hp, 2);
    hex(15, 13, diff, 4);
}

/* Both pages of bank b */
static void test_bank(BYTE b)
{
    BYTE half, hi, p, r, blk = (BYTE)passes & 7;
    WORD sum, want_sum;

    bank(b);
    for (half = 0; half < 2; ++half) {
        hi = half ? 0x60 : 0x40;
        p = (b << 1) | half;
        sum = page_sum(hi + 4 * blk);
        want_sum = SUMS[8 * p + blk];
        r = page_call(hi);
        ++pages;
        if (sum != want_sum || r != (half ? (b | 0x80) : b)) {
            if (sum != want_sum)
                ++data_err;
            if (r != (half ? (b | 0x80) : b))
                ++code_err;
            show_bad(p, hi, blk, sum);
        }
    }
}

/* GBC: 16 random 16-byte blocks from the ROM to $8800 by general DMA */
static void test_dma(void)
{
    volatile BYTE *v;
    BYTE i, j, b, bad;
    WORD o, src;

    wait_vbl();
    LCDC = 0;
    VBK = 0;
    for (i = 0; i < 16; ++i) {
        b = next_bank();
        o = rnd & 0x3FF0;
        src = 0x4000 + o;
        bank(b);
        HDMA1 = (BYTE)(src >> 8);
        HDMA2 = (BYTE)src;
        HDMA3 = 0x08;                   /* $8800 */
        HDMA4 = 0x00;
        HDMA5 = 0x00;                   /* 16 bytes, general DMA */
        bad = 0;
        for (v = (volatile BYTE *)0x8800, j = 0; j < 16; ++j)
            if (*v++ != want((b << 1) | (BYTE)(o >> 13), (o & 0x1FFF) + j))
                bad = 1;
        if (bad)
            ++dma_err;
    }
    LCDC = 0x91;
}

void main(void)
{
    BYTE k, b;

    rnd = 0xACE1;
    passes = pages = 0;
    data_err = code_err = dma_err = 0;
    screen_init();
    for (;;) {
        /* 64 random banks, then all banks in order */
        for (k = 0; k < 64 + BANKS - 1; ++k) {
            b = k < 64 ? next_bank() : k - 63;
            test_bank(b);
            if ((k & 15) == 0)
                show_counts();
        }
        if (boot_a == 0x11)
            test_dma();
        ++passes;
        show_counts();
        wait_vbl();
        put(10, 15, (data_err | code_err | dma_err) ? "ERRORS" : "ALL OK");
    }
}
