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

const uint8_t hex[] = {"0123456789ABCDEF"};


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
    ld hl, #4       // Reference the val parm
    add hl, sp
    ld d, (hl)      // Temp hold val parm
    inc hl
    ld a, (hl)      // LSB of count into A for test
    inc hl
    ld c, (hl)      // MSB of count
    cp #0           // LSB == 0?
    jr z, 001$
        inc c       // Yes, adjust MSB by one
    001$:
    ld b, a         // Put LSB into B
    ld a, d         // Put val into A for OUT instruction

    // Now A=data, B=count LSB, C=adjusted count MSB
    002$:
        out (_VDP_DATA_PORT), a
        djnz 002$   // B--, jnz

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
    ld hl, #4       // Reference the src parm
    add hl, sp
    ld e, (hl)      // Temp hold src in DE
    inc hl
    ld d, (hl)
    inc hl
    ld a, (hl)      // LSB of count into A for test
    inc hl
    ld c, (hl)      // MSB of count
    cp #0           // LSB == 0?
    jr z, 001$
        inc c       // Yes, adjust MSB by one
    001$:
    ld b, a         // Put len LSB into B
    ld a, c         // Put len MSB into A
    ex de, hl       // Put src into HL
    ld c, #_VDP_DATA_PORT

    // Now B=count LSB, A=adjusted count MSB, C=port, HL=src addr
    002$:
        otir        // (C)=(HL), B--, HL++, until B=0
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

#define CK_SLOW         0x00
#define CK_FAST         0x20
#define CE_OFF          0x01
#define CE_ON           0x00
#define R1_IDLE         0x01
#define R1_READY        0x00
#define NODATA          0xFF
#define SD_BLK_START    0xFE

// Command format: 01cccccc  response
#define CMD0     0 | 0x40   // R1   RESET_GO_IDLE    40 00 00 00 00 95
#define CMD1     1 | 0x40   // R1   SELF_INIT_MMC    41 00 00 00 00 01
#define CMD8     8 | 0x40   // R7   SEND_IF_COND     48 00 00 01 AA 87
#define CMD16   16 | 0x40   // R1   SET_BLK_SIZE     50  blk  len   01
#define CMD17   17 | 0x40   // R1   READ_SINGLE_BLK  51  data addr  01
#define CMD55   55 | 0x40   // R1   APP_CMD_NEXT     77 00 00 00 00 01
#define CMD58   58 | 0x40   // R3   READ_OCR         78 00 00 00 00 01
#define ACMD41  41 | 0x40   // R1   SELF_INIT_SD     69 00 00 00 00 01

#define CRC0    0x95
#define CRC8    0x87
#define CRCX    0x01

// When the card is in the idle state, the host shall issue CMD8 before
// ACMD41.  The argument, 'voltage supplied' is set to the host supply
// voltage and 'check pattern' is set to any 8-bit pattern.  The card
// checks whether it can operate on the host's supply voltage.
#define VHS     0x01    // Voltage Host Supplied, 0001 for 2.7V to 3.6V
#define CKPTRN  0xAA    // Check pattern, recommended

// Host Capacity Support
// Sent during ACMD41, The HCS bit set to 1 indicates that the host
// supports High Capacity SD Memory card.
#define HCS_YES 0x40    // V2.x or greater cards only
#define HCS_NO  0x00
#define CSS_BIT 0x40


enum CARD_TYPE {
    CARD_IS_SD = 0,
    CARD_IS_MMC,
    CARD_IS_UNKNOWN
};

enum CARD_ERROR {
    SD_NO_CARD = 0,
    SD_CARD_OK,
    SD_SPI_MODE_FAILED,
    SD_BAD_CMD8_VOLTAGE,
    SD_BAD_OCR_READ,
    SD_BAD_OCR_VOLTAGE,
    SD_MMC_FAILED,
    SD_INIT_TIMEOUT,
    SD_INIT_FAILED,
    SD_BAD_SSC_READ,
    SD_SET_BSIZE_FAILED,
    SD_READ_BLOCK_FAILED,
    SD_TOKEN_TIMEOUT
};

#define ADDR_BYTE   0
#define ADDR_BLOCK  1

// Global to indicate the type of addressing required by the
// detected SD-card / MMC.
uint8_t g_sd_addr_size = ADDR_BLOCK;

// SD-card status
uint8_t g_sd_status = SD_NO_CARD;

