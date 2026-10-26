/* Phoenix Intellivision boot loader and menu.
 *
 * Mounts the SD card and shows the folders and cartridge images (.BIN,
 * .INT, .ITV, .ROM) of the current folder, folders first, sorted by name.
 * The selected image goes to the SRAM with the cartridge's memory map in
 * the page table at SRAM 7E000 (see rtl/intv_cart.vhd), then the game
 * starts.  The memory map comes from:
 *
 *   - .ROM: the Intellicart header (segments, access and fine tables);
 *   - .BIN/.INT/.ITV with a .CFG file of the same name: its [mapping]
 *     (with PAGE n) and [memattr] RAM sections, as jzintv reads them;
 *   - .BIN/.INT/.ITV alone: the MiSTer core's table of known CRCs, or
 *     else the usual $5000/$D000/$F000 map.
 *
 * Controls (ColecoVision controller): stick up/down move, left/right page,
 * left fire (or #) opens, right fire (or *) goes up a folder, keypad 0
 * swaps the controller ports.  SNES pad: A/Start open, B back, Select swap.
 *
 * Memory: RAM $0000-$07FF and $6000-$7FFF, text screen $4000.
 */

#include <string.h>
#include "pff/pff.h"
#include "phoenix.h"

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
/* $6E00-$6FFF: the SD driver's sector cache (diskio.c) */
#define MAPBUF  ((BYTE *)0x7000)            /* one page of the page table, 512 bytes */
#define CFGBUF  ((char *)0x7200)            /* the .CFG file, up to 3K */
#define CFG_MAX 0x0C00

static WORD count;

/* ------------------------------------------------------------------------ */
/* Screen layout (32x30 characters) */

#define LIST_ROW    3
#define LIST_ROWS   23
#define NAME_COL    3
#define SWAP_ROW    27
#define STATUS_ROW  28

#define ERR_NO_CARD     1
#define ERR_MOUNT       2
#define ERR_DIR         3
#define ERR_READ        4
#define ERR_BAD_ROM     5
#define ERR_TOO_BIG     6
#define ERR_CFG         7

static const char *const errors[] = {
    "",
    "NO SD CARD",
    "CANNOT READ THE SD CARD",
    "CANNOT READ THE FOLDER",
    "READ ERROR",
    "NOT AN INTELLICART .ROM FILE",
    "TOO BIG FOR THE SRAM",
    "CANNOT USE THE .CFG FILE",
};

static const char help[] = "L FIRE:OPEN R FIRE:BACK 0:SWAP";

static FATFS fs;
static DIR dir;
static FILINFO fno;
static char path[80];       /* current folder, "" is the root */
static BYTE buf[64];
static BYTE swap;

/* ------------------------------------------------------------------------ */
/* Screen */

static void wait_vblank(void)
{
    while (PH_CTRL & PH_STAT_VBLANK)
        ;
    while (!(PH_CTRL & PH_STAT_VBLANK))
        ;
}

/* Write a string, then pad with spaces up to column end. */
static void text(BYTE col, BYTE row, const char *s, BYTE end)
{
    BYTE *p = TEXT + (WORD)row * 32 + col;
    while (*s && col < end) {
        *p++ = *s++;
        ++col;
    }
    while (col++ < end)
        *p++ = ' ';
}

static void status(const char *s)
{
    text(1, STATUS_ROW, s, 31);
}

static void show_swap(void)
{
    text(1, SWAP_ROW, swap ? "PLAYER 1: COLECO PORT 2" : "PLAYER 1: COLECO PORT 1", 31);
}

static void cls(void)
{
    memset(TEXT, ' ', 960);
}

/* ------------------------------------------------------------------------ */
/* Controller */

static BYTE pad_last;
static BYTE pad_timer;

/* Newly pressed buttons, with auto-repeat for the directions.  Call once
 * per frame. */
