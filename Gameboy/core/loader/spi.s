; SPI and memory block transfers for the SD card driver and the save code.
;
; void spi_read_block(unsigned char *dst);     dst in DE (sdcccall 1)
;
; Reads 512 bytes.  Each read of the SPI_NEXT register returns the last
; byte and starts the next transfer, which ends long before the loop comes
; back.  The 512th read starts a 513th transfer, the first CRC byte.

        .module spi
        .globl  _spi_read_block

SPI_DATA = 0xA000
SPI_NEXT = 0xA015

        .area   _CODE

_spi_read_block:
        ld      a, #0xFF
        ld      (#SPI_DATA), a  ; first transfer
        ld      hl, #SPI_NEXT
        ld      b, #2           ; two pages of 256 bytes
        ld      c, #0
1$:     ld      a, (hl)
        ld      (de), a
        inc     de
        dec     c
        jr      nz, 1$
        dec     b
        jr      nz, 1$
        ret

; void spi_write(const unsigned char *src, unsigned int n);   src DE, n BC
;
; Sends n bytes (n > 0), waiting for each transfer to end.

        .globl  _spi_write

SPI_CTRL = 0xA001

_spi_write:
        ld      hl, #SPI_CTRL
1$:     ld      a, (de)
        inc     de
        ld      (#SPI_DATA), a
2$:     bit     7, (hl)         ; busy
        jr      nz, 2$
        dec     bc
        ld      a, b
        or      a, c
        jr      nz, 1$
        ret

; void mem_read(unsigned char *dst, unsigned int n);   dst DE, n BC
;
; Reads n bytes (n > 0) from the load address (MEM, which increments).

        .globl  _mem_read

MEM = 0xA016

_mem_read:
        ld      hl, #MEM
1$:     ld      a, (hl)
        ld      (de), a
        inc     de
        dec     bc
        ld      a, b
        or      a, c
        jr      nz, 1$
        ret
