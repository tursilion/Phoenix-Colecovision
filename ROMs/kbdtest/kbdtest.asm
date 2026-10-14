; PS/2 keyboard test cartridge for the Phoenix ColecoVision core.
;
; Puts the keyboard in scan-code mode (port >53 bit >04) and prints every
; byte read from port >80 in hex.  A new line starts after each complete
; key code: E0/F0 prefixes stay on the line with their key, and the 8-byte
; Pause sequence (E1 ...) is kept on one line.  The screen wraps from the
; bottom back to row 3; the blank line below the newest line marks the spot.
;
; Self-contained (own VDP setup and font), does not use the BIOS, and runs
; with VDP interrupts off.
;
; Build: pasmo kbdtest.asm kbdtest.rom   (see Makefile)

VDP_DATA    equ 0BEh
VDP_CTRL    equ 0BFh
KBD_PORT    equ 080h
SGM_PORT    equ 053h

NAME_TBL    equ 1800h
COLOR_TBL   equ 2000h
SPRITE_ATT  equ 1B00h
FIRST_ROW   equ 3
ROWS        equ 24

row         equ 7000h           ; CV 1K RAM (>6000, mirrored)
col         equ 7001h
skip        equ 7002h           ; bytes left in an E1 (Pause) sequence

            org 8000h

            db 55h, 0AAh        ; cartridge, skip the BIOS title screen
            dw 0                ; sprite name table pointer
            dw 0                ; sprite order table pointer
            dw 0                ; work buffer pointer
            dw 0                ; controller map pointer
            dw start            ; start address
            db 0C9h, 0, 0       ; RST 08
            db 0C9h, 0, 0       ; RST 10
            db 0C9h, 0, 0       ; RST 18
            db 0C9h, 0, 0       ; RST 20
            db 0C9h, 0, 0       ; RST 28
            db 0C9h, 0, 0       ; RST 30
            db 0EDh, 04Dh, 0    ; IRQ:  RETI
            db 0EDh, 045h, 0    ; NMI:  RETN (VDP interrupts are off)
            db "KEYBOARD TEST/PHOENIX/2026"

start:      di
            ld sp, 7400h

            ld a, 04h           ; scan codes at port >80, SGM off
            out (SGM_PORT), a

            in a, (VDP_CTRL)    ; clear any pending VDP status
            ld hl, vdp_regs
            ld bc, 0880h        ; 8 registers, starting at register 0
regs:       ld a, (hl)
            out (VDP_CTRL), a
            ld a, c
            out (VDP_CTRL), a
            inc hl
            inc c
            djnz regs

            ld hl, NAME_TBL     ; screen to spaces
            ld bc, 0300h
            ld a, ' '
            call vfill
            ld hl, SPRITE_ATT   ; no sprites
            ld bc, 1
            ld a, 0D0h
            call vfill
            ld hl, COLOR_TBL    ; white on dark blue
            ld bc, 32
            ld a, 0F4h
            call vfill

            ld hl, 20h * 8      ; font for ASCII >20.. >5F
            call vwaddr
            ld hl, font
            ld c, VDP_DATA
            ld b, 0
            otir
            otir

            ld hl, NAME_TBL + 0 * 32 + 7
            ld de, title1
            call vprint
            ld hl, NAME_TBL + 1 * 32 + 4
            ld de, title2
            call vprint

            ld a, FIRST_ROW
            ld (row), a
            xor a
            ld (col), a
            ld (skip), a

            ld a, 0C0h          ; 16K, display on, no interrupts
            out (VDP_CTRL), a
            ld a, 81h
            out (VDP_CTRL), a

main:       in a, (KBD_PORT)
            or a
            jr z, main          ; 0 = nothing waiting
            call putbyte
            jr main


; Print the byte in A at the cursor and decide whether to start a new line.
putbyte:    push af
            call cur_addr
            call vwaddr
            pop af
            push af
            call hexout
            ld a, (col)
            add a, 3
            ld (col), a
            pop bc              ; B = the byte

            ld a, (skip)
            or a
            jr z, noskip
            dec a               ; inside a Pause sequence
            ld (skip), a
            jr z, newline       ; its last byte
            jr chkfull
noskip:     ld a, b
            cp 0E1h
            jr nz, notpause
            ld a, 7             ; E1 + 7 more bytes
            ld (skip), a
            jr chkfull
notpause:   cp 0E0h
            jr z, chkfull
            cp 0F0h
            jr z, chkfull
            jr newline

chkfull:    ld a, (col)         ; 10 bytes per line
            cp 30
            ret c

newline:    xor a
            ld (col), a
            ld a, (row)
            call nextrow
            ld (row), a
            call clearrow
            ld a, (row)         ; keep a blank line below the newest
            call nextrow
            jp clearrow

nextrow:    inc a               ; A = row after A, wrapping
            cp ROWS
            ret c
            ld a, FIRST_ROW
            ret

clearrow:   ld l, a             ; clear row A
            ld h, 0
            add hl, hl
            add hl, hl
            add hl, hl
            add hl, hl
            add hl, hl
            ld de, NAME_TBL
            add hl, de
            ld bc, 32
            ld a, ' '
            jp vfill

cur_addr:   ld a, (row)         ; HL = name table address of the cursor
            ld l, a
            ld h, 0
            add hl, hl
            add hl, hl
            add hl, hl
            add hl, hl
            add hl, hl
            ld de, NAME_TBL
            add hl, de
            ld a, (col)
            ld e, a
            ld d, 0
            add hl, de
            ret

hexout:     push af             ; A as two hex digits and a space
            rrca
            rrca
            rrca
            rrca
            call nibble
            pop af
            call nibble
            ld a, ' '
            out (VDP_DATA), a
            ret

nibble:     and 0Fh
            add a, '0'
            cp '9' + 1
            jr c, nib1
            add a, 'A' - '9' - 1
nib1:       out (VDP_DATA), a
            ret

vwaddr:     ld a, l             ; set VRAM write address HL
            out (VDP_CTRL), a
            ld a, h
            or 40h
            out (VDP_CTRL), a
            ret

vfill:      push af             ; fill BC bytes at HL with A
            call vwaddr
            pop af
            ld d, a
vfill1:     ld a, d
            out (VDP_DATA), a
            dec bc
            ld a, b
            or c
            jr nz, vfill1
            ret

vprint:     call vwaddr         ; zero-terminated string DE at HL
vprint1:    ld a, (de)
            or a
            ret z
            out (VDP_DATA), a
            inc de
            jr vprint1

vdp_regs:   db 00h              ; graphics I
            db 80h              ; 16K, display off, no interrupts
            db NAME_TBL / 400h
            db COLOR_TBL / 40h
            db 0                ; patterns at >0000
            db SPRITE_ATT / 80h
            db 07h              ; sprite patterns at >3800
            db 04h              ; dark blue border

title1:     db "PS/2 KEYBOARD TEST", 0
title2:     db "PORT 80 SCAN CODES (HEX)", 0

            include "font.inc"

            ds 0A000h - $, 0FFh ; pad to 8K
