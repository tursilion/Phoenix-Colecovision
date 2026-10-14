// Verilator testbench for dl_phoenix.
//
//   tb --sd image [--frame0 lba] [--frames n] [--ppm prefix] [--ppm-every k]
//      [--pad frame:joy:sys,...] [--wav file] [--patch addr=val,...]
//
// Models the 512Kx8 SRAM and an SDHC card in SPI mode (CMD0/8/55/41/58/16,
// CMD17, CMD18 multi-block reads and CMD12), backed by a disk image read on
// demand.  Sectors from --frame0 on are synthesized as test disc frames
// (the frame number in big digits, like tools/mkdisc.py --test), so the
// whole disc need not exist.
//
// --pad sets the controls from each given video frame on: joy is the hex
// joy byte (b0 up b1 down b2 left b3 right b4 fire), sys the hex sys bits
// (b0 start1 b1 start2 b2 coin1 b3 coin2), e.g. --pad 200:00:4,203:00:0.
//
// --patch changes game ROM bytes once the game is loaded, e.g. Lair's two
// 15.7 s power-on waits (the operands at 121B and 1235): --patch 121b=8,1235=8
//
// Writes frames as PPM files, and the audio as a 48kHz stereo WAV.

#include "Vdl_phoenix.h"
#include "verilated.h"

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <string>
#include <utility>
#include <vector>

#include <fcntl.h>
#include <unistd.h>

// ---------------------------------------------------------------------------
// Synthetic test disc frames (see tools/mkdisc.py)

static const char *DIGITS[10][5] = {
    {"111","101","101","101","111"}, {"010","110","010","010","111"},
    {"111","001","111","100","111"}, {"111","001","111","001","111"},
    {"101","101","111","001","001"}, {"111","100","111","001","111"},
    {"111","100","111","101","111"}, {"111","001","001","001","001"},
    {"111","101","111","101","111"}, {"111","101","111","001","111"},
};

static void test_frame(uint32_t f, std::vector<uint8_t> &blk)
{
    blk.assign(93 * 512, 0);
    memcpy(&blk[0], "FRM", 3);
    blk[4] = f; blk[5] = f >> 8; blk[6] = f >> 16; blk[7] = f >> 24;
    blk[8] = 2000 & 0xFF; blk[9] = 2000 >> 8;
    for (int i = 0; i < 17; ++i) {
        int r, g, b;
        if (i < 8) { r = (i & 1) * 255; g = ((i >> 1) & 1) * 255; b = ((i >> 2) & 1) * 255; }
        else if (i < 16) { r = 80 + (i & 1) * 175; g = 80 + ((i >> 1) & 1) * 175; b = 80 + ((i >> 2) & 1) * 175; }
        else { r = g = b = 40; }
        uint16_t v = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
        blk[0x200 + 2 * i] = v & 0xFF;
        blk[0x201 + 2 * i] = v >> 8;
    }
    uint8_t grid[60][80];
    memset(grid, 16, sizeof(grid));
    for (int y = 0; y < 60; ++y) grid[y][(f * 2) % 80] = 1 + (f % 7);
    char s[8];
    snprintf(s, sizeof(s), "%05u", f % 100000);
    int scale = 3, x0 = (80 - (5 * 4 - 1) * scale) / 2, y0 = (60 - 5 * scale) / 2;
    for (int n = 0; n < 5; ++n)
        for (int r = 0; r < 5; ++r)
            for (int c = 0; c < 3; ++c)
                if (DIGITS[s[n] - '0'][r][c] == '1')
                    for (int dy = 0; dy < scale; ++dy)
                        for (int dx = 0; dx < scale; ++dx)
                            grid[y0 + r * scale + dy][x0 + (n * 4 + c) * scale + dx] = 15;
    for (int x = 0; x < 80; ++x) grid[0][x] = grid[1][x] = 8 + (f % 8);
    for (int y = 0; y < 60; ++y)
        for (int x = 0; x < 80; ++x) {
            uint8_t *c = &blk[0x400 + (y * 80 + x) * 8];
            c[0] = c[1] = c[2] = c[3] = grid[y][x];
            c[4] = c[5] = c[6] = c[7] = 0;
        }
    double freq = 220.0 * (1 + (f / 10) % 4);
    for (int i = 0; i < 2000; ++i) {
        double t = (i + (double)f * 2000) / 47952.0;
        int16_t v = (int16_t)(sin(2 * M_PI * freq * t) * 6000);
        uint8_t *a = &blk[0x9A00 + 4 * i];
        a[0] = v & 0xFF; a[1] = (v >> 8) & 0xFF; a[2] = a[0]; a[3] = a[1];
    }
}

// ---------------------------------------------------------------------------
// SD card, SPI mode, SDHC (block addressing)

struct SdCard {
    int fd = -1;
    uint64_t size = 0;
    bool present = false;
    uint32_t frame0 = 0xFFFFFFFF;
    uint32_t cached_frame = 0xFFFFFFFF;
    std::vector<uint8_t> frame_blk;

