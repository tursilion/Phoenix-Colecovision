; Page access for the cache test (sdcccall 1: argument in A, 16-bit result
; in BC).
;
; unsigned int page_sum(unsigned char hi);   16-bit sum of 1K from hi * 256
; unsigned char page_call(unsigned char hi); calls the routine at hi * 256

        .module page
        .globl  _page_sum, _page_call

        .area   _CODE

_page_sum:
        ld      h, a
        ld      l, #0
        ld      bc, #0
        ld      d, #4           ; 4 x 256 bytes
        ld      e, #0
1$:     ld      a, (hl+)
        add     a, c
        ld      c, a
        jr      nc, 2$
        inc     b
2$:     dec     e
        jr      nz, 1$
        dec     d
        jr      nz, 1$
        ret

_page_call:
        ld      h, a
        ld      l, #0
        jp      (hl)
