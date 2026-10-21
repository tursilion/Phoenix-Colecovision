// Verilator testbench for gyruss_phoenix.
//
//   tb --sd image [--frames n] [--ppm prefix] [--ppm-every k] [--wav file]
//      [--pad frame:joy1:sys,...] [--trace-pc]
//
// Models the 512Kx8 SRAM and an SDHC card in SPI mode (CMD0/8/55/41/58/16,
// CMD17), backed by a disk image.
//
// --pad sets the controls from each given video frame on: joy1 is the hex
// player 1 byte (b0 up b1 down b2 left b3 right b4 fire), sys the hex
// system bits (b0 coin1 b1 coin2 b2 service b3 start1 b4 start2).
//
// Writes frames as PPM files, and the audio as a 48kHz stereo WAV.

#include "Vgyruss_phoenix.h"
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
// SD card, SPI mode, SDHC (block addressing)

struct SdCard {
    int fd = -1;
    uint64_t size = 0;
    bool present = false;

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
    const char *sd_path = nullptr, *ppm = nullptr, *wav = nullptr, *dump = nullptr;
    int frames = 30, ppm_every = 1;
    struct Pad { int frame, joy, sys; };
    std::vector<Pad> pad_script;

    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--sd") && i + 1 < argc) sd_path = argv[++i];
        else if (!strcmp(argv[i], "--frames") && i + 1 < argc) frames = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--ppm") && i + 1 < argc) ppm = argv[++i];
        else if (!strcmp(argv[i], "--ppm-every") && i + 1 < argc) ppm_every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--wav") && i + 1 < argc) wav = argv[++i];
        else if (!strcmp(argv[i], "--dump-sram") && i + 1 < argc) dump = argv[++i];
        else if (!strcmp(argv[i], "--pad") && i + 1 < argc) {
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) {
                Pad p;
                if (sscanf(t, "%d:%x:%x", &p.frame, &p.joy, &p.sys) == 3) pad_script.push_back(p);
            }
        }
    }

    Verilated::commandArgs(argc, argv);
    Vgyruss_phoenix *top = new Vgyruss_phoenix;

    static uint8_t sram[512 * 1024];
    memset(sram, 0x5A, sizeof(sram));

    SdCard sd;
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
    top->joy1 = 0;
    top->joy2 = 0;
    top->sys = 0;
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
        sd.step(top->sd_cs_n, top->sd_sclk, false, top->sd_mosi);

        if (!boot_reported && !top->boot_mode) {
            boot_reported = true;
            printf("boot done: frame %d (%.2f s), %ld SD reads\n", frame, clocks / 25e6, sd.reads);
            if (dump) {
                FILE *f = fopen(dump, "wb");
                fwrite(sram, 1, sizeof(sram), f);
                fclose(f);
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
                if (frame >= p.frame) { top->joy1 = p.joy; top->sys = p.sys; }
            if (frame % 60 == 0) {
                printf("frame %d (%.1f s): %ld SD blocks\n", frame, clocks / 25e6, sd.reads);
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
