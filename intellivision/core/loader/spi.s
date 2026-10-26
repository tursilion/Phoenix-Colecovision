; Fast SPI block read for the SD card driver.
;
; void __fastcall__ spi_read_block(unsigned char *dst);
;
; Reads 512 bytes.  The boot CPU runs at the full core clock, much faster
; than the SPI, so it waits for each transfer.

        .export     _spi_read_block
        .importzp   ptr1

SPI_DATA = $5000
SPI_STAT = $5001

        .code

_spi_read_block:
        sta     ptr1
        stx     ptr1+1
        ldx     #2              ; two pages of 256 bytes
        ldy     #0
@loop:  lda     #$FF
        sta     SPI_DATA
@wait:  bit     SPI_STAT        ; bit 7: busy
        bmi     @wait
        lda     SPI_DATA
        sta     (ptr1),y
        iny
        bne     @loop
        inc     ptr1+1
        dex
        bne     @loop
        rts
