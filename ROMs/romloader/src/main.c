/**
 *
 * sdcc -mz80 --opt-code-speed --fomit-frame-pointer -Iinc -I.. -c -o obj/main.rel src/main.c
 * sdasz80 -o obj/crt0.rel src/crt0.s
 * sdcc -mz80 --code-loc 0x0100 --data-loc 0x6000 --no-std-crt0 -o romloader.ihx obj/crt0.rel obj/main.rel
 * makebin -s 8192 romloader.ihx romloader.rom
 */

#include "main.h"
#include "msx1_font.h"

// ==========================================================================
// Defines


// ==========================================================================
// Constants



// ==========================================================================
// Globals

/// NMI counter.
volatile uint8_t nmi_count_g = 0;


/**
 * NMI Handler
 */
void
nmi_handler(void) __critical __interrupt __naked
{
    __asm
    push af
    ld a, (_nmi_count_g)
    inc a
    ld (_nmi_count_g), a
    pop af
    retn
    __endasm;
}
// nmi_service_routine()


// ==========================================================================
//
// VDP Routines
//
// ==========================================================================


/**
 * Set up a VDP read address
 */
void
vdp_rd_addr(uint16_t addr)
{
    // LSB of the address is sent first.
    VDP_CTRL_PORT = (addr & 0xFF);

    // For a read address, ensure two MS-bits are "00" and
    // send the MSB of the address.
    VDP_CTRL_PORT = ((addr >> 8) & 0x3F);
}
// vdp_rd_addr()


/**
 * Set up a VDP write address
 */
void
vdp_wr_addr(uint16_t addr)
{
    // LSB of the address is sent first.
    VDP_CTRL_PORT = (addr & 0xFF);

    // For a write address, ensure two MS-bits are "01" and
    // send the MSB of the address.
    VDP_CTRL_PORT = ((addr >> 8) & 0x3F) | 0x40;
}
// vdp_wr_addr()


/**
 * VDP Write to Register
 */
void
vdp_wtr(uint8_t reg, uint8_t val)
{
    // Value gets written first.
    VDP_CTRL_PORT = val;

    // Mask the low 6-bits that specify the register to write, and ensure
    // the two MS-bits are "10" to designate a "write to register" operation.
    VDP_CTRL_PORT = (reg & 0x3F) | 0x80;
}
// vdp_wtr()


/**
 * Sets a block of VRAM to a value
 */
void
vdp_memset(uint16_t dst, uint8_t val, uint16_t count)
{
	// Keep compiler from complaining about unused variables.
    val;
    count;

    vdp_wr_addr(dst);
    __asm
	// Set up to use DJNZ in the loop.
	// B holds the LSB of the count.  If B != 0 then the MSB of the count
	// needs to be incremented by 1 to make the loop work correctly.
	// Parameters on the stack:
	// 0000 lsb retaddr <-- sp
	// 0001 msb retaddr
	// 0002 lsb dst
	// 0003 msb dst
	// 0004 val
	// 0005 lsb count
	// 0006 msb count
	ld hl, #4		// Reference the val parm
	add hl, sp
	ld d, (hl) 		// Temp hold val parm
	inc hl
	ld a, (hl)		// LSB of count into A for test
	inc hl
	ld c, (hl)		// MSB of count
	cp #0			// LSB == 0?
	jr z, 001$
		inc c		// Yes, adjust MSB by one
	001$:
	ld b, a 		// Put LSB into B
	ld a, d			// Put val into A for OUT instruction

    // Now A=data, B=count LSB, C=adjusted count MSB
    002$:
        out (_VDP_DATA_PORT), a
        djnz 002$ 	// B--, jnz

        dec c
    jr nz, 002$
    __endasm;
}
// vdp_memset()


/**
 * Copies data from CPU memory to VRAM
 */