// All commands are 6 bytes, with 4-bytes for arguments.
//  1   2  3  4  5   6
// CMD |   ARGS   | CRC
uint8_t CMDARGS[] = {0,0,0,0};


/**
 * Sends a command to the SD-card without deselecting the
 * Chip Enable.
 *
 * Any arguments have to be set up in CMDARGS before calling.
 * The CMDARGS bytes are zeroed after being sent.
 *
 * @note The caller must turn the Chip Select off.  This allows
 *       for commands that return data.
 *
 * @return The result status byte from the SD-card
 */
uint8_t
sd_send_cmd_ex(uint8_t cmd, uint8_t crc, uint8_t clk_speed)
{
    // Make sure any previous commands are deselected.
    SD_CTRL_PORT = clk_speed | CE_OFF;
    SD_CTRL_PORT = clk_speed | CE_ON;

    // Send 8 clocks before commands.  Is this necessary?
    uint8_t d = SD_DATA_PORT;

    SD_DATA_PORT = cmd;

    // Send args buffer and zero.
    uint8_t i;
    for ( i = 0 ; i < sizeof(CMDARGS) ; i++ ) {
        SD_DATA_PORT = CMDARGS[i];
        CMDARGS[i] = 0;
    }

    SD_DATA_PORT = crc;

    // Get the response.  Looking for != 0xFF.
    // Fail after 255 attempts.
    for ( i = 255 ; i > 0 ; i-- )
    {
        d = SD_DATA_PORT;

        if ( d != NODATA ) {
            break;
        }
    }

    return d;
}
// sd_send_cmd_ex()


/**
 * Sends a command to the SD-card.
 *
 * Any arguments have to be set up in CMDARGS before calling.
 * The CMDARGS bytes are zeroed after being sent.
 *
 * @return The result status byte from the SD-card
 */
uint8_t
sd_send_cmd(uint8_t cmd, uint8_t crc, uint8_t clk_speed)
{
    uint8_t d = sd_send_cmd_ex(cmd, crc, clk_speed);
    SD_CTRL_PORT = clk_speed | CE_OFF;
    return d;
}
// sd_send_cmd()


/**
 * Initialize an SD-card or MMC.
 *
 * @return SD_CARD_OK on success, otherwise CARD_ERROR enum error value.
 */
