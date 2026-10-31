// Verilator testbench for nes_phoenix.
//
//   tb [--sd image] [--frames n] [--ppm prefix] [--press-a frame] [--check]
//      [--pad frame:buttons,...] [--menu-reset frame] [--wav prefix] [--ppm-every n]
//      [--start-after-sound frames]   press Start this long after the audio
//                                     first changes (after frame 400)
//
// --pad sets controller 1 to the hex NES button byte (bit 0 = A ... bit 7 =
// Right) from each given frame on, e.g. --pad 60:01,62:00.
//
// Models the 512Kx8 SRAM and an SDHC card in SPI mode backed by a disk
// image, captures the 640x480 output, and optionally writes frames as PPM
// files and checks the picture of sim/testrom.

#include "Vnes_phoenix.h"
#include "verilated.h"

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <string>
#include <vector>
#include <utility>

// ---------------------------------------------------------------------------
// SD card, SPI mode, SDHC (block addressing)

struct SdCard {
    std::vector<uint8_t> img;
    bool present = false;

    bool last_sclk = false, last_cs_n = true;
    uint8_t rx = 0, tx = 0xFF;
    int bit = 0;
    std::vector<uint8_t> cmd;
    std::deque<uint8_t> out;
    bool idle = true, app = false;
    int acmd41_count = 0;
    int miso = 1;
    long reads = 0, writes = 0, multi = 0;
    // CMD18: streaming sectors from mblk until CMD12
    bool streaming = false;
    size_t mblk = 0;
    // CMD24: 0 none, 1 waiting for the data token, 2 receiving
    int wstate = 0;
    size_t wbase = 0;
    std::vector<uint8_t> wdata;

    bool load(const char *path) {
        FILE *f = fopen(path, "rb");
        if (!f) return false;
        fseek(f, 0, SEEK_END);
        long n = ftell(f);
        fseek(f, 0, SEEK_SET);
        img.resize(n);
        if (fread(img.data(), 1, n, f) != (size_t)n) { fclose(f); return false; }
        fclose(f);
        present = true;
        return true;
    }

    void command() {
        uint8_t c = cmd[0] & 0x3F;
        uint32_t arg = (cmd[1] << 24) | (cmd[2] << 16) | (cmd[3] << 8) | cmd[4];
        bool was_app = app;
        app = false;
        out.push_back(0xFF);                        // Ncr
        uint8_t r1 = idle ? 0x01 : 0x00;
        if (was_app && c == 41) {
            if (++acmd41_count >= 2) idle = false;
            out.push_back(idle ? 0x01 : 0x00);
            return;
        }
        switch (c) {
        case 0:  idle = true; out.push_back(0x01); break;
        case 8:  out.push_back(r1); out.push_back(0); out.push_back(0);
                 out.push_back(0x01); out.push_back(arg & 0xFF); break;
        case 55: app = true; out.push_back(r1); break;
        case 58: out.push_back(r1); out.push_back(0xC0); out.push_back(0xFF);
                 out.push_back(0x80); out.push_back(0x00); break;
        case 16: out.push_back(r1); break;
        case 17: {
            ++reads;
            out.push_back(0x00);
            out.push_back(0xFF);
            out.push_back(0xFF);
            out.push_back(0xFE);
            size_t base = (size_t)arg * 512;
            uint16_t crc = 0;
            for (int i = 0; i < 512; ++i) {
                uint8_t d = base + i < img.size() ? img[base + i] : 0;
                out.push_back(d);
                crc ^= d << 8;
                for (int k = 0; k < 8; ++k)
                    crc = (crc & 0x8000) ? (crc << 1) ^ 0x1021 : crc << 1;
            }
            out.push_back(crc >> 8);
            out.push_back(crc & 0xFF);
            break;
        }
        case 18:
            ++multi;
            out.push_back(0x00);
            streaming = true;
            mblk = arg;
            break;
        case 12:
            streaming = false;
            out.clear();
            out.push_back(0xFF);                    // stuff byte
            out.push_back(0x00);                    // R1
            out.push_back(0x00);                    // busy
            out.push_back(0x00);
            break;
        case 24:
            out.push_back(0x00);
            wstate = 1;
            wbase = (size_t)arg * 512;
            wdata.clear();
            break;
        default: out.push_back(0x04); break;        // illegal command
        }
    }

