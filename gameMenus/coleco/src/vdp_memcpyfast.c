#include "vdp.h"

extern void vdpmemcpyfast(unsigned int pAddr, const unsigned char *pSrc, unsigned int cnt);
void dummyfunc() {
__asm
; stack has ret, pAddr, source, count
; for OTIR we need port in C, src in HL and count in B
_vdpmemcpyfast::
; save regs
	push ix
    push hl
    push bc
    push de
    push af

; point sp at pAddr
    ld ix,#12
    add ix,sp	; ix pointing at pAddr

; set the VDP address
	ld e,(ix)
	ld d,1(ix)
	ld a,e
	out (_VDPWA),a
	ld a,d
	set 6,a
	out (_VDPWA),a
	
; get source into hl
	ld l,2(ix)
	ld h,3(ix)

; get count into de
	ld e,4(ix)
	ld d,5(ix)

; get port into c
    ld c,#_VDPWD
    	
; outer loop
$0001:
	inc d		; zero test - http://z80-heaven.wikidot.com/optimization#toc14
	dec d
	jr Z,$0002	; if no

; since were > 256 but can only do 256 at a time, just run it that way
	xor a
	ld b,a
	otir		; runs 256
	
	dec d		; subtract 256
	jr $0001
	
; last pass
$0002:
    inc e
    dec e
    jr Z,$0003  ; 0 bytes remaining
	ld b,e		; get remaining count
	otir
	
; restore the stack and return
$0003:
	pop af
	pop de
	pop bc
	pop hl
	pop ix

__endasm;
}