void
vdp_memcpy(uint16_t dst, uint8_t *src, uint16_t len)
{
	// Keep compiler from complaining about unused variables.
    src;
    len;

    vdp_wr_addr(dst);
    __asm
	// Setup to use OTIR for the inner loop.
	// B holds the LSB of the count.  If B != 0 then the MSB of the count
	// needs to be incremented by 1 to make the loop work correctly.
	// Parameters on the stack:
	// 0000 lsb retaddr <-- sp
	// 0001 msb retaddr
	// 0002 lsb dst
	// 0003 msb dst
	// 0004 lsb src
	// 0005 msb src
	// 0006 lsb count
	// 0007 msb count
	ld hl, #4		// Reference the src parm
	add hl, sp
	ld e, (hl)		// Temp hold src in DE
	inc hl
	ld d, (hl)
	inc hl
	ld a, (hl)		// LSB of count into A for test
	inc hl
	ld c, (hl)		// MSB of count
	cp #0			// LSB == 0?
	jr z, 001$
		inc c		// Yes, adjust MSB by one
	001$:
	ld b, a 		// Put len LSB into B
	ld a, c			// Put len MSB into A
	ex de, hl		// Put src into HL
	ld c, #_VDP_DATA_PORT

    // Now B=count LSB, A=adjusted count MSB, C=port, HL=src addr
    002$:
        otir 		// (C)=(HL), B--, HL++, until B=0
        dec a
    jr nz, 002$
    __endasm;
}
// vdp_memcpy()


// ==========================================================================
//
// String Printing
//
// ==========================================================================

uint16_t print_loc = 0;

uint8_t
strlen(uint8_t *str)
{
	uint8_t len = 0;
	while ( str[len] != 0 && len != 255 ) { len++; }
	return len;
}
// strlen()


void
print_str(uint8_t *str)
{
	uint8_t len = strlen(str);
	vdp_memcpy(print_loc, str, len);
	print_loc += len;
}
// print_str()


void
print_str_sp(uint8_t *str)
{
	print_str(str);
	print_loc++;
	if ( print_loc > (32 * 24) ) {
		print_loc = 0;
	}
	else {
		VDP_DATA_PORT = ' ';
	}
}
// print_str_sp()


void
print_nl(void)
{
	print_loc += 32;
	if ( print_loc > (32 * 24) ) {
		print_loc = 0;
	}

	else {
		print_loc &= 0xFFE0;
	}
}
// print_nl()


void
print_str_nl(uint8_t *str)
{
	print_str(str);
	print_nl();
}
// print_str_nl()


void
print_setxy(uint8_t x, uint8_t y)
{
	print_loc = (y * 32) + x;
}
// print_setxy()


// ==========================================================================
//
// SD-card Support
//
// ==========================================================================


uint8_t
sd_card_init(void)
{
	//  >56  xxxxxx_W (W) SD Control SPI CE_n
	//       xxxxxxW_ (W) SD Control SPI clock speed, 0 = slow clock
	//       RxxxxxRR (R) SD Control bit >80 = card detect input
	//  >57  WWWWWWWW (W) SD Data Write
	//       RRRRRRRR (R) SD Data Read

	// Slow clock, CS_n disable.
	SD_CTRL_PORT = 0x01;
	
	// Send 80 clocks.
	uint8_t i = 10;
	uint8_t d = 0;
	while ( i != 0 ) {
		// The Phoenix SPI always sends 0xFF to the SD-card when reading.
		d = SD_DATA_PORT;
		i--;
	}

	// Send Reset Command CMD0 ($40,$00,$00,$00,$00,$95)
	SD_CTRL_PORT = 0x00;
	uint8_t CMD0[] = {0x40,0x00,0x00,0x00,0x00,0x95};
	i = 0;
	while ( i < sizeof(CMD0) ) {
		SD_DATA_PORT = CMD0[i];
		i++;
	}

	// Get the response.  Looking for 0x01.  Fail after 255 attempts.
	i = 255;
	while ( i != 0 ) {
		d = SD_DATA_PORT;

		if ( d != 0xFF ) {
			break;
		}
		i--;
	}

	SD_CTRL_PORT = 0x01;

	// If the return is not 0x01, or the max attempts was tried, fail.
	if ( i == 0 || d != 0x01 ) {
		return 0;
	}

	// Card is trained and idle, so kick the clock up to fast mode.
	SD_CTRL_PORT = 0x03;
	
	return 1;
}
// sd_card_init()


enum {
	SD_ST_NOTFOUND = 0,
	SD_ST_INIT,
	SD_ST_INITFAIL,
	SD_ST_FOUND
};


