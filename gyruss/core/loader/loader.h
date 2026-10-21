/* Shared definitions of the boot loader. */

#ifndef LOADER_H
#define LOADER_H

#include "pff/pff.h"

#define SECTOR_CACHE  ((BYTE *)0xA000)      /* 512 bytes in the shared RAM */

extern BYTE sd_block_addr;
BYTE sd_read_sector(BYTE *dst, DWORD sector);
void load_write(const BYTE *src, UINT count);

#endif
