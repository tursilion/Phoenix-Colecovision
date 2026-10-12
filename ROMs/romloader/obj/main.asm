;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Jun 20 2015) (MINGW64)
; This file was generated Mon Jun 17 00:57:18 2019
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _swapin_real_cart
	.globl _joystick_read
	.globl _cart_detect
	.globl _sd_card_detect
	.globl _sd_read_block
	.globl _sd_card_init
	.globl _sd_send_cmd
	.globl _sd_send_cmd_ex
	.globl _disp_hex
	.globl _print_setxy
	.globl _print_str_nl
	.globl _print_nl
	.globl _print_str_sp
	.globl _print_str
	.globl _strlen
	.globl _vdp_memcpy
	.globl _vdp_memset
	.globl _vdp_wtr
	.globl _vdp_wr_addr
	.globl _vdp_rd_addr
	.globl _nmi_handler
	.globl _CMDARGS
	.globl _g_sd_type
	.globl _g_sd_status
	.globl _g_sd_addr_size
	.globl _g_sd_type_name
	.globl _print_loc
	.globl _nmi_count_g
	.globl _hex
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_SD_CTRL_PORT	=	0x0056
_SD_DATA_PORT	=	0x0057
_CONT_KEY_PORT	=	0x0080
_CONT_JOY_PORT	=	0x00c0
_CONT1_DATA_PORT	=	0x00fc
_CONT2_DATA_PORT	=	0x00ff
_VDP_DATA_PORT	=	0x00be
_VDP_CTRL_PORT	=	0x00bf
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_sd_card_detect_state_1_74:
	.ds 1
_sd_card_detect_delay_1_74:
	.ds 1
_cart_detect_state_1_85:
	.ds 1
_cart_detect_delay_1_85:
	.ds 1
_joystick_read_state_1_94:
	.ds 1
_joystick_read_delay_1_94:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_nmi_count_g::
	.ds 1
_print_loc::
	.ds 2
_g_sd_type_name::
	.ds 8
_g_sd_addr_size::
	.ds 1
_g_sd_status::
	.ds 1
_g_sd_type::
	.ds 1
_CMDARGS::
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;src/main.c:925: static uint8_t state = SD_ST_NOTFOUND;
	ld	iy,#_sd_card_detect_state_1_74
	ld	0 (iy),#0x00
;src/main.c:926: static uint8_t delay = 0;
	ld	iy,#_sd_card_detect_delay_1_74
	ld	0 (iy),#0x00
;src/main.c:1017: static uint8_t state = CART_ST_NOTFOUND;
	ld	iy,#_cart_detect_state_1_85
	ld	0 (iy),#0x00
;src/main.c:1018: static uint8_t delay = 0;
	ld	iy,#_cart_detect_delay_1_85
	ld	0 (iy),#0x00
;src/main.c:1095: static uint8_t state = JOY_ST_NONE;
	ld	iy,#_joystick_read_state_1_94
	ld	0 (iy),#0x00
;src/main.c:1096: static uint8_t delay = 0;
	ld	iy,#_joystick_read_delay_1_94
	ld	0 (iy),#0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:57: nmi_handler(void) __critical __interrupt __naked
;	---------------------------------
; Function nmi_handler
; ---------------------------------
_nmi_handler::
;src/main.c:72: __endasm;
	push af
	ld a, (_nmi_count_g)
	inc a
	ld (_nmi_count_g), a
	pop af
	retn
;src/main.c:88: vdp_rd_addr(uint16_t addr)
;	---------------------------------
; Function vdp_rd_addr
; ---------------------------------
_vdp_rd_addr::
;src/main.c:91: VDP_CTRL_PORT = (addr & 0xFF);
	ld	iy,#2
	add	iy,sp
	ld	a, 0 (iy)
	out	(_VDP_CTRL_PORT),a
;src/main.c:95: VDP_CTRL_PORT = ((addr >> 8) & 0x3F);
	ld	a, 1 (iy)
	and	a, #0x3F
	out	(_VDP_CTRL_PORT),a
	ret
