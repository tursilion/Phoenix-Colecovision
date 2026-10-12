; Phoenix NES core test cartridge (NROM-128).
;
; Picture: blue backdrop, white 8-pixel border around the whole 256x240
; screen, red 32x32 block with its top-left corner at (80,80).
; Holding A on controller 1 turns the backdrop green.

PPUCTRL   = $2000
PPUMASK   = $2001
PPUSTATUS = $2002
PPUSCROLL = $2005
PPUADDR   = $2006
PPUDATA   = $2007
JOY1      = $4016

ptr       = $00

.segment "HEADER"
        .byte "NES", $1A, 1, 1, 0, 0
        .res 8, 0

.segment "CODE"

reset:  sei
        cld
        ldx #$FF
        txs
        inx
        stx PPUCTRL
        stx PPUMASK
        bit PPUSTATUS
@vw1:   bit PPUSTATUS
        bpl @vw1
@vw2:   bit PPUSTATUS
        bpl @vw2

        ; palettes
        lda #$3F
        sta PPUADDR
        lda #$00
        sta PPUADDR
        ldx #0
@pal:   lda palette,x
        sta PPUDATA
        inx
        cpx #32
        bne @pal

        ; clear nametable 0 and its attributes
        lda #$20
        sta PPUADDR
        lda #$00
        sta PPUADDR
        ldy #4
        ldx #0
@clr:   sta PPUDATA
        dex
        bne @clr
        dey
        bne @clr

        ; top and bottom rows
        lda #$20
        ldx #$00
        jsr row
        lda #$23
        ldx #$A0
        jsr row

        ; left and right columns, rows 1-28
        lda #$20
        sta ptr+1
        lda #$20
        sta ptr
        ldy #28
@col:   lda ptr+1
        sta PPUADDR
        lda ptr
        sta PPUADDR
        lda #1
        sta PPUDATA
        lda ptr+1
        sta PPUADDR
        lda ptr
        ora #$1F
        sta PPUADDR
        lda #1
        sta PPUDATA
        lda ptr
        clc
        adc #32
        sta ptr
        bcc :+
        inc ptr+1
:       dey
        bne @col

        ; red block: rows 10-13, columns 10-13
        ldx #0
@blk:   lda block_hi,x
        sta PPUADDR
        lda block_lo,x
        sta PPUADDR
        lda #2
        sta PPUDATA
        sta PPUDATA
        sta PPUDATA
        sta PPUDATA
        inx
        cpx #4
        bne @blk

        jsr reset_scroll
        lda #%00011110      ; background and sprites, no left clipping
        sta PPUMASK

main:   bit PPUSTATUS
@vw:    bit PPUSTATUS
        bpl @vw

        lda #1              ; read A from controller 1
        sta JOY1
        lda #0
        sta JOY1
        lda JOY1
        and #1
        tax

        lda #$3F
        sta PPUADDR
        lda #$00
        sta PPUADDR
        lda backdrop,x
        sta PPUDATA
        jsr reset_scroll
        jmp main

; Write 32 border tiles at PPU address A:X.
row:    sta PPUADDR
        stx PPUADDR
        lda #1
        ldx #32
:       sta PPUDATA
        dex
        bne :-
        rts

reset_scroll:
        lda #0
        sta PPUADDR
        sta PPUADDR
        sta PPUSCROLL
        sta PPUSCROLL
        sta PPUCTRL
        rts

nmi:
irq:    rti

palette:  .byte $01, $16, $2A, $30, $01, $16, $2A, $30, $01, $16, $2A, $30, $01, $16, $2A, $30
          .byte $01, $16, $2A, $30, $01, $16, $2A, $30, $01, $16, $2A, $30, $01, $16, $2A, $30
backdrop: .byte $01, $2A
block_hi: .byte >($2000+10*32+10), >($2000+11*32+10), >($2000+12*32+10), >($2000+13*32+10)
block_lo: .byte <($2000+10*32+10), <($2000+11*32+10), <($2000+12*32+10), <($2000+13*32+10)

.segment "VECTORS"
        .word nmi, reset, irq

.segment "CHARS"
        .res 16, $00                    ; tile 0: color 0
        .res 16, $FF                    ; tile 1: color 3 (white)
        .res 8, $FF                     ; tile 2: color 1 (red)
        .res 8, $00
