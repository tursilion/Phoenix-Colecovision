/*-----------------------------------------------------------------------*/
/* Low level disk I/O module for Phoenix SD Card                         */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Obtains integer types */
#include "diskio.h"		/* Declarations of disk functions */
#include "../phoenix.h" /* declarations of Phoenix hardware */

// Code adapted from the generic sdmm.c - not updated to Matt's reference just yet
// Obviously not bit-banging though.
// License for those parts:
/*------------------------------------------------------------------------/
/  Foolproof MMCv3/SDv1/SDv2 (in SPI mode) control module
/-------------------------------------------------------------------------/
/
/  Copyright (C) 2013, ChaN, all right reserved.
/
/ * This software is a free software and there is NO WARRANTY.
/ * No restriction on use. You can use, modify and redistribute it for
/   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
/ * Redistributions of source code must retain the above copyright notice.
*/
/*-----------------------------------------------------------------------*/
/* Receive bytes from the card (hardware)                                */
/*-----------------------------------------------------------------------*/
void rcvr_mmc (
	BYTE *buff,	/* Pointer to read buffer */
	UINT bc		/* Number of bytes to receive */
)
{
    // I think the hardware sends the 0xff for us...?
	do {
        *buff++ = phSDData;
	} while (--bc);
}

