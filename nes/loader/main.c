/* Phoenix NES boot loader and menu.
 *
 * Mounts the SD card and shows the folders and *.NES files of the current
 * folder, folders first, sorted by name.  The selected iNES image is
 * checked, sent to the core's ROM loader, and started.
 *
 * Controls: Up/Down move, Left/Right page, A or Start open, B parent folder.
 *
 * In boot mode the core gives the PPU 4K of CHR RAM (both pattern tables)
 * and the CPU 4K of RAM at $6000, used here for the directory listing.
 */

#include <string.h>
#include "pff/pff.h"
#include "phoenix.h"

/* ------------------------------------------------------------------------ */
/* Hardware */

#define PPUCTRL   (*(volatile BYTE *)0x2000)
#define PPUMASK   (*(volatile BYTE *)0x2001)
#define PPUSTATUS (*(volatile BYTE *)0x2002)
#define PPUSCROLL (*(volatile BYTE *)0x2005)
#define PPUADDR   (*(volatile BYTE *)0x2006)
#define PPUDATA   (*(volatile BYTE *)0x2007)
#define JOY1      (*(volatile BYTE *)0x4016)

#define PAD_A      0x01
#define PAD_B      0x02
#define PAD_SELECT 0x04
#define PAD_START  0x08
#define PAD_UP     0x10
#define PAD_DOWN   0x20
#define PAD_LEFT   0x40
#define PAD_RIGHT  0x80

extern const unsigned char font[];     /* ASCII 32-122, 8 bytes each */

/* ------------------------------------------------------------------------ */
/* Directory listing, in the boot RAM at $6000 */

#define MAX_ENTRIES 256

struct entry {
    char name[12];          /* 8.3 name, not terminated if 12 characters */
    BYTE kind;              /* KIND_* */
};

#define KIND_PARENT 0       /* ".." */
#define KIND_DIR    1
#define KIND_FILE   2

#define ENTRIES ((struct entry *)0x6000)    /* 256 x 13 = $0D00 bytes */
#define ORDER   ((BYTE *)0x6D00)            /* sorted entry numbers */

static WORD count;

/* ------------------------------------------------------------------------ */
/* Screen layout (32x30 tiles) */

#define LIST_ROW    3
#define LIST_ROWS   24
#define NAME_COL    3
#define STATUS_ROW  28

#define ERR_NO_CARD     1
#define ERR_MOUNT       2
#define ERR_DIR         3
#define ERR_READ        4
#define ERR_BAD_HEADER  5
#define ERR_TOO_BIG     6
#define ERR_LOAD        7
#define ERR_FRAGMENTED  8

static const char *const errors[] = {
    "",
    "NO SD CARD",
    "CANNOT READ THE SD CARD",
    "CANNOT READ THE FOLDER",
    "READ ERROR",
    "NOT AN INES FILE",
    "TOO BIG (PRG>1M OR CHR>256K)",
    "THE CORE REJECTED THE FILE",
    "FILE FRAGMENTED: COPY IT AGAIN",
};

static FATFS fs;
static DIR dir;
static FILINFO fno;
static char path[80];       /* current folder, "" is the root */
static BYTE hdr[16];
static BYTE buf[64];

/* ------------------------------------------------------------------------ */
/* PPU */

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

static void ppu_at(BYTE col, BYTE row)
{
    ppu_addr(0x2000 + (WORD)row * 32 + col);
}

/* Write a string, then pad with spaces up to column end. */
static void ppu_text(BYTE col, BYTE row, const char *s, BYTE end)
{
    ppu_at(col, row);
    while (*s && col < end) {
        PPUDATA = *s++;
        ++col;
    }
    while (col++ < end)
        PPUDATA = ' ';
}

static void ppu_done(void)
{
    ppu_addr(0);
    PPUSCROLL = 0;
    PPUSCROLL = 0;
}

static void screen_off(void)
{
    wait_vblank();
    PPUMASK = 0;
}

static void screen_on(void)
{
    ppu_done();
    wait_vblank();
    PPUMASK = 0x0A;         /* background, including the leftmost 8 pixels */
}

static void ppu_init(void)
{
    WORD i;
    BYTE t, j;
    const unsigned char *f = font;

    PPUCTRL = 0;
    PPUMASK = 0;
    PPUSTATUS;
    wait_vblank();
    wait_vblank();

    /* CHR RAM: the font as color 1, everything else blank. */
    ppu_addr(0x0000);
    for (t = 0; ; ++t) {
        if (t >= 32 && t <= 122) {
            for (j = 0; j < 8; ++j)
                PPUDATA = *f++;
        } else {
            for (j = 0; j < 8; ++j)
                PPUDATA = 0;
        }
        for (j = 0; j < 8; ++j)
            PPUDATA = 0;
        if (t == 255)
            break;
    }

    /* Palettes: dark blue background, white text. */
    ppu_addr(0x3F00);
    for (j = 0; j < 32; ++j)
        PPUDATA = (j & 3) == 0 ? 0x01 : 0x30;

    /* Name table and attributes */
    ppu_addr(0x2000);
    for (i = 0; i < 1024; ++i)
        PPUDATA = ' ';
    ppu_addr(0x23C0);
    for (j = 0; j < 64; ++j)
        PPUDATA = 0;
}

