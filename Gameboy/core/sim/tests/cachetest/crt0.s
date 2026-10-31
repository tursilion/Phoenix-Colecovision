; Cache test start-up: header at $0100, code at $0150.  Keeps the boot
; ROM's A ($11 on a Game Boy Color) in _boot_a.
        .module crt0
        .globl  _main, _boot_a

        .area   _HEADER (ABS)
        .org    0x0100
        nop
        jp      0x0150
        ; $0104-$014F: filled in by mkcache.py

        .org    0x0150
        di
        ld      sp, #0xE000
        ld      (_boot_a), a
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
