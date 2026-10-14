/* Phoenix Dragon's Lair core: boot loader and menu.
 *
 * Mounts the SD card and lists the folders and *.LD disc files of the
 * current folder, folders first, sorted by name.  The selected disc file
 * is checked, its game ROM is copied to the SRAM, and the game is started
 * with the stream engine pointed at the file's frames.
 *
 * The disc file must be contiguous on the card (the stream engine reads it
 * by sector number); a freshly formatted card with the files copied onto
 * it always is.  The loader checks the FAT chain.
 *
 * Controls: Up/Down move, Left/Right page, Fire or Start 1 open,
 * Start 2 parent folder.
 */

#include <string.h>
#include "pff/pff.h"
#include "pff/diskio.h"
#include "phoenix.h"
#include "loader.h"

/* ------------------------------------------------------------------------ */
/* Disc file header (sector 0 of a .LD file, little-endian), written by
 * tools/mkdisc.py */

struct disc_header {
    char  magic[8];         /* "PHXDISC1" */
    DWORD rom_sector;       /* file sector of the game ROM */
    DWORD rom_size;         /* bytes, up to 40K */
    DWORD frame_sector;     /* file sector of frame 0 */
    WORD  last_frame;
    BYTE  frame_sectors;    /* sectors per frame, 93 */
    BYTE  format;           /* 0: 4x4 cells of 4 colours */
    BYTE  dsw_a, dsw_b;
    BYTE  reserved[6];
    char  title[32];
    char  board[40];        /* scoreboard row text */
};

#define ROM_SRAM      0x70000UL
#define ROM_MAX       0xA000U

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

#define ENTRIES ((struct entry *)ENTRIES_ADDR)
#define ORDER   ((BYTE *)ORDER_ADDR)

static WORD count;

/* ------------------------------------------------------------------------ */
/* Screen layout (40 x 30 characters) */

#define LIST_ROW    3
#define LIST_ROWS   23
#define NAME_COL    3
#define STATUS_ROW  27
#define HELP_ROW    28
#define BOARD_ROW   29

#define ERR_NO_CARD     1
#define ERR_MOUNT       2
#define ERR_DIR         3
#define ERR_READ        4
#define ERR_BAD_HEADER  5
#define ERR_FRAGMENTED  6

static const char *const errors[] = {
    "",
    "NO SD CARD",
    "CANNOT READ THE SD CARD",
    "CANNOT READ THE FOLDER",
    "READ ERROR",
    "NOT A DISC FILE (MAKE IT WITH MKDISC)",
    "FILE IS FRAGMENTED: COPY TO A NEW CARD",
};

static const char help[] = "FIRE:OPEN  START2:BACK  L/R:PAGE";
static const char default_board[] =
    "1UP        L    CREDIT      2UP        L";

static FATFS fs;
static DIR dir;
static FILINFO fno;
static char path[80];       /* current folder, "" is the root */
static struct disc_header hdr;
static BYTE buf[64];

/* ------------------------------------------------------------------------ */
/* Text overlay */

/* Write a string, then pad with spaces up to column end.  attr 0x80 makes
 * it yellow. */
static void text(BYTE col, BYTE row, const char *s, BYTE end, BYTE attr)
{
    volatile BYTE *p = PH_TEXT + (WORD)row * TEXT_COLS + col;
    while (*s && col < end) {
        *p++ = *s++ | attr;
        ++col;
    }
    while (col++ < end)
        *p++ = ' ';
}

static void clear_rows(BYTE from, BYTE to)
{
    BYTE r;
    for (r = from; r < to; ++r)
        text(0, r, "", TEXT_COLS, 0);
}

static void status(const char *s)
{
    text(1, STATUS_ROW, s, TEXT_COLS - 1, 0x80);
}

static void wait_vblank(void)
{
    while (PH_SRAM_A1 & 1)
        ;
    while (!(PH_SRAM_A1 & 1))
        ;
}

/* ------------------------------------------------------------------------ */
/* Controller */

