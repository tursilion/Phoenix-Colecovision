; crt0.s for Phoenix ColecoVision Boot as a cartridge
; Note that a BIOS at 0x0000 has a different structure than a cartridge would!

	.module crt0
	.globl _main
	.globl _vdpinit
	.globl _my_nmi
	.globl _vdpLimi

	.area _HEADER(ABS)
	.org 0x8000

;	.db 0x55, 0xaa			; Test cart, no delay or init!
	.db 0xaa, 0x55			; Title screen and 12 second delay - swap 0x55 and 0xaa not to skip it.

	.dw 0					; sprite table stuff? - rarely used by the BIOS as a pointer
	.dw 0					; unknown - rarely used as a pointer to a single byte of RAM by the BIOS.
	.dw 0					; unknown - frequently used in BIOS routines as a pointer to a memory location (data is both
							; written to and read from there, at least 124 bytes are used - maybe this is where the bios
							; routines store most of their data, though with the common value of 0 this would be in the BIOS
							; ROM itself - strange).
	.dw 0					; pointer to 10 bytes of debounce buffer zeroed by BIOS at startup
	.dw start				; 0x800A - where to start execution of program.
	ei		; RST 0x08      ; 0x800c
	reti					
	ei		; RST 0x10      ; 0x800f
	reti
	ei		; RST 0x18      ; 0x8012
	reti
	ei		; RST 0x20      ; 0x8015
	reti
	ei		; RST 0x28      ; 0x8018
	reti
	ei		; RST 0x30      ; 0x801B
	reti
	ei		; RST 0x38        0x801E - spinner interrupt
	reti
	jp nmi		; NMI         0x8021 - NMI

    ; 0x8024 - title information, '/' delimited, date is always 4 chars
	.ascii "TURSI/PRESENTS PHOENIX BOOT/2019"

start:
	; clear interrupt flag right off
	ld hl,#_vdpLimi
	ld (hl),#0
	
	; clear RAM before starting
	ld hl,#0x7000			; set copy source
	ld de,#0x7001			; set copy dest
	ld bc,#0x03ff			; set bytes to copy (1 less than size)
	ld (hl),#0				; set initial value (this gets copied through)
	ldir					; do it
	
	ld  sp, #0x7400			; Set stack pointer to top of RAM
	call gsinit				; Initialize global variables. (always at end of code bank, so need above bank switch)
	
	call _vdpinit			; Initialize something or other ;)
	
	call _main				; call the user code
	rst 0x0					; Restart when main() returns. TODO: instead we can jump into the cartridge BIOS.

	;; Ordering of segments for the linker - copied from sdcc crt0.s
	.area _HOME
	.area _CODE
	.area _INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL
        
	.area _DATA
	.area _BSS
	.area _HEAP

	.area _BSS
_vdpLimi:		; 0x80 - interrupt set, other bits used by library
	.ds 1

    .area _CODE
nmi:
; all we do is set the MSB of _vdpLimi, and then check
; if the LSB is set. If so, we call user code now. if
; not, the library will deal with it when enabled.
	push af					; save flags (none affected, but play safe!)
	push hl
	
	ld hl,#_vdpLimi
	bit 0,(hl)				; check LSb (enable)
	jp z,notokay
	
; okay, full on call, save off the (other) regs
	push bc
	push de
	;push ix ; saved by callee
	push iy
	call _my_nmi			; call the lib version
	pop iy
	;pop ix
	pop de
	pop bc	
	jp clrup				

notokay:
	set 7,(hl)				; set MSb (flag)

clrup:
	pop hl					
	pop af
	retn

	.area _GSINIT
gsinit::
	.area _GSFINAL
	ret