uint8_t
sd_card_init(void)
{
    //  >56  xxxxxx_W (W) SD Control SPI CE_n
    //       xxxxxxW_ (W) SD Control SPI clock speed, 0 = slow clock
    //       RxxxxxRR (R) SD Control bit >80 = card detect input
    //  >57  WWWWWWWW (W) SD Data Write
    //       RRRRRRRR (R) SD Data Read, sends >FF to SD-card

    // SD-card SPI initialization from the "Simplified" Physical Layer
    // Specifications quickly found here:
    // https://users.ece.utexas.edu/~valvano/EE345M/SD_Physical_Layer_Spec.pdf
    //
    // See Section 7 for SPI Mode
    //
    // MultiMediaCard MMC Specification quickly found here:
    // http://www.files.e-shop.co.il/pdastore/Tech-mmc-samsung/SEC%20MMC%20SPEC%20ver09.pdf
    //
    // See Section 4.10 for SPI Mode
    //
    // Power-on
    // Set SPI mode:
    //   Send CMD0 with CS = 0
    //   Response is R1 with idle bit set
    // Send CMD8
    //   If response is illegal command, it is a legacy v1.x card
    //   If response is valid command, card is v2.x card
    //
    // V1.x card after CMD8 failed:
    // Send CMD58 (read OCR)
    //   If response is illegal command, not SD-card, fail
    //   If response indicates non-compatible voltage, fail
    // Send ACMD41, argument 0 (high-capacity not supported)
    //   If response is illegal command, not SD-card, fail
    //   If card in_idle_state=1, send ACMD41 again or give up
    //   If card in_idel_state=0, continue
    // Card ready, done
    //
    // V2.x card after CMD8 success:
    //   If not valid check pattern, fail
    // Send CMD58 (read OCR)
    //   If response indicates non-compatible voltage, fail
    // Send ACMD41, argument 0 (high-capacity not supported)
    //   If card in_idle_state=1, send ACMD41 again or give up
    //   If card in_idel_state=0, continue
    // Send CMD58 (read CCS)
    //   CCS=0, standard capacity card (SDSC)
    //   CCS=1, high capacity card (SDHC and SDXC)
    // Card ready, done
    //
    // MultiMediaCard MMC
    // MMC also has an SPI mode.  It will fail CMD8 like a V1.x SD-card, but
    // uses CMD1 instead of ACMD41 to initialize.  It supports CMD58 to check
    // for voltages, just like V1.x SD-cards.
    //
    // Basically the CMD8 is called with the 3.3V bit, and a V2.x card will
    // reply that it accepts that or not.  A V1.x card will give an error
    // since it does not know CMD8.  So for the V1.x card CMD58 needs to be
    // used to get the voltage ranges.
    //
    // Testing the voltages is almost a moot point on the Phoenix since it
    // cannot turn the power off to the card.
    //
    // Besides returning the supported voltages, CMD58 returns the CCS (card
    // capacity status) bit which is needed to determine if the card uses
    // byte addressing or block addressing.  All MMC, V1.x SD-cards, and
    // SDSH V2.x (CSS=0) SD-cards use byte addressing for data, which means:
    //
    //   1. MMC, V1.x, and SDSC cards can never be more than 4GB.
    //   2. All addresses for these cards need to multiplied by 512, since
    //      the FAT library will provide 512K-block addresses.
    //   3. The Phoenix cannot use cards greater than 4GB, otherwise cards
    //      less than 4GB will fail to address correctly when the block
    //      address is multiplied by 512.
    //   4. MMC and V1.x cards can specify block sizes, which should be set
    //      to 512-bytes (which is the default, but better safe than sorry).
    //      V2.x SD-cards have fixed 512-byte blocks.
    //
    // The "A" commands (for example, ACMD41) are accessed by first sending
    // CMD55, which specifies that the next command is an application specific
    // command (hence the "A") instead of a standard command.
    //
    // The duration of the internal initialization is not known (maybe the info
    // is in the spec somewhere), so a long loop is used to wait what should be
    // somewhere around 30ms to 80ms.  Waiting is performed by calling ACMD41
    // until the card returns that it is not idle.
    //
    // CRC bytes are not calculated, and in SPI mode the default for SD-cards
    // is to have CRC disabled.


    g_sd_addr_size = ADDR_BLOCK;

    // Slow clock, CS_n disable.
    SD_CTRL_PORT = CK_SLOW | CE_OFF;

    // Send 80 clocks to train SD-card.
    uint8_t i;
    uint8_t d;
    for ( i = 10 ; i > 0 ; i-- ) {
        d = SD_DATA_PORT;
    }

    // If the return is not SD-card idle, fail.
    d = sd_send_cmd(CMD0, CRC0, CK_SLOW);
    if ( d != R1_IDLE ) {
        return SD_SPI_MODE_FAILED;
    }

    // Card is now in idle mode.

    // Send CMD8 to suggest a voltage and test SD-card V2.x
    CMDARGS[2] = VHS; CMDARGS[3] = CKPTRN;
    d = sd_send_cmd_ex(CMD8, CRC8, CK_SLOW);
    if ( d == R1_IDLE )
    {
        // V2.x SD-card
        // Read the CMD8 4 response bytes. Bytes 2 and 3 should
        // be echoes of what was sent, i.e. 0x01 and 0xAA.
        d = SD_DATA_PORT; // don't care
        d = SD_DATA_PORT; // don't care
        i = SD_DATA_PORT; // echo VHS
        d = SD_DATA_PORT; // echo Check Pattern
        SD_CTRL_PORT = CK_SLOW | CE_OFF;

        if ( i != VHS || d != CKPTRN ) {
            return SD_BAD_CMD8_VOLTAGE;
        }
    }

    else
    {
        // V1.x SD-card or MMC
        // Since CMD8 failed, the voltage needs to be checked
        // via CMD58. Status 0x00 or 0x01 are fine.
        d = sd_send_cmd_ex(CMD58, CRCX, CK_SLOW);
        if ( d > R1_IDLE ) {
            SD_CTRL_PORT = CK_SLOW | CE_OFF;
            return SD_BAD_OCR_READ;
        }

        // Read the 4 OCR bytes.
        // Bits 23..15 are the voltage bits.  Looking for all '1'
        // Bits 14..0 are reserved and should be 0.
        // to indicate 2.7V to 3.6V
        // 00 FF 80 00
        i = SD_DATA_PORT; // don't care
        i = SD_DATA_PORT; // bits 23..16
        d = SD_DATA_PORT; // bit 15, 0x80 or 0x00
        d &= 0x80; // make sure reserved bits don't interfere.
        if ( i == 0xFF ) {
            d++;
        }
        i = SD_DATA_PORT; // don't care
        SD_CTRL_PORT = CK_SLOW | CE_OFF;

        if ( d != 0x81 ) {
            return SD_BAD_OCR_VOLTAGE;
        }

        g_sd_addr_size = ADDR_BYTE;
    }

    // At this point the card is SD-card V1.x or V2.x, or an MMC card
    // and supports 3.3V.

    // Try ACMD41, if that fails try CMD1 to check for MMC.
    i = sd_send_cmd(CMD55, CRCX, CK_SLOW);
    if ( g_sd_addr_size == ADDR_BLOCK ) {
        // For V2.x SD-cards, HCS must be '1' or SDHC and SDXC cards
        // will never return ready status.  See spec section 4.2.3.
        CMDARGS[0] = HCS_YES;
    }
    d = sd_send_cmd(ACMD41, CRCX, CK_SLOW);

    if ( i > R1_IDLE || d > R1_IDLE )
    {
        // CMD55 or ACMD41 failed, try CMD1 to check for MMC.
        d = sd_send_cmd(CMD1, CRCX, CK_SLOW);
        if ( d > R1_IDLE ) {
            return SD_MMC_FAILED;
        }
        i = CARD_IS_MMC;
    } else {
        i = CARD_IS_SD;
    }

    // Send the ACMD41 or CMD1 to activate the card's self initialization.
    // Repeat until the card is ready, or timeout.  A count of 8000 should
    // be around 30ms to 80ms (this is a rough guess, as well as whether
    // this is enough time to allow the card to finish initialization.)
    uint16_t wait;
    for ( wait = 8000 ; wait > 0 && d == R1_IDLE ; wait-- )
    {
        if ( i == CARD_IS_SD ) {
            d = sd_send_cmd(CMD55, CRCX, CK_SLOW);
            d = sd_send_cmd(ACMD41, CRCX, CK_SLOW);
        } else {
            d = sd_send_cmd(CMD1, CRCX, CK_SLOW);
        }
    }

    if ( wait == 0 ) {
        return SD_INIT_TIMEOUT;
    }

    if ( d != R1_READY ) {
        return SD_INIT_FAILED;
    }


    // Card is initialized and ready to go.  For V2.x SD-cards, read the
    // CSS bit to determine card addressing.  For V1.x SD-cards and MMC,
    // set the block size to 512-bytes just to be safe.  V2.x SD-cards
    // have a fixed 512-byte block size.
    if ( g_sd_addr_size == ADDR_BLOCK )
    {
        // V2.x SD-cards might still be SDSC.
        d = sd_send_cmd_ex(CMD58, CRCX, CK_SLOW);
        if ( d > R1_IDLE ) {
            return SD_BAD_SSC_READ;
        }

        // Read 4 bytes of response.
        d = SD_DATA_PORT; // CSS is bit 0x40
        i = SD_DATA_PORT; // don't care
        i = SD_DATA_PORT; // don't care
        i = SD_DATA_PORT; // don't care
        SD_CTRL_PORT = CK_SLOW | CE_OFF;

        if ( (d & CSS_BIT) == 0 ) {
            g_sd_addr_size = ADDR_BYTE;
        }
    }

    else
    {
        // Set block size to 512 (00 00 02 00)
        CMDARGS[2] = 0x02;
        d = sd_send_cmd(CMD16, CRCX, CK_SLOW);
        if ( d > R1_IDLE ) {
            return SD_SET_BSIZE_FAILED;
        }
    }

    return SD_CARD_OK;
}
// sd_card_init()


