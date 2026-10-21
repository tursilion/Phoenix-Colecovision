/* Phoenix Gyruss core: boot loader.
 *
 * Loads the MAME ROM files of Gyruss from the SD card into the core and
 * starts the game.  The files are looked for in the folders GYRUSSCE and
 * GYRUSS, then in the root, under the names of the gyrussce (Centuri) or
 * the gyruss (Konami) ROM set.
 */

#include <string.h>
#include "pff/pff.h"
#include "pff/diskio.h"
#include "phoenix.h"
#include "loader.h"

/* One ROM: where it goes (load address, see rtl/gyruss_phoenix.v), its
 * size, and its names in the two sets. */
struct rom {
    unsigned long addr;
    unsigned int  size;
    const char   *name_ce;          /* gyrussce */
    const char   *name_k;           /* gyruss */
};

static const struct rom roms[] = {
    { 0x00000UL, 0x2000, "GYA-1.11J",   "GYRUSSK.1"   },    /* main CPU */
    { 0x02000UL, 0x2000, "GYA-2.12J",   "GYRUSSK.2"   },
    { 0x04000UL, 0x2000, "GYA-3.13J",   "GYRUSSK.3"   },
    { 0x08000UL, 0x2000, "GY-5.19E",    "GYRUSSK.9"   },    /* KONAMI-1 */
    { 0x0A000UL, 0x1000, "GY-13.11H",   "GYRUSSK.3A"  },    /* 8039 */
    { 0x0C000UL, 0x2000, "GY-11.7A",    "GYRUSSK.1A"  },    /* sound CPU */
    { 0x0E000UL, 0x2000, "GY-12.8A",    "GYRUSSK.2A"  },
    { 0x10000UL, 0x2000, "GY-10.9D",    "GYRUSSK.6"   },    /* sprites */
    { 0x12000UL, 0x2000, "GY-9.8D",     "GYRUSSK.5"   },
    { 0x14000UL, 0x2000, "GY-8.7D",     "GYRUSSK.8"   },
    { 0x16000UL, 0x2000, "GY-7.6D",     "GYRUSSK.7"   },
    { 0x18000UL, 0x2000, "GY-6.1G",     "GYRUSSK.4"   },    /* tiles */
    { 0x1A000UL, 0x0020, "GYRUSSK.PR3", 0             },    /* palette */
    { 0x1A100UL, 0x0100, "GYRUSSK.PR1", 0             },    /* sprite lookup */
    { 0x1A200UL, 0x0100, "GYRUSSK.PR2", 0             },    /* tile lookup */
};

#define NROMS (sizeof(roms) / sizeof(roms[0]))

static const char *const folders[] = { "GYRUSSCE/", "GYRUSS/", "" };

/* DIP switches as the game reads them (MAME defaults for gyruss):
 * 1 coin 1 credit, 3 lives, upright, average difficulty, demo sounds and
 * music on. */
#define DSW1 0xFF
#define DSW2 0x3B
#define DSW3 0xFE

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
    text(1, 25, "GYRUSSCE OR GYRUSS.", 0);
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

/* Open a ROM in the current folder, or find the folder first. */
static BYTE open_rom(const struct rom *r)
{
    BYTE i;

    if (folder) {
        if (try_open(folder, r->name_ce) == FR_OK ||
            try_open(folder, r->name_k) == FR_OK)
            return 1;
        return 0;
    }
    for (i = 0; i < sizeof(folders) / sizeof(folders[0]); ++i) {
        if (try_open(folders[i], r->name_ce) == FR_OK ||
            try_open(folders[i], r->name_k) == FR_OK) {
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
    text(9, 1, "GYRUSS LOADER", 0);

    if (disk_initialize() & STA_NODISK)
        fail(3, "NO SD CARD", 0);
    if (pf_mount(&fs) != FR_OK)
        fail(3, "CANNOT READ THE SD CARD", 0);

    row = 3;
    for (i = 0; i < NROMS; ++i) {
        r = &roms[i];
        text(2, row, r->name_ce, 0);
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

    PH_DSW1 = DSW1;
    PH_DSW2 = DSW2;
    PH_DSW3 = DSW3;
    PH_START = 1;
    for (;;)
        ;
}
