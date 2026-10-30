/* Phoenix PC Engine ROM cache test (cc65, HuC6280).
 *
 * A 1M HuCard (mkcache.py): bank 0 is this program, banks 1-127 each start
 * with LDA #bank / RTS and then a pattern of the bank number, and the
 * table at $FE00 has each bank's 16-bit byte sum.  The test maps random
 * banks at $4000, sums all 8K and calls the routine at its start, and
 * writes and reads back a block of video RAM.  It counts and shows the
 * errors, and the last bad bank.  It runs until reset.
 */

#include <string.h>

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned long DWORD;

extern const BYTE font[];               /* ASCII 32-122, 8 bytes each */
WORD __fastcall__ page_sum(BYTE page);
BYTE __fastcall__ page_call(BYTE page);

#define REG(a) (*(volatile BYTE *)(a))
#define VDC_AR  REG(0x0200)             /* mirror: $0000 would be zero page */
#define VDC_SR  REG(0x0200)
#define VDC_LO  REG(0x0202)
#define VDC_HI  REG(0x0203)
#define VCE_CR  REG(0x0400)
#define VCE_ALO REG(0x0402)
#define VCE_AHI REG(0x0403)
#define VCE_DLO REG(0x0404)
#define VCE_DHI REG(0x0405)

#define SUMS ((const WORD *)0xFE00)     /* bank n's sum at SUMS[n] */
#define BANKS 128

static void vdc(BYTE reg, WORD val)
{
    VDC_AR = reg;
    VDC_LO = (BYTE)val;
    VDC_HI = (BYTE)(val >> 8);
}

static void text(BYTE col, BYTE row, const char *s)
{
    vdc(0, (WORD)row * 32 + col);
    VDC_AR = 2;
    while (*s) {
        VDC_LO = *s++;
        VDC_HI = 0x01;
    }
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
    text(col, row, s);
}

static void screen_init(void)
{
    const BYTE *f = font;
    BYTE c, i, r;

    vdc(5, 0x0000);
    vdc(9, 0x0000);
    vdc(10, 0x0202);
    vdc(11, 0x031F);
    vdc(12, 0x0F02);
    vdc(13, 0x00EF);
    vdc(14, 0x0003);
    vdc(7, 0);
    vdc(8, 0);
    VCE_CR = 0;

    vdc(0, 0x1000 + 32 * 16);
    VDC_AR = 2;
    for (c = 32; c <= 122; ++c) {
        for (i = 0; i < 8; ++i) { VDC_LO = *f++; VDC_HI = 0; }
        for (i = 0; i < 8; ++i) { VDC_LO = 0; VDC_HI = 0; }
    }
    for (r = 0; r < 32; ++r)
        text(0, r, "                                ");

    VCE_ALO = 0; VCE_AHI = 0;
    VCE_DLO = 0x40; VCE_DHI = 0x00;     /* dark green */
    VCE_DLO = 0xFF; VCE_DHI = 0x01;     /* white */
    vdc(5, 0x0080);
}

/* Video RAM block at $2000-$23FF: write a pattern, read it back */
static WORD vram_test(BYTE seed)
{
    WORD i, bad = 0;
    BYTE lo, hi;

    vdc(0, 0x2000);
    VDC_AR = 2;
    for (i = 0; i < 1024; ++i) {
        VDC_LO = (BYTE)(i + seed);
        VDC_HI = (BYTE)((i >> 8) ^ seed ^ 0x5A);
    }
    vdc(1, 0x2000);                     /* MARR */
    VDC_AR = 2;
    for (i = 0; i < 1024; ++i) {
        lo = VDC_LO;
        hi = VDC_HI;
        if (lo != (BYTE)(i + seed) || hi != (BYTE)((i >> 8) ^ seed ^ 0x5A))
            ++bad;
    }
    return bad;
}

/* The byte at offset o of bank b (mkcache.py) */
static BYTE want(BYTE b, WORD o)
{
    if (o == 0) return 0xA9;
    if (o == 1) return b;
    if (o == 2) return 0x60;
    return (BYTE)((b * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55));
}

