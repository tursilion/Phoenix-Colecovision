; Page access through MPR2 ($4000-$5FFF).
;
; unsigned __fastcall__ page_sum(unsigned char page);
;   16-bit sum of the page's 8192 bytes.
; unsigned char __fastcall__ page_call(unsigned char page);
;   calls the routine at the page's start (LDA #page / RTS).

        .setcpu     "HuC6280"
        .export     _page_sum, _page_call
        .importzp   ptr1, tmp1, tmp2

        .code

_page_sum:
        tam     #$04
        stz     tmp1            ; sum low
        stz     tmp2            ; sum high
        stz     ptr1
        lda     #$40
        sta     ptr1+1
        ldx     #$20            ; 32 pages of 256
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
        tam     #$04
        jsr     $4000
        ldx     #0
        rts
