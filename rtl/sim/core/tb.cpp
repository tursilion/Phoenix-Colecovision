// Verilator testbench for the ColecoVision core with the ROM cache: the
// core from VHDL (gen/cv.v), the real cv_cache.v, the menu ROM, a VDP
// stand-in (vdp_spy.v), an SD card (SPI, FAT image) and the SRAM.
//
//   obj_dir/Vsim_top --sd image [--frames n] [--fire frame,...] [--screen-every n]
//
// --fire presses the left fire button (the menu starts the highlighted
// file) at each given frame, for a few frames.  The name table (Graphics
// I or the menu's text mode) is printed every --screen-every frames and at
// the end.  Cache fills (SRAM writes at 8K boundaries above the SGM's 32K
// in a game) are counted.

#include "Vsim_top.h"
#include "Vsim_top__Syms.h"
#include "Vsim_top_vdp_spy.h"
#include "Vsim_top_colecovision.h"
#include "verilated.h"

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <string>
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

static const long FRAME = 416667;           // 25MHz / 60

int main(int argc, char **argv)
{
    const char *sd_path = nullptr, *preload = nullptr;
    int frames = 300, screen_every = 0;
    std::vector<int> fires;
    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--sd") && i + 1 < argc) sd_path = argv[++i];
        else if (!strcmp(argv[i], "--frames") && i + 1 < argc) frames = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--screen-every") && i + 1 < argc) screen_every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--preload") && i + 1 < argc) preload = argv[++i];
        else if (!strcmp(argv[i], "--fire") && i + 1 < argc)
            for (char *t = strtok(argv[++i], ","); t; t = strtok(nullptr, ",")) fires.push_back(atoi(t));
    }
    setvbuf(stdout, nullptr, _IOLBF, 0);
    Verilated::commandArgs(argc, argv);
    Vsim_top *t = new Vsim_top;
    SdCard sd;
    if (!sd_path || !sd.load(sd_path)) { fprintf(stderr, "need --sd image\n"); return 1; }
    static uint8_t sram[512 * 1024];
    for (size_t i = 0; i < sizeof(sram); ++i) sram[i] = (uint8_t)(i * 7 + 3);
    // --preload image: what the menu loads, the image's last 480K (or all
    // of a smaller one) at the top of the SRAM
    static std::vector<uint8_t> d;
    if (preload) {
        FILE *f = fopen(preload, "rb");
        if (f) { int c; while ((c = fgetc(f)) != EOF) d.push_back(c); fclose(f); }
        size_t n = d.size() > 480 * 1024 ? 480 * 1024 : d.size();
        memcpy(sram + 512 * 1024 - n, d.data() + d.size() - n, n);
        printf("preload: %zu bytes of %zu at %05zx\n", n, d.size(), 512 * 1024 - n);
    }

    auto vram = [&](int a) -> uint8_t { return t->rootp->vlSymsp->TOP__sim_top__cv__inst_f18a__spy.vram[a & 0x3FFF]; };
    auto vreg = [&](int r) -> uint8_t { return t->rootp->vlSymsp->TOP__sim_top__cv__inst_f18a__spy.regs[r]; };
    auto screen = [&](int frame) {
        int base = (vreg(2) & 0x0F) << 10;
        bool text = vreg(1) & 0x10;                      // text mode: 40 columns
        int cols = text ? 40 : 32;
        unsigned long vs = 0;
        for (int i = 0; i < 16384; ++i) vs = vs * 31 + vram(i);
        printf("---- frame %d (name table %04X%s) VRAM sum %08lx, CPU at %04x\n", frame, base, text ? ", text" : "",
               vs & 0xFFFFFFFF, t->dbg_addr);
        if (getenv("TB_QUIET")) return;
        for (int r = 0; r < 24; ++r) {
            char line[41];
            for (int c = 0; c < cols; ++c) {
                uint8_t ch = vram(base + r * cols + c);
                line[c] = (ch >= 32 && ch < 127) ? ch : '.';
            }
            line[cols] = 0;
            printf("|%s|\n", line);
        }
    };

    {
        auto &rom = t->rootp->vlSymsp->TOP__sim_top__cv.__PVT__loader__DOT__rom__DOT__rom;
        printf("menu ROM: %02x %02x %02x %02x\n", rom[0], rom[1], rom[2], rom[3]);
    }
    long clocks = 0, fills = 0, pending_at = 0;
    int pending_slot = -1;
    int div7 = 0, frame = 0, last_led = -1;
    bool game = false;
    t->por_n = 0;
    t->sd_miso = 1;
    for (long cyc = 0; frame < frames; ++cyc) {
        // controllers: left fire on the stick half when pressed
        bool fire = false;
        for (int f : fires) if (frame >= f && frame < f + 6) fire = true;
        uint8_t stick = 3, key = 3;                      // active low, both ports
        t->p1 = t->p2 = t->p3 = t->p4 = 3;
        t->p6 = (!t->p8 && fire) ? 2 : 3;                // port 1, pin 6 low
        t->p7 = 3; t->p9 = 3;
        (void)stick; (void)key;

        t->clk_3m58_en = (div7 == 6);
        div7 = (div7 == 6) ? 0 : div7 + 1;
        t->sram_rdata = sram[t->sram_addr];
        t->clk = 0; t->eval();
        // TB_CHECK: each read of the cartridge area at a CPU clock enable
        // (MegaCart, 512K): the byte against the image
        // (the T80 latches its data at the clock enable of T-state 2)
        if (getenv("TB_CHECK") && game && !d.empty() && t->dbg_clken && t->dbg_tstate == 2 &&
            !t->dbg_mreq_n && !t->dbg_rd_n && (t->dbg_addr & 0x8000)) {
            static long bad = 0, reads = 0;
            int a = t->dbg_addr, mask = (int)(d.size() / 16384) - 1;
            int bank = a < 0xC000 ? mask : (t->dbg_mc_bank & mask);
            uint8_t want = d[(size_t)bank * 16384 + (a & 0x3FFF)];
            ++reads;
            if (t->dbg_din != want && bad++ < 30)
                printf("read %04x bank %d: got %02x want %02x (frame %d, clk %ld, cache wait %d) page %d hit %d line %d mask %02x sram %05x\n",
                       a, bank, t->dbg_din, want, frame, clocks, !t->dbg_cwait_n,
                       t->dbg_rom_page, t->dbg_c_hit, t->dbg_c_line, t->dbg_mask, t->sram_addr);
        }
        t->clk = 1; t->eval();
        ++clocks;
        if (clocks == 200) t->por_n = 1;

        if (getenv("TB_RD") && clocks > 6380 && clocks < 6700)
            printf("clk %ld: sram %05x rdata %02x ce %d we %d | cpu addr %04x din %02x clken %d\n", clocks,
                   t->sram_addr, t->sram_rdata, t->sram_ce_n, t->sram_we_n, t->dbg_addr, t->dbg_din, t->dbg_clken);
            if (getenv("TB_RD") && clocks > 6380 && clocks < 6700)
                printf("      ext %02x mux %02x mreq %d en %d\n", t->dbg_ext, t->dbg_mux, t->dbg_mreq_n, t->dbg_ext_en);
        if (getenv("TB_SRAM") && !t->sram_we_n) {
            static int shown = 0;
            if (clocks > 5000 && clocks < 6400 && shown++ < 40) printf("sram write %05x = %02x (ce %d) cpu do %02x clk %ld\n", t->sram_addr, t->sram_wdata, t->sram_ce_n, t->dbg_dout, clocks);
        }
        if (!t->sram_ce_n && !t->sram_we_n) {
            uint32_t a = t->sram_addr;
            sram[a] = t->sram_wdata;
            if (game && (a & 0x1FFF) == 0 && a >= 0x8000) {
                static uint32_t last = ~0u;
                if (a != last) {
                    ++fills;
                    printf("cache fill: SRAM page %d at frame %d\n", a >> 13, frame);
                    pending_slot = a >> 13;
                    pending_at = clocks + 300000;        // check it when the fill is surely done
                }
                last = a;
            }
        }
        t->sram_rdata = sram[t->sram_addr];
        t->eval();
        sd.step(t->sd_cs_n, t->sd_sclk, t->sd_mosi);
        if (getenv("TB_IO")) {
            static long shown = 0;
            if (!t->dbg_sdcs_n && shown < 200) {
                printf("clk %ld: iorq %d wr %d sdcs %d dout %02x addr %04x clken %d mosi %d sclk %d\n", clocks,
                       t->dbg_iorq_n, t->dbg_wr_n, t->dbg_sdcs_n, t->dbg_dout, t->dbg_addr, t->dbg_clken, t->sd_mosi, t->sd_sclk);
                ++shown;
            }
        }
        if (getenv("TB_SPI")) {
            static int ls = 0; static long edges = 0, cslow = 0;
            if (t->sd_sclk != ls) ++edges;
            ls = t->sd_sclk;
            if (!t->sd_cs_n) ++cslow;
            static long ens = 0, mosi1 = 0; if (t->dbg_clken) ++ens; if (t->sd_mosi) ++mosi1;
            if (clocks % FRAME == 0) printf("frame %d: %ld CPU clock enables, MOSI high %ld clocks\n", frame, ens, mosi1);
            if (clocks % FRAME == 0)
                printf("frame %d: %ld SCLK edges, %ld clocks with CS low, sd.cmd %zu bytes, out %zu\n",
                       frame, edges, cslow, sd.cmd.size(), sd.out.size());
        }
        t->sd_miso = sd.miso;

        if (t->led != last_led) {
            if (last_led == 1 && t->led == 0 && !game) {
                game = true;
                printf("game starts: frame %d, %ld SD reads\n", frame, sd.reads);
            } else if (game)
                printf("LED %d at frame %d\n", t->led, frame);
            last_led = t->led;
        }
        // TB_PC=from-frame: the address and opcode of each instruction fetch
        {
            static int pc_from = getenv("TB_PC") ? atoi(getenv("TB_PC")) : -1;
            static int m1_d = 1;
            static long n = 0;
            static long r0 = getenv("TB_PCR0") ? atol(getenv("TB_PCR0")) : -1;
            static long r1 = getenv("TB_PCR1") ? atol(getenv("TB_PCR1")) : -1;
            if (r0 >= 0 && clocks >= r0 && clocks <= r1 && m1_d && !t->dbg_m1_n)
                printf("pc %04x op %02x clk %ld\n", t->dbg_addr, t->dbg_din, clocks);
            if (pc_from >= 0 && frame >= pc_from && m1_d && !t->dbg_m1_n && n < 3000) {
                printf("pc %04x\n", t->dbg_addr);
                ++n;
            }
            m1_d = t->dbg_m1_n;
        }
        // Which image page a fill put in its SRAM page, and is it exact?
        if (pending_slot >= 0 && clocks == pending_at && !d.empty()) {
            const uint8_t *slot = sram + pending_slot * 8192;
            int best = -1, best_diff = 8193;
            for (size_t pg = 0; pg * 8192 < d.size(); ++pg) {
                int diff = 0;
                for (int i = 0; i < 8192; ++i) diff += slot[i] != d[pg * 8192 + i];
                if (diff < best_diff) { best_diff = diff; best = pg; }
            }
            printf("  SRAM page %d holds image page %d (%d bytes differ)\n", pending_slot, best, best_diff);
            pending_slot = -1;
        }
        if (clocks % FRAME == 0) {
            ++frame;
            if (screen_every && frame % screen_every == 0) screen(frame);
        }
    }
    screen(frame);
    printf("%d frames, %ld clocks, %ld cache fills, %ld SD reads, %ld multi-block reads\n",
           frame, clocks, fills, sd.reads, sd.multi);
    return 0;
}