/* Show a message on the status line, with the screen on.  A whole line
 * takes too long for one vertical blank, so write it 10 columns at a time. */
static void status(const char *s)
{
    char part[11];
    BYTE col, i;

    for (col = 1; col < 31; col += 10) {
        for (i = 0; i < 10; ++i)
            part[i] = *s ? *s++ : ' ';
        part[10] = 0;
        wait_vblank();
        ppu_text(col, STATUS_ROW, part, col + 10);
        ppu_done();
    }
}

/* ------------------------------------------------------------------------ */
/* Controller */

static BYTE read_pad(void)
{
    BYTE i, b = 0;
    JOY1 = 1;
    JOY1 = 0;
    for (i = 0; i < 8; ++i)
        b |= (JOY1 & 1) << i;
    return b;
}

static BYTE pad_last;
static BYTE pad_timer;

/* Newly pressed buttons, with auto-repeat for the directions.  Call once
 * per frame. */
static BYTE pad_pressed(void)
{
    BYTE now = read_pad();
    BYTE pressed = now & ~pad_last;

    if (now & (PAD_UP | PAD_DOWN | PAD_LEFT | PAD_RIGHT)) {
        if (pressed)
            pad_timer = 20;
        else if (--pad_timer == 0) {
            pad_timer = 4;
            pressed |= now & (PAD_UP | PAD_DOWN | PAD_LEFT | PAD_RIGHT);
        }
    }
    pad_last = now;
    return pressed;
}

static void wait_button(void)
{
    BYTE b;
    do {
        wait_vblank();
        b = pad_pressed();
    } while (!(b & (PAD_A | PAD_B | PAD_START)));
}

/* ------------------------------------------------------------------------ */
/* Directory */

/* Is the 8.3 name a .NES file? */
static BYTE is_nes(const char *name)
{
    const char *dot = strchr(name, '.');
    return dot != 0 && strcmp(dot, ".NES") == 0;
}

/* Entry name as a terminated string */
static const char *entry_name(BYTE n)
{
    static char s[14];
    memcpy(s, ENTRIES[n].name, 12);
    s[12] = 0;
    return s;
}

static signed char entry_cmp(BYTE a, BYTE b)
{
    const struct entry *ea = &ENTRIES[a];
    const struct entry *eb = &ENTRIES[b];
    int r;
    if (ea->kind != eb->kind)
        return ea->kind < eb->kind ? -1 : 1;
    r = strncmp(ea->name, eb->name, 12);
    return r < 0 ? -1 : r > 0 ? 1 : 0;
}

/* Shell sort of ORDER[0..count-1] */
static void sort_entries(void)
{
    static const BYTE gaps[] = { 57, 23, 10, 4, 1 };
    BYTE g, gap, t;
    WORD i, j;

    for (g = 0; g < sizeof(gaps); ++g) {
        gap = gaps[g];
        for (i = gap; i < count; ++i) {
            t = ORDER[i];
            for (j = i; j >= gap && entry_cmp(ORDER[j - gap], t) > 0; j -= gap)
                ORDER[j] = ORDER[j - gap];
            ORDER[j] = t;
        }
    }
}

static BYTE read_dir(void)
{
    struct entry *e;

    count = 0;
    if (path[0]) {
        e = &ENTRIES[0];
        memset(e->name, 0, 12);
        memcpy(e->name, "..", 2);
        e->kind = KIND_PARENT;
        ORDER[0] = 0;
        count = 1;
    }

    if (pf_opendir(&dir, path) != FR_OK)
        return 0;
    while (count < MAX_ENTRIES) {
        if (pf_readdir(&dir, &fno) != FR_OK)
            return 0;
        if (fno.fname[0] == 0)
            break;
        if (fno.fname[0] == '.' || (fno.fattrib & (AM_HID | AM_SYS)))
            continue;
        if (!(fno.fattrib & AM_DIR) && !is_nes(fno.fname))
            continue;
        e = &ENTRIES[count];
        memset(e->name, 0, 12);
        memcpy(e->name, fno.fname, strlen(fno.fname));
        e->kind = (fno.fattrib & AM_DIR) ? KIND_DIR : KIND_FILE;
        ORDER[count] = (BYTE)count;
        ++count;
    }
    sort_entries();
    return 1;
}

