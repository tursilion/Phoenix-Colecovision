; Start-up code for the Phoenix Game Boy loader (SDCC sm83).
;
; The core starts the loader at $0000 in CGB mode, with no boot ROM.  It
; switches to double speed, sets the stack at the top of the work RAM,
; sets up the C globals and runs main().

        .module crt0
        .globl  _main

        .area   _HEADER (ABS)
        .org    0x0000
        di
        ld      sp, #0xE000
        jp      init

        .org    0x0100
init:
        ; CGB double speed: KEY1 bit 0, then STOP
        ld      a, #0x01
        ldh     (0x4D), a
        .db     0x10, 0x00      ; stop
        nop

        ; Zero the globals, then copy the initialized ones.
        ld      hl, #s__DATA
        ld      bc, #l__DATA
        xor     a, a
1$:     ld      a, b
        or      a, c
        jr      z, 2$
        xor     a, a
        ld      (hl+), a
        dec     bc
        jr      1$
2$:
        ld      de, #s__INITIALIZED
        ld      hl, #s__INITIALIZER
        ld      bc, #l__INITIALIZER
3$:     ld      a, b
        or      a, c
        jr      z, 4$
        ld      a, (hl+)
        ld      (de), a
        inc     de
        dec     bc
        jr      3$
4$:
        call    _main
5$:     jr      5$

        ; Ordering of segments for the linker.
        .area   _HOME
        .area   _CODE
        .area   _INITIALIZER
        .area   _GSINIT
        .area   _GSFINAL

        .area   _DATA
        .area   _INITIALIZED
        .area   _BSEG
        .area   _BSS
        .area   _HEAP