/**
 * Read a 512 byte block from SD-card to VRAM
 *
 * @return SD_CARD_OK on success, otherwise CARD_ERROR enum error value.
 */
uint8_t
sd_read_block_to_vram(uint32_t block_addr)
{
    if ( g_sd_addr_size == ADDR_BYTE ) {
        block_addr *= 512;
    }

    CMDARGS[0] = (block_addr >> 24) & 0xFF;
    CMDARGS[1] = (block_addr >> 16) & 0xFF;
    CMDARGS[2] = (block_addr >>  8) & 0xFF;
    CMDARGS[3] =  block_addr        & 0xFF;

    uint8_t d;
    d = sd_send_cmd_ex(CMD17, CRCX, CK_FAST);
    if ( d != R1_READY ) {
        SD_CTRL_PORT = CK_FAST | CE_OFF;
        return SD_READ_BLOCK_FAILED;
    }


    // Block transfers begin with a Start Block Token, followed the data.
    // So loop until the token is received.
    // Measured counts: 894 to 944

    uint16_t wait;
    d = NODATA;
    for ( wait = 2000 ; wait > 0 && d != SD_BLK_START ; wait-- ) {
        d = SD_DATA_PORT;
    }

    if ( wait == 0 ) {
        SD_CTRL_PORT = CK_FAST | CE_OFF;
        VDP_DATA_PORT = '!';
        VDP_DATA_PORT = hex[((d&0xF0)>>4)];
        VDP_DATA_PORT = hex[(d&0x0F)];
        return SD_TOKEN_TIMEOUT;
    }

    // Show the timeout value for knowledge purposes.
    VDP_DATA_PORT = hex[((wait>>12)&0xF)];
    VDP_DATA_PORT = hex[((wait>> 8)&0xF)];
    VDP_DATA_PORT = hex[((wait>> 4)&0xF)];
    VDP_DATA_PORT = hex[( wait     &0xF)];
    VDP_DATA_PORT = ' ';

    // Start token received, 512 data bytes follow.
    for ( wait = 512 ; wait > 0 ; wait-- ) {
        d = SD_DATA_PORT;

        if ( wait > (512 - 128) ) {
            VDP_DATA_PORT = hex[((d >> 4) & 0xF)];
            VDP_DATA_PORT = hex[( d       & 0xF)];
            VDP_DATA_PORT = ' ';
        }
    }

    // Consume the 16-bit CRC from the card.
    d = SD_DATA_PORT;
    d = SD_DATA_PORT;

    SD_CTRL_PORT = CK_FAST | CE_OFF;

    return SD_CARD_OK;
}