/* Append a name to, or remove the last name from, the current path. */
static BYTE path_enter(const char *name)
{
    WORD l = strlen(path);
    if (l + 1 + strlen(name) >= sizeof(path))
        return 0;
    path[l] = '/';
    strcpy(path + l + 1, name);
    return 1;
}

static void path_leave(void)
{
    char *p = strrchr(path, '/');
    if (p)
        *p = 0;
    else
        path[0] = 0;
}

/* ------------------------------------------------------------------------ */
/* Menu */

static WORD top, sel;

static void draw_row(BYTE row)
{
    WORD n = top + row;
    char line[16];
    BYTE l;

    if (n < count) {
        strcpy(line, entry_name(ORDER[n]));
        if (ENTRIES[ORDER[n]].kind != KIND_FILE) {
            l = strlen(line);
            line[l] = '/';
            line[l + 1] = 0;
        }
    } else {
        line[0] = 0;
    }
    ppu_text(NAME_COL, LIST_ROW + row, line, 31);
}

static void draw_cursor(char c)
{
    ppu_at(1, LIST_ROW + (BYTE)(sel - top));
    PPUDATA = c;
}

/* Redraw the whole screen, with rendering off. */
static void draw_page(void)
{
    BYTE r;
    char title[32];

    screen_off();
    strcpy(title, "PHOENIX NES  ");
    strncat(title, path[0] ? path : "/", sizeof(title) - 14);
    ppu_text(1, 1, title, 31);
    for (r = 0; r < LIST_ROWS; ++r) {
        ppu_at(1, LIST_ROW + r);
        PPUDATA = ' ';
        draw_row(r);
    }
    if (count)
        draw_cursor('>');
    else
        ppu_text(NAME_COL, LIST_ROW, "NO .NES FILES HERE", 31);
    ppu_text(1, STATUS_ROW, "A:OPEN  B:BACK  L/R:PAGE", 31);
    screen_on();
}

static void show_folder(void)
{
    top = sel = 0;
    if (!read_dir()) {
        count = 0;
        draw_page();
        status(errors[ERR_DIR]);
        return;
    }
    draw_page();
}

/* Move the cursor to n, scrolling by whole pages. */
static void move_to(WORD n)
{
    WORD new_top;

    if (!count)
        return;
    if (n >= count)
        n = count - 1;
    new_top = n - n % LIST_ROWS;
    if (new_top != top) {
        top = new_top;
        sel = n;
        draw_page();
    } else if (n != sel) {
        wait_vblank();
        draw_cursor(' ');
        sel = n;
        draw_cursor('>');
        ppu_done();
    }
}

/* ------------------------------------------------------------------------ */
/* Loading */

/* Size in 8K units, rounded up to a power of two the way the ROM loader
 * does it. */
static WORD pow2_8k(WORD units8k)
{
    WORD n = 1;
    while (n < units8k)
        n <<= 1;
    return n;
}

BYTE disk_block_addr(void);

static DWORD page_arg;

/* pf_pages: PRG page n starts in SD sector sect */
static void set_page(UINT n, DWORD sect)
{
    page_arg = disk_block_addr() ? sect : sect << 9;
    PH_PAGE = (BYTE)n;
    PH_ARG[0] = (BYTE)page_arg;
    PH_ARG[1] = (BYTE)(page_arg >> 8);
    PH_ARG[2] = (BYTE)(page_arg >> 16);
    PH_ARG[3] = (BYTE)(page_arg >> 24);
}

/* Load and start the game; returns an error code if it cannot.
 *
 * SRAM: CHR (or 8K of CHR RAM) at the top, the PRG in the 8K pages below
 * (64 minus the CHR's).  A bigger PRG plays from the core's ROM cache: the
 * core keeps the first pages, and the loader gives it the SD sector of
 * every page (each starts after the header, inside a sector). */