    void byte_received(uint8_t b) {
        if (wstate == 1) {
            if (b == 0xFE) wstate = 2;
            return;
        }
        if (wstate == 2) {
            wdata.push_back(b);
            if (wdata.size() == 514) {              // data and CRC
                if (wbase + 512 <= img.size())
                    memcpy(&img[wbase], wdata.data(), 512);
                ++writes;
                wstate = 0;
                out.clear();
                out.push_back(0x05);                // accepted
                for (int i = 0; i < 8; ++i) out.push_back(0x00);   // busy
            }
            return;
        }
        if (cmd.empty() && (b & 0xC0) != 0x40)
            return;
        cmd.push_back(b);
        if (cmd.size() == 6) {
            out.clear();
            command();
            cmd.clear();
        }
    }

    // The next sector of a CMD18, when the card has sent the last.
    void stream() {
        if (!streaming || out.size() > 2) return;
        out.push_back(0xFF);
        out.push_back(0xFE);
        size_t base = mblk * 512;
        uint16_t crc = 0;
        for (int i = 0; i < 512; ++i) {
            uint8_t b = base + i < img.size() ? img[base + i] : 0;
            out.push_back(b);
            crc ^= b << 8;
            for (int k = 0; k < 8; ++k)
                crc = (crc & 0x8000) ? (crc << 1) ^ 0x1021 : crc << 1;
        }
        out.push_back(crc >> 8);
        out.push_back(crc & 0xFF);
        ++mblk;
        ++reads;
    }

    // Called once per clock with the current pins.
    void step(bool cs_n, bool sclk, bool mosi) {
        stream();
        if (cs_n) {
            if (!last_cs_n) { bit = 0; cmd.clear(); wstate = 0; streaming = false; }
            miso = 1;
        } else {
            if (last_cs_n) {                        // selected: load first byte
                bit = 0;
                tx = 0xFF;
                miso = 1;
            }
            if (sclk && !last_sclk) {               // rising: sample MOSI
                rx = (rx << 1) | (mosi ? 1 : 0);
                if (++bit == 8) {
                    bit = 0;
                    byte_received(rx);
                }
            }
            if (!sclk && last_sclk) {               // falling: next MISO bit
                if (bit == 0) {
                    if (!out.empty()) { tx = out.front(); out.pop_front(); }
                    else tx = 0xFF;
                }
                miso = (tx >> (7 - bit)) & 1;
            }
        }
        last_sclk = sclk;
        last_cs_n = cs_n;
    }
};

// ---------------------------------------------------------------------------
// Audio capture: <prefix>_48k.wav point-samples the audio port at 48 kHz like
// the HDMI encoder does; <prefix>_raw.wav averages blocks of 64 clocks
// (390.625 kHz) to show what the APU produces above 24 kHz.

struct Wav {
    FILE *f = nullptr;
    uint32_t n = 0, rate = 0;
    bool open(const std::string &name, uint32_t r) {
        f = fopen(name.c_str(), "wb");
        rate = r;
        if (f) header();
        return f != nullptr;
    }
    void header() {
        uint32_t bytes = n * 2;
        auto u32 = [&](uint32_t v) { fwrite(&v, 4, 1, f); };
        auto u16 = [&](uint16_t v) { fwrite(&v, 2, 1, f); };
        fseek(f, 0, SEEK_SET);
        fwrite("RIFF", 1, 4, f); u32(36 + bytes); fwrite("WAVEfmt ", 1, 8, f);
        u32(16); u16(1); u16(1); u32(rate); u32(rate * 2); u16(2); u16(16);
        fwrite("data", 1, 4, f); u32(bytes);
        fseek(f, 0, SEEK_END);
    }
    void put(int16_t s) { if (f) { fwrite(&s, 2, 1, f); ++n; } }
    void close() { if (f) { header(); fclose(f); f = nullptr; } }
};

static const uint32_t W = 640, H = 480;

struct Pixel { uint8_t r, g, b; };

