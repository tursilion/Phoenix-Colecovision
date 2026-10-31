; Cache test cartridge start-up.  Header at $8000: $55 $AA (test mode: the
; BIOS, or the Phoenix menu, jumps straight to the start address at $800A).
        .module crt0
        .globl  _main

        .area   _HEADER (ABS)
        .org    0x8000
        .db     0x55, 0xAA
        .dw     0, 0, 0, 0      ; sprite table, order, work buffer, controller map
        .dw     start           ; $800A
start:  di
        ld      sp, #0x7400     ; top of the 1K RAM (mirror)
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
