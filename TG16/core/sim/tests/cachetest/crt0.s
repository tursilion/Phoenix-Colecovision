; Cache test HuCard startup: bank 0 at $E000 (MPR7 = 0 after reset).
; Map the I/O page at $0000 and the work RAM at $2000, 7.16MHz, interrupts
; masked, C stack at the top of the work RAM.

        .setcpu     "HuC6280"
        .export     __STARTUP__ : absolute = 1
        .import     zerobss, copydata, _main
        .include    "zeropage.inc"

        .segment    "STARTUP"

reset:  sei
        csh
        cld
        lda     #$FF
        tam     #$01
        lda     #$F8
        tam     #$02
        ldx     #$FF
        txs
        lda     #$07
        sta     $1402
        stz     $0C01
        lda     #<$4000
        sta     sp
        lda     #>$4000
        sta     sp+1
        jsr     zerobss
        jsr     copydata
        jsr     _main
@hang:  jmp     @hang

nmi:
irq:    rti

        .segment    "VECTORS"
        .word       irq, irq, irq, nmi, reset
