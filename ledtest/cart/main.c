/* Phoenix LED test (SDCC, Z80): a plain 32K ColecoVision cart.
 *
 * The board has two LEDs:
 *   D24  green, FPGA pin D14 (led_o): 'Z' = on, '0' = off.  The cores
 *        light it during reset and (Coleco) the menu and cache errors.
 *   D6   RGB, pins B16/A16/C15 (red/green/blue), common anode: a colour is
 *        lit when its pin is '0'.  The cores show yellow (red + green).
 *
 * The LED test core (ledtest/, slot CORE29) adds port >5F to override both:
 *   bits 1-0  LED: 00/11 = normal, 01 = off, 10 = on
 *   bit  7    RGB override, bits 6/5/4 = red/green/blue (1 = lit)
 *   Reads back the value written; reset sets >00.
 *
 * Keys (keypad on either controller, or the PS/2 number keys):
 *   1 LED normal  2 LED off  3 LED on  4 LED blink (1 Hz)
 *   5 RGB normal  6/7/8 toggle red/green/blue  9 RGB colour cycle
 *   0 both normal  * both off  # both on (RGB white)
 */

typedef unsigned char BYTE;
typedef unsigned int  WORD;

__sfr __at 0xBE VDP_DATA;
__sfr __at 0xBF VDP_CTRL;
__sfr __at 0x5F LED_PORT;
__sfr __at 0x80 PAD_KEYS;       /* write: select the keypad halves */
__sfr __at 0xFC PAD1;
__sfr __at 0xFF PAD2;

extern const BYTE font[];       /* font.c: ASCII 32-122 */

/* port >FC/>FF bits 3-0 to the key, 0xFF = none */
static const BYTE keymap[16] = {
    0xFF, '8', '4', '5',
    0xFF, '7', '#', '2',
    0xFF, '*', '0', '9',
    '3',  '1', '6', 0xFF
};

static void vdp_reg(BYTE r, BYTE v)
{
    VDP_CTRL = v;
    VDP_CTRL = 0x80 | r;
}

static void vdp_addr(WORD a)
{
    VDP_CTRL = (BYTE)a;
    VDP_CTRL = (BYTE)(a >> 8) | 0x40;
}

/* Graphics I: names at $1800, colours $2000, patterns $0000 */
static void put(BYTE col, BYTE row, const char *s)
{
    vdp_addr(0x1800 + (WORD)row * 32 + col);
    while (*s)
        VDP_DATA = *s++;
}

static const char hexd[] = "0123456789ABCDEF";

static void hex2(BYTE col, BYTE row, BYTE v)
{
    char s[3];
    s[0] = hexd[v >> 4];
    s[1] = hexd[v & 15];
    s[2] = 0;
    put(col, row, s);
}

static void screen_init(void)
{
    const BYTE *f = font;
    WORD i;

    vdp_reg(1, 0x80);           /* 16K, display off, no interrupt */
    vdp_reg(0, 0x00);
    vdp_reg(2, 0x06);
    vdp_reg(3, 0x80);
    vdp_reg(4, 0x00);
    vdp_reg(5, 0x36);
    vdp_reg(6, 0x07);
    vdp_reg(7, 0xF4);
    vdp_addr(0x0000);
    for (i = 0; i < 32 * 8; ++i)
        VDP_DATA = 0;
    for (i = 0; i < 91 * 8; ++i)
        VDP_DATA = *f++;
    vdp_addr(0x2000);
    for (i = 0; i < 32; ++i)
        VDP_DATA = 0xF4;        /* white on dark blue */
    vdp_addr(0x1800);
    for (i = 0; i < 768; ++i)
        VDP_DATA = ' ';
    vdp_addr(0x1B00);
    VDP_DATA = 0xD0;            /* no sprites */

    put(2, 1, "PHOENIX LED TEST");
    put(2, 3, "PORT >5F SUPPORT");
    put(2, 4, "WROTE      READ");
    put(2, 6, "LED (GREEN, D24)");
    put(2, 9, "RGB LED (D6)");
    put(2, 13, "1 LED NORMAL  2 LED OFF");
    put(2, 14, "3 LED ON      4 LED BLINK");
    put(2, 16, "5 RGB NORMAL (YELLOW)");
    put(2, 17, "6 RED  7 GREEN  8 BLUE");
    put(2, 18, "9 RGB COLOUR CYCLE");
    put(2, 20, "0 BOTH NORMAL");
    put(2, 21, "* BOTH OFF    # BOTH ON");
    vdp_reg(1, 0xC0);           /* display on */
}

static BYTE read_key(void)
{
    BYTE k;

    PAD_KEYS = 0;
    k = keymap[PAD1 & 15];
    if (k == 0xFF)
        k = keymap[PAD2 & 15];
    return k;
}

/* wait for the VDP's frame flag (polled: the VDP interrupt is off) */
static void wait_frame(void)
{
    while (!(VDP_CTRL & 0x80))
        ;
}

static const char *const led_names[4] = {
    "NORMAL (CORE)", "OFF          ", "ON           ", "BLINKING     "
};

static const char *const colour_names[8] = {
    "NONE   ", "BLUE   ", "GREEN  ", "CYAN   ",
    "RED    ", "MAGENTA", "YELLOW ", "WHITE  "
};

void main(void)
{
    BYTE led_mode, rgb_mode, rgb, frame, secs, key, last_key, v, r;

    screen_init();

    /* Older cores read >00 at port >5F: write an unused bit pattern and
     * see whether it comes back. */
    LED_PORT = 0x0C;
    put(19, 3, LED_PORT == 0x0C ? "YES" : "NO ");
    LED_PORT = 0x00;

    led_mode = 0;               /* normal, off, on, blink */
    rgb_mode = 0;               /* normal, manual, cycle */
    rgb = 6;                    /* red, green, blue = bits 2, 1, 0 */
    frame = 0;
    secs = 0;
    last_key = 0xFF;

    for (;;) {
        wait_frame();
        if (++frame == 60) {
            frame = 0;
            ++secs;
        }

        key = read_key();
        if (key != last_key) {
            switch (key) {
            case '1': led_mode = 0; break;
            case '2': led_mode = 1; break;
            case '3': led_mode = 2; break;
            case '4': led_mode = 3; break;
            case '5': rgb_mode = 0; rgb = 6; break;
            case '6': rgb_mode = 1; rgb ^= 4; break;
            case '7': rgb_mode = 1; rgb ^= 2; break;
            case '8': rgb_mode = 1; rgb ^= 1; break;
            case '9': rgb_mode = 2; break;
            case '0': led_mode = 0; rgb_mode = 0; rgb = 6; break;
            case '*': led_mode = 1; rgb_mode = 1; rgb = 0; break;
            case '#': led_mode = 2; rgb_mode = 1; rgb = 7; break;
            }
            last_key = key;
        }
        if (rgb_mode == 2)
            rgb = secs & 7;

        v = 0;
        if (led_mode == 1 || (led_mode == 3 && frame >= 30))
            v = 0x01;
        else if (led_mode == 2 || led_mode == 3)
            v = 0x02;
        if (rgb_mode != 0)
            v |= 0x80 | (rgb << 4);
        LED_PORT = v;
        r = LED_PORT;

        hex2(8, 4, v);
        hex2(18, 4, r);
        put(4, 7, led_names[led_mode]);
        put(4, 10, rgb_mode == 0 ? "NORMAL (YELLOW)" :
                   rgb_mode == 1 ? "SET            " : "CYCLING        ");
        put(4, 11, colour_names[rgb]);
    }
}
