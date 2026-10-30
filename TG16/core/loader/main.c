/* Phoenix PC Engine loader and menu (cc65, HuC6280).
 *
 * Runs on the core's own HuC6280.  Mounts the SD card and shows the
 * folders and HuCard images (.PCE) of the current folder, folders first,
 * sorted by name.  The selected image goes to the SRAM and the game
 * starts.
 *
 * Images: up to 448K (the video RAM has the rest of the SRAM), with or
 * without a 512-byte copier header.  Images whose bits are reversed (some
 * US TurboGrafx-16 dumps) are found by their reset vector and played
 * reversed back.
 *
 * Controls: up/down move, left/right page, I (or Run) opens, II goes up a
 * folder (ColecoVision: left fire I, right fire II, # Run, * Select).
 *
 * Screen: the VDC's 32 x 32 background map at VRAM $0000, the font as
 * tiles $100-$17F at VRAM $1000.
 */

#include <string.h>
#include "pff/pff.h"
#include "phoenix.h"

extern const unsigned char font[];   /* font.c: ASCII 32-122, 8 bytes each */

/* ------------------------------------------------------------------------ */
/* Directory listing */

#define MAX_ENTRIES 256

struct entry {
    char name[12];          /* 8.3 name, not terminated if 12 characters */
    BYTE kind;              /* KIND_* */
};

#define KIND_PARENT 0       /* ".." */
#define KIND_DIR    1
#define KIND_FILE   2

static struct entry entries[MAX_ENTRIES];
static BYTE order[MAX_ENTRIES];
static WORD count;

/* ------------------------------------------------------------------------ */
/* Screen layout (32 x 28 characters) */

#define COLS        32
#define TITLE_ROW   1
#define LIST_ROW    3
#define LIST_ROWS   21
#define NAME_COL    3
#define STATUS_ROW  26

#define ERR_NO_CARD     1
#define ERR_MOUNT       2
#define ERR_DIR         3
#define ERR_READ        4
#define ERR_TOO_BIG     5
#define ERR_EMPTY       6

static const char *const errors[] = {
    "",
    "NO SD CARD",
    "CANNOT READ THE SD CARD",
    "CANNOT READ THE FOLDER",
    "READ ERROR",
    "TOO BIG (MAX 448K)",
    "EMPTY FILE",
};

static const char help[] = "I:OPEN  II:BACK";

static FATFS fs;
static DIR dir;
static FILINFO fno;
static char path[64];       /* current folder, "" is the root */
static char fname[80];      /* the selected file */
static BYTE buf[512];       /* the first bank, a sector at a time */

/* ------------------------------------------------------------------------ */
/* Screen */

static void vdc(BYTE reg, WORD val)
{
    VDC_AR = reg;
    VDC_LO = (BYTE)val;
    VDC_HI = (BYTE)(val >> 8);
}

/* Write a string, then pad with spaces up to column end. */
static void text(BYTE col, BYTE row, const char *s, BYTE end)
{
    vdc(0, (WORD)row * 32 + col);       /* MAWR */
    VDC_AR = 2;                         /* VWR */
    while (*s && col < end) {
        VDC_LO = *s++;
        VDC_HI = 0x01;                  /* tile $100 + c, palette 0 */
        ++col;
    }
    while (col++ < end) {
        VDC_LO = ' ';
        VDC_HI = 0x01;
    }
}

static void status(const char *s)
{
    text(0, STATUS_ROW, s, COLS);
}

static void cls(void)
{
    BYTE r;
    for (r = 0; r < 32; ++r)
        text(0, r, "", 32);
}

/* Wait for the start of vertical blank (the VDC's VD status flag). */
static void frame(void)
{
    (void)VDC_SR;                       /* clear the flag */
    while (!(VDC_SR & 0x20))
        ;
}

/* VDC: 256 x 240, 32 x 32 map, background only; VCE: 5.37MHz dots;
 * font tiles; dark blue and white. */