static BYTE load_game(const char *file)
{
    UINT br;
    WORD prg8k, chr8k, n, data_ofs = 16;
    DWORD left;
    BYTE slots;

    if (pf_open(file) != FR_OK)
        return ERR_READ;

    if (pf_read(hdr, 16, &br) != FR_OK || br != 16)
        return ERR_READ;
    if (hdr[0] != 'N' || hdr[1] != 'E' || hdr[2] != 'S' || hdr[3] != 0x1A || hdr[4] == 0)
        return ERR_BAD_HEADER;

    /* Skip a trainer; the ROM loader rejects the flag, and the core does
     * not support trainers anyway. */
    if (hdr[6] & 0x04) {
        for (n = 0; n < 512 / sizeof(buf); ++n)
            if (pf_read(buf, sizeof(buf), &br) != FR_OK || br != sizeof(buf))
                return ERR_READ;
        hdr[6] &= ~0x04;
        data_ofs += 512;
    }

    /* Four-screen mirroring is not supported; the ROM loader rejects it.
     * Try the game anyway. */
    hdr[6] &= ~0x08;

    /* Old iNES dumpers wrote junk into bytes 7-15 ("DiskDude!"), which
     * corrupts the upper mapper nibble.  NES 2.0 headers are left alone. */
    if ((hdr[7] & 0x0C) != 0x08 && (hdr[12] | hdr[13] | hdr[14] | hdr[15]))
        hdr[7] = 0;

    prg8k = pow2_8k((WORD)hdr[4] * 2);
    chr8k = pow2_8k(hdr[5] ? hdr[5] : 1);   /* CHR RAM takes 8K */
    if (prg8k > 128 || chr8k > 32)          /* 1M PRG, 256K CHR */
        return ERR_TOO_BIG;
    slots = (BYTE)(64 - chr8k);

    PH_SLOTS = slots;
    PH_LOAD_RESET = 0;
    for (n = 0; n < 16; ++n)
        PH_LOAD_DATA = hdr[n];

    left = (DWORD)hdr[4] * 16384 + (DWORD)hdr[5] * 8192;
    while (left) {
        n = left > 0x4000 ? 0x4000 : (WORD)left;
        if (pf_read(0, n, &br) != FR_OK || br != n)
            return ERR_READ;
        left -= n;
    }

    while (PH_CTRL & PH_STAT_BUSY)
        ;
    if ((PH_CTRL & (PH_STAT_DONE | PH_STAT_ERROR)) != PH_STAT_DONE)
        return ERR_LOAD;

    /* PRG pages past the SRAM's: the cache reads them from the card */
    if (prg8k > slots) {
        status("MAPPING...");
        PH_SKIP_LO = (BYTE)data_ofs;
        PH_SKIP_HI = 0;
        switch (pf_pages(data_ofs >> 9, (UINT)hdr[4] * 2, set_page)) {
        case 1: return ERR_READ;
        case 2: return ERR_FRAGMENTED;
        }
        for (n = (WORD)hdr[4] * 2; n < prg8k; ++n) {    /* (padding to a power of two) */
            PH_PAGE = (BYTE)n;
            PH_ARG[0] = (BYTE)page_arg;
            PH_ARG[1] = (BYTE)(page_arg >> 8);
            PH_ARG[2] = (BYTE)(page_arg >> 16);
            PH_ARG[3] = (BYTE)(page_arg >> 24);
        }
    }

    screen_off();
    PH_START = 0;
    for (;;)
        ;
}

static void open_selected(void)
{
    const struct entry *e;
    char file[96];
    BYTE err;

    if (!count)
        return;
    e = &ENTRIES[ORDER[sel]];

    if (e->kind == KIND_PARENT) {
        path_leave();
        show_folder();
    } else if (e->kind == KIND_DIR) {
        if (path_enter(entry_name(ORDER[sel])))
            show_folder();
    } else {
        strcpy(file, path);
        strcat(file, "/");
        strcat(file, entry_name(ORDER[sel]));
        status("LOADING...");
        err = load_game(file[0] == '/' ? file + 1 : file);
        PH_LED = 1;
        status(errors[err]);
        wait_button();
        PH_LED = 0;
        status("A:OPEN  B:BACK  L/R:PAGE");
    }
}

/* ------------------------------------------------------------------------ */

static void fatal(BYTE code)
{
    BYTE n;

    PH_LED = 1;
    ppu_text(1, 1, "PHOENIX NES", 31);
    ppu_text(1, 4, errors[code], 31);
    ppu_text(1, 6, "INSERT A FAT16 OR FAT32 CARD", 31);
    ppu_text(1, 7, "AND PRESS A BUTTON", 31);
    screen_on();
    wait_button();
    PH_LED = 0;
    screen_off();
    for (n = 1; n < 8; ++n)
        ppu_text(1, n, "", 31);
}

void main(void)
{
    BYTE b, n;

    ppu_init();

    for (;;) {
        if (!(PH_CTRL & PH_STAT_CARD)) {
            fatal(ERR_NO_CARD);
            continue;
        }
        for (n = 0; n < 3 && pf_mount(&fs) != FR_OK; ++n)
            ;
        if (n == 3) {
            fatal(ERR_MOUNT);
            continue;
        }
        break;
    }

    path[0] = 0;
    show_folder();

    for (;;) {
        wait_vblank();
        b = pad_pressed();
        if (b & PAD_DOWN)
            move_to(sel + 1);
        else if (b & PAD_UP)
            move_to(sel ? sel - 1 : 0);
        else if (b & PAD_RIGHT)
            move_to(sel + LIST_ROWS);
        else if (b & PAD_LEFT)
            move_to(sel >= LIST_ROWS ? sel - LIST_ROWS : 0);
        else if (b & (PAD_A | PAD_START))
            open_selected();
        else if ((b & PAD_B) && path[0]) {
            path_leave();
            show_folder();
        }
    }
}
