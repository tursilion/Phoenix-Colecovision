;; Phoenix Gyruss core boot loader startup (sdcc, Z80).
;;
;; The loader starts in the tile ROM's block RAM at 0000-1FFF.  It first
;; copies itself to the SRAM at 20000 and switches to that copy, so that
;; the tile ROM can be loaded.  Variables at 9000 (work RAM), stack and
;; sector buffer in A000-A7FF (shared RAM).  No interrupts in boot mode.

	.module crt0
	.globl	_main

	.area	_HEADER (ABS)
	.org	0
	di
	jp	init

	.org	0x38
	reti

	.org	0x66
	retn

	.org	0x100
init:
	ld	sp, #0xA800
	;; copy 0000-1FFF to load address 20000
	xor	a
	ld	(0xC002), a
	ld	(0xC003), a
	ld	a, #2
	ld	(0xC004), a
	ld	hl, #0
	ld	c, #0
	ld	d, #32
1$:	ld	b, #0
	otir				; 256 bytes, one I/O write each
	dec	d
	jr	NZ, 1$
2$:	ld	a, (0xC002)		; wait for the last SRAM write
	rrca
	jr	C, 2$
	ld	a, #1
	ld	(0xC00C), a		; run from the copy
	call	gsinit
	call	_main
3$:	halt
	jr	3$

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area	_GSINIT
	.area	_GSFINAL

	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area	_BSS
	.area	_HEAP

	.area	_GSINIT
gsinit::
	ld	bc, #l__DATA
	ld	a, b
	or	a, c
	jr	Z, zeroed_data
	ld	hl, #s__DATA
	ld	(hl), #0x00
	dec	bc
	ld	a, b
	or	a, c
	jr	Z, zeroed_data
	ld	e, l
	ld	d, h
	inc	de
	ldir
zeroed_data:
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	.area	_GSFINAL
	ret
