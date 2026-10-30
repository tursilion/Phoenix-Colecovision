/* Petit FatFs disk I/O for the Phoenix PC Engine loader: SD card over the
 * loader I/O window's SPI port.  Reads only.  A NULL buffer forwards the
 * data to the SRAM with the hardware forward engine.
 */

#include <string.h>
#include "pff/diskio.h"
#include "phoenix.h"

#define CMD0    0x40            /* GO_IDLE_STATE */
#define CMD8    (0x40 + 8)      /* SEND_IF_COND */
#define CMD16   (0x40 + 16)     /* SET_BLOCKLEN */
#define CMD17   (0x40 + 17)     /* READ_SINGLE_BLOCK */
#define CMD55   (0x40 + 55)     /* APP_CMD */
#define CMD58   (0x40 + 58)     /* READ_OCR */
#define ACMD41  (0xC0 + 41)     /* SD_SEND_OP_COND (application command) */

static BYTE ctrl;               /* current PH_CTRL value */
static BYTE block_addr;         /* SDHC/SDXC: sector numbers, not byte offsets */

/* One-sector cache for buffered reads (directory and FAT), at the top of
 * the work RAM below the C stack (boot.cfg).  Petit FatFs reads these a few
 * bytes at a time. */
#define CACHE ((BYTE *)0x3A00)
static DWORD cache_sector;
static BYTE cache_valid;

void __fastcall__ spi_read_block(BYTE *dst);

static BYTE xfer(BYTE b)
{
    PH_SPI_DATA = b;
    while (PH_CTRL & PH_STAT_BUSY)
        ;
    return PH_SPI_DATA;
}

static void select(void)
{
    ctrl |= PH_CTRL_SELECT;
    PH_CTRL = ctrl;
    xfer(0xFF);
}

static void deselect(void)
{
    ctrl &= ~PH_CTRL_SELECT;
    PH_CTRL = ctrl;
    xfer(0xFF);                 /* release MISO */
}

/* Clock in n bytes with the forward engine, to the ROM loader or nowhere. */
static void forward(UINT n, BYTE discard)
{
    if (!n)
        return;
    if (discard)
        PH_CTRL = ctrl | PH_CTRL_DISCARD;
    PH_FWD_LO = (BYTE)n;
    PH_FWD_HI = (BYTE)(n >> 8);
    while (PH_CTRL & PH_STAT_BUSY)
        ;
    PH_CTRL = ctrl;
}

static BYTE send_cmd(BYTE cmd, DWORD arg)
{
    BYTE n, r;

    if (cmd & 0x80) {           /* application command: CMD55 first */
        cmd &= 0x7F;
        r = send_cmd(CMD55, 0);
        if (r > 1)
            return r;
    }

    deselect();
    select();

    xfer(cmd);
    xfer(((BYTE *)&arg)[3]);    /* 6502 is little-endian; avoids long shifts */
    xfer(((BYTE *)&arg)[2]);
    xfer(((BYTE *)&arg)[1]);
    xfer(((BYTE *)&arg)[0]);
    xfer(cmd == CMD0 ? 0x95 : cmd == CMD8 ? 0x87 : 0x01);

    n = 10;
    do {
        r = xfer(0xFF);
    } while ((r & 0x80) && --n);
    return r;
}

/* SD v1 cards take byte offsets, not sector numbers */
BYTE disk_block_addr(void)
{
    return block_addr;
}

DSTATUS disk_initialize(void)
{
    BYTE n, ocr[4];
    WORD tmr;

    ctrl = PH_CTRL_SLOW;
    PH_CTRL = ctrl;
    block_addr = 0;
    cache_valid = 0;

    if (!(PH_CTRL & PH_STAT_CARD))
        return STA_NODISK;

    for (n = 10; n; --n)        /* 80 clocks with CS deasserted */
        xfer(0xFF);

    if (send_cmd(CMD0, 0) != 1) {
        deselect();
        return STA_NOINIT;
    }

    if (send_cmd(CMD8, 0x1AA) == 1) {
        /* SD v2 */
        for (n = 0; n < 4; ++n)
            ocr[n] = xfer(0xFF);
        if (ocr[2] != 0x01 || ocr[3] != 0xAA) {
            deselect();
            return STA_NOINIT;
        }
        for (tmr = 10000; tmr && send_cmd(ACMD41, 1UL << 30); --tmr)
            ;
        if (!tmr || send_cmd(CMD58, 0) != 0) {
            deselect();
            return STA_NOINIT;
        }
        for (n = 0; n < 4; ++n)
            ocr[n] = xfer(0xFF);
        block_addr = (ocr[0] & 0x40) ? 1 : 0;
    } else {
        /* SD v1 */
        for (tmr = 10000; tmr && send_cmd(ACMD41, 0); --tmr)
            ;
        if (!tmr || send_cmd(CMD16, 512) != 0) {
            deselect();
            return STA_NOINIT;
        }
    }

    deselect();
    ctrl = 0;                   /* full speed */
    PH_CTRL = ctrl;
    return 0;
}

/* Send CMD17 and wait for the data token. */
static BYTE start_read(DWORD sector)
{
    WORD tmr;
    BYTE r;

    if (!block_addr)
        sector <<= 9;
    if (send_cmd(CMD17, sector) != 0)
        return 0;
    tmr = 40000U;
    do {
        r = xfer(0xFF);
    } while (r == 0xFF && --tmr);
    return r == 0xFE;
}

DRESULT disk_readp(BYTE *buff, DWORD sector, UINT offset, UINT count)
{
    DRESULT res = RES_ERROR;
    WORD rest;

    if (buff) {
        /* Buffered read, through the cache. */
        if (!cache_valid || cache_sector != sector) {
            cache_valid = 0;
            if (!start_read(sector)) {
                deselect();
                return RES_ERROR;
            }
            spi_read_block(CACHE);      /* and the first CRC byte */
            forward(1, 1);              /* the second */
            deselect();
            cache_sector = sector;
            cache_valid = 1;
        }
        memcpy(buff, CACHE + offset, count);
        return RES_OK;
    }

    /* Forward to the SRAM. */
    if (start_read(sector)) {
        rest = 514 - offset - count;    /* bytes after the data, with CRC */
        forward(offset, 1);
        forward(count, 0);
        forward(rest, 1);
        res = RES_OK;
    }

    deselect();
    return res;
}
