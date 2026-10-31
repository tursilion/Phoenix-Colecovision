; NES cache test startup (MMC3, this code in the fixed last PRG page).

        .export     __STARTUP__ : absolute = 1
        .import     zerobss, copydata, _main
        .import     __RAM_START__, __RAM_SIZE__

        .include    "zeropage.inc"

        .segment    "STARTUP"

reset:  sei
        cld
        ldx     #$FF
        txs
        lda     #0
        sta     $2000           ; PPU: no NMI
        sta     $2001           ; PPU: rendering off

        ; C stack at the top of RAM
        lda     #<(__RAM_START__ + __RAM_SIZE__)
        sta     sp
        lda     #>(__RAM_START__ + __RAM_SIZE__)
        sta     sp+1

        jsr     zerobss
        jsr     copydata
        jsr     _main
@hang:  jmp     @hang

nmi:
irq:    rti

        .segment    "VECTORS"
        .word       nmi, reset, irq
