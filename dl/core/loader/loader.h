/* Shared definitions of the boot loader. */

#ifndef LOADER_H
#define LOADER_H

#include "pff/pff.h"

/* Buffers in the 24K boot RAM, above the code and constants (which must
 * end below 0x4000, see the Makefile). */
#define ENTRIES_ADDR  0x4000        /* 256 x 13 bytes of directory entries */
#define ORDER_ADDR    0x4D00        /* 256 sorted entry numbers */
#define SECTOR_CACHE  ((BYTE *)0x4E00)
#define LOAD_BUF      ((BYTE *)0x5000)      /* 512 bytes for the ROM copy */

extern BYTE sd_block_addr;
BYTE sd_read_sector(BYTE *dst, DWORD sector);
void sram_write_512(const BYTE *src);

#endif