enum SDCARD_ST {
    SD_ST_NOTFOUND = 0,
    SD_ST_INIT,
    SD_ST_INITFAIL,
    SD_ST_FOUND
};


/**
 * SD-card detection
 *
 * @note Call with VDP Write Address set to a location to
 *       dump 512 bytes from the SD-card on successful init.
 */
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

        g_sd_status = sd_card_init();
        if ( g_sd_status == SD_CARD_OK ) {
            state = SD_ST_FOUND;
            sd_read_block_to_vram(0);
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
            // The SD-card detect input went low, card was pulled out.
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


enum CARTRIDGE_ST {
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


// ==========================================================================
//
// Joystick Support
//
// ==========================================================================


enum JOYSTICK_ST {
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
    // Copy the swap-code below at label 001$ to address 6000h (RAM)
    ld hl, #001$
    ld de, #0x6000
    ld bc, #002$ - #001$
    ldir
    // Jump to the swap code just copied to RAM
    jp 0x6000

    001$:
    // Reading port 55h swaps the CV BIOS into address 0000h,
    // and the Loader ROM becomes inaccessible.
    in a, (0x55)

    // Jump to BIOS address 0000h, just like a power-on event.
    jp 0x0000
    002$:
    nop
    __endasm;
}
// swapin_real_cart()


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
    vdp_wtr(0x00, 0x00);    // VR0 GM1
    vdp_wtr(0x01, 0xC0);    // VR1 16K, not blanked, no interrupt, GM1
    vdp_wtr(0x02, 0x00);    // VR2 ntba  @ >0000 for 768 bytes
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
    CONT_JOY_PORT = 0;  // Any write selects the joystick

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


        // Display SD-card status.
        vdp_wr_addr(160);
        rtn = sd_card_detect(frame_tick);
        print_setxy(2, 1);
        print_str_sp("SDCARD:");
        switch ( rtn ) {
        case SD_ST_NOTFOUND :
            print_str("NONE   :"); break;
        case SD_ST_INIT :
            print_str("INIT... "); break;
        case SD_ST_INITFAIL :
            print_str("ERROR  :"); break;
        case SD_ST_FOUND :
            print_str("YES    :"); break;
        }

        VDP_DATA_PORT = ' ';
        VDP_DATA_PORT = hex[(g_sd_status&0x0F)];
        VDP_DATA_PORT = ' ';
        VDP_DATA_PORT = hex[(g_sd_addr_size&0x0F)];


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