/* Bytes of the bank mapped at $4000 that differ from bank b's (offsets 0-2
 * are the same in every bank: not checked).  The first difference goes to
 * *first and *got. */
static WORD count_bad(BYTE b, WORD *first, BYTE *got)
{
    const BYTE *p = (const BYTE *)0x4003;
    BYTE bm = b * 0x9D, hm, acc, hi, lo, w;
    WORD n = 0;

    for (hi = 0; hi < 0x20; ++hi) {
        hm  = bm ^ (BYTE)(hi * 0x55);
        lo  = hi ? 0 : 3;
        acc = lo * 0x3B;
        do {
            w = hm ^ acc;
            if (*p != w) {
                if (!n && first) { *first = ((WORD)hi << 8) | lo; *got = *p; }
                ++n;
            }
            ++p;
            acc += 0x3B;
        } while (++lo);
    }
    return n;
}

/* Show bank b's bad bytes: the first one, how many, which bank's data it
 * has (byte 1 of each bank is its number) and how many bytes differ from
 * that bank's.  All lines are written together. */
static void find_bad(BYTE b, WORD sum)
{
    WORD first = 0, n, n2;
    BYTE got = 0, g;

    page_sum(b);                        /* maps it */
    g  = *(const BYTE *)0x4001;
    n  = count_bad(b, &first, &got);
    n2 = (g & 0x80) ? 0xFFFF : count_bad(g, 0, 0);
    hex(17, 13, b, 2);
    hex(17, 14, sum, 4);
    hex(22, 14, SUMS[b], 4);
    hex(17, 15, first, 4);
    hex(22, 15, got, 2);
    hex(25, 15, want(b, first), 2);
    hex(17, 16, n, 4);
    hex(17, 17, g, 2);
    hex(22, 17, n2, 4);
}

static WORD rnd = 0xACE1;

static BYTE next_bank(void)
{
    BYTE b;
    do {
        rnd = (rnd >> 1) ^ (-(rnd & 1) & 0xB400);
        b = (BYTE)rnd & (BANKS - 1);
    } while (b == 0);
    return b;
}

void main(void)
{
    DWORD passes = 0, pages = 0;
    WORD data_err = 0, code_err = 0, vram_err = 0, sum, v;
    BYTE b, k, r;

    screen_init();
    text(2, 1, "PHOENIX PC ENGINE CACHE TEST");
    text(2, 3, "1M ROM, 128 BANKS, 56 IN SRAM");
    text(2, 6, "PASSES");
    text(2, 7, "BANKS READ");
    text(2, 9, "DATA ERRORS");
    text(2, 10, "CODE ERRORS");
    text(2, 11, "VRAM ERRORS");
    text(2, 13, "LAST BAD BANK");
    text(2, 14, "  SUM / WANT");
    text(2, 15, "  1ST/GOT/WANT");
    text(2, 16, "  BAD BYTES");
    text(2, 17, "  HAS BANK/DIFF");
    text(2, 19, "STATUS");

    for (;;) {
        /* 64 random banks, then all banks in order */
        for (k = 0; k < 64 + BANKS; ++k) {
            b = k < 64 ? next_bank() : k - 64;
            if (b == 0)
                continue;
            sum = page_sum(b);
            r = page_call(b);
            ++pages;
            if (sum != SUMS[b] || r != b) {
                if (sum != SUMS[b])
                    ++data_err;
                if (r != b)
                    ++code_err;
                find_bad(b, sum);
            }
            if ((k & 7) == 0) {
                hex(17, 7, pages, 8);
                hex(17, 9, data_err, 4);
                hex(17, 10, code_err, 4);
            }
        }
        v = vram_test((BYTE)passes);
        vram_err += v;
        ++passes;
        hex(17, 6, passes, 8);
        hex(17, 7, pages, 8);
        hex(17, 9, data_err, 4);
        hex(17, 10, code_err, 4);
        hex(17, 11, vram_err, 4);
        text(17, 19, (data_err | code_err | vram_err) ? "ERRORS " : "ALL OK ");
    }
}
