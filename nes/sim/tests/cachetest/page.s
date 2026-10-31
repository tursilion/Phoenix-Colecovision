; PRG page access for the cache test.
;
; unsigned __fastcall__ page_sum(unsigned char hi);
;   16-bit sum of the 1K at hi * 256.
; unsigned char __fastcall__ page_call(unsigned char hi);
;   calls the routine at hi * 256 (LDA #page / LDX #0 / RTS).

        .export     _page_sum, _page_call
        .importzp   ptr1, tmp1, tmp2

        .code

_page_sum:
        sta     ptr1+1
        lda     #0
        sta     ptr1
        sta     tmp1            ; sum low
        sta     tmp2            ; sum high
        ldx     #4              ; 4 x 256 bytes
        ldy     #0
@loop:  lda     (ptr1),y
        clc
        adc     tmp1
        sta     tmp1
        bcc     @nc
        inc     tmp2
@nc:    iny
        bne     @loop
        inc     ptr1+1
        dex
        bne     @loop
        lda     tmp1
        ldx     tmp2
        rts

_page_call:
        sta     ptr1+1
        lda     #0
        sta     ptr1
        jmp     (ptr1)
