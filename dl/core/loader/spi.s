;; Fast SPI block read for the SD card driver.
;;
;; void spi_read_block(unsigned char *dst);   (sdcc calling convention 1: dst in HL)
;;
;; Reads the 512 data bytes of a block.  In boot mode an I/O read returns
;; the last received SPI byte and starts the next transfer, so INIR reads a
;; byte every 21 T-states (a transfer at 12.5MHz takes about 3).  The first
;; IN only starts byte 0; the last data IN also starts CRC byte 0, which the
;; caller skips.

	.module spi
	.globl	_spi_read_block

	.area	_CODE

_spi_read_block:
	ld	c, #0
	in	a, (c)			; start byte 0
	ld	b, #0
	inir				; bytes 0-255
	inir				; bytes 256-511, and starts CRC 0
	ret

;; void sram_write_512(const unsigned char *src);   (src in HL)
;;
;; Writes 512 bytes to the SRAM at the current address.  In boot mode an
;; I/O write is an SRAM data write (the address then goes up by one).

	.globl	_sram_write_512

_sram_write_512:
	ld	c, #0
	ld	b, #0
	otir
	otir
	ret
