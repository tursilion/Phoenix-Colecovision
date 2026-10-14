;; Phoenix Dragon's Lair core boot loader startup (sdcc, Z80).
;;
;; The loader runs from the 24K boot RAM at 0000 (code and constants up to
;; 3FFF, buffers above), with its variables and stack in the 2K RAM at
;; A000-A7FF.  No interrupts in boot mode.

	.module crt0
	.globl	_main

	.area	_HEADER (ABS)
	.org	0
	di
	jp	init

	.org	0x38
	reti

	.org	0x100
init:
	ld	sp,#0xA800
	call	gsinit
	call	_main
1$:	halt
	jr	1$

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
