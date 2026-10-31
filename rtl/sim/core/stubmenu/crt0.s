; Stub menu start-up (the loader ROM at $0000, RAM at $7000-$7FFF).
        .module crt0
        .globl  _main
        .area   _HEADER (ABS)
        .org    0x0000
        di
        ld      sp, #0x7F00
        jp      _main
        .org    0x0066
        retn                    ; NMI
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
