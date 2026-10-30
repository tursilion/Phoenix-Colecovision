/* 512K MBC1 test cartridge for the simulation: checks that each of the 31
 * switchable ROM banks holds its own number at its first byte, that the 8K
 * cartridge RAM and the work RAM keep a pattern, then shows the result:
 * a black screen if everything passed, white with dark stripes (one per
 * failed part: ROM, cartridge RAM, work RAM) if not. */

#define REG(a) (*(volatile unsigned char *)(a))

static unsigned char bad_rom, bad_ram, bad_wram;

void main(void)
{
    unsigned char n;
    unsigned int i;
    volatile unsigned char *p;

    for (n = 1; n < 32; ++n) {
        REG(0x2000) = n;
        if (REG(0x4000) != n)
            bad_rom = 1;
    }

    REG(0x0000) = 0x0A;                     /* RAM enable */
    for (p = (unsigned char *)0xA000, i = 0; i < 0x2000; ++i)
        *p++ = (unsigned char)(i ^ (i >> 8));
    for (p = (unsigned char *)0xA000, i = 0; i < 0x2000; ++i)
        if (*p++ != (unsigned char)(i ^ (i >> 8)))
            bad_ram = 1;

    for (p = (unsigned char *)0xC000, i = 0; i < 0x1D00; ++i)
        *p++ = (unsigned char)(i * 7);
    for (p = (unsigned char *)0xC000, i = 0; i < 0x1D00; ++i)
        if (*p++ != (unsigned char)(i * 7))
            bad_wram = 1;

    while (REG(0xFF44) != 144)              /* LCD off in vertical blank */
        ;
    REG(0xFF40) = 0;
    /* tile 0: black if all passed, else white; tile 1 black */
    for (p = (unsigned char *)0x8000, i = 0; i < 16; ++i)
        *p++ = (bad_rom | bad_ram | bad_wram) ? 0x00 : 0xFF;
    for (i = 0; i < 16; ++i)
        *p++ = 0xFF;
    /* map: tile 0, with rows 4, 8 and 12 of tile 1 for each failure */
    for (p = (unsigned char *)0x9800, i = 0; i < 0x400; ++i) {
        n = (unsigned char)(i >> 5);
        *p++ = (n == 4 && bad_rom) || (n == 8 && bad_ram) || (n == 12 && bad_wram);
    }
    REG(0xFF47) = 0xE4;
    REG(0xFF40) = 0x91;
    for (;;)
        ;
}