    bool last_sclk = false, last_cs_n = true;
    uint8_t rx = 0, tx = 0xFF;
    int bit = 0;
    std::vector<uint8_t> cmd;
    std::deque<uint8_t> out;
    bool idle = true, app = false;
    int acmd41_count = 0;
    int miso = 1;
    long reads = 0, cmd18s = 0, cmd12s = 0;
    bool multi = false;          // CMD18 open
    uint32_t multi_lba = 0;

    bool open_img(const char *path) {
        fd = open(path, O_RDONLY);
        if (fd < 0) return false;
        size = lseek(fd, 0, SEEK_END);
        present = true;
        return true;
    }

    void sector(uint32_t lba, uint8_t *dst) {
        if (lba >= frame0) {
            uint32_t f = (lba - frame0) / 93, s = (lba - frame0) % 93;
            if (f != cached_frame) { test_frame(f, frame_blk); cached_frame = f; }
            memcpy(dst, &frame_blk[s * 512], 512);
            return;
        }
        memset(dst, 0, 512);
        if ((uint64_t)lba * 512 < size)
            if (pread(fd, dst, 512, (off_t)lba * 512) < 0) perror("pread");
    }

    void push_block(uint32_t lba) {
        uint8_t b[512];
        sector(lba, b);
        out.push_back(0xFF);
        out.push_back(0xFE);
        for (int i = 0; i < 512; ++i) out.push_back(b[i]);
        out.push_back(0x12);
        out.push_back(0x34);
        ++reads;
    }

    void command() {
        uint8_t c = cmd[0] & 0x3F;
        uint32_t arg = (cmd[1] << 24) | (cmd[2] << 16) | (cmd[3] << 8) | cmd[4];
        bool was_app = app;
        app = false;
        if (c == 12) {
            ++cmd12s;
            out.clear();
            multi = false;
            out.push_back(0xFF);                    // stuff byte
            out.push_back(0x00);                    // R1
            out.push_back(0x00);                    // busy
            out.push_back(0x00);
            return;
        }
        out.clear();
        multi = false;
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
        case 17: out.push_back(0x00); push_block(arg); break;
        case 18: out.push_back(0x00); multi = true; multi_lba = arg; ++cmd18s; break;
        default: out.push_back(0x04); break;        // illegal command
        }
    }

    void byte_received(uint8_t b) {
        if (cmd.empty() && (b & 0xC0) != 0x40)
            return;
        cmd.push_back(b);
        if (cmd.size() == 6) {
            command();
            cmd.clear();
        }
    }

    uint8_t next_out() {
        if (out.empty() && multi)
            push_block(multi_lba++);
        if (out.empty()) return 0xFF;
        uint8_t v = out.front();
        out.pop_front();
        return v;
    }

    // One full SCLK pulse (25MHz mode): sample MOSI, then the next MISO bit.
    void pulse(bool mosi) {
        rx = (rx << 1) | (mosi ? 1 : 0);
        if (++bit == 8) { bit = 0; byte_received(rx); }
        if (bit == 0) tx = next_out();
        miso = (tx >> (7 - bit)) & 1;
    }

    // Called once per clock with the current pins.
    void step(bool cs_n, bool sclk, bool sclk_pulse, bool mosi) {
        if (cs_n) {
            if (!last_cs_n) { bit = 0; cmd.clear(); }
            miso = 1;
        } else {
            if (last_cs_n) {                        // selected
                bit = 0;
                tx = 0xFF;
                miso = 1;
            }
            if (sclk_pulse) {
                pulse(mosi);
            } else {
                if (sclk && !last_sclk) {           // rising: sample MOSI
                    rx = (rx << 1) | (mosi ? 1 : 0);
                    if (++bit == 8) { bit = 0; byte_received(rx); }
                }
                if (!sclk && last_sclk) {           // falling: next MISO bit
                    if (bit == 0) tx = next_out();
                    miso = (tx >> (7 - bit)) & 1;
                }
            }
        }
        last_sclk = sclk;
        last_cs_n = cs_n;
    }
};

// ---------------------------------------------------------------------------

static const uint32_t W = 640, H = 480;

struct Pixel { uint8_t r, g, b; };

static void wav_header(FILE *f, uint32_t samples)
{
    uint32_t data = samples * 4;
    fwrite("RIFF", 1, 4, f);
    uint32_t v = 36 + data; fwrite(&v, 4, 1, f);
    fwrite("WAVEfmt ", 1, 8, f);
    v = 16; fwrite(&v, 4, 1, f);
    uint16_t s = 1; fwrite(&s, 2, 1, f);
    s = 2; fwrite(&s, 2, 1, f);
    v = 48000; fwrite(&v, 4, 1, f);
    v = 48000 * 4; fwrite(&v, 4, 1, f);
    s = 4; fwrite(&s, 2, 1, f);
    s = 16; fwrite(&s, 2, 1, f);
    fwrite("data", 1, 4, f);
    fwrite(&data, 4, 1, f);
}