int main(int argc, char **argv)
{
    const char *sd_path = nullptr, *ppm = nullptr, *wav = nullptr;
    int frames = 30, press_a = -1, menu_reset = -1, ppm_every = 1;
    int start_after_sound = -1, sound_frame = -1, sound_after = 400;
    bool check = false;
    std::vector<std::pair<int, int>> pad_script;

    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--sd") && i + 1 < argc) sd_path = argv[++i];
        else if (!strcmp(argv[i], "--frames") && i + 1 < argc) frames = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--ppm") && i + 1 < argc) ppm = argv[++i];
        else if (!strcmp(argv[i], "--ppm-every") && i + 1 < argc) ppm_every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--press-a") && i + 1 < argc) press_a = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--wav") && i + 1 < argc) wav = argv[++i];
        else if (!strcmp(argv[i], "--start-after-sound") && i + 1 < argc) start_after_sound = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--check")) check = true;
        else if (!strcmp(argv[i], "--menu-reset") && i + 1 < argc) menu_reset = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--pad") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                int f, b;
                if (sscanf(t, "%d:%x", &f, &b) == 2) pad_script.push_back({f, b});
            }
        }
    }

    setvbuf(stdout, nullptr, _IOLBF, 0);
    Verilated::commandArgs(argc, argv);
    Vnes_phoenix *top = new Vnes_phoenix;

    static uint8_t sram[512 * 1024];
    memset(sram, 0x5A, sizeof(sram));

    SdCard sd;
    if (sd_path && !sd.load(sd_path)) {
        fprintf(stderr, "cannot read %s\n", sd_path);
        return 1;
    }

    std::vector<Pixel> fb(W * H);
    uint32_t x = 0, y = 0;
    bool last_blank = true, last_vsync_n = true;
    int frame = 0;
    bool boot_reported = false;
    int last_led = 0;
    long clocks = 0;
    int result = 0;

    Wav wav48, wavraw;
    if (wav) {
        wav48.open(std::string(wav) + "_48k.wav", 48000);
        wavraw.open(std::string(wav) + "_raw.wav", 390625);
    }
    uint32_t audio_timer = 0;                       // 25 MHz -> 48 kHz, as in hdmidataencoder.v
    int64_t raw_sum = 0;

    top->clk = 0;
    top->reset = 1;
    top->game_reset = 0;
    top->joy1 = 0;
    top->joy2 = 0;
    top->sd_cd_n = sd.present ? 0 : 1;
    top->sd_miso = 1;
    top->sram_din = 0;

    while (frame < frames && !Verilated::gotFinish()) {
        if (clocks == 32) top->reset = 0;
        // Back to the menu (the top level does this when reset is held).
        static long menu_reset_at = -1;
        if (menu_reset >= 0 && frame == menu_reset && menu_reset_at < 0) {
            menu_reset_at = clocks;
            top->reset = 1;
            boot_reported = false;
            printf("menu reset at frame %d\n", frame);
        }
        if (menu_reset_at >= 0 && clocks == menu_reset_at + 32) top->reset = 0;

        top->sram_din = sram[top->sram_addr];
        {
            // ROM cache holds and freezes
            static int last = 0;
            static long holds = 0, freezes = 0;
            int d = top->cache_dbg;
            if ((d & 2) && !(last & 2)) printf("cache freeze %ld at frame %d\n", ++freezes, frame);
            if ((d & 1) && !(last & 1)) ++holds;
            last = d;
            (void)holds;
        }
        top->sd_miso = sd.miso;
        top->clk = 1;
        top->eval();
        top->clk = 0;
        top->eval();
        ++clocks;

        if (!top->sram_we_n && top->sram_doe)
        {
            sram[top->sram_addr] = top->sram_dout;
            // A game's 8K-page writes below the CHR: the ROM cache filling a page
            static int last_a = -1;
            if (!top->boot_mode && (top->sram_addr & 0x1FFF) == 0 && (int)top->sram_addr != last_a)
                printf("cache fill: SRAM page %d at frame %d\n", top->sram_addr >> 13, frame);
            last_a = top->sram_addr;
        }
        sd.step(top->sd_cs_n, top->sd_sclk, top->sd_mosi);

        if (start_after_sound >= 0 && sound_frame < 0 && frame >= sound_after) {
            static int16_t settled = 0;
            static bool have = false;
            if (!have) { settled = (int16_t)top->audio; have = true; }
            else if ((int16_t)top->audio != settled) {
                sound_frame = frame;
                printf("sound starts at frame %d; Start at frame %d\n", frame, frame + start_after_sound);
            }
        }

        if (wav) {
            int16_t s = (int16_t)top->audio;
            audio_timer += 48;
            if (audio_timer >= 25000) { audio_timer -= 25000; wav48.put(s); }
            raw_sum += s;
            if ((clocks & 63) == 0) { wavraw.put((int16_t)(raw_sum / 64)); raw_sum = 0; }
        }

        if (!boot_reported && !top->boot_mode) {
            boot_reported = true;
            printf("boot done: frame %d (%.2f s), %ld SD reads\n",
                   frame, clocks / 25e6, sd.reads);
        }
        if (top->led_err != last_led) {
            last_led = top->led_err;
            printf("error LED %s at frame %d\n", last_led ? "on" : "off", frame);
        }

        // Video capture
        if (!top->vid_blank) {
            if (x < W && y < H)
                fb[y * W + x] = { top->vid_r, top->vid_g, top->vid_b };
            ++x;
        } else if (!last_blank) {
            x = 0;
            ++y;
        }
        last_blank = top->vid_blank;

        if (!top->vid_vsync_n && last_vsync_n) {
            if (y == H) {
                if (ppm && frame % ppm_every == 0) {
                    char name[512];
                    snprintf(name, sizeof(name), "%s%03d.ppm", ppm, frame);
                    FILE *f = fopen(name, "wb");
                    fprintf(f, "P6\n%u %u\n255\n", W, H);
                    fwrite(fb.data(), 3, fb.size(), f);
                    fclose(f);
                }
            } else if (frame > 0) {
                printf("frame %d: %u lines\n", frame, y);
            }
            ++frame;
            y = 0;
            x = 0;
            int pad = 0;
            for (auto &p : pad_script)
                if (frame >= p.first) pad = p.second;
            if (press_a >= 0 && frame >= press_a) pad |= 0x01;
            if (sound_frame >= 0 && frame >= sound_frame + start_after_sound &&
                frame < sound_frame + start_after_sound + 4) pad |= 0x08;
            top->joy1 = pad;
        }
        last_vsync_n = top->vid_vsync_n;
    }

    printf("%d frames, %ld clocks, boot_mode=%d, %ld multi-block reads\n", frame, clocks, top->boot_mode, sd.multi);
    wav48.close();
    wavraw.close();

    if (check) {
        // Picture of sim/testrom, in NES coordinates.
        struct { int x, y; const char *what; } spots[] = {
            {   0,   0, "white" }, { 255,   0, "white" }, {   0, 239, "white" },
            { 255, 239, "white" }, {   7, 120, "white" }, {   8, 120, "back"  },
            { 248, 120, "white" }, { 247, 120, "back"  }, { 128,   7, "white" },
            { 128,   8, "back"  }, { 128, 232, "white" }, { 128, 231, "back"  },
            {  80,  80, "red"   }, { 111, 111, "red"   }, {  79,  80, "back"  },
            { 112,  80, "back"  }, {  80,  79, "back"  }, {  80, 112, "back"  },
        };
        const char *back = (press_a >= 0 && frame > press_a + 2) ? "green" : "blue";
        int bad = 0;
        for (auto &s : spots) {
            for (int dy = 0; dy < 2; ++dy) for (int dx = 0; dx < 2; ++dx) {
                Pixel p = fb[(2 * s.y + dy) * W + 64 + 2 * s.x + dx];
                const char *want = strcmp(s.what, "back") ? s.what : back;
                const char *got =
                    (p.r > 200 && p.g > 200 && p.b > 200) ? "white" :
                    (p.r > 120 && p.g < 100 && p.b < 100) ? "red" :
                    (p.g > 120 && p.r < 150 && p.b < 120) ? "green" :
                    (p.b > 120 && p.r < 100 && p.g < 100) ? "blue" : "other";
                if (strcmp(want, got)) {
                    if (bad < 12)
                        printf("  (%d,%d)+(%d,%d): want %s, got %s %02x%02x%02x\n",
                               s.x, s.y, dx, dy, want, got, p.r, p.g, p.b);
                    ++bad;
                }
            }
        }
        // Borders outside the 512-pixel picture must be black.
        for (uint32_t yy = 0; yy < H; yy += 37)
            for (uint32_t xx : { 0u, 63u, 576u, 639u }) {
                Pixel p = fb[yy * W + xx];
                if (p.r | p.g | p.b) {
                    if (bad < 12) printf("  border (%u,%u) not black\n", xx, yy);
                    ++bad;
                }
            }
        printf("check: %s (%d bad)\n", bad ? "FAIL" : "PASS", bad);
        result = bad ? 1 : 0;
    }

    top->final();
    delete top;
    return result;
}
