// Verilator test of cv_cache.v (the ColecoVision core's ROM cache) on its
// own, with models of the SD card (SPI, CMD17/18/12 with real CRCs), the
// SRAM and the menu.
//
//   The menu part sends the CMD17s FatFs would for each 8K page of a 2M
//   image (a FAT read, then the page's first sector; the page's last
//   sector for the check), the SRAM starts with the image's last 480K at
//   its top, as the menu loads it, and the CPU part then reads random bytes
//   of random pages, waiting while the cache holds it, and checks each
//   byte.  Then a fragmented page must set the fragmented flag.
//
//   obj_dir/Vcv_cache [reads]

#include "Vcv_cache.h"
#include "verilated.h"

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <vector>

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

static Vcv_cache *t;
static SdCard sd;
static std::vector<uint8_t> sram(512 * 1024);
static long clocks = 0, fills = 0;

static const uint32_t S0 = 3000;            // the image's first sector
static const int PAGES = 256;               // 2M

static uint8_t pat(int p, int o)
{
    return (uint8_t)((p * 0x9D) ^ (o * 0x3B) ^ ((o >> 8) * 0x55) ^ (p >> 2));
}

static void tick()
{
    t->clk = 0; t->eval();
    t->clk = 1; t->eval();
    ++clocks;
    if (t->ov_active && t->ov_en && !t->ov_we_n) {
        static int last = -1;
        if ((t->ov_addr & 0x1FFF) == 0 && (int)t->ov_addr != last) ++fills;
        last = t->ov_addr;
        sram[t->ov_addr] = t->ov_data;
    }
    sd.step(t->sd_cs_n, t->sd_sclk, t->sd_mosi);
    t->sd_miso = sd.miso;
}

// One CPU write: a one-clock pulse on the given input
static void pulse(unsigned char &sig, uint8_t data)
{
    t->cpu_data = data;
    sig = 1; tick(); sig = 0;
    for (int i = 0; i < 4; ++i) tick();
}

static void cmd17(uint32_t arg)
{
    uint8_t b[6] = { 0x51, (uint8_t)(arg >> 24), (uint8_t)(arg >> 16), (uint8_t)(arg >> 8), (uint8_t)arg, 0x01 };
    for (int i = 0; i < 6; ++i) pulse(t->sd_wr, b[i]);
    for (int i = 0; i < 3; ++i) pulse(t->sd_wr, 0xFF);     // response, data: the CPU sends $FF
}

int main(int argc, char **argv)
{
    int reads = argc > 1 ? atoi(argv[1]) : 3000;
    Verilated::commandArgs(argc, argv);
    t = new Vcv_cache;

    sd.img.resize((S0 + PAGES * 16 + 64) * 512);
    for (int p = 0; p < PAGES; ++p)
        for (int o = 0; o < 8192; ++o)
            sd.img[(size_t)S0 * 512 + p * 8192 + o] = pat(p, o);
    sd.present = true;
    sd.idle = false;                       // initialized by the menu

    // The menu loads the last 480K at the top of the SRAM
    for (int p = PAGES - 60; p < PAGES; ++p)
        for (int o = 0; o < 8192; ++o)
            sram[(64 - PAGES + p) * 8192 + o] = pat(p, o);

    t->reset = 1;
    for (int i = 0; i < 10; ++i) tick();
    t->reset = 0;
    t->active = 0;
    t->n_pages = PAGES;

    // The menu: each page's first and last sector
    for (int p = 0; p < PAGES; ++p) {
        pulse(t->cap_wr, p);
        cmd17(100 + p);                    // a FAT sector
        cmd17(S0 + 16 * p);                // the page
        pulse(t->chk_wr, p);
        cmd17(200 + p);
        cmd17(S0 + 16 * p + 15);
    }
    pulse(t->end_wr, 0);
    if (t->frag) { printf("FAIL: fragmented flag after a good image\n"); return 1; }

    // The game starts
    t->start = 1; tick(); t->start = 0;
    for (int i = 0; i < 400; ++i) tick();
    t->active = 1;

    uint32_t rnd = 12345;
    int bad = 0, waits = 0;
    for (int k = 0; k < reads; ++k) {
        rnd = rnd * 1103515245 + 12345;
        int p = (rnd >> 8) % PAGES;
        if (k >= reads / 2) p = (k - reads / 2) % PAGES;   // then in order
        int o = (rnd >> 16) & 0x1FFF;
        t->rom_page = p;
        t->rom_rd = 1;
        tick(); tick();
        bool waited = false;
        for (long n = 0; !t->cpu_wait_n; ++n) {
            waited = true;
            tick();
            if (n > 5000000) { printf("FAIL: CPU held forever, page %d\n", p); return 1; }
        }
        if (waited) ++waits;
        if (!t->c_hit) { printf("FAIL: page %d released without a hit\n", p); return 1; }
        uint8_t got = sram[(t->c_line << 13) | o];
        if (got != pat(p, o)) {
            if (bad < 10)
                printf("read %d: page %d offset %04x in SRAM page %d: got %02x want %02x\n",
                       k, p, o, t->c_line, got, pat(p, o));
            ++bad;
        }
        if (t->c_line < 4) { printf("FAIL: page %d in SRAM page %d (the SGM's)\n", p, t->c_line); return 1; }
        t->rom_rd = 0;
        tick(); tick();
    }
    printf("%d reads, %d waited, %ld page fills, %ld clocks, %d bad, %ld SD multi-block reads\n",
           reads, waits, fills, clocks, bad, sd.multi);

    // A fragmented page sets the flag
    t->active = 0;
    pulse(t->chk_wr, 7);
    cmd17(S0 + 16 * 7 + 99);
    pulse(t->end_wr, 0);
    printf("fragmented page: flag %d (want 1)\n", t->frag);
    bool ok = bad == 0 && t->frag && fills > 0;
    printf("%s\n", ok ? "PASS" : "FAIL");
    return ok ? 0 : 1;
}