static BYTE pad_pressed(void)
{
    BYTE now = PH_BUTTONS;
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

static const char *ext_of(const char *name)
{
    const char *dot = strchr(name, '.');
    return dot ? dot : name + strlen(name);
}

/* Is the 8.3 name a cartridge image? */
static BYTE is_cart(const char *name)
{
    const char *e = ext_of(name);
    return strcmp(e, ".BIN") == 0 || strcmp(e, ".INT") == 0 ||
           strcmp(e, ".ITV") == 0 || strcmp(e, ".ROM") == 0;
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
        if (!(fno.fattrib & AM_DIR) && !is_cart(fno.fname))
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
    text(NAME_COL, LIST_ROW + row, line, 31);
}

static void draw_cursor(char c)
{
    TEXT[(WORD)(LIST_ROW + (BYTE)(sel - top)) * 32 + 1] = c;
}

static void draw_page(void)
{
    BYTE r;
    char title[32];

    strcpy(title, "INTELLIVISION  ");
    strncat(title, path[0] ? path : "/", sizeof(title) - 16);
    text(1, 1, title, 31);
    for (r = 0; r < LIST_ROWS; ++r) {
        TEXT[(WORD)(LIST_ROW + r) * 32 + 1] = ' ';
        draw_row(r);
    }
    if (count)
        draw_cursor('>');
    else
        text(NAME_COL, LIST_ROW, "NO CARTRIDGE IMAGES HERE", 31);
    show_swap();
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
/* SRAM */

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

static void sram_put(BYTE b)
{
    while (PH_CTRL & PH_STAT_BUSY)
        ;
    PH_LOAD_DATA = b;
}

static void sram_fill(DWORD a, WORD n, BYTE b)
{
    sram_at(a);
    while (n--)
        sram_put(b);
}

/* ------------------------------------------------------------------------ */
/* Memory map */

#define TABLE_ADDR  0x7E000UL   /* page table in the SRAM */
#define DATA_PAGES  0x3F0       /* SRAM pages (256 words) below the table */

#define F_READ   0x80
#define F_WRITE  0x40
#define F_NARROW 0x20

/* A range of CPU pages (256 words) mapped to consecutive SRAM pages. */
struct range {
    BYTE first, last;       /* CPU address bits 15:8 */
    BYTE page;              /* page register value, 0-15 */
    BYTE flags;             /* F_* */
    WORD spage;             /* SRAM page of 'first' */
};

#define MAX_RANGES 40
static struct range ranges[MAX_RANGES];
static BYTE nranges;
static WORD paged;          /* zones with page registers */
static WORD pages_used;     /* page register values that have ranges */
static WORD file_pages;     /* SRAM pages taken by the file */
static WORD next_spage;     /* next free SRAM page for RAM */

static BYTE add_range(BYTE first, BYTE last, BYTE page, BYTE flags, WORD spage)
{
    struct range *r;
    if (nranges == MAX_RANGES || last < first)
        return 0;
    r = &ranges[nranges++];
    r->first = first;
    r->last = last;
    r->page = page;
    r->flags = flags;
    r->spage = spage;
    pages_used |= 1 << page;
    return 1;
}

/* Map file words [fa, fb] at CPU address ca, pages beyond the file left
 * out. */
static BYTE map_file(WORD fa, WORD fb, WORD ca, BYTE page)
{
    WORD n = (fb >> 8) - (fa >> 8);         /* pages - 1 */
    WORD sp = fa >> 8;

    if (sp >= file_pages)
        return 1;
    if (sp + n >= file_pages)
        n = file_pages - 1 - sp;
    if ((ca >> 8) + n > 255)
        return 0;
    return add_range((BYTE)(ca >> 8), (BYTE)((ca >> 8) + n), page, F_READ, sp);
}

/* RAM at CPU words [ca, cb]. */
static BYTE map_ram(WORD ca, WORD cb, BYTE narrow)
{
    WORD n = (cb >> 8) - (ca >> 8) + 1;
    if (next_spage + n > DATA_PAGES)
        return 0;
    if (!add_range((BYTE)(ca >> 8), (BYTE)(cb >> 8), 0,
                   F_READ | F_WRITE | (narrow ? F_NARROW : 0), next_spage))
        return 0;
    sram_fill((DWORD)next_spage << 9, n << 9, 0);
    next_spage += n;
    return 1;
}

/* Write the page table: every page register value that has ranges, and
 * page 0 always.  Other entries stay unreadable. */
static void write_table(void)
{
    BYTE p, i, j;
    WORD k, sp;
    struct range *r;

    for (p = 0; p < 16; ++p) {
        if (p && !(pages_used & (1 << p)))
            continue;
        memset(MAPBUF, 0, 512);
        for (i = 0; i < nranges; ++i) {
            r = &ranges[i];
            if (r->page != p)
                continue;
            sp = r->spage;
            for (j = r->first; ; ++j) {
                k = (WORD)j << 1;
                MAPBUF[k] = r->flags | (BYTE)(sp >> 8);
                MAPBUF[k + 1] = (BYTE)sp;
                ++sp;
                if (j == r->last)
                    break;
            }
        }
        sram_at(TABLE_ADDR + ((DWORD)p << 9));
        for (k = 0; k < 512; ++k)
            sram_put(MAPBUF[k]);
    }
    wait_idle();
    PH_PAGED_LO = (BYTE)paged;
    PH_PAGED_HI = (BYTE)(paged >> 8);
}

/* The MiSTer core's standard maps, as file range / CPU address pairs in
 * 4K-word units: map n is maps[n].  RAM 8 at D000 (map 4) or 8800 (map 9). */
struct std_map {
    BYTE n;
    BYTE part[4][3];        /* first, last file 4K block, CPU 4K block */
};

static const struct std_map std_maps[11] = {
    { 3, { { 0, 1, 0x5 }, { 2, 2, 0xD }, { 3, 3, 0xF } } },
    { 2, { { 0, 1, 0x5 }, { 2, 4, 0xD } } },
    { 3, { { 0, 1, 0x5 }, { 2, 4, 0x9 }, { 5, 5, 0xD } } },
    { 4, { { 0, 1, 0x5 }, { 2, 3, 0x9 }, { 4, 4, 0xD }, { 5, 5, 0xF } } },
    { 1, { { 0, 1, 0x5 } } },
    { 2, { { 0, 2, 0x5 }, { 3, 5, 0x9 } } },
    { 1, { { 0, 1, 0x6 } } },
    { 1, { { 0, 1, 0x4 } } },       /* at $4800, see below */
    { 2, { { 0, 0, 0x5 }, { 1, 1, 0x7 } } },
    { 4, { { 0, 1, 0x5 }, { 2, 3, 0x9 }, { 4, 4, 0xD }, { 5, 5, 0xF } } },
    { 2, { { 0, 0, 0x5 }, { 1, 1, 0xD } } },
};

static BYTE use_std_map(BYTE m)
{
    const struct std_map *sm = &std_maps[m];
    BYTE i;
    WORD ca;

    for (i = 0; i < sm->n; ++i) {
        ca = (WORD)sm->part[i][2] << 12;
        if (m == 7)
            ca = 0x4800;
        if (!map_file((WORD)sm->part[i][0] << 12, ((WORD)sm->part[i][1] << 12) | 0x0FFF, ca, 0))
            return 0;
    }
    if (m == 4)
        return map_ram(0xD000, 0xD3FF, 1);
    if (m == 9)
        return map_ram(0x8800, 0x8FFF, 1);
    return 1;
}

/* Known CRC-32s of raw images and their maps, from the MiSTer core's
 * intv_pack.vhd. */
struct crc_map {
    DWORD crc;
    BYTE map;
};

static const struct crc_map crc_maps[] = {
    { 0x4CC46A04UL, 1 }, { 0xD5F038B6UL, 1 }, { 0xA3ACD160UL, 1 }, { 0x4422868EUL, 1 },
    { 0xC2063C08UL, 1 }, { 0xA12C27E1UL, 1 },
    { 0x515E1D7EUL, 2 }, { 0x0BF464C6UL, 2 }, { 0x3289C8BAUL, 2 }, { 0x16BFB8EBUL, 2 },
    { 0x6802B191UL, 2 }, { 0x13EE56F1UL, 2 }, { 0xFF83FF80UL, 2 }, { 0x2C5FD5FAUL, 2 },
    { 0x632F6ADFUL, 2 }, { 0xB745C1CAUL, 2 }, { 0xBB939881UL, 2 }, { 0x800B572FUL, 2 },
    { 0x32076E9DUL, 2 }, { 0xA95021FCUL, 2 }, { 0x23DC808DUL, 2 },
    { 0xD1D352A0UL, 3 },
    { 0x752FD927UL, 4 }, { 0x3825C25BUL, 4 },
    { 0x4B23A757UL, 5 }, { 0xD8F99AA2UL, 5 }, { 0x159AF7F7UL, 5 }, { 0xA21C31C3UL, 5 },
    { 0x6E4E8EB4UL, 5 },
    { 0xD5363B8CUL, 6 },
    { 0x13FF363CUL, 7 }, { 0xC047D487UL, 7 }, { 0x5E6A8CD8UL, 7 }, { 0xE806AD91UL, 7 },
    { 0xC83EEA4CUL, 8 },
    { 0xCE8FC699UL, 9 }, { 0x095638C0UL, 9 },
    { 0xA63AA3D8UL, 10 },
};

static BYTE crc_lookup(void)
{
    DWORD crc;
    BYTE i;

    memcpy(&crc, (const void *)PH_CRC, 4);
    for (i = 0; i < sizeof(crc_maps) / sizeof(crc_maps[0]); ++i)
        if (crc_maps[i].crc == crc)
            return crc_maps[i].map;
    return 0;
}

/* ------------------------------------------------------------------------ */
/* .CFG files */

static const char *cp;      /* parse position */

static void skip_blanks(void)
{
    while (*cp == ' ' || *cp == '\t')
        ++cp;
}

/* A number: $hex or decimal.  Returns 0 if there is none. */
static BYTE get_num(WORD *v)
{
    WORD n = 0;
    BYTE c, any = 0;

    skip_blanks();
    if (*cp == '$') {
        ++cp;
        for (;;) {
            c = *cp;
            if (c >= '0' && c <= '9') c -= '0';
            else if (c >= 'A' && c <= 'F') c -= 'A' - 10;
            else if (c >= 'a' && c <= 'f') c -= 'a' - 10;
            else break;
            n = (n << 4) | c;
            any = 1;
            ++cp;
        }
    } else {
        while (*cp >= '0' && *cp <= '9') {
            n = n * 10 + (*cp - '0');
            any = 1;
            ++cp;
        }
    }
    *v = n;
    return any;
}

static BYTE get_char(char c)
{
    skip_blanks();
    if (*cp != c)
        return 0;
    ++cp;
    return 1;
}

/* Case-insensitive keyword */
static BYTE get_word(const char *w)
{
    const char *p;
    skip_blanks();
    for (p = cp; *w; ++p, ++w)
        if ((*p & 0xDF) != *w)
            return 0;
    cp = p;
    return 1;
}

static void next_line(void)
{
    while (*cp && *cp != '\n')
        ++cp;
    if (*cp)
        ++cp;
}

#define SEC_NONE    0
#define SEC_MAPPING 1
#define SEC_MEMATTR 2

/* Parse the .CFG text in CFGBUF.  Returns 0 on a line it cannot use. */
static BYTE parse_cfg(void)
{
    BYTE section = SEC_NONE;
    WORD a, b, c, page;

    cp = CFGBUF;
    while (*cp) {
        skip_blanks();
        if (*cp == '[') {
            ++cp;
            if (get_word("MAPPING") || get_word("PRELOAD"))
                section = SEC_MAPPING;
            else if (get_word("MEMATTR"))
                section = SEC_MEMATTR;
            else
                section = SEC_NONE;
        } else if (*cp == '$' && section != SEC_NONE) {
            if (!get_num(&a) || !get_char('-') || !get_num(&b) || !get_char('='))
                return 0;
            if (section == SEC_MAPPING) {
                if (!get_num(&c))
                    return 0;
                page = 0;
                if (get_word("PAGE")) {
                    if (!get_num(&page) || page > 15)
                        return 0;
                    paged |= 1 << (c >> 12);
                }
                if (!map_file(a, b, c, (BYTE)page))
                    return 0;
            } else {
                /* "RAM 8", "RAM 10" or "RAM 16" */
                if (!get_word("RAM") || !get_num(&c))
                    return 0;
                if (!map_ram(a, b, c == 8))
                    return 0;
            }
        }
        next_line();
    }
    return 1;
}

/* Read name's .CFG file into CFGBUF.  Returns 0 if there is none. */
static BYTE read_cfg(const char *file)
{
    char cfg[96];
    char *dot;
    UINT br;

    strcpy(cfg, file);
    dot = strrchr(cfg, '.');
    if (!dot || dot < strrchr(cfg, '/'))
        return 0;
    strcpy(dot, ".CFG");
    if (pf_open(cfg) != FR_OK)
        return 0;
    if (pf_read(CFGBUF, CFG_MAX - 1, &br) != FR_OK)
        return 0;
    CFGBUF[br] = 0;
    return 1;
}

/* ------------------------------------------------------------------------ */
/* Loading */

static void map_reset(void)
{
    nranges = 0;
    paged = 0;
    pages_used = 1;
    file_pages = 0;
    next_spage = 0;
}

/* Raw image: the file goes to SRAM 0, word n at page n >> 8. */
static BYTE load_raw(const char *file)
{
    UINT br;
    DWORD left;
    WORD n;
    BYTE has_cfg;

    map_reset();
    has_cfg = read_cfg(file);

    if (pf_open(file) != FR_OK)
        return ERR_READ;
    left = fs.fsize;
    if (left > (DWORD)DATA_PAGES * 512)
        return ERR_TOO_BIG;
    file_pages = (WORD)((left + 511) >> 9);
    next_spage = file_pages;

    sram_at(0);
    PH_CRC_RESET = 0;
    while (left) {
        n = left > 0x4000 ? 0x4000 : (WORD)left;
        if (pf_read(0, n, &br) != FR_OK || br != n)
            return ERR_READ;
        left -= n;
    }
    /* The rest of the last page reads as $FFFF. */
    n = (WORD)(fs.fsize & 511);
    if (n)
        sram_fill(fs.fsize, 512 - n, 0xFF);
    wait_idle();

    if (has_cfg) {
        if (!parse_cfg())
            return ERR_CFG;
    } else if (!use_std_map(crc_lookup()))
        return ERR_TOO_BIG;
    write_table();
    return 0;
}

/* Intellicart .ROM: segments at their CPU addresses (SRAM page = CPU
 * page), then the access and fine tables for 2K-word zones. */
static BYTE load_icart(const char *file)
{
    UINT br;
    BYTE nseg, z, acc, fine, lo, hi, p, flags;
    WORD n, m;

    map_reset();
    if (pf_open(file) != FR_OK)
        return ERR_READ;
    if (pf_read(buf, 3, &br) != FR_OK || br != 3)
        return ERR_READ;
    if (buf[0] != 0xA8 || (BYTE)(buf[1] ^ buf[2]) != 0xFF)
        return ERR_BAD_ROM;
    nseg = buf[1];

    PH_CRC_RESET = 0;
    while (nseg--) {
        if (pf_read(buf, 2, &br) != FR_OK || br != 2)
            return ERR_READ;
        if (buf[1] < buf[0])
            return ERR_BAD_ROM;
        sram_at((DWORD)buf[0] << 9);
        /* 256 words (512 bytes) per page, 32 bytes per 16 words */
        for (n = ((WORD)(buf[1] - buf[0]) + 1) << 5; n; n -= m) {
            m = n > 0x200 ? 0x200 : n;
            if (pf_read(0, m << 4, &br) != FR_OK || br != (m << 4))
                return ERR_READ;
        }
        if (pf_read(buf, 2, &br) != FR_OK || br != 2)    /* CRC-16 */
            return ERR_READ;
    }
    wait_idle();

    /* Enable table: a nibble per 2K zone; fine table: a byte per zone,
     * first the even zones, then the odd ones. */
    if (pf_read(buf, 48, &br) != FR_OK || br != 48)
        return ERR_BAD_ROM;
    for (z = 0; z < 32; ++z) {
        acc = buf[z >> 1];
        if (z & 1)
            acc >>= 4;
        fine = buf[16 + (z >> 1) + ((z & 1) << 4)];
        if (!(acc & 3))
            continue;
        flags = ((acc & 1) ? F_READ : 0) | ((acc & 2) ? F_WRITE : 0) |
                ((acc & 4) ? F_NARROW : 0);
        lo = (fine >> 4) & 7;
        hi = fine & 7;
        if (lo > hi)
            continue;
        p = (z << 3) + lo;
        if (!add_range(p, (z << 3) + hi, 0, flags, p))
            return ERR_BAD_ROM;
    }
    write_table();
    return 0;
}

static BYTE load_game(const char *file)
{
    BYTE err;
    const char *base = strrchr(file, '/');

    if (strcmp(ext_of(base ? base : file), ".ROM") == 0)
        err = load_icart(file);
    else
        err = load_raw(file);
    if (err)
        return err;

    wait_idle();
    PH_OPTIONS = swap;
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
        status(help);
    }
}

/* ------------------------------------------------------------------------ */

static void fatal(BYTE code)
{
    PH_LED = 1;
    cls();
    text(1, 1, "INTELLIVISION", 31);
    text(1, 4, errors[code], 31);
    text(1, 6, "INSERT A FAT16 OR FAT32 CARD", 31);
    text(1, 7, "AND PRESS A BUTTON", 31);
    wait_button();
    PH_LED = 0;
    cls();
}

void main(void)
{
    BYTE b, n;

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
        } else if (b & PAD_SELECT) {
            swap ^= 1;
            show_swap();
        }
    }
}
