/* Save test cartridge for the simulation: MBC5 with 32K of cartridge RAM
 * (SAVE32.GB) or MBC1 with 8K (SAVE8.GB).  Writes byte i of RAM bank b as
 * (i ^ (i >> 8)) + b + 1, then shows a black screen. */

#define REG(a) (*(volatile unsigned char *)(a))

void main(void)
{
    unsigned char b, banks = REG(0x0149) == 3 ? 4 : 1;
    unsigned int i;
    volatile unsigned char *p;

    REG(0x0000) = 0x0A;                     /* RAM enable */
    for (b = 0; b < banks; ++b) {
        REG(0x4000) = b;
        for (p = (unsigned char *)0xA000, i = 0; i < 0x2000; ++i)
            *p++ = (unsigned char)((i ^ (i >> 8)) + b + 1);
    }
    REG(0x0000) = 0x00;

    while (REG(0xFF44) != 144)
        ;
    REG(0xFF40) = 0;
    for (p = (unsigned char *)0x8000, i = 0; i < 16; ++i)
        *p++ = 0xFF;
    for (p = (unsigned char *)0x9800, i = 0; i < 0x400; ++i)
        *p++ = 0;
    REG(0xFF47) = 0xE4;
    REG(0xFF40) = 0x91;
    for (;;)
        ;
}
