/* Phoenix Game Boy loader and menu (SDCC, sm83).
 *
 * Runs on the core's own Game Boy CPU in CGB mode.  Mounts the SD card and
 * shows the folders and Game Boy images (.GB, .GBC, .CGB) of the current
 * folder, folders first, sorted by name.  The selected image goes to the
 * SRAM, a .SAV file of the same name (if there is one) to the cartridge
 * RAM, and the game starts with its boot ROM.
 *
 * Saves: the loader notes the .SAV file, its length and its CRC in the I/O
 * window's 128 bytes that resets keep (PH_KEEP).  Back in the menu (hold
 * reset), it takes the CRC of the cartridge RAM, which is still there, and
 * if it changed writes it back to the .SAV.  Petit FatFs cannot create or
 * grow files, so a game saves only to a .SAV that exists.
 *
 * Images over 256K (up to 512K) fill the SRAM, so they run on the original
 * Game Boy hardware (the GBC's extra work RAM is in the SRAM) and with at
 * most 8K of cartridge RAM (in block RAM).
 *
 * Controls: up/down move, left/right page, A (or Start) opens, B goes up a
 * folder (ColecoVision: left fire A, right fire B, # Start, * Select).
 * Keypad 1 sets the hardware: AUTO (from the cartridge header), GB or
 * GBC; keypad 2 the colours of GB games.  SNES pad: L and R.
 *
 * Screen: 20 x 18 characters, written to a copy in the work RAM and sent
 * to the BG map with the GBC's DMA in vertical blank.
 *
 * Memory: work RAM $C000-$DFFF (see the #defines), the stack at its top.
 */

#include <string.h>
#include "pff/pff.h"
#include "phoenix.h"

extern const unsigned char font[];   /* font.c: ASCII 32-122, 8 bytes each */

/* ------------------------------------------------------------------------ */
/* Work RAM */

#define MAX_ENTRIES 256

struct entry {
    char name[12];          /* 8.3 name, not terminated if 12 characters */
    BYTE kind;              /* KIND_* */
};

#define KIND_PARENT 0       /* ".." */
#define KIND_DIR    1
#define KIND_FILE   2

#define ENTRIES ((struct entry *)0xC000)    /* 256 x 13 = $0D00 bytes */
#define ORDER   ((BYTE *)0xCD00)            /* sorted entry numbers */
/* $CE00-$CFFF: the SD driver's sector cache (diskio.c) */
/* $D000-$D7FF: the C globals */
#define SAVE_BUF ((BYTE *)0xC000)           /* writing a save, before the listing */
#define SCR     ((BYTE *)0xD800)            /* screen copy, 18 rows of 32 */

static WORD count;

/* ------------------------------------------------------------------------ */
/* Screen layout (20 x 18 characters) */

#define COLS        20
#define LIST_ROW    2
#define LIST_ROWS   12
#define NAME_COL    2
#define MODE_ROW    15
#define PAL_ROW     16
#define STATUS_ROW  17

#define ERR_NO_CARD     1
#define ERR_MOUNT       2
#define ERR_DIR         3
#define ERR_READ        4
#define ERR_TOO_BIG     5
#define ERR_MAPPER      6
#define ERR_BIG_GBC     7
#define ERR_BIG_RAM     8
#define MSG_SAVED       9
#define ERR_SAVE        10
#define MSG_NO_SAV      11

static const char *const errors[] = {
    "",
    "NO SD CARD",
    "CANNOT READ CARD",
    "CANNOT READ FOLDER",
    "READ ERROR",
    "TOO BIG (MAX 512K)",
    "UNKNOWN CART TYPE",
    "OVER 256K: GB ONLY",
    "OVER 256K: RAM>8K",
    "GAME SAVED",
    "SAVE FAILED",
    "NOT SAVED: NO .SAV",
};

static const char help[] = "A:OPEN  B:BACK";

#define HW_AUTO 0
#define HW_GB   1
#define HW_GBC  2
static const char *const hw_names[] = { "AUTO", "GB", "GBC" };
static const char *const pal_names[] = { "GREY", "GREEN", "POCKET", "LIGHT" };
static BYTE hw_mode, dmg_pal = 1;

static FATFS fs;
static DIR dir;
static FILINFO fno;
static char path[64];       /* current folder, "" is the root */
static BYTE hdr[0x150];     /* cartridge header */
static char fname[80];      /* the selected file */
static BYTE dirty;

