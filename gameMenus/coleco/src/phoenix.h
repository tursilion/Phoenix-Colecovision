// definitions for Phoenix I/O ports
//

volatile __sfr __at 0x50 sgmPSGAddressWrite;    // PSG Address write
volatile __sfr __at 0x51 sgmPSGDataWrite;       // PSG Data write
volatile __sfr __at 0x52 sgmPSGDataRead;        // PSG Data read

volatile __sfr __at 0x53 sgmConfig;             // configuration
#define SGM_CFG_SGM_ENABLE 1
#define SGM_CFG_SEX_ENABLE 2

volatile __sfr __at 0x54 phRAMBankSelect;       // 32k RAM bank select. 0 and 1 are both 1.

volatile __sfr __at 0x55 phBankingScheme;       // cartridge emulation control (also read it to disable Phoenix BIOS)
#define PH_BANK_CART        0
#define PH_BANK_MEGACART    1
#define PH_BANK_SGM         2
#define PH_BANK_ATARI       3
#define PH_UPPER_INTRAM     0x00              // non-banked
#define PH_UPPER_EXPROM     0x10              // cartridge emulation?
#define PH_UPPER_EXPRAM     0x20              // banked RAM
#define PH_UPPER_CART       0x30              // 32k fixed ROM

volatile __sfr __at 0x56 phSDControl;         // SD card control
#define PH_SD_CE_OFF        1                 // CE control, active low (RW)
#define PH_SD_LOW_SPEED     2                 // set for 400Khz, clear for 12MHz (RW)
#define PH_SD_CARD_DETECT   0x80              // read for card detect (other bits?)

volatile __sfr __at 0x57 phSDData;            // SD card read/write data
volatile __sfr __at 0x58 phMachineID;         // reads as 8 for Phoenix

volatile __sfr __at 0x7f sgmBIOSMap;          // swaps RAM with the Coleco BIOS
#define SGM_CFG_ENABLE_BIOS 0x02

#ifndef true
#define true 1
#endif
#ifndef false
#define false 0
#endif

// address that the Coleco BIOS font occurs, offset for the Phoenix memory map
// TODO: I don't have access to this anymore, we'll use fatfont
// That way SOME games will use it. ;) We don't have much choice
// unless I ditch fatfont for thinfont, or get them both back in.
// (thinfont is the actual Coleco/TI font)
//#define COLECO_FONT_ADR (0x158b + 0x4000)

void dly_50us(unsigned char n);
