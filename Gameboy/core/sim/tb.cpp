// Verilator testbench for gb_phoenix.
//
//   tb [--sd image] [--frames n] [--ppm prefix] [--ppm-every n] [--wav file]
//      [--pad frame:bits,...] [--reset frame] [--menu-reset frame]
//      [--dump-sram file] [--sd-out image]
//
// --pad sets the SNES pad (hex, bit 0 A, 1 B, 2 X, 3 Y, 4 start, 5 select,
// 6 L, 7 R, 8 up, 9 down, 10 left, 11 right) from each given frame on.
// --key sets the ColecoVision keypad (key number 0-11, or -1 for none) the
// same way.
//
// Clocks: 25MHz and 33.75MHz (27/20) on a 1/27 ns time base; clk_g is
// clk_i gated by run, sampled at the falling edge of clk_i like a BUFGCE.
// Models the 512Kx8 SRAM and an SDHC card in SPI mode backed by a disk
// image (with single-block writes; --sd-out saves the image at the end),
// captures the 640x480 output, writes frames as PPM files.

#include "Vgb_phoenix.h"
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
    long reads = 0, writes = 0;
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
            for (int i = 0; i < 512; ++i)
                out.push_back(base + i < img.size() ? img[base + i] : 0);
            out.push_back(0x12);
            out.push_back(0x34);
            break;
        }
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

    // Called once per clock with the current pins.
    void step(bool cs_n, bool sclk, bool mosi) {
        if (cs_n) {
            if (!last_cs_n) { bit = 0; cmd.clear(); wstate = 0; }
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
// 48 kHz stereo audio, point-sampled like the HDMI encoder

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
        uint32_t bytes = n * 4;
        auto u32 = [&](uint32_t v) { fwrite(&v, 4, 1, f); };
        auto u16 = [&](uint16_t v) { fwrite(&v, 2, 1, f); };
        fseek(f, 0, SEEK_SET);
        fwrite("RIFF", 1, 4, f); u32(36 + bytes); fwrite("WAVEfmt ", 1, 8, f);
        u32(16); u16(1); u16(2); u32(rate); u32(rate * 4); u16(4); u16(16);
        fwrite("data", 1, 4, f); u32(bytes);
        fseek(f, 0, SEEK_END);
    }
    void put(int16_t l, int16_t r) { if (f) { fwrite(&l, 2, 1, f); fwrite(&r, 2, 1, f); ++n; } }
    void close() { if (f) { header(); fclose(f); f = nullptr; } }
};

struct Pixel { uint8_t r, g, b; };
static const uint32_t W = 640, H = 480;