uint8_t
sd_card_detect(uint8_t frame_tick)
{
	static uint8_t state = SD_ST_NOTFOUND;
	static uint8_t delay = 0;

	// Sample the card detect input.
	uint8_t sample = (SD_CTRL_PORT & 0x80);

	switch ( state ) {
	case SD_ST_NOTFOUND :
		if ( sample == 0x80 )
		{
			// Looks like an SD-card may be inserted, so debounce.
			if ( frame_tick != 0 )
			{
				if ( delay > 20 ) {
					delay = 0;
					state = SD_ST_INIT;
				}
				else {
					delay++;
				}
			}
		}
		
		else {
			// Any other value and the debounce count starts over.
			delay = 0;
		}

		break;

	case SD_ST_INIT :
	
		if ( sd_card_init() == 0x01 ) {
			state = SD_ST_FOUND;
		}
		else {
			state = SD_ST_INITFAIL;
		}

		break;

	case SD_ST_INITFAIL :

		// If the card failed, it must be removed and reinserted before
		// another attempt will be made.

		// fall-through.  This state is just to allow a return value other
		// that success.

	case SD_ST_FOUND :
		if ( sample != 0x80 )
		{
			// The SD-card detect input went low, card was pull out.
			delay = 0;
			state = SD_ST_NOTFOUND;
		}

		break;
	}

	return state;
}
// sd_card_detect()


// ==========================================================================
//
// Cartridge Detection
//
// ==========================================================================


enum {
	CART_ST_NOTFOUND = 0,
	CART_ST_FOUND
};


uint8_t
cart_detect(uint8_t frame_tick)
{
	static uint8_t state = CART_ST_NOTFOUND;
	static uint8_t delay = 0;

	// Valid carts start with AA55h or 55AAh at 8000h, the later value
	// being a special header used by prototype carts to skip the delay
	// on the title screen.
	uint8_t sample = peek(0x8000);

	switch ( state ) {
	case CART_ST_NOTFOUND :
		if ( sample == 0x55 || sample == 0xAA )
		{
			// Looks like a cart may be inserted, so debounce.
			if ( frame_tick != 0 )
			{
				if ( delay > 40 ) {
					delay = 0;
					state = CART_ST_FOUND;
				}
				else {
					delay++;
				}
			}
		}
		
		else {
			// Any values other than 55H or AAh and the debounce count
			// starts over.
			delay = 0;
		}

		break;

	case CART_ST_FOUND :
		if ( sample != 0x55 && sample != 0xAA )
		{
			// If the header values are not found, then the cartridge is
			// not considered valid.
			delay = 0;
			state = CART_ST_NOTFOUND;
		}

		break;
	}

	return state;
}
// cart_detect()



enum {
	JOY_ST_NONE = 0,
	JOY_ST_SCAN,
	JOY_ST_WAIT,
	JOY_ST_UP,
	JOY_ST_DN,
	JOY_ST_LT,
	JOY_ST_RT,
	JOY_ST_FIRE
};

/**
 * Read Joystick.
 *
 * Direction/Fire will only be valid for one tick, and the
 * status must return to NONE before another direction/fire
 * state will be returned again.
 */
uint8_t hex[] = {"0123456789ABCDEF"};
uint8_t
joystick_read(uint8_t frame_tick)
{
	static uint8_t state = JOY_ST_NONE;
	static uint8_t delay = 0;

	uint8_t sample = CONT1_DATA_PORT;
	sample = ~sample;
	sample &= 0x4F;

	vdp_wr_addr(30);
	VDP_DATA_PORT = hex[((sample&0xF0)>>4)];
	VDP_DATA_PORT = hex[(sample&0x0F)];

	// Controller Input Data Byte
	// -------------------------------
	//  7   6   5   4   3   2   1   0   bit
	//  QA  FL  QB  IF  L   D   R   U   stick
	//  !QA FR  Hi  IF  P3  P2  P4  P1  keypad

	switch ( state ) {
	case JOY_ST_NONE :
		if ( sample != 0 )
		{
			// Joystick input is changing, so debounce ~64ms.
			if ( frame_tick != 0 )
			{
				if ( delay > 4 ) {
					delay = 0;
					state = JOY_ST_SCAN;
				}
				else {
					delay++;
				}
			}
		}
		
		else {
			// Any other values start the debounce count over.
			delay = 0;
		}

		break;

	case JOY_ST_SCAN :
		// The joystick input is consistent, so decode the value.
		// Creates a single-tick value, then waits for no input.
		state = JOY_ST_WAIT;

		if ( (sample & 0x01) != 0 ) {
			state = JOY_ST_UP;
		}
		else if ( (sample & 0x04) != 0 ) {
			state = JOY_ST_DN;
		}
		else if ( (sample & 0x08) != 0 ) {
			state = JOY_ST_LT;
		}
		else if ( (sample & 0x02) != 0 ) {
			state = JOY_ST_RT;
		}
		else if ( (sample & 0x40) != 0 ) {
			state = JOY_ST_FIRE;
		}

		break;

	case JOY_ST_WAIT :
		// Wait for a neutral state before allowing another input.
		// This prevents repeating input, which can be added later.
		if ( sample == 0 ) {
			delay = 0;
			state = JOY_ST_NONE;
		}

		break;

	default :
		// All detected actions are only valid for as single tick.
		state = JOY_ST_WAIT;
		break;
	}

	return state;
}
// joystick_read()


