;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_phRAMBankSelect	=	0x0054
_phBankingScheme	=	0x0055
_phSDControl	=	0x0056
_phSDData	=	0x0057
_phCartMask	=	0x0059
_phCachePage	=	0x005c
_phCacheCheck	=	0x005d
_phCacheStatus	=	0x005e
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:37: static BYTE spi(BYTE b) { phSDData = b; return phSDData; }
;	---------------------------------
; Function spi
; ---------------------------------
_spi:
	out	(_phSDData), a
	in	a, (_phSDData)
	ret
;main.c:41: static void read_sector(DWORD s, BYTE *dst)
;	---------------------------------
; Function read_sector
; ---------------------------------
_read_sector:
;main.c:45: phSDControl = 0;                    /* select, fast */
	ld	a, #0x00
	out	(_phSDControl), a
;main.c:46: spi(0xFF);
	push	hl
	push	de
	ld	a, #0xff
	call	_spi
	pop	de
	pop	hl
;main.c:47: phSDData = 0x51;
	ld	a, #0x51
	out	(_phSDData), a
;main.c:48: phSDData = (BYTE)(s >> 24);
	ld	a, h
	out	(_phSDData), a
;main.c:49: phSDData = (BYTE)(s >> 16);
	ld	a, l
	out	(_phSDData), a
;main.c:50: phSDData = (BYTE)(s >> 8);
	ld	a, d
	out	(_phSDData), a
;main.c:51: phSDData = (BYTE)s;
	ld	a, e
	out	(_phSDData), a
;main.c:52: phSDData = 0x01;
	ld	a, #0x01
	out	(_phSDData), a
;main.c:53: if (!dst) {
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	or	a, (hl)
	jr	NZ, 00103$
;main.c:54: phSDControl = 1;
	ld	a, #0x01
	out	(_phSDControl), a
;main.c:55: spi(0xFF);
	ld	a, #0xff
	call	_spi
;main.c:56: return;
	jr	00115$
;main.c:58: do { r = phSDData; } while (r == 0xFF);
00103$:
	in	a, (_phSDData)
	inc	a
	jr	Z, 00103$
;main.c:59: do { r = phSDData; } while (r != 0xFE);
00106$:
	in	a, (_phSDData)
	sub	a, #0xfe
	jr	NZ, 00106$
;main.c:60: for (i = 0; i < 512; ++i) {
	pop	de
	pop	hl
	push	hl
	push	de
	ld	de, #0x0200
00114$:
;main.c:61: r = phSDData;
	in	a, (_phSDData)
	ld	c, a
;main.c:62: if (dst) *dst++ = r;
	ld	a, h
	or	a, l
	jr	Z, 00110$
	ld	(hl), c
	inc	hl
00110$:
	dec	de
;main.c:60: for (i = 0; i < 512; ++i) {
	ld	a, d
	or	a, e
	jr	NZ, 00114$
;main.c:64: r = phSDData; r = phSDData;         /* CRC */
	in	a, (_phSDData)
	in	a, (_phSDData)
;main.c:65: phSDControl = 1;                    /* deselect */
	ld	a, #0x01
	out	(_phSDControl), a
;main.c:66: spi(0xFF);
	ld	a, #0xff
	call	_spi
00115$:
;main.c:67: }
	pop	hl
	pop	af
	jp	(hl)
;main.c:72: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;main.c:80: phBankingScheme = 0x01 | 0x00;      /* MegaCart, upper internal RAM */
	ld	a, #0x01
	out	(_phBankingScheme), a
;main.c:103: do {
	ld	c, #0x00
00101$:
;main.c:104: phCachePage = i;
	ld	a, c
	out	(_phCachePage), a
;main.c:105: read_sector(IMG_SECT + (DWORD)i * 16, 0);
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	de, #0x0000
	ld	b, #0x04
00143$:
	add	hl, hl
	rl	e
	rl	d
	djnz	00143$
	ld	-4 (ix), l
	ld	a, h
	add	a, #0x08
	ld	-3 (ix), a
	ld	a, e
	adc	a, #0x00
	ld	-2 (ix), a
	ld	a, d
	adc	a, #0x00
	ld	-1 (ix), a
	push	hl
	push	bc
	push	de
	ld	hl, #0x0000
	push	hl
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_read_sector
	pop	de
	pop	bc
	pop	hl
;main.c:106: phCacheCheck = i;
	ld	a, c
	out	(_phCacheCheck), a
;main.c:107: read_sector(IMG_SECT + (DWORD)i * 16 + 15, 0);
	push	de
	ld	de, #0x080f
	add	hl, de
	pop	de
	jr	NC, 00145$
	inc	de
00145$:
	push	bc
	ld	bc, #0x0000
	push	bc
	ex	de, hl
	call	_read_sector
	pop	bc
;main.c:108: } while (++i != (BYTE)(IMG_BLOCKS * 2));
	inc	c
	ld	a, c
;main.c:109: phCacheStatus = 0;
	sub	a,#0x40
	jr	NZ, 00101$
	out	(_phCacheStatus), a
;main.c:110: if (phCacheStatus & 1)
	in	a, (_phCacheStatus)
	rrca
	jr	NC, 00108$
00111$:
	jr	00111$
00108$:
;main.c:114: phCartMask = IMG_SGM ? IMG_BLOCKS * 2 - 1 : IMG_BLOCKS - 1;
	ld	a, #0x1f
	out	(_phCartMask), a
;main.c:115: phBankingScheme = IMG_SGM ? (0x02 | 0x10) : (0x01 | 0x10);
	ld	a, #0x11
	out	(_phBankingScheme), a
;main.c:116: phRAMBankSelect = 1;
	ld	a, #0x01
	out	(_phRAMBankSelect), a
;main.c:118: for (i = 0; i < sizeof(start_code); ++i)
	ld	c, #0x00
00112$:
;main.c:119: MEM(0x6000 + i) = start_code[i];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x6000
	add	hl, de
	ex	de, hl
	ld	hl, #_start_code
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:118: for (i = 0; i < sizeof(start_code); ++i)
	inc	c
	ld	a, c
	sub	a, #0x06
	jr	C, 00112$
;main.c:120: ((void (*)(void))0x6000)();
	call	0x6000
;main.c:121: }
	ld	sp, ix
	pop	ix
	ret
_start_code:
	.db #0xdb	; 219
	.db #0x55	; 85	'U'
	.db #0x2a	; 42
	.db #0x0a	; 10
	.db #0x80	; 128
	.db #0xe9	; 233
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
