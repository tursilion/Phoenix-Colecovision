/* Phoenix Time Pilot '84 core: boot loader.
 *
 * Loads the MAME ROM files of Time Pilot '84 from the SD card into the
 * core and starts the game.  The files are looked for in the folders TP84
 * and TP84A, then in the root, under the names of the tp84 (set 1) or
 * tp84a (set 2) ROM sets.  Runs on the sound Z80.
 */

#include <string.h>
#include "pff/pff.h"
#include "pff/diskio.h"
#include "phoenix.h"
#include "loader.h"

/* One ROM: where it goes (load address, see rtl/tp84_phoenix.v), its
 * size, and its names in the two sets (or 0). */
struct rom {
    unsigned long addr;
    unsigned int  size;
    const char   *name1;            /* tp84 */
    const char   *name2;            /* tp84a */
};

static const struct rom roms[] = {
    { 0x00000UL, 0x2000, "388_F04.7J",  0             },    /* main CPU */
    { 0x02000UL, 0x2000, "388_05.8J",   "388_F05.8J"  },
    { 0x04000UL, 0x2000, "388_F06.9J",  0             },
    { 0x06000UL, 0x2000, "388_07.10J",  "388_F07.10J" },
    { 0x08000UL, 0x2000, "388_F08.10D", 0             },    /* sub CPU */
    { 0x0C000UL, 0x2000, "388J13.6A",   0             },    /* sound CPU */
    { 0x10000UL, 0x2000, "388_E09.12A", 0             },    /* sprites */
    { 0x12000UL, 0x2000, "388_E10.13A", 0             },
    { 0x14000UL, 0x2000, "388_E11.14A", 0             },
    { 0x16000UL, 0x2000, "388_E12.15A", 0             },
    { 0x18000UL, 0x2000, "388_H02.2J",  0             },    /* tiles */
    { 0x1A000UL, 0x2000, "388_D01.1J",  0             },
    { 0x1C000UL, 0x0100, "388D14.2C",   0             },    /* red */
    { 0x1C100UL, 0x0100, "388D15.2D",   0             },    /* green */
    { 0x1C200UL, 0x0100, "388D16.1E",   0             },    /* blue */
    { 0x1C300UL, 0x0100, "388D18.1F",   0             },    /* tile lookup */
    { 0x1C400UL, 0x0100, "388J17.16C",  "388D17.16C"  },    /* sprite lookup */
};

#define NROMS (sizeof(roms) / sizeof(roms[0]))

static const char *const folders[] = { "TP84/", "TP84A/", "" };

/* DIP switches as the game reads them (MAME defaults for tp84): 1 coin
 * 1 credit, 3 lives, upright, bonus at 20000 and every 60000, hard (the
 * US default), demo sounds on. */
#define DSW1 0xFF
#define DSW2 0x32

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
    text(1, 25, "TP84 OR TP84A.", 0);
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
        if (try_open(folder, r->name1) == FR_OK ||
            try_open(folder, r->name2) == FR_OK)
            return 1;
        return 0;
    }
    for (i = 0; i < sizeof(folders) / sizeof(folders[0]); ++i) {
        if (try_open(folders[i], r->name1) == FR_OK ||
            try_open(folders[i], r->name2) == FR_OK) {
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
    text(6, 1, "TIME PILOT 84 LOADER", 0);

    if (disk_initialize() & STA_NODISK)
        fail(3, "NO SD CARD", 0);
    if (pf_mount(&fs) != FR_OK)
        fail(3, "CANNOT READ THE SD CARD", 0);

    row = 3;
    for (i = 0; i < NROMS; ++i) {
        r = &roms[i];
        text(2, row, r->name1, 0);
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
    PH_START = 1;
    for (;;)
        ;
}