void
swapin_real_cart(void)
{
	// Turn off the VDP interrupt so the NMI can't mess this up.
    // VR1=E0h to enable the frame flag (triggers the NMI).
    vdp_wtr(0x01, 0xC0);

	// Write the Loader/BIOS swap trigger code to 0x6000 (RAM), and
	// jump to the code.
	__asm
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
	__endasm;
}


void
main(void)
{
    uint8_t nmi_last_cnt = 0;
	uint8_t frame_tick = 0;
	uint8_t rtn;
	uint8_t *bp;
	uint8_t cursor = 1;
	uint8_t have_cart = 0;

	// TODO Set upper memory for external cartridge.

	// Set up the VDP registers, font, and colors.
    vdp_wtr(0x00, 0x00);	// VR0 GM1
    vdp_wtr(0x01, 0xC0);	// VR1 16K, not blanked, no interrupt, GM1
    vdp_wtr(0x02, 0x00);	// VR2 ntba  @ >0000 for 768 bytes
    vdp_wtr(0x03, 0x10);    // VR3 ctba  @ >0400 for 32 bytes for color sets
    vdp_wtr(0x04, 0x01);    // VR4 pgtba @ >0800 for 2K bytes for patterns
    vdp_wtr(0x05, 0x0A);    // VR5 satba @ >0500 for 128 bytes
    vdp_wtr(0x06, 0x02);    // VR6 spgba @ >1000 for 2K bytes for patterns
    vdp_wtr(0x07, 0x1A);    // FG/BG text color for text mode

	// Color table, black on dark yellow.
	vdp_memset(0x0400, 0x1A, 32);

	// Load the font.
	vdp_memcpy(0x0800, msx1_font, sizeof(msx1_font));

	// Set controller to joystick mode
	CONT_JOY_PORT = 0;	// Any write selects the joystick

    // Clear the screen.
    vdp_memset(0x0000, ' ', 32*24);

	print_setxy(0, 0);
	print_str_nl("Devices Detected:");

    // VR1=E0h to enable the frame flag (triggers the NMI).
    vdp_wtr(0x01, 0xE0);

    while ( 1 )
    {
		frame_tick = 0;

        // Check if the NMI has run.
        if ( nmi_last_cnt != nmi_count_g )
        {
            // Read the VDP status to clear the frame flag and update the
            // NMI flag variable.
            nmi_last_cnt = VDP_CTRL_PORT;
            nmi_last_cnt = nmi_count_g;
			frame_tick = 1;
        }
		else {
			continue;
		}

		// Display cartridge status.
		print_setxy(2, 2);
		print_str_sp("CART  :");
		rtn = cart_detect(frame_tick);
		if ( rtn == 0 ) {
			print_str("NONE");
			vdp_memset(print_loc, ' ', 58);
			have_cart = 0;
		}
		else {
			bp = (uint8_t *)GAME_NAME;
			vdp_memcpy(print_loc, bp, 54);
			have_cart = 1;
		}

		// Display SD-card status.
		print_setxy(2, 1);
		print_str_sp("SDCARD:");
		rtn = sd_card_detect(frame_tick);
		switch ( rtn ) {
		case SD_ST_NOTFOUND :
			print_str("NONE       "); break;
		case SD_ST_INIT :
			print_str("INIT...    "); break;
		case SD_ST_INITFAIL :
			print_str("INIT FAILED"); break;
		case SD_ST_FOUND :
			print_str("YES        "); break;
		}

		// Read joystick and update cursor.
		rtn = joystick_read(frame_tick);

		if ( rtn == JOY_ST_UP ) {
			cursor--;
		}
		else if ( rtn == JOY_ST_DN ) {
			cursor++;
		}
		
		if ( cursor > 2 ) { cursor = 1; }
		if ( cursor < 1 ) { cursor = 2; }

		vdp_wr_addr(32); VDP_DATA_PORT = ' ';
		vdp_wr_addr(64); VDP_DATA_PORT = ' ';
		vdp_wr_addr((32 * cursor)); VDP_DATA_PORT = '>';

		if ( rtn == JOY_ST_FIRE )
		{
			if ( cursor == 2 && have_cart == 1 ) {
				swapin_real_cart();
			}
		}
    }
}
// main()