/* ------------------------------------------------------------------------ */
/* Screen */

static void wait_vblank(void)
{
    while (LY == 144)
        ;
    while (LY != 144)
        ;
}

/* Wait for vertical blank, then send the screen copy to the BG map. */
static void frame(void)
{
    wait_vblank();
    if (dirty) {
        HDMA1 = 0xD8;           /* SCR */
        HDMA2 = 0x00;
        HDMA3 = 0x18;           /* $9800 */
        HDMA4 = 0x00;
        HDMA5 = 18 * 32 / 16 - 1;
        dirty = 0;
    }
}

/* Write a string, then pad with spaces up to column end. */
static void text(BYTE col, BYTE row, const char *s, BYTE end)
{
    BYTE *p = SCR + (WORD)row * 32 + col;
    while (*s && col < end) {
        *p++ = *s++;
        ++col;
    }
    while (col++ < end)
        *p++ = ' ';
    dirty = 1;
}

static void status(const char *s)
{
    text(0, STATUS_ROW, s, COLS);
}

static void show_opts(void)
{
    char line[COLS + 1];
    strcpy(line, "1:HARDWARE ");
    strcat(line, hw_names[hw_mode]);
    text(0, MODE_ROW, line, COLS);
    strcpy(line, "2:GB COLOR ");
    strcat(line, pal_names[dmg_pal]);
    text(0, PAL_ROW, line, COLS);
}

static void cls(void)
{
    memset(SCR, ' ', 18 * 32);
    dirty = 1;
}

/* Font, BG map and palette, with the LCD off (it is off after reset). */
static void screen_init(void)
{
    BYTE *v = (BYTE *)0x8200;   /* tile 32 */
    const BYTE *f = font;
    WORD n;

    for (n = 0; n < 91 * 8; ++n) {
        *v++ = *f;
        *v++ = *f++;
    }
    VBK = 1;                    /* attributes: palette 0, bank 0 */
    memset((BYTE *)0x9800, 0, 0x400);
    VBK = 0;
    memset((BYTE *)0x9800, ' ', 0x400);

    BCPS = 0x80;                /* palette 0, auto-increment */
    BCPD = 0x63; BCPD = 0x30;   /* dark blue */
    BCPD = 0x63; BCPD = 0x30;
    BCPD = 0x63; BCPD = 0x30;
    BCPD = 0xFF; BCPD = 0x7F;   /* white */

    LCDC = 0x91;                /* on, tiles at $8000, map at $9800, BG on */
}

/* ------------------------------------------------------------------------ */
/* Controller */

static BYTE pad_last;
static BYTE pad_timer;
static BYTE key_last = 0xFF;

static BYTE read_pad(void)
{
    BYTE d, b;
    P1 = 0x20;                  /* directions */
    d = P1; d = P1;
    P1 = 0x10;                  /* buttons */
    b = P1; b = P1;
    P1 = 0x30;
    return (BYTE)(~b & 0x0F) | (BYTE)((~d & 0x0F) << 4);
}

/* Newly pressed keypad key, or $FF */
static BYTE key_pressed(void)
{
    BYTE k = PH_KEY;
    BYTE n = (k != key_last) ? k : 0xFF;
    key_last = k;
    return n;
}

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
        frame();
        b = pad_pressed();
    } while (!(b & (PAD_A | PAD_B | PAD_START)));
}

/* ------------------------------------------------------------------------ */
/* Directory */

static const char *ext_of(const char *name)
{
    const char *dot = strchr(name, '.');
    return dot ? dot : name + strlen(name);
}

/* Is the 8.3 name a Game Boy image? */
static BYTE is_game(const char *name)
{
    const char *e = ext_of(name);
    return strcmp(e, ".GB") == 0 || strcmp(e, ".GBC") == 0 ||
           strcmp(e, ".CGB") == 0;
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
        if (!(fno.fattrib & AM_DIR) && !is_game(fno.fname))
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
    text(NAME_COL, LIST_ROW + row, line, COLS);
}

static void draw_cursor(char c)
{
    SCR[(WORD)(LIST_ROW + (BYTE)(sel - top)) * 32 + 1] = c;
    dirty = 1;
}

