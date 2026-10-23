/* Phoenix Galaga core: boot loader.
 *
 * Loads the MAME ROM files of Galaga from the SD card into the core and
 * starts the game.  The files are looked for in the folders GALAGA,
 * GALAGAO and GALAGAMW, then in the root, under the names of the galaga
 * (Namco rev. B), galagao (Namco) or galagamw (Midway) ROM sets.  Runs on
 * the main Z80.
 */

#include <string.h>
#include "pff/pff.h"
#include "pff/diskio.h"
#include "phoenix.h"
#include "loader.h"

/* One ROM: where it goes (load address, see rtl/galaga_phoenix.v), its
 * size, and its names in the three sets (or 0). */
struct rom {
    unsigned long addr;
    unsigned int  size;
    const char   *name[3];          /* galaga, galagao, galagamw */
};

static const struct rom roms[] = {
    { 0x00000UL, 0x1000, { "GG1_1B.3P",  "GG1-1.3P",  "3200A.BIN" } },   /* main CPU */
    { 0x01000UL, 0x1000, { "GG1_2B.3M",  "GG1-2.3M",  "3300B.BIN" } },
    { 0x02000UL, 0x1000, { "GG1_3.2M",   "GG1-3.2M",  "3400C.BIN" } },
    { 0x03000UL, 0x1000, { "GG1_4B.2L",  "GG1-4.2L",  "3500D.BIN" } },
    { 0x04000UL, 0x1000, { "GG1_5B.3F",  "GG1-5.3F",  "3600E.BIN" } },   /* sub CPU */
    { 0x05000UL, 0x1000, { "GG1_7B.2C",  "GG1-7.2C",  "3700G.BIN" } },   /* sound CPU */
    { 0x10000UL, 0x1000, { "GG1_9.4L",   "GG1-9.4L",  "2600J.BIN" } },   /* tiles */
    { 0x12000UL, 0x1000, { "GG1_11.4D",  "GG1-11.4D", "2800L.BIN" } },   /* sprites */
    { 0x13000UL, 0x1000, { "GG1_10.4F",  "GG1-10.4F", "2700K.BIN" } },
    { 0x14000UL, 0x0400, { "51XX.BIN",   0,           0           } },   /* 51xx */
    { 0x14400UL, 0x0400, { "54XX.BIN",   0,           0           } },   /* 54xx */
    { 0x15000UL, 0x0020, { "PROM-5.5N",  0,           0           } },   /* palette */
    { 0x15100UL, 0x0100, { "PROM-4.2N",  0,           0           } },   /* tile lookup */
    { 0x15200UL, 0x0100, { "PROM-3.1C",  0,           0           } },   /* sprite lookup */
    { 0x15300UL, 0x0100, { "PROM-1.1D",  0,           0           } },   /* sound */
};

#define NROMS (sizeof(roms) / sizeof(roms[0]))

static const char *const folders[] = { "GALAGA/", "GALAGAO/", "GALAGAMW/", "" };

/* DIP switches as the game reads them (MAME defaults for galaga): easy,
 * demo sounds on, upright; 1 coin 1 credit, bonus at 20000, 70000 and
 * every 70000, 3 lives. */
#define DSWA 0xF7
#define DSWB 0x97

static FATFS fs;
static char path[32];
static const char *folder;

/* ------------------------------------------------------------------------ */
/* Text */

static void text(BYTE col, BYTE row, const char *s, BYTE attr)
{
    volatile BYTE *p = PH_TEXT + (WORD)row * TEXT_COLS + col;
    while (*s && col < TEXT_COLS) {
        *p++ = *s++ | attr;
        ++col;
    }
}

static void cls(void)
{
    volatile BYTE *p = PH_TEXT;
    WORD n;
    for (n = 0; n < TEXT_COLS * TEXT_ROWS; ++n)
        *p++ = ' ';
}

static void fail(BYTE row, const char *a, const char *b)
{
    text(2, row, a, 0x80);
    if (b)
        text(2, row + 1, b, 0x80);
    text(1, 23, "PUT THE MAME ROM FILES", 0);
    text(1, 24, "(UNZIPPED) IN A FOLDER", 0);
    text(1, 25, "GALAGA.", 0);
    PH_LED = 1;
    for (;;)
        ;
}

/* ------------------------------------------------------------------------ */

static FRESULT try_open(const char *dir, const char *name)
{
    if (!name)
        return FR_NO_FILE;
    strcpy(path, dir);
    strcat(path, name);
    return pf_open(path);
}

/* Open a ROM under any of its names in one folder. */
static BYTE open_in(const char *dir, const struct rom *r)
{
    BYTE n;

    for (n = 0; n < 3; ++n)
        if (try_open(dir, r->name[n]) == FR_OK)
            return 1;
    return 0;
}

/* Open a ROM in the current folder, or find the folder first. */
static BYTE open_rom(const struct rom *r)
{
    BYTE i;

    if (folder)
        return open_in(folder, r);
    for (i = 0; i < sizeof(folders) / sizeof(folders[0]); ++i) {
        if (open_in(folders[i], r)) {
            folder = folders[i];
            return 1;
        }
    }
    return 0;
}

static void set_load_addr(unsigned long a)
{
    PH_LOAD_A0 = (BYTE)a;
    PH_LOAD_A1 = (BYTE)(a >> 8);
    PH_LOAD_A2 = (BYTE)(a >> 16);
}

void main(void)
{
    BYTE i, row, tries;
    UINT br;
    const char *err;
    const struct rom *r;

    cls();
    text(9, 1, "GALAGA LOADER", 0);

    if (disk_initialize() & STA_NODISK)
        fail(3, "NO SD CARD", 0);
    if (pf_mount(&fs) != FR_OK)
        fail(3, "CANNOT READ THE SD CARD", 0);

    row = 3;
    for (i = 0; i < NROMS; ++i) {
        r = &roms[i];
        text(2, row, r->name[0], 0);
        /* A failed card read can look like a missing file: try 3 times. */
        for (tries = 0; ; ++tries) {
            err = 0;
            if (!open_rom(r))
                err = "NOT FOUND:";
            else if (fs.fsize != r->size)
                err = "WRONG SIZE:";
            else {
                set_load_addr(r->addr);
                if (pf_read(0, r->size, &br) != FR_OK || br != r->size)
                    err = "READ ERROR:";
            }
            if (!err)
                break;
            if (tries == 2)
                fail(row + 1, err, path);
        }
        text(14, row, "OK", 0);
        if (++row == 21)
            row = 3;
    }
    while (PH_LOAD_A0 & 1)          /* last SRAM write */
        ;

    PH_DSWA = DSWA;
    PH_DSWB = DSWB;
    PH_START = 1;
    for (;;)
        ;
}
