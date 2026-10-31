; Page access for the cache test (sdcccall 1).
;
; unsigned int page_sum(unsigned int addr, unsigned int len);
;   16-bit sum of len bytes from addr (addr in HL, len in DE, sum in DE)
; unsigned char page_call(unsigned int addr);
;   calls the routine at addr (LD A,page / RET), returns A

        .module page
        .globl  _page_sum, _page_call

        .area   _CODE

_page_sum:
        ld      b, d            ; BC = len
        ld      c, e
        ld      de, #0
1$:     ld      a, (hl)
        inc     hl
        add     a, e
        ld      e, a
        jr      nc, 2$
        inc     d
2$:     dec     bc
        ld      a, b
        or      a, c
        jr      nz, 1$
        ret

_page_call:
        jp      (hl)