int main(int argc, char **argv)
{
    const char *sd_path = nullptr, *ppm = nullptr, *wav = nullptr, *dump = nullptr, *sd_out = nullptr;
    int frames = 30, ppm_every = 1, reset_frame = -1, menu_reset = -1;
    std::vector<std::pair<int, int>> pad_script, key_script;

    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--sd") && i + 1 < argc) sd_path = argv[++i];
        else if (!strcmp(argv[i], "--frames") && i + 1 < argc) frames = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--ppm") && i + 1 < argc) ppm = argv[++i];
        else if (!strcmp(argv[i], "--ppm-every") && i + 1 < argc) ppm_every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--wav") && i + 1 < argc) wav = argv[++i];
        else if (!strcmp(argv[i], "--dump-sram") && i + 1 < argc) dump = argv[++i];
        else if (!strcmp(argv[i], "--sd-out") && i + 1 < argc) sd_out = argv[++i];
        else if (!strcmp(argv[i], "--reset") && i + 1 < argc) reset_frame = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--menu-reset") && i + 1 < argc) menu_reset = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--key") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                int f, k;
                if (sscanf(t, "%d:%d", &f, &k) == 2) key_script.push_back({f, k});
            }
        }
        else if (!strcmp(argv[i], "--pad") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                int f, b;
                if (sscanf(t, "%d:%x", &f, &b) == 2) pad_script.push_back({f, b});
            }
        }
    }

    Verilated::commandArgs(argc, argv);
    Vgb_phoenix *top = new Vgb_phoenix;

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

    Wav wav48;
    if (wav)
        wav48.open(wav, 48000);
    uint32_t audio_timer = 0;

    top->clk25 = 0;
    top->clk_i = 0;
    top->clk_g = 0;
    top->reset = 1;
    top->game_reset = 0;
    top->cv1 = 0x3C0;           // no key
    top->cv2 = 0x3C0;
    top->snes = 0;
    top->kb_keys = 0;
    top->kb_joy = 0;
    top->sd_cd_n = sd.present ? 0 : 1;
    top->sd_miso = 1;
    top->eval();

    // Time in units of 1/27 ns: clk25 half period 20 ns = 540,
    // clk_i half period 14.815 ns = 400.
    const long H25 = 540, HI = 400;
    long t25 = H25, ti = HI;
    bool en = true;
    int reset_cnt = 0;

    while (frame < frames && !Verilated::gotFinish()) {
        bool edge25 = t25 <= ti;
        bool edgei = ti <= t25;
        if (edge25) { top->clk25 = !top->clk25; t25 += H25; }
        if (edgei) {
            top->clk_i = !top->clk_i;
            ti += HI;
            if (top->clk_i) {
                if (en) top->clk_g = 1;
            } else {
                top->clk_g = 0;
                en = top->run;      // BUFGCE: enable sampled at the falling edge
            }
        }
        top->eval();

        // SRAM: asynchronous
        if (!top->sram_we_n && top->sram_doe)
            sram[top->sram_addr] = top->sram_dout;
        top->sram_din = top->sram_oe_n ? 0xFF : sram[top->sram_addr];
        sd.step(top->sd_cs_n, top->sd_sclk, top->sd_mosi);
        top->sd_miso = sd.miso;
        top->eval();

        if (!(edge25 && top->clk25))
            continue;

        // ---- clk25 rising edge ----
        ++clocks;
        // Power-on reset, or a held reset (two frames, like the button)
        if (reset_cnt < 64) ++reset_cnt;
        top->reset = reset_cnt < 64 ||
                     (menu_reset >= 0 && frame >= menu_reset && frame < menu_reset + 2);

        if (wav) {
            audio_timer += 48;
            if (audio_timer >= 25000) { audio_timer -= 25000; wav48.put((int16_t)top->audio_l, (int16_t)top->audio_r); }
        }

        if (!boot_reported && !top->boot_mode) {
            boot_reported = true;
            printf("game starts: frame %d (%.2f s), %ld SD reads\n",
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
                    snprintf(name, sizeof(name), "%s%04d.ppm", ppm, frame);
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
            top->snes = pad;
            int key = -1;
            for (auto &k : key_script)
                if (frame >= k.first) key = k.second;
            // ColecoVision keypad codes on pins 4..1 (cv_pads bits 9:6)
            static const int codes[12] = { 0xC, 0x7, 0xB, 0x6, 0x8, 0x9, 0xE, 0x3, 0x1, 0xD, 0x5, 0xA };
            top->cv1 = (key >= 0 && key < 12) ? (codes[key] << 6) : 0x3C0;
            top->game_reset = (reset_frame >= 0 && frame >= reset_frame && frame < reset_frame + 2);
        }
        last_vsync_n = top->vid_vsync_n;
    }

    printf("%d frames, %ld clocks, boot_mode=%d, %ld SD writes\n", frame, clocks, top->boot_mode, sd.writes);
    if (sd_out) {
        FILE *f = fopen(sd_out, "wb");
        fwrite(sd.img.data(), 1, sd.img.size(), f);
        fclose(f);
    }
    wav48.close();
    if (dump) {
        FILE *f = fopen(dump, "wb");
        fwrite(sram, 1, sizeof(sram), f);
        fclose(f);
    }
    top->final();
    delete top;
    return 0;
}
