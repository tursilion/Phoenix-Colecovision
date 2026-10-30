; Phoenix PC Engine loader startup.
;
; The core starts the loader in ROM bank 0 ($E000 after reset).  Map the
; I/O page at $0000, the work RAM at $2000 and loader bank 1 at $C000,
; switch to 7.16MHz, mask the interrupts and run main() with the C stack at
; the top of the work RAM.

        .setcpu     "HuC6280"
        .export     __STARTUP__ : absolute = 1
        .import     zerobss, copydata, _main
        .include    "zeropage.inc"

        .segment    "STARTUP"

reset:  sei
        csh                     ; 7.16MHz
        cld
        lda     #$FF
        tam     #$01            ; MPR0: I/O page
        lda     #$F8
        tam     #$02            ; MPR1: work RAM
        lda     #$01
        tam     #$40            ; MPR6: loader bank 1
        lda     #$00
        tam     #$80            ; MPR7: loader bank 0
        ldx     #$FF
        txs
        lda     #$07
        sta     $1402           ; mask IRQ2, IRQ1 and the timer
        stz     $0C01           ; timer off

        lda     #<$4000         ; C stack
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
        .word       irq, irq, irq, nmi, reset    ; IRQ2, IRQ1, timer, NMI, reset