static void screen_init(void)
{
    const BYTE *f;
    BYTE c, i;

    vdc(5, 0x0000);         /* CR: off while setting up */
    vdc(9, 0x0000);         /* MWR: 32 x 32 map */
    vdc(10, 0x0202);        /* HSR */
    vdc(11, 0x031F);        /* HDR: 32 tiles */
    vdc(12, 0x0F02);        /* VSR */
    vdc(13, 0x00EF);        /* VDR: 240 lines */
    vdc(14, 0x0003);        /* VCR */
    vdc(7, 0);              /* BXR */
    vdc(8, 0);              /* BYR */
    VCE_CR = 0;             /* 5.37MHz dot clock */

    /* Font: tile $100 + c for c = 32-122, colour 1 on 0 (planes 0 only) */
    vdc(0, 0x1000 + 32 * 16);
    VDC_AR = 2;
    f = font;
    for (c = 32; c <= 122; ++c) {
        for (i = 0; i < 8; ++i) {
            VDC_LO = *f++;
            VDC_HI = 0;
        }
        for (i = 0; i < 8; ++i) {
            VDC_LO = 0;
            VDC_HI = 0;
        }
    }

    cls();

    VCE_ALO = 0;            /* background palette 0 */
    VCE_AHI = 0;
    VCE_DLO = 0x03;         /* colour 0: dark blue (GGGRRRBBB) */
    VCE_DHI = 0x00;
    VCE_DLO = 0xFF;         /* colour 1: white */
    VCE_DHI = 0x01;
    VCE_ALO = 0;            /* sprite palette 0... not used; the border: */
    VCE_AHI = 1;
    VCE_DLO = 0x03;
    VCE_DHI = 0x00;

    vdc(5, 0x0088);         /* CR: background on, vertical blank flag */
}

/* ------------------------------------------------------------------------ */
/* Controller */

static BYTE pad_last;
static BYTE pad_timer;
static BYTE key_last = 0xFF;

static BYTE read_pad(void)
{
    BYTE d, b;
    JOYPAD = 1;             /* SEL: directions */
    JOYPAD = 3;             /* CLR: reset a multitap */
    JOYPAD = 1;
    d = JOYPAD; d = JOYPAD;
    JOYPAD = 0;             /* buttons */
    b = JOYPAD; b = JOYPAD;
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
    } while (!(b & (PAD_I | PAD_II | PAD_RUN)));
}

/* ------------------------------------------------------------------------ */
/* Directory */

static const char *ext_of(const char *name)
{
    const char *dot = strchr(name, '.');
    return dot ? dot : name + strlen(name);
}

/* Is the 8.3 name a HuCard image? */
static BYTE is_game(const char *name)
{
    return strcmp(ext_of(name), ".PCE") == 0;
}

/* Entry name as a terminated string */
static const char *entry_name(BYTE n)
{
    static char s[14];
    memcpy(s, entries[n].name, 12);
    s[12] = 0;
    return s;
}

static signed char entry_cmp(BYTE a, BYTE b)
{
    const struct entry *ea = &entries[a];
    const struct entry *eb = &entries[b];
    int r;
    if (ea->kind != eb->kind)
        return ea->kind < eb->kind ? -1 : 1;
    r = strncmp(ea->name, eb->name, 12);
    return r < 0 ? -1 : r > 0 ? 1 : 0;
}

/* Shell sort of order[0..count-1] */
static void sort_entries(void)
{
    static const BYTE gaps[] = { 57, 23, 10, 4, 1 };
    BYTE g, gap, t;
    WORD i, j;

    for (g = 0; g < sizeof(gaps); ++g) {
        gap = gaps[g];
        for (i = gap; i < count; ++i) {
            t = order[i];
            for (j = i; j >= gap && entry_cmp(order[j - gap], t) > 0; j -= gap)
                order[j] = order[j - gap];
            order[j] = t;
        }
    }
}

static BYTE read_dir(void)
{
    struct entry *e;

    count = 0;
    if (path[0]) {
        e = &entries[0];
        memset(e->name, 0, 12);
        memcpy(e->name, "..", 2);
        e->kind = KIND_PARENT;
        order[0] = 0;
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
        e = &entries[count];
        memset(e->name, 0, 12);
        memcpy(e->name, fno.fname, strlen(fno.fname));
        e->kind = (fno.fattrib & AM_DIR) ? KIND_DIR : KIND_FILE;
        order[count] = (BYTE)count;
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
        strcpy(line, entry_name(order[n]));
        if (entries[order[n]].kind != KIND_FILE) {
            l = strlen(line);
            line[l] = '/';
            line[l + 1] = 0;
        }
    } else {
        line[0] = 0;
    }
    text(NAME_COL, LIST_ROW + row, line, COLS);
}