static void draw_page(void)
{
    BYTE r;
    const char *p = path[0] ? path : "/";
    WORD l = strlen(p);

    text(0, 0, "GAME BOY", COLS);
    if (l > COLS - 9)
        p += l - (COLS - 9);
    text(9, 0, p, COLS);
    for (r = 0; r < LIST_ROWS; ++r) {
        SCR[(WORD)(LIST_ROW + r) * 32 + 1] = ' ';
        draw_row(r);
    }
    if (count)
        draw_cursor('>');
    else
        text(NAME_COL, LIST_ROW, "NO GAMES HERE", COLS);
    show_opts();
    status(help);
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
        draw_cursor(' ');
        sel = n;
        draw_cursor('>');
    }
}

/* ------------------------------------------------------------------------ */
/* Loading */

void mem_read(BYTE *dst, UINT n);  /* spi.s: n bytes from PH_MEM */

/* PH_KEEP: the save of the game that runs, for the way back to the menu */
#define KEEP_NOTE   0       /* NOTE_* */
#define KEEP_LEN    2       /* DWORD: bytes to save */
#define KEEP_CRC    6       /* DWORD: their CRC as loaded */
#define KEEP_ADDR   10      /* DWORD: their load address */
#define KEEP_NAME   16      /* the .SAV file's path */
#define NOTE_SAVE   'S'     /* a .SAV to save to */
#define NOTE_NO_SAV 'N'     /* cartridge RAM, but no .SAV file */

static void wait_idle(void)
{
    while (PH_CTRL & PH_STAT_BUSY)
        ;
}

static void sram_at(DWORD a)
{
    wait_idle();
    PH_ADDR0 = (BYTE)a;
    PH_ADDR1 = (BYTE)(a >> 8);
    PH_ADDR2 = (BYTE)(a >> 16);
}

/* Forward the open file, from its current position, to the SRAM. */
static BYTE forward_file(DWORD n)
{
    UINT chunk, br;

    while (n) {
        chunk = n > 0x4000 ? 0x4000 : (UINT)n;
        if (pf_read(0, chunk, &br) != FR_OK || br != chunk)
            return 0;
        n -= chunk;
    }
    wait_idle();
    return 1;
}

/* Mapper for the cartridge type byte, or $FF */
static BYTE mapper_of(BYTE t)
{
    if (t == 0x00 || t == 0x08 || t == 0x09)
        return MAP_NONE;
    if (t <= 0x03 || t == 0xFF)         /* MBC1, HuC1 */
        return MAP_MBC1;
    if (t == 0x05 || t == 0x06)
        return MAP_MBC2;
    if (t >= 0x0F && t <= 0x13)
        return MAP_MBC3;
    if (t >= 0x19 && t <= 0x1E)
        return MAP_MBC5;
    return 0xFF;
}

/* 8K RAM banks for the RAM size byte (0: none) */
static const BYTE ram_banks[] = { 0, 1, 1, 4, 16, 8 };

/* Load and start the game in fname. */
static BYTE load_game(void)
{
    const char *file = fname;
    UINT br;
    DWORD size;
    BYTE map, banks, rbanks, gbc, note = 0;
    DWORD a;
    char *e;

    if (pf_open(file) != FR_OK)
        return ERR_READ;
    size = fs.fsize;
    if (size > ROM_MAX)
        return ERR_TOO_BIG;
    if (pf_read(hdr, sizeof(hdr), &br) != FR_OK || br != sizeof(hdr))
        return ERR_READ;

    map = mapper_of(hdr[0x147]);
    if (map == 0xFF)
        return ERR_MAPPER;
    banks = (BYTE)((size + 0x3FFF) >> 14);      /* 16K banks in the file */
    if (hdr[0x148] <= 4 && (BYTE)(2 << hdr[0x148]) > banks)
        banks = 2 << hdr[0x148];
    rbanks = hdr[0x149] < sizeof(ram_banks) ? ram_banks[hdr[0x149]] : 0;

    gbc = hw_mode == HW_GBC || (hw_mode == HW_AUTO && (hdr[0x143] & 0x80));
    if (size > ROM_GBC) {
        if (hdr[0x143] == 0xC0 || hw_mode == HW_GBC)
            return ERR_BIG_GBC;
        if (rbanks > 1)
            return ERR_BIG_RAM;
        gbc = 0;
    }

    status("LOADING...");
    frame();

    if (pf_open(file) != FR_OK)
        return ERR_READ;
    sram_at(SRAM_ROM);
    if (!forward_file(size))
        return ERR_READ;

    /* NAME.SAV next to the image goes to the cartridge RAM */
    if (rbanks || map == MAP_MBC2) {
        note = NOTE_NO_SAV;
        e = strrchr(fname, '.');
        strcpy(e, ".SAV");
        if (pf_open(fname) == FR_OK && fs.fsize) {
            size = fs.fsize;
            if (size > (DWORD)(rbanks ? rbanks : 1) << 13)
                size = (DWORD)(rbanks ? rbanks : 1) << 13;
            a = rbanks > 1 ? SRAM_CRAM : BRAM_CRAM;
            sram_at(a);
            PH_CRC_RESET = 1;
            if (!forward_file(size))
                return ERR_READ;
            memcpy(PH_KEEP + KEEP_LEN, &size, 4);
            memcpy(PH_KEEP + KEEP_CRC, PH_CRC, 4);
            memcpy(PH_KEEP + KEEP_ADDR, &a, 4);
            strcpy(PH_KEEP + KEEP_NAME, fname);
            note = NOTE_SAVE;
        }
    }
    PH_KEEP[KEEP_NOTE] = note;

    PH_MAPPER = map;
    PH_ROM_MASK = banks - 1;
    PH_ROM_MASK8 = 0;
    PH_RAM = (rbanks ? 0x80 | (rbanks - 1) : 0) | (rbanks > 1 ? 0 : 0x40);
    PH_MODE = gbc | (dmg_pal << 2);
    PH_START = 1;
    for (;;)
        ;
}