_msx1_font:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3C	; 60
	.db #0x42	; 66	'B'
	.db #0xA5	; 165
	.db #0x81	; 129
	.db #0xA5	; 165
	.db #0x99	; 153
	.db #0x42	; 66	'B'
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x7E	; 126
	.db #0xDB	; 219
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xDB	; 219
	.db #0x66	; 102	'f'
	.db #0x3C	; 60
	.db #0x6C	; 108	'l'
	.db #0xFE	; 254
	.db #0xFE	; 254
	.db #0xFE	; 254
	.db #0x7C	; 124
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x7C	; 124
	.db #0xFE	; 254
	.db #0x7C	; 124
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x54	; 84	'T'
	.db #0xFE	; 254
	.db #0x54	; 84	'T'
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x7C	; 124
	.db #0xFE	; 254
	.db #0xFE	; 254
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xE7	; 231
	.db #0xE7	; 231
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0xBB	; 187
	.db #0x7D	; 125
	.db #0x7D	; 125
	.db #0x7D	; 125
	.db #0xBB	; 187
	.db #0xC7	; 199
	.db #0xFF	; 255
	.db #0x0F	; 15
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x79	; 121	'y'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x7C	; 124
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x28	; 40
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x28	; 40
	.db #0x20	; 32
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0x3C	; 60
	.db #0x24	; 36
	.db #0x3C	; 60
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0xE4	; 228
	.db #0xDC	; 220
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x54	; 84	'T'
	.db #0x38	; 56	'8'
	.db #0xEE	; 238
	.db #0x38	; 56	'8'
	.db #0x54	; 84	'T'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x7C	; 124
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x1F	; 31
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xFF	; 255
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1F	; 31
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x1F	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x42	; 66	'B'
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x7E	; 126
	.db #0x81	; 129
	.db #0xBD	; 189
	.db #0xA1	; 161
	.db #0xA1	; 161
	.db #0xBD	; 189
	.db #0x81	; 129
	.db #0x7E	; 126
	.db #0x1F	; 31
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x6C	; 108	'l'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0xF8	; 248
	.db #0x50	; 80	'P'
	.db #0xF8	; 248
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x78	; 120	'x'
	.db #0xA0	; 160
	.db #0x70	; 112	'p'
	.db #0x28	; 40
	.db #0xF0	; 240
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x98	; 152
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xA0	; 160
	.db #0x40	; 64
	.db #0xA8	; 168
	.db #0x90	; 144
	.db #0x98	; 152
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0xA8	; 168
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0xA8	; 168
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0xA8	; 168
	.db #0xC8	; 200
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0xA0	; 160
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x08	; 8
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x50	; 80	'P'
	.db #0x90	; 144
	.db #0xF8	; 248
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0xE0	; 224
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0xE0	; 224
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xF0	; 240
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x08	; 8
	.db #0x48	; 72	'H'
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x70	; 112	'p'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0xE0	; 224
	.db #0x50	; 80	'P'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x50	; 80	'P'
	.db #0xE0	; 224
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xF0	; 240
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xF0	; 240
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0xB8	; 184
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0xA0	; 160
	.db #0xC0	; 192
	.db #0xA0	; 160
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0xD8	; 216
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0xC8	; 200
	.db #0xC8	; 200
	.db #0xA8	; 168
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xF0	; 240
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xA8	; 168
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xF0	; 240
	.db #0xA0	; 160
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0xD8	; 216
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xB0	; 176
	.db #0xC8	; 200
	.db #0x88	; 136
	.db #0xC8	; 200
	.db #0xB0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x68	; 104	'h'
	.db #0x98	; 152
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xF0	; 240
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x48	; 72	'H'
	.db #0x50	; 80	'P'
	.db #0x60	; 96
	.db #0x50	; 80	'P'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xD0	; 208
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xB0	; 176
	.db #0xC8	; 200
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xB0	; 176
	.db #0xC8	; 200
	.db #0xC8	; 200
	.db #0xB0	; 176
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xB0	; 176
	.db #0xC8	; 200
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xF0	; 240
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xA8	; 168
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xFF	; 255
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0xF0	; 240
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6C	; 108	'l'
	.db #0x12	; 18
	.db #0x7E	; 126
	.db #0x90	; 144
	.db #0x6E	; 110	'n'
	.db #0x00	; 0
	.db #0x3E	; 62
	.db #0x50	; 80	'P'
	.db #0x90	; 144
	.db #0x9C	; 156
	.db #0xF0	; 240
	.db #0x90	; 144
	.db #0x9E	; 158
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0xE2	; 226
	.db #0x5C	; 92
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x9C	; 156
	.db #0x84	; 132
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0x7C	; 124
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0xB0	; 176
	.db #0xC8	; 200
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xC8	; 200
	.db #0xA8	; 168
	.db #0x98	; 152
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0xA8	; 168
	.db #0x54	; 84	'T'
	.db #0x84	; 132
	.db #0x08	; 8
	.db #0x1C	; 28
	.db #0x84	; 132
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0xA8	; 168
	.db #0x58	; 88	'X'
	.db #0xA8	; 168
	.db #0x3C	; 60
	.db #0x08	; 8
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x24	; 36
	.db #0x48	; 72	'H'
	.db #0x90	; 144
	.db #0x48	; 72	'H'
	.db #0x24	; 36
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x48	; 72	'H'
	.db #0x24	; 36
	.db #0x12	; 18
	.db #0x24	; 36
	.db #0x48	; 72	'H'
	.db #0x90	; 144
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0xFC	; 252
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0xE8	; 232
	.db #0x08	; 8
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xA0	; 160
	.db #0x00	; 0
	.db #0xA0	; 160
	.db #0xA0	; 160
	.db #0xA0	; 160
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0xC0	; 192
	.db #0x44	; 68	'D'
	.db #0xC8	; 200
	.db #0x54	; 84	'T'
	.db #0xEC	; 236
	.db #0x54	; 84	'T'
	.db #0x9E	; 158
	.db #0x04	; 4
	.db #0x10	; 16
	.db #0xA8	; 168
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0xB6	; 182
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x7C	; 124
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x68	; 104	'h'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x3F	; 63
	.db #0x11	; 17
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x88	; 136
	.db #0x11	; 17
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x44	; 68	'D'
	.db #0x22	; 34
	.db #0x11	; 17
	.db #0x88	; 136
	.db #0x44	; 68	'D'
	.db #0x22	; 34
	.db #0x11	; 17
	.db #0xFE	; 254
	.db #0x7C	; 124
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x7C	; 124
	.db #0xFE	; 254
	.db #0x80	; 128
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x0F	; 15
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x7E	; 126
	.db #0x3C	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3C	; 60
	.db #0x7E	; 126
	.db #0xFF	; 255
	.db #0x81	; 129
	.db #0xC3	; 195
	.db #0xE7	; 231
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xE7	; 231
	.db #0xC3	; 195
	.db #0x81	; 129
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xA8	; 168
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0x0F	; 15
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x70	; 112	'p'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x70	; 112	'p'
	.db #0xC0	; 192
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x98	; 152
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x68	; 104	'h'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0xA0	; 160
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0xF8	; 248
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0xD8	; 216
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0xA8	; 168
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xF8	; 248
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xF8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0x30	; 48	'0'
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xA0	; 160
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xF8	; 248
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0xA0	; 160
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0xA0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3E	; 62
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xA0	; 160
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xA0	; 160
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xA0	; 160
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0xE0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_hex:
	.ascii "0123456789ABCDEF"
	.db 0x00
;src/main.c:104: vdp_wr_addr(uint16_t addr)
;	---------------------------------
; Function vdp_wr_addr
; ---------------------------------
_vdp_wr_addr::
;src/main.c:107: VDP_CTRL_PORT = (addr & 0xFF);
	ld	iy,#2
	add	iy,sp
	ld	a, 0 (iy)
	out	(_VDP_CTRL_PORT),a
;src/main.c:111: VDP_CTRL_PORT = ((addr >> 8) & 0x3F) | 0x40;
	ld	a, 1 (iy)
	and	a, #0x3F
	set	6, a
	out	(_VDP_CTRL_PORT),a
	ret
;src/main.c:120: vdp_wtr(uint8_t reg, uint8_t val)
;	---------------------------------
; Function vdp_wtr
; ---------------------------------
_vdp_wtr::
;src/main.c:123: VDP_CTRL_PORT = val;
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	out	(_VDP_CTRL_PORT),a
;src/main.c:127: VDP_CTRL_PORT = (reg & 0x3F) | 0x80;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x3F
	set	7, a
	out	(_VDP_CTRL_PORT),a
	ret
;src/main.c:136: vdp_memset(uint16_t dst, uint8_t val, uint16_t count)
;	---------------------------------
; Function vdp_memset
; ---------------------------------
_vdp_memset::
;src/main.c:142: vdp_wr_addr(dst);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_vdp_wr_addr
	pop	af
;src/main.c:176: __endasm;
	ld hl, #4
	add hl, sp
	ld d, (hl)
	inc hl
	ld a, (hl)
	inc hl
	ld c, (hl)
	cp #0
	jr z, 001$
	inc c
	    001$:
	ld b, a
	ld a, d
	    002$:
	out (_VDP_DATA_PORT), a
	djnz 002$
	dec c
	jr nz, 002$
	ret
;src/main.c:185: vdp_memcpy(uint16_t dst, uint8_t *src, uint16_t len)
;	---------------------------------
; Function vdp_memcpy
; ---------------------------------
_vdp_memcpy::
;src/main.c:191: vdp_wr_addr(dst);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_vdp_wr_addr
	pop	af
;src/main.c:228: __endasm;
	ld hl, #4
	add hl, sp
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld a, (hl)
	inc hl
	ld c, (hl)
	cp #0
	jr z, 001$
	inc c
	    001$:
	ld b, a
	ld a, c
	ex de, hl
	ld c, #_VDP_DATA_PORT
	    002$:
	otir
	dec a
	jr nz, 002$
	ret
;src/main.c:242: strlen(uint8_t *str)
;	---------------------------------
; Function strlen
; ---------------------------------
_strlen::
;src/main.c:245: while ( str[len] != 0 && len != 255 ) { len++; }
	ld	e,#0x00
00102$:
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	d,#0x00
	add	hl, de
	ld	a,(hl)
	or	a, a
	jr	Z,00104$
	ld	a,e
	inc	a
	jr	Z,00104$
	inc	e
	jr	00102$
00104$:
;src/main.c:246: return len;
	ld	l,e
	ret
