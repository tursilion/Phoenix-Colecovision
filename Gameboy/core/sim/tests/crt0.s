; Start-up code for the test cartridges: header at $0100, code at $0150.
        .module crt0
        .globl  _main

        .area   _HEADER (ABS)
        .org    0x0100
        nop
        jp      0x0150
        ; $0104-$014F: filled in by mkbig.py (logo, title, type, checksum)

        .org    0x0150
        di
        ld      sp, #0xE000
        call    _main
1$:     jr      1$

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