#define PAD_UP     0x01
#define PAD_DOWN   0x02
#define PAD_LEFT   0x04
#define PAD_RIGHT  0x08
#define PAD_FIRE   0x10
#define PAD_START1 0x20
#define PAD_START2 0x40
#define PAD_DIRS   (PAD_UP | PAD_DOWN | PAD_LEFT | PAD_RIGHT)

static BYTE read_pad(void)
{
    BYTE j = ~PH_JOY & 0x1F;
    BYTE s = ~PH_SYS;
    if (s & SYS_START1) j |= PAD_START1;
    if (s & SYS_START2) j |= PAD_START2;
    return j;
}

static BYTE pad_last;
static BYTE pad_timer;

/* Newly pressed buttons, with auto-repeat for the directions.  Call once
 * per frame. */
static BYTE pad_pressed(void)
{
    BYTE now = read_pad();
    BYTE pressed = now & ~pad_last;

    if (now & PAD_DIRS) {
        if (pressed)
            pad_timer = 20;
        else if (--pad_timer == 0) {
            pad_timer = 4;
            pressed |= now & PAD_DIRS;
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
    } while (!(b & (PAD_FIRE | PAD_START1 | PAD_START2)));
}

/* ------------------------------------------------------------------------ */
/* Directory */

/* Is the 8.3 name a .LD file? */
static BYTE is_disc(const char *name)
{
    const char *dot = strchr(name, '.');
    return dot != 0 && strcmp(dot, ".LD") == 0;
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
        if (!(fno.fattrib & AM_DIR) && !is_disc(fno.fname))
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
    text(NAME_COL, LIST_ROW + row, line, TEXT_COLS - 1, 0);
}

static void draw_cursor(char c)
{
    text(1, LIST_ROW + (BYTE)(sel - top), c == ' ' ? " " : ">", 2, 0x80);
}

static void draw_page(void)
{
    BYTE r;
    char title[40];

    strcpy(title, "PHOENIX LASERDISC  ");
    strncat(title, path[0] ? path : "/", sizeof(title) - 20);
    text(1, 1, title, TEXT_COLS - 1, 0x80);
    for (r = 0; r < LIST_ROWS; ++r) {
        text(1, LIST_ROW + r, " ", 2, 0);
        draw_row(r);
    }
    if (count)
        draw_cursor('>');
    else
        text(NAME_COL, LIST_ROW, "NO .LD FILES HERE", TEXT_COLS - 1, 0);
    text(1, HELP_ROW, help, TEXT_COLS - 1, 0);
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

static void sram_at(DWORD a)
{
    PH_SRAM_A0 = (BYTE)a;
    PH_SRAM_A1 = (BYTE)(a >> 8);
    PH_SRAM_A2 = (BYTE)(a >> 16);
}

static void put32(volatile BYTE *r, DWORD v)
{
    r[0] = (BYTE)v;
    r[1] = (BYTE)(v >> 8);
    r[2] = (BYTE)(v >> 16);
    r[3] = (BYTE)(v >> 24);
}

/* Is the open file one run of clusters?  The core's FAT checker reads the
 * file's FAT entries in one multi-block read and checks FAT[c] = c + 1 for
 * all but the last cluster.  Returns 0 if it does, else an error code. */
static BYTE check_contiguous(void)
{
    DWORD c = fs.org_clust;
    DWORD clusters;
    DWORD cbytes = (DWORD)fs.csize * 512;
    BYTE fat32 = (fs.fs_type == FS_FAT32);

    clusters = (fs.fsize + cbytes - 1) / cbytes;
    if (clusters < 2)
        return 0;

    PH_SDHC = sd_block_addr;
    put32(&PH_CHK_SECT0, fs.fatbase + (fat32 ? (c >> 7) : (c >> 8)));
    PH_CHK_INDEX = fat32 ? (BYTE)(c & 127) : (BYTE)c;
    PH_CHK_FAT16 = !fat32;
    put32(&PH_CHK_EXP0, c + 1);
    put32(&PH_CHK_CNT0, clusters - 1);
    PH_CHK_START = 0;
    while (PH_CHK_STATUS & PH_CHK_BUSY)
        ;
    if (PH_CHK_STATUS & PH_CHK_ERR)
        return ERR_READ;
    if (PH_CHK_STATUS & PH_CHK_BAD)
        return ERR_FRAGMENTED;
    return 0;
}

/* Load and start the game; returns an error code if it cannot. */
static BYTE load_game(const char *file)
{
    UINT br, n;
    DWORD base;
    WORD a;
    BYTE i;

    if (pf_open(file) != FR_OK)
        return ERR_READ;

    if (pf_read(&hdr, sizeof(hdr), &br) != FR_OK || br != sizeof(hdr))
        return ERR_READ;
    if (memcmp(hdr.magic, "PHXDISC1", 8) != 0 || hdr.rom_size > ROM_MAX ||
        hdr.frame_sectors != 93 || hdr.format != 0)
        return ERR_BAD_HEADER;

    text(1, 2, hdr.title, TEXT_COLS - 1, 0);

    /* Game ROM to the SRAM, 512 bytes at a time, the rest of the 40K
     * filled with FF */
    if (pf_lseek(hdr.rom_sector * 512) != FR_OK)
        return ERR_READ;
    sram_at(ROM_SRAM);
    for (a = 0; a < ROM_MAX; a += 512) {
        if (a < (WORD)hdr.rom_size) {
            n = (WORD)hdr.rom_size - a > 512 ? 512 : (UINT)((WORD)hdr.rom_size - a);
            if (pf_read(LOAD_BUF, n, &br) != FR_OK || br != n)
                return ERR_READ;
            if (n < 512)
                memset(LOAD_BUF + n, 0xFF, 512 - n);
        } else if (a == ((WORD)hdr.rom_size + 511) / 512 * 512)
            memset(LOAD_BUF, 0xFF, 512);
        sram_write_512(LOAD_BUF);
    }

    status("CHECKING THE FILE");
    if ((i = check_contiguous()) != 0)
        return i;

    base = fs.database + (fs.org_clust - 2) * fs.csize + hdr.frame_sector;
    PH_LBA0 = (BYTE)base;
    PH_LBA1 = (BYTE)(base >> 8);
    PH_LBA2 = (BYTE)(base >> 16);
    PH_LBA3 = (BYTE)(base >> 24);
    PH_SDHC = sd_block_addr;
    PH_MAXF_LO = (BYTE)hdr.last_frame;
    PH_MAXF_HI = (BYTE)(hdr.last_frame >> 8);
    PH_DSW_A = hdr.dsw_a;
    PH_DSW_B = hdr.dsw_b;

    /* Leave only the scoreboard row on screen. */
    clear_rows(0, BOARD_ROW);
    if (hdr.board[0]) {
        for (i = 0; i < TEXT_COLS; ++i)
            PH_TEXT[BOARD_ROW * TEXT_COLS + i] = hdr.board[i] ? hdr.board[i] : ' ';
    } else
        text(0, BOARD_ROW, default_board, TEXT_COLS, 0);

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
        status("");
        text(1, 2, "", TEXT_COLS - 1, 0);
    }
}

/* ------------------------------------------------------------------------ */

static void fatal(BYTE code)
{
    PH_LED = 1;
    text(1, 1, "PHOENIX LASERDISC", TEXT_COLS - 1, 0x80);
    text(1, 4, errors[code], TEXT_COLS - 1, 0);
    text(1, 6, "INSERT A FAT16 OR FAT32 CARD", TEXT_COLS - 1, 0);
    text(1, 7, "AND PRESS FIRE", TEXT_COLS - 1, 0);
    wait_button();
    PH_LED = 0;
    clear_rows(0, TEXT_ROWS);
}

void main(void)
{
    BYTE b, n;

    PH_LED = 0;
    clear_rows(0, TEXT_ROWS);

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
        else if (b & (PAD_FIRE | PAD_START1))
            open_selected();
        else if ((b & PAD_START2) && path[0]) {
            path_leave();
            show_folder();
        }
    }
}