;src/main.c:252: print_str(uint8_t *str)
;	---------------------------------
; Function print_str
; ---------------------------------
_print_str::
;src/main.c:254: uint8_t len = strlen(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_strlen
	pop	af
	ld	e,l
;src/main.c:255: vdp_memcpy(print_loc, str, len);
	ld	l,e
	ld	h,#0x00
	push	de
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl,(_print_loc)
	push	hl
	call	_vdp_memcpy
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	de
;src/main.c:256: print_loc += len;
	ld	d,#0x00
	ld	hl,#_print_loc
	ld	a,(hl)
	add	a, e
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, d
	ld	(hl),a
	ret
;src/main.c:262: print_str_sp(uint8_t *str)
;	---------------------------------
; Function print_str_sp
; ---------------------------------
_print_str_sp::
;src/main.c:264: print_str(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_print_str
	pop	af
;src/main.c:265: print_loc++;
	ld	hl, #_print_loc+0
	inc	(hl)
	jr	NZ,00110$
	ld	hl, #_print_loc+1
	inc	(hl)
00110$:
;src/main.c:266: if ( print_loc > (32 * 24) ) {
	xor	a, a
	ld	iy,#_print_loc
	cp	a, 0 (iy)
	ld	a,#0x03
	ld	iy,#_print_loc
	sbc	a, 1 (iy)
	jr	NC,00102$
;src/main.c:267: print_loc = 0;
	ld	hl,#0x0000
	ld	(_print_loc),hl
	ret
00102$:
;src/main.c:270: VDP_DATA_PORT = ' ';
	ld	a,#0x20
	out	(_VDP_DATA_PORT),a
	ret
;src/main.c:277: print_nl(void)
;	---------------------------------
; Function print_nl
; ---------------------------------
_print_nl::
;src/main.c:279: print_loc += 32;
	ld	hl,#_print_loc
	ld	a,(hl)
	add	a, #0x20
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, #0x00
	ld	(hl),a
;src/main.c:280: if ( print_loc > (32 * 24) ) {
	xor	a, a
	ld	iy,#_print_loc
	cp	a, 0 (iy)
	ld	a,#0x03
	ld	iy,#_print_loc
	sbc	a, 1 (iy)
	jr	NC,00102$
;src/main.c:281: print_loc = 0;
	ld	hl,#0x0000
	ld	(_print_loc),hl
	ret
00102$:
;src/main.c:285: print_loc &= 0xFFE0;
	ld	a,(#_print_loc + 0)
	and	a, #0xE0
	ld	(#_print_loc + 0),a
	ret
;src/main.c:292: print_str_nl(uint8_t *str)
;	---------------------------------
; Function print_str_nl
; ---------------------------------
_print_str_nl::
;src/main.c:294: print_str(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_print_str
	pop	af
;src/main.c:295: print_nl();
	jp	_print_nl
;src/main.c:301: print_setxy(uint8_t x, uint8_t y)
;	---------------------------------
; Function print_setxy
; ---------------------------------
_print_setxy::
;src/main.c:303: print_loc = (y * 32) + x;
	ld	iy,#3
	add	iy,sp
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	d,l
	ld	e,h
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
	ld	b,#0x00
	ld	a,d
	ld	hl,#_print_loc
	add	a, c
	ld	(hl),a
	ld	a,e
	adc	a, b
	inc	hl
	ld	(hl),a
	ret
;src/main.c:309: disp_hex(uint8_t d)
;	---------------------------------
; Function disp_hex
; ---------------------------------
_disp_hex::
;src/main.c:311: VDP_DATA_PORT = hex[((d >> 4) & 0xF)];
	ld	de,#_hex+0
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	and	a, #0x0F
	ld	l, a
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:312: VDP_DATA_PORT = hex[( d       & 0xF)];
	ld	a,0 (iy)
	and	a, #0x0F
	ld	l, a
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:313: VDP_DATA_PORT = ' ';
	ld	a,#0x20
	out	(_VDP_DATA_PORT),a
	ret
;src/main.c:491: sd_send_cmd_ex(uint8_t cmd, uint8_t crc, uint8_t clk_speed)
;	---------------------------------
; Function sd_send_cmd_ex
; ---------------------------------
_sd_send_cmd_ex::
;src/main.c:498: SD_CTRL_PORT = clk_speed | CE_OFF;
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	set	0, a
	out	(_SD_CTRL_PORT),a
;src/main.c:499: d = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:501: SD_CTRL_PORT = clk_speed | CE_ON;
	ld	a,0 (iy)
	out	(_SD_CTRL_PORT),a
;src/main.c:503: SD_DATA_PORT = cmd;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	out	(_SD_DATA_PORT),a
;src/main.c:506: for ( i = 0 ; i < sizeof(CMDARGS) ; i++ ) {
	ld	d,#0x00
00105$:
;src/main.c:507: SD_DATA_PORT = CMDARGS[i];
	ld	a,#<(_CMDARGS)
	add	a, d
	ld	c,a
	ld	a,#>(_CMDARGS)
	adc	a, #0x00
	ld	b,a
	ld	a,(bc)
	out	(_SD_DATA_PORT),a
;src/main.c:508: CMDARGS[i] = 0;
	xor	a, a
	ld	(bc),a
;src/main.c:506: for ( i = 0 ; i < sizeof(CMDARGS) ; i++ ) {
	inc	d
	ld	a,d
	sub	a, #0x04
	jr	C,00105$
;src/main.c:511: SD_DATA_PORT = crc;
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	out	(_SD_DATA_PORT),a
;src/main.c:515: for ( i = 255 ; i > 0 ; i-- )
	ld	d,#0xFF
00107$:
;src/main.c:517: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:519: if ( d != NODATA ) {
	ld	e,a
	inc	a
	jr	NZ,00104$
;src/main.c:515: for ( i = 255 ; i > 0 ; i-- )
	dec	d
	ld	a,d
	or	a, a
	jr	NZ,00107$
00104$:
;src/main.c:524: return d;
	ld	l,e
	ret
;src/main.c:538: sd_send_cmd(uint8_t cmd, uint8_t crc, uint8_t clk_speed)
;	---------------------------------
; Function sd_send_cmd
; ---------------------------------
_sd_send_cmd::
;src/main.c:541: uint8_t d = sd_send_cmd_ex(cmd, crc, clk_speed);
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_sd_send_cmd_ex
	pop	af
	inc	sp
	ld	d,l
;src/main.c:542: SD_CTRL_PORT = clk_speed | CE_OFF;
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	set	0, a
	out	(_SD_CTRL_PORT),a
;src/main.c:546: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:548: return d;
	ld	l,d
	ret
;src/main.c:559: sd_card_init(void)
;	---------------------------------
; Function sd_card_init
; ---------------------------------
_sd_card_init::
;src/main.c:638: g_sd_addr_size = ADDR_BLOCK;
	ld	hl,#_g_sd_addr_size + 0
	ld	(hl), #0x01
;src/main.c:639: g_sd_type = SD_IS_UNKNOWN;
	ld	hl,#_g_sd_type + 0
	ld	(hl), #0x03
;src/main.c:642: SD_CTRL_PORT = CK_SLOW | CE_OFF;
	ld	a,#0x03
	out	(_SD_CTRL_PORT),a
;src/main.c:645: for ( i = 10 ; i > 0 ; i-- ) {
	ld	d,#0x0A
00140$:
;src/main.c:646: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:645: for ( i = 10 ; i > 0 ; i-- ) {
	dec	d
	ld	a,d
	or	a, a
	jr	NZ,00140$
;src/main.c:650: d = sd_send_cmd(CMD0, CRC0, CK_SLOW);
	ld	hl,#0x0295
	push	hl
	ld	a,#0x40
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
;src/main.c:651: if ( d != R1_IDLE ) {
	dec	l
	jr	Z,00103$
;src/main.c:652: return SD_SPI_MODE_FAILED;
	ld	l,#0x02
	ret
00103$:
;src/main.c:658: CMDARGS[2] = VHS; CMDARGS[3] = CKPTRN;
	ld	hl,#(_CMDARGS + 0x0002)
	ld	(hl),#0x01
	ld	hl,#_CMDARGS + 3
	ld	(hl),#0xAA
;src/main.c:659: d = sd_send_cmd_ex(CMD8, CRC8, CK_SLOW);
	ld	hl,#0x0287
	push	hl
	ld	a,#0x48
	push	af
	inc	sp
	call	_sd_send_cmd_ex
	pop	af
	inc	sp
;src/main.c:660: if ( d == R1_IDLE )
	dec	l
	jr	NZ,00114$
;src/main.c:665: d = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:666: d = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:667: i = SD_DATA_PORT; // echo VHS
	in	a,(_SD_DATA_PORT)
	ld	e,a
;src/main.c:668: d = SD_DATA_PORT; // echo Check Pattern
	in	a,(_SD_DATA_PORT)
	ld	d,a
;src/main.c:669: SD_CTRL_PORT = CK_SLOW | CE_OFF;
	ld	a,#0x03
	out	(_SD_CTRL_PORT),a
;src/main.c:670: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:672: if ( i != VHS || d != CKPTRN ) {
	dec	e
	jr	NZ,00104$
	ld	a,d
	sub	a, #0xAA
	jr	Z,00105$
00104$:
;src/main.c:673: return SD_BAD_CMD8_VOLTAGE;
	ld	l,#0x03
	ret
00105$:
;src/main.c:676: g_sd_type = SD_IS_SDHC;
	ld	hl,#_g_sd_type + 0
	ld	(hl), #0x01
	jr	00115$
00114$:
;src/main.c:684: d = sd_send_cmd_ex(CMD58, CRCX, CK_SLOW);
	ld	hl,#0x0201
	push	hl
	ld	a,#0x7A
	push	af
	inc	sp
	call	_sd_send_cmd_ex
	pop	af
	inc	sp
;src/main.c:685: if ( d > R1_IDLE ) {
	ld	a,#0x01
	sub	a, l
	jr	NC,00108$
;src/main.c:686: SD_CTRL_PORT = CK_SLOW | CE_OFF;
	ld	a,#0x03
	out	(_SD_CTRL_PORT),a
;src/main.c:687: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:688: return SD_BAD_OCR_READ;
	ld	l,#0x04
	ret
00108$:
;src/main.c:696: i = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:697: i = SD_DATA_PORT; // bits 23..16
	in	a,(_SD_DATA_PORT)
	ld	e,a
;src/main.c:698: d = SD_DATA_PORT; // bit 15, 0x80 or 0x00
	in	a,(_SD_DATA_PORT)
;src/main.c:699: d &= 0x80; // make sure reserved bits don't interfere.
	and	a, #0x80
	ld	d,a
;src/main.c:700: if ( i == 0xFF ) {
	inc	e
	jr	NZ,00110$
;src/main.c:701: d++;
	inc	d
00110$:
;src/main.c:703: i = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:704: SD_CTRL_PORT = CK_SLOW | CE_OFF;
	ld	a,#0x03
	out	(_SD_CTRL_PORT),a
;src/main.c:705: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:707: if ( d != 0x81 ) {
	ld	a,d
	sub	a, #0x81
	jr	Z,00112$
;src/main.c:708: return SD_BAD_OCR_VOLTAGE;
	ld	l,#0x05
	ret
00112$:
;src/main.c:711: g_sd_addr_size = ADDR_BYTE;
	ld	hl,#_g_sd_addr_size + 0
	ld	(hl), #0x00
;src/main.c:712: g_sd_type = SD_IS_SDSC;
	ld	hl,#_g_sd_type + 0
	ld	(hl), #0x00
00115$:
;src/main.c:719: i = sd_send_cmd(CMD55, CRCX, CK_SLOW);
	ld	hl,#0x0201
	push	hl
	ld	a,#0x77
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
	ld	d,l
;src/main.c:720: if ( g_sd_addr_size == ADDR_BLOCK ) {
	ld	a,(#_g_sd_addr_size + 0)
	dec	a
	jr	NZ,00117$
;src/main.c:723: CMDARGS[0] = HCS_YES;
	ld	hl,#_CMDARGS
	ld	(hl),#0x40
00117$:
;src/main.c:725: d = sd_send_cmd(ACMD41, CRCX, CK_SLOW);
	push	de
	ld	hl,#0x0201
	push	hl
	ld	a,#0x69
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
	pop	de
	ld	c,l
;src/main.c:727: if ( i > R1_IDLE || d > R1_IDLE )
	ld	a,#0x01
	cp	a,d
	jr	C,00120$
	sub	a, c
	jr	NC,00121$
00120$:
;src/main.c:730: d = sd_send_cmd(CMD1, CRCX, CK_SLOW);
	ld	hl,#0x0201
	push	hl
	ld	a,#0x41
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
	ld	c,l
;src/main.c:731: if ( d > R1_IDLE ) {
	ld	a,#0x01
	sub	a, c
	jr	NC,00119$
;src/main.c:732: return SD_MMC_FAILED;
	ld	l,#0x06
	ret
00119$:
;src/main.c:735: g_sd_type = SD_IS_MMC;
	ld	hl,#_g_sd_type + 0
	ld	(hl), #0x02
00121$:
;src/main.c:740: for ( wait = 25000 ; wait > 0 && d == R1_IDLE ; wait-- )
	ld	hl,#0x61A8
	ld	e,l
	ld	d,h
00144$:
	ld	a,d
	or	a,e
	jr	Z,00126$
	ld	a,c
	dec	a
	jr	NZ,00126$
;src/main.c:742: if ( g_sd_type == SD_IS_MMC ) {
	ld	a,(#_g_sd_type + 0)
	sub	a, #0x02
	jr	NZ,00124$
;src/main.c:743: d = sd_send_cmd(CMD1, CRCX, CK_SLOW);
	push	de
	ld	hl,#0x0201
	push	hl
	ld	a,#0x41
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
	pop	de
	ld	c,l
	jr	00145$
00124$:
;src/main.c:745: d = sd_send_cmd(CMD55, CRCX, CK_SLOW);
	push	de
	ld	hl,#0x0201
	push	hl
	ld	a,#0x77
	push	af
	inc	sp
	call	_sd_send_cmd
	inc	sp
	ld	hl,#0x0201
	ex	(sp),hl
	ld	a,#0x69
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
	pop	de
	ld	c,l
00145$:
;src/main.c:740: for ( wait = 25000 ; wait > 0 && d == R1_IDLE ; wait-- )
	dec	de
	ld	l, e
	ld	h, d
	jr	00144$
00126$:
;src/main.c:750: if ( wait == 0 ) {
	ld	a,h
	or	a,l
	jr	NZ,00128$
;src/main.c:751: return SD_INIT_TIMEOUT;
	ld	l,#0x07
	ret
00128$:
;src/main.c:754: if ( d != R1_READY ) {
	ld	a,c
	or	a, a
	jr	Z,00130$
;src/main.c:755: return SD_INIT_FAILED;
	ld	l,#0x08
	ret
00130$:
;src/main.c:763: if ( g_sd_addr_size == ADDR_BLOCK )
	ld	a,(#_g_sd_addr_size + 0)
	dec	a
	jr	NZ,00138$
;src/main.c:766: d = sd_send_cmd_ex(CMD58, CRCX, CK_SLOW);
	ld	hl,#0x0201
	push	hl
	ld	a,#0x7A
	push	af
	inc	sp
	call	_sd_send_cmd_ex
	pop	af
	inc	sp
;src/main.c:767: if ( d > R1_IDLE ) {
	ld	a,#0x01
	sub	a, l
	jr	NC,00132$
;src/main.c:768: return SD_BAD_SSC_READ;
	ld	l,#0x09
	ret
00132$:
;src/main.c:772: d = SD_DATA_PORT; // CSS is bit 0x40
	in	a,(_SD_DATA_PORT)
	ld	d,a
;src/main.c:773: i = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:774: i = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:775: i = SD_DATA_PORT; // don't care
	in	a,(_SD_DATA_PORT)
;src/main.c:776: SD_CTRL_PORT = CK_SLOW | CE_OFF;
	ld	a,#0x03
	out	(_SD_CTRL_PORT),a
;src/main.c:777: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:779: if ( (d & CSS_BIT) == 0 ) {
	bit	6, d
	jr	NZ,00139$
;src/main.c:780: g_sd_addr_size = ADDR_BYTE;
	ld	hl,#_g_sd_addr_size + 0
	ld	(hl), #0x00
;src/main.c:781: g_sd_type = SD_IS_SDSC;
	ld	hl,#_g_sd_type + 0
	ld	(hl), #0x00
	jr	00139$
00138$:
;src/main.c:788: CMDARGS[2] = 0x02;
	ld	hl,#(_CMDARGS + 0x0002)
	ld	(hl),#0x02
;src/main.c:789: d = sd_send_cmd(CMD16, CRCX, CK_SLOW);
	ld	hl,#0x0201
	push	hl
	ld	a,#0x50
	push	af
	inc	sp
	call	_sd_send_cmd
	pop	af
	inc	sp
;src/main.c:790: if ( d > R1_IDLE ) {
	ld	a,#0x01
	sub	a, l
	jr	NC,00139$
;src/main.c:791: return SD_SET_BSIZE_FAILED;
	ld	l,#0x0A
	ret
00139$:
;src/main.c:795: return SD_CARD_OK;
	ld	l,#0x01
	ret
;src/main.c:818: sd_read_block(uint32_t block_addr, uint8_t *dst)
;	---------------------------------
; Function sd_read_block
; ---------------------------------
_sd_read_block::
;src/main.c:824: if ( g_sd_addr_size == ADDR_BYTE ) {
	ld	a,(#_g_sd_addr_size + 0)
	or	a, a
	jr	NZ,00102$
;src/main.c:825: block_addr *= 512;
	push	af
	pop	af
	ld	b,#0x09
00174$:
	ld	iy,#2
	add	iy,sp
	sla	0 (iy)
	rl	1 (iy)
	rl	2 (iy)
	rl	3 (iy)
	djnz	00174$
00102$:
;src/main.c:828: CMDARGS[0] = (uint8_t)(block_addr >> 24);
	push	af
	ld	iy,#4
	add	iy,sp
	ld	d,0 (iy)
	ld	h,1 (iy)
	ld	l,2 (iy)
	ld	e,3 (iy)
	pop	af
	ld	b,#0x18
00176$:
	srl	e
	rr	l
	rr	h
	rr	d
	djnz	00176$
	ld	hl,#_CMDARGS
	ld	(hl),d
;src/main.c:829: CMDARGS[1] = (uint8_t)(block_addr >> 16);
	push	af
	ld	d,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	l,3 (iy)
	pop	af
	ld	b,#0x10
00178$:
	srl	l
	rr	e
	rr	h
	rr	d
	djnz	00178$
	ld	hl,#(_CMDARGS + 0x0001)
	ld	(hl),d
;src/main.c:830: CMDARGS[2] = (uint8_t)(block_addr >>  8);
	push	af
	ld	d,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	l,3 (iy)
	pop	af
	ld	b,#0x08
00180$:
	srl	l
	rr	e
	rr	h
	rr	d
	djnz	00180$
	ld	hl,#(_CMDARGS + 0x0002)
	ld	(hl),d
;src/main.c:831: CMDARGS[3] = (uint8_t) block_addr;
	ld	a,0 (iy)
	ld	(#(_CMDARGS + 0x0003)),a
;src/main.c:833: d = sd_send_cmd_ex(CMD17, CRCX, CK_FAST);
	ld	hl,#0x0001
	push	hl
	ld	a,#0x51
	push	af
	inc	sp
	call	_sd_send_cmd_ex
	pop	af
	inc	sp
	ld	a,l
;src/main.c:834: if ( d != R1_READY ) {
	or	a, a
	jr	Z,00135$
;src/main.c:835: SD_CTRL_PORT = CK_FAST | CE_OFF;
	ld	a,#0x01
	out	(_SD_CTRL_PORT),a
;src/main.c:836: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:837: return SD_READ_BLOCK_FAILED;
	ld	l,#0x0B
	ret
;src/main.c:855: for ( count = 25000 ; count > 0 ; count-- )
00135$:
	ld	bc,#0x61A8
00116$:
;src/main.c:857: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:859: if ( d == SD_START_TOKEN ||
	ld	h,a
	sub	a, #0xFE
	jr	NZ,00182$
	ld	a,#0x01
	jr	00183$
00182$:
	xor	a,a
00183$:
	ld	d,a
	or	a, a
	jr	NZ,00108$
;src/main.c:860: (d & SD_ERROR_TOKEN_TEST) == SD_ERROR_TOKEN ) {
	ld	a,h
	and	a, #0xF0
	jr	Z,00108$
;src/main.c:855: for ( count = 25000 ; count > 0 ; count-- )
	dec	bc
	ld	a,b
	or	a,c
	jr	NZ,00116$
00108$:
;src/main.c:865: if ( d != SD_START_TOKEN ) {
	ld	a,d
	or	a, a
	jr	NZ,00110$
;src/main.c:866: SD_CTRL_PORT = CK_FAST | CE_OFF;
	ld	a,#0x01
	out	(_SD_CTRL_PORT),a
;src/main.c:867: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:868: return SD_TOKEN_TIMEOUT;
	ld	l,#0x0C
	ret
00110$:
;src/main.c:875: if ( dst == 0 )
	ld	hl, #6+1
	add	hl, sp
	ld	a, (hl)
	dec	hl
	or	a,(hl)
	jr	NZ,00141$
;src/main.c:878: for ( count = 512 ; count > 0 ; count-- )
	ld	de,#0x0200
00118$:
;src/main.c:880: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
	out	(_VDP_DATA_PORT),a
;src/main.c:878: for ( count = 512 ; count > 0 ; count-- )
	dec	de
	ld	a,d
	or	a,e
	jr	NZ,00118$
	jr	00115$
;src/main.c:888: for ( count = 512 ; count > 0 ; count--, dst++ )
00141$:
	ld	de,#0x0200
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
00120$:
;src/main.c:890: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:891: *dst = d;
	ld	(bc),a
;src/main.c:888: for ( count = 512 ; count > 0 ; count--, dst++ )
	dec	de
	inc	bc
	ld	a,d
	or	a,e
	jr	NZ,00120$
00115$:
;src/main.c:896: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:897: d = SD_DATA_PORT;
	in	a,(_SD_DATA_PORT)
;src/main.c:899: SD_CTRL_PORT = CK_FAST | CE_OFF;
	ld	a,#0x01
	out	(_SD_CTRL_PORT),a
;src/main.c:900: eop = SD_DATA_PORT; // required end-of-op 8-clocks
	in	a,(_SD_DATA_PORT)
;src/main.c:902: return SD_CARD_OK;
	ld	l,#0x01
	ret
;src/main.c:923: sd_card_detect(uint8_t frame_tick)
;	---------------------------------
; Function sd_card_detect
; ---------------------------------
_sd_card_detect::
;src/main.c:929: uint8_t sample = (SD_CTRL_PORT & 0x80);
	in	a,(_SD_CTRL_PORT)
	and	a, #0x80
	ld	b,a
;src/main.c:931: switch ( state ) {
	ld	a,#0x04
	ld	iy,#_sd_card_detect_state_1_74
	sub	a, 0 (iy)
	jp	C,00119$
	ld	iy,#_sd_card_detect_state_1_74
	ld	e,0 (iy)
	ld	d,#0x00
	ld	hl,#00146$
	add	hl,de
	add	hl,de
;src/main.c:932: case SD_ST_NOTFOUND :
	jp	(hl)
00146$:
	jr	00101$
	jr	00110$
	jr	00114$
	jr	00115$
	jr	00116$
00101$:
;src/main.c:933: if ( sample == 0x80 )
	ld	a,b
	sub	a, #0x80
	jr	NZ,00108$
;src/main.c:936: if ( frame_tick != 0 )
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z,00119$
;src/main.c:938: if ( delay > 20 ) {
	ld	a,#0x14
	ld	iy,#_sd_card_detect_delay_1_74
	sub	a, 0 (iy)
	jr	NC,00103$
;src/main.c:939: delay = 0;
	ld	hl,#_sd_card_detect_delay_1_74 + 0
	ld	(hl), #0x00
;src/main.c:940: state = SD_ST_INIT;
	ld	hl,#_sd_card_detect_state_1_74 + 0
	ld	(hl), #0x01
	jr	00119$
00103$:
;src/main.c:943: delay++;
	ld	hl, #_sd_card_detect_delay_1_74+0
	inc	(hl)
	jr	00119$
00108$:
;src/main.c:950: delay = 0;
	ld	hl,#_sd_card_detect_delay_1_74 + 0
	ld	(hl), #0x00
;src/main.c:953: break;
	jr	00119$
;src/main.c:955: case SD_ST_INIT :
00110$:
;src/main.c:957: g_sd_status = sd_card_init();
	call	_sd_card_init
	ld	iy,#_g_sd_status
	ld	0 (iy),l
;src/main.c:958: if ( g_sd_status == SD_CARD_OK ) {
	ld	a,(#_g_sd_status + 0)
	dec	a
	jr	NZ,00112$
;src/main.c:959: state = SD_ST_FOUND;
	ld	hl,#_sd_card_detect_state_1_74 + 0
	ld	(hl), #0x02
	jr	00119$
00112$:
;src/main.c:962: state = SD_ST_INITFAIL;
	ld	hl,#_sd_card_detect_state_1_74 + 0
	ld	(hl), #0x03
;src/main.c:965: break;
	jr	00119$
;src/main.c:967: case SD_ST_FOUND :
00114$:
;src/main.c:972: state = SD_ST_READY;
	ld	hl,#_sd_card_detect_state_1_74 + 0
	ld	(hl), #0x04
;src/main.c:973: break;
	jr	00119$
;src/main.c:975: case SD_ST_INITFAIL :
00115$:
;src/main.c:985: case SD_ST_READY :
00116$:
;src/main.c:986: if ( sample != 0x80 )
	ld	a,b
	sub	a, #0x80
	jr	Z,00119$
;src/main.c:989: delay = 0;
	ld	hl,#_sd_card_detect_delay_1_74 + 0
	ld	(hl), #0x00
;src/main.c:990: state = SD_ST_NOTFOUND;
	ld	hl,#_sd_card_detect_state_1_74 + 0
	ld	(hl), #0x00
;src/main.c:994: }
00119$:
;src/main.c:996: return state;
	ld	iy,#_sd_card_detect_state_1_74
	ld	l,0 (iy)
	ret
;src/main.c:1015: cart_detect(uint8_t frame_tick)
;	---------------------------------
; Function cart_detect
; ---------------------------------
_cart_detect::
;src/main.c:1023: uint8_t sample = peek(0x8000);
	ld	hl,#0x8000
	ld	d,(hl)
	inc	hl
	ld	h,(hl)
;src/main.c:1025: switch ( state ) {
	ld	a,(#_cart_detect_state_1_85 + 0)
	or	a, a
	jr	Z,00101$
	ld	a,(#_cart_detect_state_1_85 + 0)
	dec	a
	jr	Z,00111$
	jr	00115$
;src/main.c:1026: case CART_ST_NOTFOUND :
00101$:
;src/main.c:1027: if ( sample == 0x55 || sample == 0xAA )
	ld	a,d
	cp	a,#0x55
	jr	Z,00107$
	sub	a, #0xAA
	jr	NZ,00108$
00107$:
;src/main.c:1030: if ( frame_tick != 0 )
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z,00115$
;src/main.c:1032: if ( delay > 40 ) {
	ld	a,#0x28
	ld	iy,#_cart_detect_delay_1_85
	sub	a, 0 (iy)
	jr	NC,00103$
;src/main.c:1033: delay = 0;
	ld	hl,#_cart_detect_delay_1_85 + 0
	ld	(hl), #0x00
;src/main.c:1034: state = CART_ST_FOUND;
	ld	hl,#_cart_detect_state_1_85 + 0
	ld	(hl), #0x01
	jr	00115$
00103$:
;src/main.c:1037: delay++;
	ld	hl, #_cart_detect_delay_1_85+0
	inc	(hl)
	jr	00115$
00108$:
;src/main.c:1045: delay = 0;
	ld	hl,#_cart_detect_delay_1_85 + 0
	ld	(hl), #0x00
;src/main.c:1048: break;
	jr	00115$
;src/main.c:1050: case CART_ST_FOUND :
00111$:
;src/main.c:1051: if ( sample != 0x55 && sample != 0xAA )
	ld	a,d
	cp	a,#0x55
	jr	Z,00115$
	sub	a, #0xAA
	jr	Z,00115$
;src/main.c:1055: delay = 0;
	ld	hl,#_cart_detect_delay_1_85 + 0
	ld	(hl), #0x00
;src/main.c:1056: state = CART_ST_NOTFOUND;
	ld	hl,#_cart_detect_state_1_85 + 0
	ld	(hl), #0x00
;src/main.c:1060: }
00115$:
;src/main.c:1062: return state;
	ld	iy,#_cart_detect_state_1_85
	ld	l,0 (iy)
	ret
;src/main.c:1093: joystick_read(uint8_t frame_tick)
;	---------------------------------
; Function joystick_read
; ---------------------------------
_joystick_read::
	dec	sp
;src/main.c:1098: uint8_t sample = CONT1_DATA_PORT;
	in	a,(_CONT1_DATA_PORT)
;src/main.c:1099: sample = ~sample;
	cpl
;src/main.c:1100: sample &= 0x4F;
	and	a, #0x4F
	inc	sp
	push	af
	inc	sp
;src/main.c:1102: vdp_wr_addr(30);
	ld	hl,#0x001E
	push	hl
	call	_vdp_wr_addr
	pop	af
;src/main.c:1103: VDP_DATA_PORT = hex[((sample&0xF0)>>4)];
	ld	de,#_hex+0
	ld	iy,#0
	add	iy,sp
	ld	a,0 (iy)
	and	a, #0xF0
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	l, a
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:1104: VDP_DATA_PORT = hex[(sample&0x0F)];
	ld	a,0 (iy)
	and	a, #0x0F
	ld	l, a
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:1112: switch ( state ) {
	ld	a,#0x02
	ld	iy,#_joystick_read_state_1_94
	sub	a, 0 (iy)
	jp	C,00128$
	ld	iy,#_joystick_read_state_1_94
	ld	e,0 (iy)
	ld	d,#0x00
	ld	hl,#00172$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00172$:
	jp	00101$
	jp	00110$
	jp	00125$
;src/main.c:1113: case JOY_ST_NONE :
00101$:
;src/main.c:1114: if ( sample != 0 )
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z,00108$
;src/main.c:1117: if ( frame_tick != 0 )
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jp	Z,00129$
;src/main.c:1119: if ( delay > 4 ) {
	ld	a,#0x04
	ld	iy,#_joystick_read_delay_1_94
	sub	a, 0 (iy)
	jr	NC,00103$
;src/main.c:1120: delay = 0;
	ld	hl,#_joystick_read_delay_1_94 + 0
	ld	(hl), #0x00
;src/main.c:1121: state = JOY_ST_SCAN;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x01
	jp	00129$
00103$:
;src/main.c:1124: delay++;
	ld	hl, #_joystick_read_delay_1_94+0
	inc	(hl)
	jp	00129$
00108$:
;src/main.c:1131: delay = 0;
	ld	hl,#_joystick_read_delay_1_94 + 0
	ld	(hl), #0x00
;src/main.c:1134: break;
	jr	00129$
;src/main.c:1136: case JOY_ST_SCAN :
00110$:
;src/main.c:1139: state = JOY_ST_WAIT;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x02
;src/main.c:1141: if ( (sample & 0x01) != 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	rrca
	jr	NC,00123$
;src/main.c:1142: state = JOY_ST_UP;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x03
	jr	00129$
00123$:
;src/main.c:1144: else if ( (sample & 0x04) != 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x04
	jr	Z,00120$
;src/main.c:1145: state = JOY_ST_DN;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x04
	jr	00129$
00120$:
;src/main.c:1147: else if ( (sample & 0x08) != 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x08
	jr	Z,00117$
;src/main.c:1148: state = JOY_ST_LT;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x05
	jr	00129$
00117$:
;src/main.c:1150: else if ( (sample & 0x02) != 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x02
	jr	Z,00114$
;src/main.c:1151: state = JOY_ST_RT;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x06
	jr	00129$
00114$:
;src/main.c:1153: else if ( (sample & 0x40) != 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	and	a, #0x40
	jr	Z,00129$
;src/main.c:1154: state = JOY_ST_FIRE;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x07
;src/main.c:1157: break;
	jr	00129$
;src/main.c:1159: case JOY_ST_WAIT :
00125$:
;src/main.c:1162: if ( sample == 0 ) {
	ld	hl, #0+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	NZ,00129$
;src/main.c:1163: delay = 0;
	ld	hl,#_joystick_read_delay_1_94 + 0
	ld	(hl), #0x00
;src/main.c:1164: state = JOY_ST_NONE;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x00
;src/main.c:1167: break;
	jr	00129$
;src/main.c:1169: default :
00128$:
;src/main.c:1171: state = JOY_ST_WAIT;
	ld	hl,#_joystick_read_state_1_94 + 0
	ld	(hl), #0x02
;src/main.c:1173: }
00129$:
;src/main.c:1175: return state;
	ld	iy,#_joystick_read_state_1_94
	ld	l,0 (iy)
	inc	sp
	ret
;src/main.c:1181: swapin_real_cart(void)
;	---------------------------------
; Function swapin_real_cart
; ---------------------------------
_swapin_real_cart::
;src/main.c:1186: vdp_wtr(0x01, 0xC0);
	ld	hl,#0xC001
	push	hl
	call	_vdp_wtr
	pop	af
;src/main.c:1208: __endasm;
	ld hl, #001$
	ld de, #0x6000
	ld bc, #002$ - #001$
	ldir
	jp 0x6000
	    001$:
	in a, (0x55)
	jp 0x0000
	    002$:
	nop
	ret
;src/main.c:1214: main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	af
	dec	sp
;src/main.c:1216: uint8_t nmi_last_cnt = 0;
;src/main.c:1220: uint8_t cursor = 1;
	ld	bc,#0x0100
;src/main.c:1226: vdp_wtr(0x00, 0x00);    // VR0 GM1
	push	bc
	ld	hl,#0x0000
	push	hl
	call	_vdp_wtr
	ld	hl, #0xC001
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x0002
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x1003
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x0104
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x0A05
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x0206
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x1A07
	ex	(sp),hl
	call	_vdp_wtr
	ld	hl, #0x0020
	ex	(sp),hl
	ld	a,#0x1A
	push	af
	inc	sp
	ld	hl,#0x0400
	push	hl
	call	_vdp_memset
	pop	af
	pop	af
	inc	sp
	pop	bc
;src/main.c:1239: vdp_memcpy(0x0800, msx1_font, sizeof(msx1_font));
	ld	hl,#_msx1_font
	push	bc
	ld	de,#0x0800
	push	de
	push	hl
	ld	hl,#0x0800
	push	hl
	call	_vdp_memcpy
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/main.c:1242: CONT_JOY_PORT = 0;  // Any write selects the joystick
	ld	a,#0x00
	out	(_CONT_JOY_PORT),a
;src/main.c:1245: vdp_memset(0x0000, ' ', 32*24);
	push	bc
	ld	hl,#0x0300
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	h, #0x00
	push	hl
	call	_vdp_memset
	pop	af
	inc	sp
	ld	hl,#0x0000
	ex	(sp),hl
	call	_print_setxy
	pop	af
	pop	bc
;src/main.c:1248: print_str_nl("Devices Detected:");
	ld	hl,#___str_1
	push	bc
	push	hl
	call	_print_str_nl
	ld	hl, #0xE001
	ex	(sp),hl
	call	_vdp_wtr
	pop	af
	pop	bc
;src/main.c:1254: while ( 1 )
00129$:
;src/main.c:1259: if ( nmi_last_cnt != nmi_count_g )
	ld	a,(#_nmi_count_g + 0)
	sub	a, c
	jr	Z,00129$
;src/main.c:1263: nmi_last_cnt = VDP_CTRL_PORT;
	in	a,(_VDP_CTRL_PORT)
;src/main.c:1264: nmi_last_cnt = nmi_count_g;
	ld	hl,#_nmi_count_g + 0
	ld	c, (hl)
;src/main.c:1273: print_setxy(2, 1);
	push	bc
	ld	hl,#0x0102
	push	hl
	call	_print_setxy
	pop	af
	pop	bc
;src/main.c:1274: print_str_sp("SDCARD:");
	ld	hl,#___str_2
	push	bc
	push	hl
	call	_print_str_sp
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_card_detect
	inc	sp
	pop	bc
	ld	e,l
;src/main.c:1277: switch ( rtn ) {
	ld	a,#0x04
	sub	a, e
	jp	C,00110$
	ld	d,#0x00
	ld	hl,#00191$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00191$:
	jp	00104$
	jp	00105$
	jp	00107$
	jp	00106$
	jp	00109$
;src/main.c:1278: case SD_ST_NOTFOUND :
00104$:
;src/main.c:1279: print_str("NONE     "); break;
	ld	hl,#___str_3
	push	bc
	push	hl
	call	_print_str
	pop	af
	pop	bc
	jp	00110$
;src/main.c:1280: case SD_ST_INIT :
00105$:
;src/main.c:1281: print_str("INIT...  "); break;
	ld	hl,#___str_4
	push	bc
	push	hl
	call	_print_str
	pop	af
	pop	bc
	jp	00110$
;src/main.c:1282: case SD_ST_INITFAIL :
00106$:
;src/main.c:1283: print_str("ERROR:  ");
	ld	hl,#___str_5
	push	bc
	push	hl
	call	_print_str
	pop	af
	pop	bc
;src/main.c:1286: VDP_DATA_PORT = hex[(g_sd_status&0x0F)];
	ld	a,(#_g_sd_status + 0)
	and	a, #0x0F
	ld	e,a
	ld	hl,#_hex
	ld	d,#0x00
	add	hl, de
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:1287: break;
	jr	00110$
;src/main.c:1288: case SD_ST_FOUND : {
00107$:
;src/main.c:1292: print_str("READING.."); 
	ld	hl,#___str_6
	push	bc
	push	hl
	call	_print_str
	ld	hl, #0x00A0
	ex	(sp),hl
	call	_vdp_wr_addr
	ld	hl, #0x6400
	ex	(sp),hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0800
	push	hl
	call	_sd_read_block
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/main.c:1298: for ( lp = 512 ; lp > 0 ; lp--, src++ ) {
	ld	de,#0x0200
	ld	hl,#0x6400
	ex	(sp), hl
00131$:
;src/main.c:1299: VDP_DATA_PORT = *src;
	pop	hl
	push	hl
	ld	a,(hl)
	out	(_VDP_DATA_PORT),a
;src/main.c:1298: for ( lp = 512 ; lp > 0 ; lp--, src++ ) {
	dec	de
	ld	iy,#0
	add	iy,sp
	inc	0 (iy)
	jr	NZ,00192$
	inc	1 (iy)
00192$:
	ld	a,d
	or	a,e
	jr	NZ,00131$
;src/main.c:1302: break;
	jr	00110$
;src/main.c:1303: case SD_ST_READY :
00109$:
;src/main.c:1304: print_str("YES: ");
	ld	hl,#___str_7
	push	bc
	push	hl
	call	_print_str
	pop	af
	pop	bc
;src/main.c:1305: print_str(g_sd_type_name[g_sd_type]);
	ld	iy,#_g_sd_type
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	de,#_g_sd_type_name
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	push	de
	call	_print_str
	pop	af
	pop	bc
;src/main.c:1307: }
00110$:
;src/main.c:1311: print_setxy(2, 2);
	push	bc
	ld	hl,#0x0202
	push	hl
	call	_print_setxy
	pop	af
	pop	bc
;src/main.c:1312: print_str_sp("CART  :");
	ld	hl,#___str_8
	push	bc
	push	hl
	call	_print_str_sp
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_cart_detect
	inc	sp
	ld	a,l
	pop	bc
;src/main.c:1314: if ( rtn == 0 ) {
	or	a, a
	jr	NZ,00112$
;src/main.c:1315: print_str("NONE");
	ld	hl,#___str_9
	push	bc
	push	hl
	call	_print_str
	ld	hl, #0x003A
	ex	(sp),hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,(_print_loc)
	push	hl
	call	_vdp_memset
	pop	af
	pop	af
	inc	sp
	pop	bc
;src/main.c:1317: have_cart = 0;
	ld	iy,#2
	add	iy,sp
	ld	0 (iy),#0x00
	jr	00113$
00112$:
;src/main.c:1321: vdp_memcpy(print_loc, bp, 54);
	push	bc
	ld	hl,#0x0036
	push	hl
	ld	hl,#0x8024
	push	hl
	ld	hl,(_print_loc)
	push	hl
	call	_vdp_memcpy
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/main.c:1322: have_cart = 1;
	ld	iy,#2
	add	iy,sp
	ld	0 (iy),#0x01
00113$:
;src/main.c:1327: rtn = joystick_read(frame_tick);
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	call	_joystick_read
	inc	sp
	pop	bc
	ld	d,l
;src/main.c:1329: if ( rtn == JOY_ST_UP ) {
	ld	a,d
	sub	a, #0x03
	jr	NZ,00117$
;src/main.c:1330: cursor--;
	dec	b
	jr	00118$
00117$:
;src/main.c:1332: else if ( rtn == JOY_ST_DN ) {
	ld	a,d
	sub	a, #0x04
	jr	NZ,00118$
;src/main.c:1333: cursor++;
	inc	b
00118$:
;src/main.c:1336: if ( cursor > 2 ) { cursor = 1; }
	ld	a,#0x02
	sub	a, b
	jr	NC,00120$
	ld	b,#0x01
00120$:
;src/main.c:1337: if ( cursor < 1 ) { cursor = 2; }
	ld	a,b
	sub	a, #0x01
	jr	NC,00122$
	ld	b,#0x02
00122$:
;src/main.c:1339: vdp_wr_addr(32); VDP_DATA_PORT = ' ';
	push	bc
	push	de
	ld	hl,#0x0020
	push	hl
	call	_vdp_wr_addr
	pop	af
	pop	de
	pop	bc
	ld	a,#0x20
	out	(_VDP_DATA_PORT),a
;src/main.c:1340: vdp_wr_addr(64); VDP_DATA_PORT = ' ';
	push	bc
	push	de
	ld	hl,#0x0040
	push	hl
	call	_vdp_wr_addr
	pop	af
	pop	de
	pop	bc
	ld	a,#0x20
	out	(_VDP_DATA_PORT),a
;src/main.c:1341: vdp_wr_addr((32 * cursor)); VDP_DATA_PORT = '>';
	ld	l,b
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	push	de
	push	hl
	call	_vdp_wr_addr
	pop	af
	pop	de
	pop	bc
	ld	a,#0x3E
	out	(_VDP_DATA_PORT),a
;src/main.c:1343: if ( rtn == JOY_ST_FIRE )
	ld	a,d
	sub	a, #0x07
	jp	NZ,00129$
;src/main.c:1345: if ( cursor == 2 && have_cart == 1 ) {
	ld	a,b
	sub	a, #0x02
	jp	NZ,00129$
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	dec	a
	jp	NZ,00129$
;src/main.c:1346: swapin_real_cart();
	push	bc
	call	_swapin_real_cart
	pop	bc
	jp	00129$
	pop	af
	inc	sp
	ret
___str_1:
	.ascii "Devices Detected:"
	.db 0x00
___str_2:
	.ascii "SDCARD:"
	.db 0x00
___str_3:
	.ascii "NONE     "
	.db 0x00
___str_4:
	.ascii "INIT...  "
	.db 0x00
___str_5:
	.ascii "ERROR:  "
	.db 0x00
___str_6:
	.ascii "READING.."
	.db 0x00
___str_7:
	.ascii "YES: "
	.db 0x00
___str_8:
	.ascii "CART  :"
	.db 0x00
___str_9:
	.ascii "NONE"
	.db 0x00
	.area _CODE
___str_10:
	.ascii "SDSC"
	.db 0x00
___str_11:
	.ascii "SDHC"
	.db 0x00
___str_12:
	.ascii "MMC "
	.db 0x00
___str_13:
	.ascii "????"
	.db 0x00
	.area _INITIALIZER
__xinit__nmi_count_g:
	.db #0x00	; 0
__xinit__print_loc:
	.dw #0x0000
__xinit__g_sd_type_name:
	.dw ___str_10
	.dw ___str_11
	.dw ___str_12
	.dw ___str_13
__xinit__g_sd_addr_size:
	.db #0x01	; 1
__xinit__g_sd_status:
	.db #0x00	; 0
__xinit__g_sd_type:
	.db #0x03	; 3
__xinit__CMDARGS:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