static void draw_cursor(const char *c)
{
    text(1, LIST_ROW + (BYTE)(sel - top), c, 2);
}

static void draw_page(void)
{
    BYTE r;
    const char *p = path[0] ? path : "/";
    WORD l = strlen(p);

    text(1, TITLE_ROW, "PC ENGINE", COLS);
    if (l > COLS - 12)
        p += l - (COLS - 12);
    text(11, TITLE_ROW, p, COLS);
    for (r = 0; r < LIST_ROWS; ++r) {
        text(1, LIST_ROW + r, " ", 2);
        draw_row(r);
    }
    if (count)
        draw_cursor(">");
    else
        text(NAME_COL, LIST_ROW, "NO GAMES HERE", COLS);
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
        draw_cursor(" ");
        sel = n;
        draw_cursor(">");
    }
}

/* ------------------------------------------------------------------------ */
/* Loading */

static void wait_idle(void)
{
    while (PH_CTRL & PH_STAT_BUSY)
        ;
}

static BYTE bitrev(BYTE b)
{
    BYTE r = 0, i;
    for (i = 0; i < 8; ++i) {
        r = (r << 1) | (b & 1);
        b >>= 1;
    }
    return r;
}

/* Load and start the game in fname. */
static BYTE load_game(void)
{
    UINT br, n, i;
    DWORD size, left;
    WORD kb;
    BYTE vec_hi = 0, swap;

    if (pf_open(fname) != FR_OK)
        return ERR_READ;
    size = fs.fsize;
    if ((size & 0x1FFF) == 512) {       /* copier header */
        if (pf_read(0, 512, &br) != FR_OK || br != 512)
            return ERR_READ;
        size -= 512;
    }
    if (size == 0)
        return ERR_EMPTY;
    if (size > ROM_MAX)
        return ERR_TOO_BIG;

    status("LOADING...");

    wait_idle();
    PH_ADDR0 = 0;
    PH_ADDR1 = 0;
    PH_ADDR2 = 0;

    /* Bank 0 through the CPU, for its reset vector at $1FFE */
    left = size;
    for (i = 0; i < 16 && left; ++i) {
        n = left > 512 ? 512 : (UINT)left;
        if (pf_read(buf, n, &br) != FR_OK || br != n)
            return ERR_READ;
        for (br = 0; br < n; ++br) {
            wait_idle();
            PH_LOAD_DATA = buf[br];
        }
        if (i == 15)
            vec_hi = buf[511];
        left -= n;
    }

    /* The rest straight to the SRAM */
    while (left) {
        n = left > 0x4000 ? 0x4000 : (UINT)left;
        if (pf_read(0, n, &br) != FR_OK || br != n)
            return ERR_READ;
        left -= n;
    }
    wait_idle();

    /* The reset vector points into $E000-$FFFF; reversed bits if only the
     * reversed byte does. */
    swap = (vec_hi & 0xE0) != 0xE0 && (bitrev(vec_hi) & 0xE0) == 0xE0;

    kb = (WORD)((size + 1023) >> 10);
    PH_SIZE_LO = (BYTE)kb;
    PH_SIZE_HI = (BYTE)(kb >> 8);
    PH_SWAP = swap;
    PH_START = 1;
    for (;;)
        ;
}

static void open_selected(void)
{
    struct entry *e;
    BYTE r;

    if (!count)
        return;
    e = &entries[order[sel]];
    if (e->kind == KIND_PARENT) {
        path_leave();
        show_folder();
        return;
    }
    if (e->kind == KIND_DIR) {
        if (path_enter(entry_name(order[sel])))
            show_folder();
        return;
    }

    strcpy(fname, path);
    strcat(fname, "/");
    strcat(fname, entry_name(order[sel]));
    r = load_game();
    status(errors[r]);
}

static void fatal(BYTE code)
{
    cls();
    text(1, TITLE_ROW, "PC ENGINE", COLS);
    text(1, LIST_ROW, errors[code], COLS);
    text(1, LIST_ROW + 2, "PRESS I TO RETRY", COLS);
    PH_LED = 1;
    wait_button();
    PH_LED = 0;
    cls();
}

void main(void)
{
    BYTE b, n;

    screen_init();
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
        else if (b & (PAD_I | PAD_RUN))
            open_selected();
        else if ((b & PAD_II) && path[0]) {
            path_leave();
            show_folder();
        }
        (void)key_pressed();
    }
}
