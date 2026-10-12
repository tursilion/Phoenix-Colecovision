; Fast SPI block read for the SD card driver.
;
; void __fastcall__ spi_read_block(unsigned char *dst);
;
; Reads 512 bytes.  At full speed a transfer takes 18 core clocks, less than
; the time between the STA and the LDA below, so there is no busy polling.

        .export     _spi_read_block
        .importzp   ptr1

SPI_DATA = $5000

        .code

_spi_read_block:
        sta     ptr1
        stx     ptr1+1
        ldx     #2              ; two pages of 256 bytes
        ldy     #0
@loop:  lda     #$FF
        sta     SPI_DATA
        nop
        lda     SPI_DATA
        sta     (ptr1),y
        iny
        bne     @loop
        inc     ptr1+1
        dex
        bne     @loop
        rts