/* Back from a game: write its cartridge RAM to its .SAV if it changed.
 * Returns a message, or 0. */
static BYTE save_back(void)
{
    BYTE note = PH_KEEP[KEEP_NOTE];
    DWORD len, crc, a;
    UINT n, bw;

    PH_KEEP[KEEP_NOTE] = 0;
    if (note == NOTE_NO_SAV)
        return MSG_NO_SAV;
    if (note != NOTE_SAVE)
        return 0;
    memcpy(&len, PH_KEEP + KEEP_LEN, 4);
    memcpy(&crc, PH_KEEP + KEEP_CRC, 4);
    memcpy(&a, PH_KEEP + KEEP_ADDR, 4);

    /* Changed? */
    sram_at(a);
    PH_CRC_RESET = 1;
    for (bw = 0; bw < (UINT)(len >> 9); ++bw)
        mem_read(SAVE_BUF, 512);
    if ((UINT)len & 511)
        mem_read(SAVE_BUF, (UINT)len & 511);
    if (memcmp(PH_CRC, &crc, 4) == 0)
        return 0;

    status("SAVING...");
    frame();
    strcpy(fname, PH_KEEP + KEEP_NAME);
    if (pf_open(fname) != FR_OK)
        return ERR_SAVE;
    sram_at(a);
    while (len) {
        n = len > 512 ? 512 : (UINT)len;
        mem_read(SAVE_BUF, n);
        if (pf_write(SAVE_BUF, n, &bw) != FR_OK || bw != n)
            return ERR_SAVE;
        len -= n;
    }
    if (pf_write(0, 0, &bw) != FR_OK)
        return ERR_SAVE;
    return MSG_SAVED;
}

static void open_selected(void)
{
    struct entry *e;
    BYTE r;

    if (!count)
        return;
    e = &ENTRIES[ORDER[sel]];
    if (e->kind == KIND_PARENT) {
        path_leave();
        show_folder();
        return;
    }
    if (e->kind == KIND_DIR) {
        if (path_enter(entry_name(ORDER[sel])))
            show_folder();
        return;
    }

    strcpy(fname, path);
    strcat(fname, "/");
    strcat(fname, entry_name(ORDER[sel]));
    r = load_game();
    status(errors[r]);
}

static void fatal(BYTE code)
{
    cls();
    text(0, 0, "GAME BOY", COLS);
    text(0, 2, errors[code], COLS);
    text(0, 4, "PRESS A TO RETRY", COLS);
    PH_LED = 1;
    wait_button();
    PH_LED = 0;
    cls();
}

void main(void)
{
    BYTE b, n;

    screen_init();
    cls();
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

    text(0, 0, "GAME BOY", COLS);
    n = save_back();
    path[0] = 0;
    show_folder();
    if (n)
        status(errors[n]);

    for (;;) {
        frame();
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

        switch (key_pressed()) {
        case 1:
            hw_mode = hw_mode == HW_GBC ? HW_AUTO : hw_mode + 1;
            show_opts();
            break;
        case 2:
            dmg_pal = (dmg_pal + 1) & 3;
            show_opts();
            break;
        }
    }
}
