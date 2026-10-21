;; Fast SPI block read and load-port writes.
;;
;; void spi_read_block(unsigned char *dst);   (sdcc calling convention 1: dst in HL)
;;
;; Reads the 512 data bytes of a block.  In boot mode an I/O read returns
;; the last received SPI byte and starts the next transfer, so INIR reads a
;; byte every 21 T-states (a transfer at 12.5MHz takes about 2).  The first
;; IN only starts byte 0; the last data IN also starts CRC byte 0, which the
;; caller skips.

	.module spi
	.globl	_spi_read_block
	.globl	_load_write

	.area	_CODE

_spi_read_block:
	ld	c, #0
	in	a, (c)			; start byte 0
	ld	b, #0
	inir				; bytes 0-255
	inir				; bytes 256-511, and starts CRC 0
	ret

;; void load_write(const unsigned char *src, unsigned int count);
;; (src in HL, count in DE)
;;
;; Writes count bytes (1-512) to the load port; in boot mode an I/O write
;; is a load data write (the address then goes up by one).

_load_write:
	ld	c, #0
1$:	ld	a, d
	or	a, a
	jr	Z, 2$
	ld	b, #0			; 256 bytes
	otir
	dec	d
	jr	1$
2$:	ld	a, e
	or	a, a
	ret	Z
	ld	b, e
	otir
	ret