int main(int argc, char **argv)
{
    const char *sd_path = nullptr, *ppm = nullptr, *wav = nullptr;
    int frames = 30, ppm_every = 1;
    uint32_t frame0 = 0xFFFFFFFF;
    struct Pad { int frame, joy, sys; };
    std::vector<Pad> pad_script;
    std::vector<std::pair<uint32_t, uint8_t>> patches;

    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--sd") && i + 1 < argc) sd_path = argv[++i];
        else if (!strcmp(argv[i], "--frame0") && i + 1 < argc) frame0 = strtoul(argv[++i], 0, 0);
        else if (!strcmp(argv[i], "--frames") && i + 1 < argc) frames = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--ppm") && i + 1 < argc) ppm = argv[++i];
        else if (!strcmp(argv[i], "--ppm-every") && i + 1 < argc) ppm_every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--wav") && i + 1 < argc) wav = argv[++i];
        else if (!strcmp(argv[i], "--patch") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                unsigned a, v;
                if (sscanf(t, "%x=%x", &a, &v) == 2) patches.push_back({a, (uint8_t)v});
            }
        }
        else if (!strcmp(argv[i], "--pad") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                Pad p;
                if (sscanf(t, "%d:%x:%x", &p.frame, &p.joy, &p.sys) == 3) pad_script.push_back(p);
            }
        }
    }

    Verilated::commandArgs(argc, argv);
    Vdl_phoenix *top = new Vdl_phoenix;

    static uint8_t sram[512 * 1024];
    memset(sram, 0x5A, sizeof(sram));

    SdCard sd;
    sd.frame0 = frame0;
    if (sd_path && !sd.open_img(sd_path)) {
        fprintf(stderr, "cannot read %s\n", sd_path);
        return 1;
    }

    FILE *wf = nullptr;
    uint32_t wav_samples = 0;
    if (wav) { wf = fopen(wav, "wb"); wav_header(wf, 0); }

    std::vector<Pixel> fb(W * H);
    uint32_t x = 0, y = 0;
    bool last_blank = true, last_vsync_n = true;
    int frame = 0;
    bool boot_reported = false;
    int last_led = 0;
    long clocks = 0;
    double audio_acc = 0;

    top->clk = 0;
    top->reset = 1;
    top->game_reset = 0;
    top->joy = 0;
    top->sys = 0;
    top->ov_toggle = 0;
    top->sd_cd_n = sd.present ? 0 : 1;
    top->sd_miso = 1;
    top->sram_din = 0;

    while (frame < frames && !Verilated::gotFinish()) {
        if (clocks == 32) top->reset = 0;

        top->sram_din = sram[top->sram_addr];
        top->sd_miso = sd.miso;
        top->clk = 1;
        top->eval();
        top->clk = 0;
        top->eval();
        ++clocks;

        if (!top->sram_we_n && top->sram_doe)
            sram[top->sram_addr] = top->sram_dout;
        sd.step(top->sd_cs_n, top->sd_sclk_lvl, top->sd_sclk_pulse, top->sd_mosi);

        if (!boot_reported && !top->boot_mode) {
            boot_reported = true;
            printf("boot done: frame %d (%.2f s), %ld SD reads\n", frame, clocks / 25e6, sd.reads);
            for (auto &p : patches) {
                printf("patch %04x: %02x -> %02x\n", p.first, sram[0x70000 + p.first], p.second);
                sram[0x70000 + p.first] = p.second;
            }
            fflush(stdout);
        }
        if (top->led_err != last_led) {
            last_led = top->led_err;
            printf("error LED %s at frame %d\n", last_led ? "on" : "off", frame);
        }

        // Audio at 48kHz
        audio_acc += 48000.0 / 25e6;
        if (audio_acc >= 1.0) {
            audio_acc -= 1.0;
            if (wf) {
                int16_t s[2] = { (int16_t)top->audio_l, (int16_t)top->audio_r };
                fwrite(s, 2, 2, wf);
                ++wav_samples;
            }
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
            if (y == H && ppm && frame % ppm_every == 0) {
                char name[512];
                snprintf(name, sizeof(name), "%s%05d.ppm", ppm, frame);
                FILE *f = fopen(name, "wb");
                fprintf(f, "P6\n%u %u\n255\n", W, H);
                fwrite(fb.data(), 3, fb.size(), f);
                fclose(f);
            }
            ++frame;
            y = 0;
            x = 0;
            for (auto &p : pad_script)
                if (frame >= p.frame) { top->joy = p.joy; top->sys = p.sys; }
            if (frame % 60 == 0) {
                printf("frame %d (%.1f s): %ld blocks, %ld CMD18, %ld CMD12\n",
                       frame, clocks / 25e6, sd.reads, sd.cmd18s, sd.cmd12s);
                fflush(stdout);
            }
        }
        last_vsync_n = top->vid_vsync_n;
    }

    printf("%d frames, %ld clocks, boot_mode=%d\n", frame, clocks, top->boot_mode);
    if (wf) { fseek(wf, 0, SEEK_SET); wav_header(wf, wav_samples); fclose(wf); }

    top->final();
    delete top;
    return 0;
}
