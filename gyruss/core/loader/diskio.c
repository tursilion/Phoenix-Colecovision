/* Petit FatFs disk I/O for the Phoenix Gyruss core boot loader: SD card
 * over the boot SPI port.  Reads only, through a one-sector cache; a read
 * without a buffer goes to the load port.  Adapted from the Dragon's Lair
 * core's loader.
 */

#include <string.h>
#include "pff/diskio.h"
#include "phoenix.h"
#include "loader.h"

#define CMD0    0x40            /* GO_IDLE_STATE */
#define CMD8    (0x40 + 8)      /* SEND_IF_COND */
#define CMD12   (0x40 + 12)     /* STOP_TRANSMISSION */
#define CMD16   (0x40 + 16)     /* SET_BLOCKLEN */
#define CMD17   (0x40 + 17)     /* READ_SINGLE_BLOCK */
#define CMD55   (0x40 + 55)     /* APP_CMD */
#define CMD58   (0x40 + 58)     /* READ_OCR */
#define ACMD41  (0xC0 + 41)     /* SD_SEND_OP_COND (application command) */

static BYTE ctrl;               /* current PH_CTRL value */
BYTE sd_block_addr;             /* SDHC/SDXC: sector numbers, not byte offsets */

static DWORD cache_sector;
static BYTE cache_valid;

void spi_read_block(BYTE *dst);

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
    xfer(((BYTE *)&arg)[3]);    /* little-endian */
    xfer(((BYTE *)&arg)[2]);
    xfer(((BYTE *)&arg)[1]);
    xfer(((BYTE *)&arg)[0]);
    xfer(cmd == CMD0 ? 0x95 : cmd == CMD8 ? 0x87 : cmd == CMD12 ? 0x61 : 0x01);

    if (cmd == CMD12)
        xfer(0xFF);             /* stuff byte */
    n = 10;
    do {
        r = xfer(0xFF);
    } while ((r & 0x80) && --n);
    return r;
}

DSTATUS disk_initialize(void)
{
    BYTE n, ocr[4];
    WORD tmr;

    ctrl = PH_CTRL_SLOW;
    PH_CTRL = ctrl;
    sd_block_addr = 0;
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
        sd_block_addr = (ocr[0] & 0x40) ? 1 : 0;
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
    ctrl = PH_CTRL_FAST;
    PH_CTRL = ctrl;
    return 0;
}

/* Send CMD17 and wait for the data token. */
static BYTE start_read(DWORD sector)
{
    WORD tmr;
    BYTE r;

    if (!sd_block_addr)
        sector <<= 9;
    if (send_cmd(CMD17, sector) != 0)
        return 0;
    tmr = 40000U;
    do {
        r = xfer(0xFF);
    } while (r == 0xFF && --tmr);
    return r == 0xFE;
}

/* Read a whole sector into dst (512 bytes). */
BYTE sd_read_sector(BYTE *dst, DWORD sector)
{
    if (!start_read(sector)) {
        deselect();
        return 0;
    }
    spi_read_block(dst);        /* also clocks in CRC byte 0 */
    while (PH_CTRL & PH_STAT_BUSY)
        ;
    xfer(0xFF);                 /* CRC byte 1 */
    deselect();
    return 1;
}

DRESULT disk_readp(BYTE *buff, DWORD sector, UINT offset, UINT count)
{
    BYTE tries;

    if (!cache_valid || cache_sector != sector) {
        cache_valid = 0;
        for (tries = 0; !sd_read_sector(SECTOR_CACHE, sector); )
            if (++tries == 5)
                return RES_ERROR;
        cache_sector = sector;
        cache_valid = 1;
    }
    if (buff)
        memcpy(buff, SECTOR_CACHE + offset, count);
    else
        load_write(SECTOR_CACHE + offset, count);
    return RES_OK;
}
