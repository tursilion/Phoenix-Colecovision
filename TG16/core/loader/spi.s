; Fast SPI block read for the SD card driver.
;
; void __fastcall__ spi_read_block(unsigned char *dst);
;
; Reads 512 bytes.  Each read of SPI_NEXT returns the last byte and starts
; the next transfer (32 core clocks), which ends before the loop comes back.
; The 512th read starts a 513th transfer: the first CRC byte.

        .setcpu     "HuC6280"
        .export     _spi_read_block
        .importzp   ptr1

SPI_DATA = $1800
SPI_NEXT = $1815

        .code

_spi_read_block:
        sta     ptr1
        stx     ptr1+1
        lda     #$FF
        sta     SPI_DATA        ; first transfer
        ldx     #2              ; two pages of 256 bytes
        ldy     #0
@loop:  lda     SPI_NEXT
        sta     (ptr1),y
        iny
        bne     @loop
        inc     ptr1+1
        dex
        bne     @loop
        rts
