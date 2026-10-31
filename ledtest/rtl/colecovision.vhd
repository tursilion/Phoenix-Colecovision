--
-- Phoenix ColecoVision Core
-- Released under the 3-Clause BSD License:
--
-- Copyright 2019 - 2020
-- Matthew Hagerty, Brian Burney
--
-- This core started as a mix of the ColecoFPGA core and a CV core designed and
-- written by Matthew.  By the time of the first release, this CV core has been
-- completely rewritten several times over, and nothing of either original core
-- remains. However, both systems provided information and a starting point for
-- this implementation, and credit is always due.
--
-- Attribution for the ColecoFPGA project:
--
-------------------------------------------------------------------------------
--
-- ColecoFPGA project
--
-- Copyright (c) 2006, Arnim Laeuger (arnim.laeuger@gmx.net)
-- Copyright (c) 2016, Fabio Belavenuto (belavenuto@gmail.com)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity colecovision is
generic
   ( mach_id_g             : integer := 0
);
port
   ( clk_25m0_i            : in  std_logic
   ; clk_100m0_i           : in  std_logic
   ; clk_3m58_en_i         : in  std_logic
   ; reset_i               : in  std_logic -- Soft Reset, active high
   ; por_n_i               : in  std_logic -- Power-on Reset, active low

   -- Physical controller interface
   ; ctrl_p1_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p2_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p3_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p4_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p5_o             : out std_logic
   ; ctrl_p6_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p7_i             : in  std_logic_vector( 2 downto 1)
   ; ctrl_p8_o             : out std_logic
   ; ctrl_p9_i             : in  std_logic_vector( 2 downto 1)

   -- Physical cartridge interface
   ; cart_addr_o           : out std_logic_vector(14 downto 0) -- 32K
   ; cart_dir_o            : out std_logic
   ; cart_data_io          : inout std_logic_vector( 7 downto 0)
   ; cart_oe_n_o           : out std_logic
   ; cart_en_80_n_o        : out std_logic
   ; cart_en_a0_n_o        : out std_logic
   ; cart_en_c0_n_o        : out std_logic
   ; cart_en_e0_n_o        : out std_logic

   -- Audio output
   ; pcm16_o               : out std_logic_vector(15 downto 0)

   -- VGA output
   ; blank_o               : out std_logic
   ; hsync_n_o             : out std_logic
   ; vsync_n_o             : out std_logic
   ; red_o                 : out std_logic_vector( 3 downto 0)
   ; grn_o                 : out std_logic_vector( 3 downto 0)
   ; blu_o                 : out std_logic_vector( 3 downto 0)

   -- External SRAM, 512Kx8, 10ns
   ; sram_addr_o           : out    std_logic_vector(18 downto 0)
   ; sram_data_io          : inout  std_logic_vector(7 downto 0)
   ; sram_ce_n_o           : out    std_logic
   ; sram_oe_n_o           : out    std_logic
   ; sram_we_n_o           : out    std_logic

   -- SD-card SPI interface
   ; sd_miso_i             : in  std_logic
   ; sd_mosi_o             : out std_logic
   ; sd_sclk_o             : out std_logic
   ; sd_cs_n_o             : out std_logic
   ; sd_cd_n_i             : in  std_logic -- Card detect, active low.

   -- PS/2 keyboard raw scan code bytes
   ; kbd_byte_i            : in  std_logic_vector( 7 downto 0)
   ; kbd_stb_i             : in  std_logic -- one clock per received byte
   ; kbd_mode_o            : out std_logic -- 1 = keyboard at port >80, 0 = joystick emulation

   ; led_o                 : out std_logic -- debug LED, 1 = on
   ; rgb_o                 : out std_logic_vector(2 downto 0) -- RGB LED red, green, blue, 1 = lit
);
end entity;

architecture rtl of colecovision is

   signal reset_n_s                       : std_logic;

   -- Z80 CPU
   signal clk_en_cpu_s                    : std_logic;
   signal nmi_n_s                         : std_logic;
   signal int_n_s                         : std_logic;
   signal iorq_n_s                        : std_logic;
   signal m1_n_s                          : std_logic;
   signal m1_n_r                          : std_logic := '1';
   signal m1_wait_n_r                     : std_logic := '1';
   signal rd_n_s                          : std_logic;
   signal wr_n_s                          : std_logic;
   signal mreq_n_s                        : std_logic;
   signal rfsh_n_s                        : std_logic;
   signal cpu_addr_s                      : std_logic_vector(15 downto 0);
   signal d_to_cpu_s                      : std_logic_vector( 7 downto 0);
   signal d_from_cpu_s                    : std_logic_vector( 7 downto 0);

   -- F18A VDP
   signal d_from_vdp_s                    : std_logic_vector( 7 downto 0);
   signal vdp_r_n_s                       : std_logic;
   signal vdp_w_n_s                       : std_logic;
   signal vdp_settings_r						: std_logic_vector( 1 downto 0) := "00";

   -- SN76489 PSG
	signal sn489_ready_s                   : std_logic;
   signal sn489_we_n_s                    : std_logic;
   signal sn76489_pcm14s_s                : unsigned(13 downto 0);

   -- YM-2149 / AY-3-8910 PSG
   signal d_from_wsg_s                    : std_logic_vector(7 downto 0);
   signal wsg_bdir_s                      : std_logic;
   signal wsg_bc_s                        : std_logic;
   signal ym2149_pcm14s_s                 : unsigned(13 downto 0);

   -- Audio Mixing
   signal pcm16_r                         : unsigned (15 downto 0) := (others => '0');
   signal pcm16_x                         : unsigned (15 downto 0);

   -- Internal 1K RAM
   type ram1k_t is array (0 to 1023) of std_logic_vector( 7 downto 0);

   signal cv_ram1k_r                      : ram1k_t;
   signal cv_ram1k_en_s                   : std_logic;
   signal cv_ram1k_addr_s                 : std_logic_vector( 9 downto 0);
   signal d_from_cv_ram1k_r               : std_logic_vector( 7 downto 0);

   -- SGM RAM
   signal sgm_en_r                        : std_logic := '0';
   signal sgm_en_x                        : std_logic;
   signal sgm_8k_en_r                     : std_logic := '0';
   signal sgm_8k_en_x                     : std_logic;

   -- External SRAM
   signal ext_ram_addr_s                  : std_logic_vector(18 downto 0);
   signal ext_ram_bank_r                  : std_logic_vector( 3 downto 0) := "0001";
   signal ext_ram_bank_x                  : std_logic_vector( 3 downto 0);
   signal ext_ram_en_s                    : std_logic := '0';
   signal ext_ram_we_n_s                  : std_logic;
   signal d_from_ext512_s                 : std_logic_vector( 7 downto 0);

   -- Data and IO bus
   signal io_decode_s                     : std_logic_vector( 2 downto 0);
   signal cpu_data_mux_s                  : std_logic_vector( 7 downto 0);
   signal io_data_mux_s                   : std_logic_vector( 7 downto 0);
   signal ex_data_mux_s                   : std_logic_vector( 7 downto 0);

   -- BIOS
   signal d_from_bios_s                   : std_logic_vector( 7 downto 0);
   signal bios_we_s                       : std_logic;

   -- ROM Loader
   signal rom_loader_en_r                 : std_logic := '1'; -- at power-up the loader is active.
   signal rom_loader_en_x                 : std_logic;
   signal d_from_loader_s                 : std_logic_vector( 7 downto 0);
   signal rom_loader_we_n_s               : std_logic := '1';

   -- SD-card support
   signal d_from_sd_s                     : std_logic_vector( 7 downto 0);
   signal sd_cs_n_s                       : std_logic;        -- SD-card selected
   signal sd_wait_n_s                     : std_logic;        -- CPU should wait for SD-card
   signal sd_detect_r                     : std_logic := '0'; -- default no card.
   signal sd_slow_clk_r                   : std_logic := '1'; -- start SPI with slow clock
   signal sd_slow_clk_x                   : std_logic;
   signal sd_spi_ss_n_r                   : std_logic := '1'; -- SD-card SPI device select
   signal sd_spi_ss_n_x                   : std_logic;

   -- Machine ID
   constant machine_id_c                  : std_logic_vector( 7 downto 0) := std_logic_vector(to_unsigned(mach_id_g, 8));

   -- External cartridge
   signal cart_en_80_n_s                  : std_logic;
   signal cart_en_A0_n_s                  : std_logic;
   signal cart_en_C0_n_s                  : std_logic;
   signal cart_en_E0_n_s                  : std_logic;

   -- Controllers
   signal d_from_ctrl_s                   : std_logic_vector( 7 downto 0);
   signal ctrl_en_key_n_s                 : std_logic;
   signal ctrl_en_joy_n_s                 : std_logic;
   signal ctrl_int_n_s                    : std_logic;

   -- PS/2 keyboard.  A small FIFO holds the bytes of one key sequence (the
   -- longest is Pause, 8 bytes), so it can be read at port >80 one byte at a
   -- time without losing prefix bytes.  This is not a typing buffer.
   type kbd_fifo_t is array (0 to 7) of std_logic_vector(7 downto 0);
   signal kbd_fifo_r                      : kbd_fifo_t;
   signal kbd_wr_ptr_r                    : unsigned(2 downto 0) := "000";
   signal kbd_rd_ptr_r                    : unsigned(2 downto 0) := "000";
   signal kbd_count_r                     : unsigned(3 downto 0) := "0000";
   signal kbd_data_r                      : std_logic_vector(7 downto 0) := x"00";
   signal kbd_rd_s                        : std_logic;
   signal kbd_rd_r                        : std_logic := '0';
   signal kbd_mode_r                      : std_logic := '0';
   signal kbd_mode_x                      : std_logic;

   -- Upper memory selection and bank schemes
   signal real_cart_r                     : std_logic := '1'; -- '1' when using a real cartridge
   signal real_cart_x                     : std_logic;
   signal bank_mode_r                     : std_logic_vector( 1 downto 0) := "00";
   signal bank_mode_x                     : std_logic_vector( 1 downto 0);
   signal upmem_mode_r                    : std_logic_vector( 1 downto 0) := "00";
   signal upmem_mode_x                    : std_logic_vector( 1 downto 0);
   signal upmem_we_inhibit_s              : std_logic;

   -- MegaCart banking support
   -- Page mask from port >59: 16K pages for MegaCart (6 bits used, 1M), 8K
   -- pages for SGM (8 bits, 2M).
   signal mc_mem_size_r                   : std_logic_vector( 7 downto 0) := x"0F"; -- 256K
   signal mc_mem_size_x                   : std_logic_vector( 7 downto 0);
   signal mc_bank_r                       : std_logic_vector( 5 downto 0) := "111111";
   signal mc_bank_x                       : std_logic_vector( 5 downto 0);
   signal mc_en_r                         : std_logic := '0';
   signal mc_en_x                         : std_logic;

   -- SGM banking support: 8K pages at >A000, >C000, >E000 (>8000 is page 0)
   signal sgmbk_en_r                      : std_logic := '0';
   signal sgmbk_en_x                      : std_logic;
   signal sgmbk_a_r                       : std_logic_vector( 7 downto 0) := x"01";
   signal sgmbk_a_x                       : std_logic_vector( 7 downto 0);
   signal sgmbk_c_r                       : std_logic_vector( 7 downto 0) := x"02";
   signal sgmbk_c_x                       : std_logic_vector( 7 downto 0);
   signal sgmbk_e_r                       : std_logic_vector( 7 downto 0) := x"03";
   signal sgmbk_e_x                       : std_logic_vector( 7 downto 0);
   signal sgmbk_wr_a_s                    : std_logic;  -- CPU write to >FFFC
   signal sgmbk_wr_c_s                    : std_logic;  -- CPU write to >FFFD
   signal sgmbk_wr_e_s                    : std_logic;  -- CPU write to >FFFE

   -- ROM cache (cv_cache.v): MegaCart and SGM images up to 2M, 480K in the
   -- SRAM, the rest read from the SD card when the game needs it.
   component cv_cache
   port
      ( clk          : in  std_logic
      ; reset        : in  std_logic
      ; active       : in  std_logic
      ; start        : in  std_logic
      ; n_pages      : in  std_logic_vector(8 downto 0)
      ; rom_rd       : in  std_logic
      ; rom_page     : in  std_logic_vector(7 downto 0)
      ; c_hit        : out std_logic
      ; c_line       : out std_logic_vector(5 downto 0)
      ; cpu_wait_n   : out std_logic
      ; sd_wr        : in  std_logic
      ; cap_wr       : in  std_logic
      ; chk_wr       : in  std_logic
      ; end_wr       : in  std_logic
      ; cpu_data     : in  std_logic_vector(7 downto 0)
      ; frag         : out std_logic
      ; ov_active    : out std_logic
      ; ov_en        : out std_logic
      ; ov_we_n      : out std_logic
      ; ov_addr      : out std_logic_vector(18 downto 0)
      ; ov_data      : out std_logic_vector(7 downto 0)
      ; sd_cs_n      : out std_logic
      ; sd_sclk      : out std_logic
      ; sd_mosi      : out std_logic
      ; sd_miso      : in  std_logic
      ; led          : out std_logic
      );
   end component;

   signal rom_page_s                      : std_logic_vector( 7 downto 0);  -- 8K ROM page of a banked read
   signal cache_active_s                  : std_logic;
   signal cache_start_r                   : std_logic := '0';
   signal loader_en_d_r                   : std_logic := '1';
   signal cache_n_pages_s                 : std_logic_vector( 8 downto 0);
   signal cache_rom_rd_s                  : std_logic;
   signal c_hit_s                         : std_logic;
   signal c_line_s                        : std_logic_vector( 5 downto 0);
   signal cache_wait_n_s                  : std_logic;
   signal cache_frag_s                    : std_logic;
   signal cache_led_s                     : std_logic;
   signal dbg_led_r, dbg_led_x            : std_logic_vector(7 downto 0);
   signal io_wr_s                         : std_logic;  -- an I/O write cycle
   signal io_wr_d_r                       : std_logic := '0';
   signal sd_wr_p_s, cap_wr_p_s, chk_wr_p_s, end_wr_p_s : std_logic;
   signal ov_active_s, ov_en_s, ov_we_n_s : std_logic;
   signal ov_addr_s                       : std_logic_vector(18 downto 0);
   signal ov_data_s                       : std_logic_vector( 7 downto 0);
   signal ext512_addr_s                   : std_logic_vector(18 downto 0);
   signal ext512_en_s, ext512_we_n_s      : std_logic;
   signal ext512_data_s                   : std_logic_vector( 7 downto 0);
   signal sdc_cs_n_s, sdc_sclk_s, sdc_mosi_s : std_logic;   -- the CPU's SD port
   signal cc_cs_n_s, cc_sclk_s, cc_mosi_s    : std_logic;   -- the cache's

begin

   -- Debug LED.
   led_o <= '1' when dbg_led_r(1 downto 0) = "10" else
            '0' when dbg_led_r(1 downto 0) = "01" else
            rom_loader_en_r or cache_led_s;
   -- RGB LED: yellow unless port >5F overrides it.
   rgb_o <= dbg_led_r(6 downto 4) when dbg_led_r(7) = '1' else "110";

   -- Active-low version of the soft reset.
   reset_n_s <= not reset_i;

   --
   -- Instruction Fetch Wait State Generator.
   --
   -- Z80-based systems, like the ColecoVision and MSX computers, have a
   -- circuit that inserts a wait-state during the instruction fetch cycle.
   -- It is unclear why this is necessary, but that mystery will have to be
   -- solved later.
   --
   m1_wait: process (clk_25m0_i, reset_n_s, m1_n_s)
   begin
   if rising_edge(clk_25m0_i) then

      m1_n_r <= m1_n_s;

      -- Disable during reset or non-instruction fetch cycles.
      if reset_n_s = '0' or m1_n_s = '1' then
         m1_wait_n_r <= '1';

      -- Edge-detect the instruction-fetch signal and assert the wait.
      elsif m1_n_r = '1' and m1_n_s = '0' then
         m1_wait_n_r <= '0';

      -- Remove the wait on the next machine cycle.
      elsif clk_3m58_en_i = '1' then
         m1_wait_n_r <= '1';
      end if;
   end if;
   end process m1_wait;


   --
   -- Z80 CPU, synchronous top level with clock enable
   --

   -- TODO: Matthew H, March 19, 2019
   -- Why is the wait being created via the clock enable instead of the
   -- real WAIT_n input to the CPU?  Is the T80 core WAIT_n broken?
   --
   -- Modified CPU clock enable based on slow devices or the wait state.
   clk_en_cpu_s <= clk_3m58_en_i and sn489_ready_s and m1_wait_n_r and sd_wait_n_s and cache_wait_n_s;

   -- CPU maskable interrupt input, currently only the controllers.
   int_n_s <= ctrl_int_n_s;

   inst_t80 : entity work.t80se
   port map
   ( RESET_n   => reset_n_s    -- in std_logic;
   , CLK_n     => clk_25m0_i   -- in std_logic;
   , CLKEN     => clk_en_cpu_s -- in std_logic;
   , WAIT_n    => '1'          -- in std_logic;
   , INT_n     => int_n_s      -- in std_logic;
   , NMI_n     => nmi_n_s      -- in std_logic;
   , BUSRQ_n   => '1'          -- in std_logic;
   , M1_n      => m1_n_s       -- out std_logic;
   , MREQ_n    => mreq_n_s     -- out std_logic;
   , IORQ_n    => iorq_n_s     -- out std_logic;
   , RD_n      => rd_n_s       -- out std_logic;
   , WR_n      => wr_n_s       -- out std_logic;
   , RFSH_n    => rfsh_n_s     -- out std_logic;
   , HALT_n    => open         -- out std_logic;
   , BUSAK_n   => open         -- out std_logic;
   , A         => cpu_addr_s   -- out std_logic_vector(15 downto 0);
   , DI        => d_to_cpu_s   -- in std_logic_vector(7 downto 0);
   , DO        => d_from_cpu_s -- out std_logic_vector(7 downto 0)
   );


   --
   -- F18A VDP
   --
   -- The soft button reset is sent to the F18A (unlike the real CV) to ensure
   -- a game will not leave enhanced F18A settings enabled which will cause
   -- problems for legacy or non-F18A games.
   --
   inst_f18a : entity work.f18a_core
   port map
   ( clk_100m0_i    => clk_100m0_i  -- must be 100MHz
   , clk_25m0_i     => clk_25m0_i   -- must be an actual 25MHz clock, NOT an enable
   -- 9918A to Host interface
   , reset_n_i      => reset_n_s    -- active low, the F18A gets soft reset
   , mode_i         => cpu_addr_s(0)
   , csw_n_i        => vdp_w_n_s
   , csr_n_i        => vdp_r_n_s
   , int_n_o        => nmi_n_s
   , cd_i           => d_from_cpu_s
   , cd_o           => d_from_vdp_s
   -- Video Output
   , blank_o        => blank_o      -- active high during active video
   , hsync_o        => hsync_n_o
   , vsync_o        => vsync_n_o
   , red_o          => red_o        -- 4-bit red
   , grn_o          => grn_o        -- 4-bit green
   , blu_o          => blu_o        -- 4-bit blue
   -- Feature Selection
   , sprite_max_i   => vdp_settings_r(1) -- default sprite max, '0'=32, '1'=4
   , scanlines_i    => vdp_settings_r(0) -- simulated scan lines, '0'=no, '1'=yes
   -- SPI for GPU access, not enabled in the Phoenix
   , spi_clk_o      => open
   , spi_cs_o       => open
   , spi_mosi_o     => open
   , spi_miso_i     => '0'
   );


   --
   -- SN76489 Programmable Sound Generator
   --
   sn76489_audio_inst : entity work.sn76489_audio
   generic map
   ( MIN_PERIOD_CNT_G => 17 -- Accommodate games that use audible-carrier A.M.
   )
   port map
   ( clk_i        => clk_25m0_i    -- System clock
   , en_clk_psg_i => clk_3m58_en_i -- PSG clock enable
   , ce_n_i       => sn489_we_n_s  -- chip enable, active low
   , wr_n_i       => sn489_we_n_s  -- write enable, active low
   , ready_o      => sn489_ready_s -- low during I/O operations
   , data_i       => d_from_cpu_s
   , ch_a_o       => open
   , ch_b_o       => open
   , ch_c_o       => open
   , noise_o      => open
   , mix_audio_o  => open
   , pcm14s_o     => sn76489_pcm14s_s
   );


   --
   -- YM-2149 (AY-3-8910) Programmable Sound Generator
   --
   ym2149_audio_inst: entity work.ym2149_audio
   port map
   ( clk_i        => clk_25m0_i     -- System clock
   , en_clk_psg_i => clk_3m58_en_i  -- PSG clock enable
   , sel_n_i      => '0'            -- divide the input clock by 2
   , reset_n_i    => reset_n_s      -- active low
   , bc_i         => wsg_bc_s       -- bus control
   , bdir_i       => wsg_bdir_s     -- bus direction
   , data_i       => d_from_cpu_s
   , data_r_o     => d_from_wsg_s   -- registered output data
   , ch_a_o       => open
   , ch_b_o       => open
   , ch_c_o       => open
   , mix_audio_o  => open
   , pcm14s_o     => ym2149_pcm14s_s
   );


   -- Mix the 14-bit signed PCM audio signals into a signed 16-bit PCM sample.
   pcm16_x <= (
      (sn76489_pcm14s_s(13) & sn76489_pcm14s_s) +
      ( ym2149_pcm14s_s(13) &  ym2149_pcm14s_s) ) & "0";

   pcm16_o <= std_logic_vector(pcm16_r);

   -- Register the final audio sample.
   process (clk_25m0_i) begin
   if rising_edge(clk_25m0_i) then
   if clk_3m58_en_i = '1' then
      pcm16_r <= pcm16_x;
   end if;
   end if; end process;


   --
   -- Controller ports
   --
   ctrl_b : entity work.cv_ctrl
   port map
   ( clk_i           => clk_25m0_i
   , clk_3m58_en_i   => clk_3m58_en_i
   , reset_n_i       => reset_n_s
   , ctrl_en_key_n_i => ctrl_en_key_n_s
   , ctrl_en_joy_n_i => ctrl_en_joy_n_s
   , ctrl_p1_i       => ctrl_p1_i
   , ctrl_p2_i       => ctrl_p2_i
   , ctrl_p3_i       => ctrl_p3_i
   , ctrl_p4_i       => ctrl_p4_i
   , ctrl_p5_o       => ctrl_p5_o
   , ctrl_p6_i       => ctrl_p6_i
   , ctrl_p7_i       => ctrl_p7_i
   , ctrl_p8_o       => ctrl_p8_o
   , ctrl_p9_i       => ctrl_p9_i
   , ctrl_sel_i      => cpu_addr_s(1) -- A1=0 read controller 1, A1=1 read controller 2
   , ctrl_d_o        => d_from_ctrl_s
   , ctrl_int_n_o    => ctrl_int_n_s
   );


   --
   -- SD-card SPI interface
   --
   sdcard: entity work.sdcard
   port map
   ( clk_i        => clk_25m0_i
   , reset_n_i    => reset_n_s
   , slow_clk_i   => sd_slow_clk_r -- '1' = use slow SPI clock
   , spi_ss_n_i   => sd_spi_ss_n_r
   , cs_n_i       => sd_cs_n_s
   , wait_n_o     => sd_wait_n_s
   , wr_n_i       => wr_n_s
   , data_i       => d_from_cpu_s
   , data_o       => d_from_sd_s
   -- SD card interface
   , spi_cs_n_o   => sdc_cs_n_s
   , spi_sclk_o   => sdc_sclk_s
   , spi_mosi_o   => sdc_mosi_s
   , spi_miso_i   => sd_miso_i
   );

   -- The ROM cache owns the card while a banked game runs.
   sd_cs_n_o <= cc_cs_n_s when cache_active_s = '1' else sdc_cs_n_s;
   sd_sclk_o <= cc_sclk_s when cache_active_s = '1' else sdc_sclk_s;
   sd_mosi_o <= cc_mosi_s when cache_active_s = '1' else sdc_mosi_s;


   --
   -- The loader ROM and BIOS have different addresses at PoR to give the
   -- loader extra room, contain interrupt vectors, and make development
   -- easier.  Once the loader is done it will read port >55 which will
   -- disable the loader and move the 8K BIOS to the original location.
   -- The loader can also overwrite the BIOS with a file from SD.
   --
   -- NOTE: The code that reads port >55 better be in the 1K RAM!
   --
   --                       Loader
   --  Address         Enabled  Disabled
   -- ------------------------------------
   -- >0000 .. >1FFF   Loader   BIOS
   -- >2000 .. >3FFF   Loader   no memory
   -- >4000 .. >5FFF   BIOS     no memory
   --

   --
   -- 24K ROM Loader
   --
   loader: entity work.romloader
   port map
   ( clock_i      => clk_25m0_i
   , we_n_i       => rom_loader_we_n_s
   , addr_i       => cpu_addr_s(14 downto 0)
   , data_i       => d_from_cpu_s
   , data_o       => d_from_loader_s
   );


   --
   -- 8K ROM BIOS
   --
   bios: entity work.rombios
   port map
   ( clock_i      => clk_25m0_i
   , we_i         => bios_we_s
   , addr_i       => cpu_addr_s(12 downto 0)
   , data_i       => d_from_cpu_s
   , data_o       => d_from_bios_s
   );

   -- TODO Maybe allow BIOS to be written to?
   bios_we_s <= '0';


   --
   -- CV Internal 1K RAM
   --
   cv_ram_1k : process (clk_25m0_i, cv_ram1k_en_s, cv_ram1k_addr_s, wr_n_s)
   begin
   if rising_edge(clk_25m0_i) then
      if cv_ram1k_en_s = '1' then
         if wr_n_s = '0' then
            cv_ram1k_r(to_integer(unsigned(cv_ram1k_addr_s))) <= d_from_cpu_s;
         end if;
         d_from_cv_ram1k_r <= cv_ram1k_r(to_integer(unsigned(cv_ram1k_addr_s)));
      end if;
   end if;
   end process;

   cv_ram1k_addr_s <= cpu_addr_s(9 downto 0);


   --
   -- External SRAM, 512Kx8, 10ns
   --
   ext512 : entity work.ext512x8sram
   port map
   ( clk_i        => clk_25m0_i
   -- Z80 CPU
   , cpu_addr_i   => ext512_addr_s
   , cpu_en_i     => ext512_en_s    -- active high
   , cpu_we_n_i   => ext512_we_n_s  -- active low
   , cpu_data_i   => ext512_data_s
   , cpu_data_o   => d_from_ext512_s
   -- External SRAM Interface
   , sram_addr_o  => sram_addr_o
   , sram_data_io => sram_data_io
   , sram_ce_n_o  => sram_ce_n_o
   , sram_oe_n_o  => sram_oe_n_o
   , sram_we_n_o  => sram_we_n_o
   );


   -- The ROM cache writes the pages it reads (the CPU waits meanwhile).
   ext512_addr_s <= ov_addr_s when ov_active_s = '1' else ext_ram_addr_s;
   ext512_en_s   <= ov_en_s   when ov_active_s = '1' else ext_ram_en_s;
   ext512_we_n_s <= ov_we_n_s when ov_active_s = '1' else ext_ram_we_n_s;
   ext512_data_s <= ov_data_s when ov_active_s = '1' else d_from_cpu_s;


   --
   -- ROM cache
   --
   cache_active_s  <= (mc_en_r or sgmbk_en_r) and not rom_loader_en_r;
   cache_rom_rd_s  <= '1' when mreq_n_s = '0' and rfsh_n_s = '1' and rd_n_s = '0' and
                               cpu_addr_s(15) = '1' else '0';
   -- Image size in 8K pages: MegaCart 2 x (mask + 1), SGM mask + 1
   cache_n_pages_s <= std_logic_vector(unsigned("00" & mc_mem_size_r(5 downto 0) & '1') + 1) when mc_en_r = '1' else
                      std_logic_vector(unsigned('0' & mc_mem_size_r) + 1);

   -- One-clock pulses at the start of the CPU's I/O writes: port >57 (SD
   -- data, for the cache's snooping) and the cache ports >5C, >5D, >5E.
   io_wr_s    <= '1' when iorq_n_s = '0' and m1_n_s = '1' and wr_n_s = '0' else '0';
   sd_wr_p_s  <= '1' when io_wr_s = '1' and io_wr_d_r = '0' and cpu_addr_s(7 downto 0) = x"57" else '0';
   cap_wr_p_s <= '1' when io_wr_s = '1' and io_wr_d_r = '0' and cpu_addr_s(7 downto 0) = x"5C" else '0';
   chk_wr_p_s <= '1' when io_wr_s = '1' and io_wr_d_r = '0' and cpu_addr_s(7 downto 0) = x"5D" else '0';
   end_wr_p_s <= '1' when io_wr_s = '1' and io_wr_d_r = '0' and cpu_addr_s(7 downto 0) = x"5E" else '0';

   process (clk_25m0_i)
   begin
   if rising_edge(clk_25m0_i) then
      io_wr_d_r     <= io_wr_s;
      loader_en_d_r <= rom_loader_en_r;
      cache_start_r <= loader_en_d_r and not rom_loader_en_r;   -- a game starts
   end if;
   end process;

   cache : cv_cache
   port map
   ( clk          => clk_25m0_i
   , reset        => reset_i
   , active       => cache_active_s
   , start        => cache_start_r
   , n_pages      => cache_n_pages_s
   , rom_rd       => cache_rom_rd_s
   , rom_page     => rom_page_s
   , c_hit        => c_hit_s
   , c_line       => c_line_s
   , cpu_wait_n   => cache_wait_n_s
   , sd_wr        => sd_wr_p_s
   , cap_wr       => cap_wr_p_s
   , chk_wr       => chk_wr_p_s
   , end_wr       => end_wr_p_s
   , cpu_data     => d_from_cpu_s
   , frag         => cache_frag_s
   , ov_active    => ov_active_s
   , ov_en        => ov_en_s
   , ov_we_n      => ov_we_n_s
   , ov_addr      => ov_addr_s
   , ov_data      => ov_data_s
   , sd_cs_n      => cc_cs_n_s
   , sd_sclk      => cc_sclk_s
   , sd_mosi      => cc_mosi_s
   , sd_miso      => sd_miso_i
   , led          => cache_led_s
   );


   --
   -- External Cartridge Interface
   --                    74245
   --  Op      FPGA   !OE   DIR
   -- ------------------------------
   -- read      Z      0     0 (B->A) (cart->FPGA)
   -- write    CPU     0     1 (A->B) (FPGA->cart)
   -- !cart     Z      1     X
   --

   -- TODO: Maybe register the cart output so they do not glitch,
   -- since they are driving real external hardware.

   -- The output enable for the 74245 must remain active all the time
   -- so the cart_en_XX_n_s outputs remain valid; The output-enable for
   -- both halves of the 74245 are tied to the same FPGA output.
   -- New carts do not seem to tolerate invalid state on these lines
   -- even when the cartridge is not being addressed.
   cart_oe_n_o    <= '0';
   cart_dir_o     <= rd_n_s;

   -- Only tri-state when reading, otherwise just drive whatever is on
   -- the CPU bus out to the cartridge.  This is what the real CV does.
   cart_data_io   <= (others => 'Z') when rd_n_s = '0' else d_from_cpu_s;
   cart_addr_o    <= cpu_addr_s(14 downto 0);

   -- Individual cartridge range select should always be valid. These are
   -- combinatorial signals and may glitch, however in the real CV they
   -- are also combinatorial (derived from a 74138 which is driven by
   -- the address bus).
   cart_en_80_n_o <= cart_en_80_n_s;
   cart_en_a0_n_o <= cart_en_A0_n_s;
   cart_en_c0_n_o <= cart_en_C0_n_s;
   cart_en_e0_n_o <= cart_en_E0_n_s;


   --
   -- CPU Data-In Mux
   --
   d_to_cpu_s <=
      -- Memory
      cpu_data_mux_s when (mreq_n_s = '0' and rfsh_n_s = '1') else
      -- Original IO ports >80 .. >FF
      io_data_mux_s when cpu_addr_s(7) = '1' else
      -- Extended non-standard IO ports >50 .. >7F
      ex_data_mux_s;


   -- CV Memory Map Decode
   --
   -- A15 A14 A13
   --  8   4   2
   -- -----------
   --  0   0   0   >0000 .. >1FFF (8K)    BIOS, 8K
   --  0   0   1   >2000 .. >3FFF (8K)    EXT_20, no physical memory
   --  0   1   0   >4000 .. >5FFF (8K)    EXT_40, no physical memory
   --  0   1   1   >6000 .. >7FFF (8K)    RAM, 1K, appears at every 1K boundary
   --  1   0   0   >8000 .. >9FFF (8K)    ROM_80
   --  1   0   1   >A000 .. >BFFF (8K)    ROM_A0
   --  1   1   0   >C000 .. >DFFF (8K)    ROM_C0
   --  1   1   1   >E000 .. >FFFF (8K)    ROM_E0
   --
   --
   -- ROM Addressing During Loading
   --
   -- During PoR a 24K ROM loader and 8K RAM is mapped into the bottom 32K of
   -- memory, and the BIOS is not accessible.  When the loader is disabled, the
   -- original BIOS and 1K RAM are visible in their original location.
   --
   --                 Loader: Enabled  Disabled
   --                 ---------------------------
   --  >0000 .. >1FFF (8K)    Loader   BIOS
   --  >2000 .. >3FFF (8K)    Loader   no memory
   --  >4000 .. >5FFF (8K)    Loader   no memory
   --  >6000 .. >63FF (1K)    RAM      RAM
   --  >6400 .. >7FFF (7K)    RAM      mirror of >6000
   --
   -- ADAM Memory Banking
   --
   -- The ADAM computer added a custom memory decode IC that allows for a
   -- flexible selection of RAM or ROM in the upper and lower 32K sections
   -- of the CPU address space.  The Super Game Module (SGM) simply copies
   -- portions of the ADAM's memory map for us on the CV.  The memory
   -- options are selected via I/O port >7F.
   --
   -- Port >7F  CPU Address Space
   --  8 4 2 1  >0000 .. >7FFF
   --  --------------------------------
   --      0 0  SmartWRITER and EOS ROM
   --      0 1  32K Lower Internal RAM
   --      1 0  32K Lower Expansion RAM
   --      1 1  8K BIOS + 24K Lower Internal RAM
   --
   --  8 2 4 1  >8000 .. >FFFF
   --  ---------------------------------
   --  0 0      32K Upper Internal RAM
   --  0 1      32K Expansion ROM
   --  1 0      32K Upper Expansion RAM
   --  1 1      32K Cartridge ROM
   --
   --
   -- SGM Memory
   --
   -- The SGM copies the ADAM Lower Internal RAM option to provide either
   -- 8K BIOS + 24K RAM, or 32K RAM in the lower 32K address range >0000
   -- to >7FFF.
   --
   -- The SGM is enabled via port >53 bit >01=1, and the BIOS+24K or full
   -- 32K option is selected via the ADAM port >7F bit >02.
   --
   -- It is not clear if software on the CV written to use the SGM manages
   -- the 4-bits in port >7F correctly, i.e. as per the ADAM specification.
   -- To support poorly written software, only bit >02 of port >7F will be
   -- used to select between the BIOS or 8K RAM.
   --
   -- Port: >53   >7F   CPU Address Space
   --  bit:   1   2 1   >0000 .. >7FFFF
   --        ---------  ---------------------
   --         0   x x   Original CV BIOS and 1K RAM
   --         1   0 x   32K SGM RAM
   --         1   1 x   CV 8K BIOS + 24K SGM RAM
   --
   -- **Note that the original CV 1K RAM and the SGM RAM are *separate*
   --   memories. Some software might rely on this trait.
   --
   -- The CV has separate memory and I/O decode override inputs on the
   -- expansion port.  This allows expansion modules like the SGM to replace
   -- the system BIOS with RAM.
   --
   --
   -- MegaCart
   --
   -- The MegaCart bank select register is updated any time memory is accessed
   -- in the range >FFC0 to >FFFF.  The LS-address bits (5..0) are used to
   -- specify the bank.  The CV does not provide read or write enables to the
   -- cartridge port, so the enable for updating the bank select register is
   -- any access to the specified memory range.
   --
   --
   -- SGM Banking
   --
   -- 8K pages: >8000 is always page 0 of the ROM, and >A000, >C000, >E000
   -- show the pages selected by CPU *writes* to >FFFC, >FFFD, >FFFE (reads
   -- do not change the banks).  The three bank registers are also
   -- accessible at ports >54 (only while SGM banking is active), >5A, >5B.
   -- Like the MegaCart, the ROM is loaded at the top of the 512K, and the
   -- 8K page mask in port >59 maps a page to (page AND mask) OR (NOT mask).

   memory_decode : process
   ( cpu_addr_s, mreq_n_s, rfsh_n_s, wr_n_s
   , d_from_loader_s, d_from_bios_s, d_from_cv_ram1k_r, cart_data_io
   , d_from_ext512_s, sgm_en_r, sgm_8k_en_r
   , ext_ram_bank_r, rom_loader_en_r, real_cart_r, upmem_mode_r
   , mc_bank_r, mc_en_r, sgmbk_en_r, c_line_s
   , cart_en_80_n_s, cart_en_A0_n_s, upmem_we_inhibit_s
   ) begin

      cv_ram1k_en_s  <= '0';

      cart_en_80_n_s <= '1';
      cart_en_A0_n_s <= '1';
      cart_en_C0_n_s <= '1';
      cart_en_E0_n_s <= '1';

      -- Default to data from a cartridge.
      cpu_data_mux_s <= cart_data_io;


      -- External 512K SRAM address select priority decode:
      --
      --   1. Select the fixed 32K SGM bank-0 when addressing the lower 32K.
      --   2. If banking, choose address based on the selected bank method.
      --   3. Otherwise use the 32K bank register.

      if cpu_addr_s(15) = '0' then
         -- Address the SGM 32K at the fixed bank-0 in the 512K.
         ext_ram_addr_s <= "0000" & cpu_addr_s(14 downto 0);
      else
         if mc_en_r = '1' or sgmbk_en_r = '1' then
            -- MegaCart or SGM banking: the ROM cache's SRAM page for the
            -- addressed 8K ROM page (rom_page_s).
            ext_ram_addr_s <= c_line_s & cpu_addr_s(12 downto 0);
         else
            -- Use the 32K bank register.
            ext_ram_addr_s <= ext_ram_bank_r & cpu_addr_s(14 downto 0);
         end if;
      end if;

      ext_ram_en_s      <= '0';
      ext_ram_we_n_s    <= '1';


      -- Required to keep loader ROM from being removed by the synthesizer.
      rom_loader_we_n_s <= '1';

      -- The upper memory-mode register controls whether the 32K pages are
      -- writable.
      upmem_we_inhibit_s <= upmem_mode_r(0);

      -- MegaCart bank select register.
      mc_bank_x         <= mc_bank_r;

      -- SGM bank register writes.
      sgmbk_wr_a_s      <= '0';
      sgmbk_wr_c_s      <= '0';
      sgmbk_wr_e_s      <= '0';


      -- Memory access that is not a refresh cycle.
      if mreq_n_s = '0' and rfsh_n_s = '1' then

         -- Enable the external RAM when the SGM is enabled or
         -- the physical cartridge is NOT enabled.
         ext_ram_en_s <= sgm_en_r or (not real_cart_r);

         case cpu_addr_s(15 downto 13) is

         when "000" =>                 -- 8K  >0000 .. >1FFF   Loader, BIOS, or SGM RAM

            -- The loader is priority.
            if rom_loader_en_r = '1' then
               cpu_data_mux_s <= d_from_loader_s;

            -- The SGM must be enabled to be able to switch the BIOS for 8K RAM.
            elsif sgm_8k_en_r = '0' or sgm_en_r = '0' then
               cpu_data_mux_s <= d_from_bios_s;

            else
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "001" =>                 -- 8K >2000 .. >3FFF   Loader or SGM 24K RAM (if enabled)

            if rom_loader_en_r = '1' then
               cpu_data_mux_s <= d_from_loader_s;

            elsif sgm_en_r = '1' then
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "010" =>                 -- 8K >4000 .. >5FFF   Loader or SGM 24K RAM (if enabled)

            if rom_loader_en_r = '1' then
               --cpu_data_mux_s <= d_from_bios_s;
               cpu_data_mux_s <= d_from_loader_s;

            elsif sgm_en_r = '1' then
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "011" =>                 -- 8K  >6000 .. >7FFF   CV 1K and / or SGM 24K RAM

            if rom_loader_en_r = '1' or sgm_en_r = '1' then

               ext_ram_en_s <= '1';

               if cpu_addr_s(12 downto 10) = "000" then
                  -- Enable the CV 1K RAM when memory at >6000 is addressed
                  -- while the loader is active.  This allows the loader to
                  -- set up the CV 1K the same as the original BIOS would
                  -- prepare the RAM prior to jumping to a game.
                  cv_ram1k_en_s <= rom_loader_en_r;
               end if;

               -- A write-enable is required to keep the synthesizer from
               -- deciding that the loader ROM is redundant and removing parts
               -- of it from the design.  This is only enabled in the address
               -- range >6000 .. >7FFF when the loader module is internally
               -- preventing the write enable.
               rom_loader_we_n_s <= wr_n_s;

               -- Enable writing to the SGM, and read data from the SGM.
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;

            else
               -- Normal CV 1K when the loader and SGM are disabled.
               cv_ram1k_en_s  <= '1';
               cpu_data_mux_s <= d_from_cv_ram1k_r;
            end if;

         when "100" =>                 -- 8K  >8000 .. >9FFF

            cart_en_80_n_s <= '0';

            if real_cart_r = '1' then
               cpu_data_mux_s <= cart_data_io;
            else
               cpu_data_mux_s <= d_from_ext512_s;
               ext_ram_we_n_s <= wr_n_s or upmem_we_inhibit_s;
            end if;

         when "101" =>                 -- 8K  >A000 .. >BFFF

            cart_en_A0_n_s <= '0';

            if real_cart_r = '1' then
               cpu_data_mux_s <= cart_data_io;
            else
               cpu_data_mux_s <= d_from_ext512_s;
               ext_ram_we_n_s <= wr_n_s or upmem_we_inhibit_s;
            end if;

         when "110" =>                 -- 8K  >C000 .. >DFFF

            cart_en_C0_n_s <= '0';

            if real_cart_r = '1' then
               cpu_data_mux_s <= cart_data_io;
            else
               cpu_data_mux_s <= d_from_ext512_s;
               ext_ram_we_n_s <= wr_n_s or upmem_we_inhibit_s;
           end if;

         when "111" =>                 -- 8K  >E000 .. >FFFF

            cart_en_E0_n_s <= '0';

            if real_cart_r = '1' then
               cpu_data_mux_s <= cart_data_io;
            else
               cpu_data_mux_s <= d_from_ext512_s;
               ext_ram_we_n_s <= wr_n_s or upmem_we_inhibit_s;
            end if;

            -- MegaCart bank register (6 bits, 1M).  Update on read or write.
            if cpu_addr_s(12 downto 6) = "1111111" then
               mc_bank_x <= cpu_addr_s(5 downto 0);
            end if;

            -- SGM bank registers, writes only.
            if sgmbk_en_r = '1' and wr_n_s = '0' then
               case cpu_addr_s(12 downto 0) is
               when "1111111111100" => sgmbk_wr_a_s <= '1';
               when "1111111111101" => sgmbk_wr_c_s <= '1';
               when "1111111111110" => sgmbk_wr_e_s <= '1';
               when others => null;
               end case;
            end if;

         when others => null;
         end case;
      end if;
   end process;


   -- The 8K ROM page of a banked read, masked to the image's size (the ROM
   -- cache places it in the SRAM).
   --  MegaCart: 16K banks; >8000 is the last bank (the mask), >C000 the
   --            bank selected by an access to >FFC0+bank.
   --  SGM:      8K pages; >8000 is page 0, >A000, >C000, >E000 the pages
   --            written to >FFFC, >FFFD, >FFFE.
   rom_page : process ( cpu_addr_s, mc_en_r, mc_bank_r, mc_mem_size_r
                      , sgmbk_a_r, sgmbk_c_r, sgmbk_e_r )
      variable bank_v : std_logic_vector(5 downto 0);
      variable page_v : std_logic_vector(7 downto 0);
   begin
      if mc_en_r = '1' then
         if cpu_addr_s(14) = '0' then
            bank_v := mc_mem_size_r(5 downto 0);
         else
            bank_v := mc_bank_r and mc_mem_size_r(5 downto 0);
         end if;
         rom_page_s <= '0' & bank_v & cpu_addr_s(13);
      else
         case cpu_addr_s(14 downto 13) is
         when "00"   => page_v := x"00";       -- >8000 fixed page 0
         when "01"   => page_v := sgmbk_a_r;   -- >A000
         when "10"   => page_v := sgmbk_c_r;   -- >C000
         when others => page_v := sgmbk_e_r;   -- >E000
         end case;
         rom_page_s <= page_v and mc_mem_size_r;
      end if;
   end process;


   -- CV I/O Decode
   --
   -- A7 A6 A5 WR
   -- EN 4  2  1
   -- -----------
   -- 1  0  0  0  >80 .. >9F  (W) set controllers to keypad mode
   -- 1  0  0  1  >80 .. >9F  (R) keyboard scan code when port >53 bit >04 = 1
   --                             (next byte, 0 when none), else not connected
   -- 1  0  1  0  >A0 .. >BF  (W) VDP csw_n, A0==mode
   -- 1  0  1  1  >A0 .. >BF  (R) VDP csr_n, A0==mode
   -- 1  1  0  0  >C0 .. >DF  (W) set controllers to joystick mode
   -- 1  1  0  1  >C0 .. >DF  (R) not connected
   -- 1  1  1  0  >E0 .. >FF  (W) sound chip (SN76489A)
   -- 1  1  1  1  >E0 .. >FF  (R) read controller data, A1=0 read controller 1, A1=1 read controller 2
   --

   io_decode_s <= cpu_addr_s(6 downto 5) & wr_n_s;

   process ( cpu_addr_s, io_decode_s, iorq_n_s, m1_n_s, rd_n_s,
             d_from_ctrl_s, d_from_vdp_s, kbd_mode_r, kbd_data_r )
   begin
      kbd_rd_s          <= '0';
      vdp_w_n_s         <= '1';
      vdp_r_n_s         <= '1';
      sn489_we_n_s      <= '1';
      ctrl_en_key_n_s   <= '1';
      ctrl_en_joy_n_s   <= '1';
      io_data_mux_s     <= d_from_ctrl_s;

      if iorq_n_s = '0' and m1_n_s = '1' and cpu_addr_s(7) = '1' then
         case io_decode_s is
         when "000" =>  ctrl_en_key_n_s   <= '0';
         when "001" =>  if kbd_mode_r = '1' then
                           kbd_rd_s       <= not rd_n_s;
                           io_data_mux_s  <= kbd_data_r;
                        end if;
         when "010" =>  vdp_w_n_s         <= '0';
         when "011" =>  vdp_r_n_s         <= '0';
                        io_data_mux_s     <= d_from_vdp_s;
         when "100" =>  ctrl_en_joy_n_s   <= '0';
         when "110" =>  sn489_we_n_s      <= '0';
         when others => null;
         end case;
      end if;
   end process;


   -- Extended I/O Ports
   --
   -- Port  CPU Data
   -- --------------
   --  >50  WWWWWWWW (W) WSG / SGM-PSG Address Write
   --  >51  WWWWWWWW (W) WSG / SGM-PSG Data Write
   --  >52  RRRRRRRR (R) WSG / SGM-PSG Data Read
   --  >53  xxxxxx_W (W) 0 = SGM disable, 1 = SGM enable
   --       xxxxxxW_ (W) 0 = SGM Sound AY-8910, 1 = SGM Sound SEX-7264
   --       xxxxxWxx (W) 0 = PS/2 keyboard emulates joystick 1,
   --                    1 = PS/2 scan codes readable at port >80
   --
   --  >54  xxxxWWWW (W) 32K RAM bank select, 0000 is ignored
   --       xxxxRRRR (R) current bank
   --       WWWWWWWW (W) SGM banking active: 8K page at >A000 (as >FFFC)
   --       RRRRRRRR (R) SGM banking active: 8K page at >A000
   --
   --  >55  xxxxxxxx (R) Loader disable, PoR re-enabled ROM loader
   --       xx__xxWW (W) Banking scheme
   --             00     None, physical cartridge, other bits ignored
   --             01     MegaCart: bank is address access >FFC0+bank
   --             10     SGM: Bank is data written to >FFFF
   --             11     Atari: >FF80, >FF90, >FFA0, >FFB0 ???
   --       xxWWxx__ (W) Select the upper memory operation:
   --         00         32K Upper Internal RAM, ignores bank scheme
   --         01         32K Expansion ROM, uses bank scheme
   --         10         32K Upper Expansion RAM, uses bank scheme
   --         11         32K Cartridge ROM, ignores bank scheme
   --
   --  >56  xxxxxx_W (W) SD-card CE_n (AKA SS_n), 0=enable
   --       xxxxxxW_ (W) SD-card speed, 1=400KHz, 0=12MHz
   --       RxxxxxRR (R) SD-card card-detect, bit >80 1=card inserted
   --
   --  >57  WWWWWWWW (W) SD-card Data Write
   --       RRRRRRRR (R) SD-card Data Read
   --
   --  >58  00001000 (R) Machine ID, Phoenix = 8
   --
   --  >59  xxWWWWWW (W) MegaCart bank mask (16K banks - 1): 000001 = 32K,
   --                    011111 = 512K, 111111 = 1M
   --       WWWWWWWW (W) SGM page mask (8K pages - 1): 00001111 = 128K,
   --                    11111111 = 2M
   --
   --  >5A  WWWWWWWW (W) SGM 8K page at >C000 (as >FFFD)
   --       RRRRRRRR (R)
   --  >5B  WWWWWWWW (W) SGM 8K page at >E000 (as >FFFE)
   --       RRRRRRRR (R)
   --
   --  ROM cache (cv_cache.v): MegaCart and SGM images up to 1M / 2M.  The
   --  SRAM holds 480K of the image (above the SGM's 32K), loaded at the top
   --  (a bigger image's last 480K); the cache reads other 8K pages from the
   --  SD card when the game needs them, while the CPU waits.  The menu gives
   --  it each page's SD sector by reading one byte of the page with FatFs:
   --  >5C  WWWWWWWW (W) the page: the next CMD17s sent to >57 give its sector
   --  >5D  WWWWWWWW (W) the page again: the next CMD17 must be its last sector
   --  >5E  xxxxxxxx (W) end the above
   --       0000000R (R) 1 = a page was not in consecutive sectors (or not read)
   --
   --  >5F  RRRRRRRR (R) the value written (LED test)
   --       xxxxxxWW (W) LED: 00/11 = normal (on during reset, the menu and
   --                    cache errors), 01 = off, 10 = on
   --       WWWWxxxx (W) RGB LED: bit 7 = 1 overrides the normal yellow with
   --                    bits 6, 5, 4 = red, green, blue (1 = lit)
   --       Reset sets >00.
   --
   --  >7F  xxxxxxWx (W) 0 = 8K SGM RAM, 1 = 8K CV BIOS
   --
   process
   ( cpu_addr_s, iorq_n_s, m1_n_s, wr_n_s, rd_n_s
   , d_from_cpu_s, d_from_wsg_s, sgm_en_r, sgm_8k_en_r
   , ext_ram_bank_r, rom_loader_en_r
   , d_from_sd_s, sd_detect_r, sd_slow_clk_r, sd_spi_ss_n_r
   , real_cart_r, bank_mode_r, upmem_mode_r
   , mc_mem_size_r, mc_en_r, kbd_mode_r
   , sgmbk_en_r, sgmbk_a_r, sgmbk_c_r, sgmbk_e_r
   , sgmbk_wr_a_s, sgmbk_wr_c_s, sgmbk_wr_e_s, cache_frag_s, dbg_led_r
   ) begin
      sgm_en_x          <= sgm_en_r;
      sgm_8k_en_x       <= sgm_8k_en_r;
      kbd_mode_x        <= kbd_mode_r;

      ext_ram_bank_x    <= ext_ram_bank_r;

      rom_loader_en_x   <= rom_loader_en_r;

      wsg_bdir_s        <= '0';  -- bus direction
      wsg_bc_s          <= '0';  -- bus control

      -- SD-card
      sd_cs_n_s         <= '1';
      sd_slow_clk_x     <= sd_slow_clk_r;
      sd_spi_ss_n_x     <= sd_spi_ss_n_r;

      ex_data_mux_s     <= (others => '0');

      -- Upper memory and bank mode.
      real_cart_x       <= real_cart_r;   -- Will be '1' when bank_mode_r == "00"
      bank_mode_x       <= bank_mode_r;
      upmem_mode_x      <= upmem_mode_r;

      -- MegaCart support.
      mc_mem_size_x     <= mc_mem_size_r;
      mc_en_x           <= mc_en_r;

      -- SGM banking, bank registers also written via >FFFC..>FFFE.
      sgmbk_en_x        <= sgmbk_en_r;
      sgmbk_a_x         <= sgmbk_a_r;
      sgmbk_c_x         <= sgmbk_c_r;
      sgmbk_e_x         <= sgmbk_e_r;
      dbg_led_x         <= dbg_led_r;
      if sgmbk_wr_a_s = '1' then sgmbk_a_x <= d_from_cpu_s; end if;
      if sgmbk_wr_c_s = '1' then sgmbk_c_x <= d_from_cpu_s; end if;
      if sgmbk_wr_e_s = '1' then sgmbk_e_x <= d_from_cpu_s; end if;


      if iorq_n_s = '0' and m1_n_s = '1' then
         case cpu_addr_s(7 downto 4) is

         when x"5" =>
            case cpu_addr_s(3 downto 0) is

            when x"0" =>                  -- port >50 PSG address write

               if wr_n_s = '0' then
                  wsg_bdir_s  <= '1';
                  wsg_bc_s    <= '1';
               end if;

            when x"1" =>                  -- port >51 PSG data write

               if wr_n_s = '0' then
                  wsg_bdir_s  <= '1';
               end if;

            when x"2" =>                  -- port >52 PSG data read

               if rd_n_s = '0' then
                  wsg_bc_s       <= '1';
                  ex_data_mux_s  <= d_from_wsg_s;
               end if;

            when x"3" =>                  -- port >53 SGM enable / disable

               if wr_n_s = '0' then
                  sgm_en_x       <= d_from_cpu_s(0);
                  kbd_mode_x     <= d_from_cpu_s(2);
               end if;

            when x"4" =>                  -- port >54 external RAM bank select

               if sgmbk_en_r = '1' then
                  -- SGM banking: the >A000 8K page register.
                  if rd_n_s = '0' then
                     ex_data_mux_s  <= sgmbk_a_r;
                  end if;
                  if wr_n_s = '0' then
                     sgmbk_a_x <= d_from_cpu_s;
                  end if;
               else
                  if rd_n_s = '0' then
                     ex_data_mux_s  <= "0000" & ext_ram_bank_r;
                  end if;

                  -- Page 0 is reserved for the SGM and cannot be
                  -- directly selected.
                  if wr_n_s = '0' and d_from_cpu_s(3 downto 0) /= "0000" then
                     ext_ram_bank_x <= d_from_cpu_s(3 downto 0);
                  end if;
               end if;

            when x"5" =>                  -- port >55 ROM loader disable

               if rd_n_s = '0' then
                  rom_loader_en_x <= '0';
               end if;

               if wr_n_s = '0' then
                  -- A physical cartridge is selected when no banking is
                  -- selected.  In this case, all other upper memory banking
                  -- is ignored.
                  real_cart_x    <= d_from_cpu_s(1) nor d_from_cpu_s(0);
                  bank_mode_x    <= d_from_cpu_s(1 downto 0);
                  upmem_mode_x   <= d_from_cpu_s(5 downto 4);

                  -- MegaCart enable, true when MegaCart mode, and upper memory
                  -- is set to recognize banking.
                  -- SGM banking enable, same idea.
                  sgmbk_en_x     <= d_from_cpu_s(1) and (not d_from_cpu_s(0)) and
                                    (d_from_cpu_s(5) xor d_from_cpu_s(4));
                  mc_en_x        <= (not d_from_cpu_s(1)) and d_from_cpu_s(0) and
                                    (d_from_cpu_s(5) xor d_from_cpu_s(4));
               end if;

            when x"6" =>                  -- port >56 SD-card control

               if rd_n_s = '0' then
                  ex_data_mux_s  <= sd_detect_r & "00000" &
                                    sd_slow_clk_r & sd_spi_ss_n_r;
               end if;

               if wr_n_s = '0' then
                  sd_slow_clk_x <= d_from_cpu_s(1);
                  sd_spi_ss_n_x <= d_from_cpu_s(0);
               end if;

            when x"7" =>                  -- port >57 SD-card data read / write

               sd_cs_n_s <= '0';

               if rd_n_s = '0' then
                  ex_data_mux_s  <= d_from_sd_s;
               end if;

            when x"8" =>                  -- port >58 machine ID

               if rd_n_s = '0' then
                  ex_data_mux_s  <= machine_id_c;
               end if;

            when x"9" =>                  -- port >59 MegaCart / SGM page mask

               if wr_n_s = '0' then
                  mc_mem_size_x  <= d_from_cpu_s;
               end if;

            when x"A" =>                  -- port >5A SGM page at >C000

               if rd_n_s = '0' then
                  ex_data_mux_s  <= sgmbk_c_r;
               end if;
               if wr_n_s = '0' then
                  sgmbk_c_x      <= d_from_cpu_s;
               end if;

            when x"B" =>                  -- port >5B SGM page at >E000

               if rd_n_s = '0' then
                  ex_data_mux_s  <= sgmbk_e_r;
               end if;
               if wr_n_s = '0' then
                  sgmbk_e_x      <= d_from_cpu_s;
               end if;

            when x"E" =>                  -- port >5E ROM cache status

               if rd_n_s = '0' then
                  ex_data_mux_s  <= "0000000" & cache_frag_s;
               end if;

            when x"F" =>                  -- port >5F LED test

               if rd_n_s = '0' then
                  ex_data_mux_s  <= dbg_led_r;
               end if;
               if wr_n_s = '0' then
                  dbg_led_x      <= d_from_cpu_s;
               end if;

            when others => null;
            end case;
			when x"3" =>
				case cpu_addr_s(3 downto 0) is
					when x"1" =>                  -- port >30 AK keyboard interface check port
						--set port 30 to 30 so it will be different then port reads on 31,32,33 which will cause the system
						-- to not detect an Andy Keys keyboard
						if rd_n_s = '0' then
							ex_data_mux_s  <= cpu_addr_s(7 downto 0);
						end if;
				when others => null;
				end case;
			when others => null;
         end case;

         -- ADAM compatible selection for BIOS vs 8K RAM at >0000.
         if cpu_addr_s(7 downto 0) = x"7F" and wr_n_s = '0' then
            -- The SGM 8K enable, active high.
            sgm_8k_en_x <= not d_from_cpu_s(1);
         end if;
      end if;
   end process;


   -- System reset and register transfer.
   process (clk_25m0_i, reset_i, clk_3m58_en_i)
   begin
   if rising_edge(clk_25m0_i) then
      if reset_i = '1' then
         sgm_en_r          <= '0';           -- disable SGM on reset
         sgm_8k_en_r       <= '0';           -- BIOS over SGM 8K RAM at >0000
         kbd_mode_r        <= '0';           -- keyboard emulates the joystick
         ext_ram_bank_r    <= "0001";        -- external RAM bank select
         rom_loader_en_r   <= '1';           -- enabled ROM loader
         sd_detect_r       <= '0';           -- no card until sampled
         sd_slow_clk_r     <= '1';           -- fall-back to SD-card SPI slow clock
         sd_spi_ss_n_r     <= '1';           -- de-select the SD-card device
         real_cart_r       <= '1';           -- default to a real cartridge
         bank_mode_r       <= "00";          -- no banking
         upmem_mode_r      <= "00";          -- upper memory selection does not matter
         mc_mem_size_r     <= x"0F";         -- default to 256K
         mc_bank_r         <= "111111";      -- default to top bank
         mc_en_r           <= '0';           -- disable MegaCart
         sgmbk_en_r        <= '0';           -- disable SGM banking
         sgmbk_a_r         <= x"01";         -- SGM pages 1, 2, 3 (linear)
         sgmbk_c_r         <= x"02";
         sgmbk_e_r         <= x"03";
         dbg_led_r         <= x"00";         -- normal LEDs

      elsif clk_3m58_en_i = '1' then
         sgm_en_r          <= sgm_en_x;
         sgm_8k_en_r       <= sgm_8k_en_x;
         kbd_mode_r        <= kbd_mode_x;
         ext_ram_bank_r    <= ext_ram_bank_x;
         rom_loader_en_r   <= rom_loader_en_x;
         sd_detect_r       <= not sd_cd_n_i; -- sample and invert input directly
         sd_slow_clk_r     <= sd_slow_clk_x;
         sd_spi_ss_n_r     <= sd_spi_ss_n_x;
         real_cart_r       <= real_cart_x;
         bank_mode_r       <= bank_mode_x;
         upmem_mode_r      <= upmem_mode_x;
         mc_mem_size_r     <= mc_mem_size_x;
         mc_bank_r         <= mc_bank_x;
         mc_en_r           <= mc_en_x;
         sgmbk_en_r        <= sgmbk_en_x;
         sgmbk_a_r         <= sgmbk_a_x;
         sgmbk_c_r         <= sgmbk_c_x;
         sgmbk_e_r         <= sgmbk_e_x;
         dbg_led_r         <= dbg_led_x;

      end if;
   end if;
   end process;


   --
   -- PS/2 keyboard FIFO, only active in keyboard mode.  The byte is taken
   -- (and removed) at the start of a port >80 read and held for the rest of
   -- the read cycle, so a byte arriving during the read is not lost.  When
   -- full, new bytes are dropped.
   --
   kbd_mode_o <= kbd_mode_r;

   process (clk_25m0_i)
      variable push_v, pop_v : boolean;
   begin
   if rising_edge(clk_25m0_i) then
      if reset_i = '1' or kbd_mode_r = '0' then
         kbd_wr_ptr_r   <= "000";
         kbd_rd_ptr_r   <= "000";
         kbd_count_r    <= "0000";
         kbd_data_r     <= x"00";
         kbd_rd_r       <= '0';
      else
         kbd_rd_r <= kbd_rd_s;

         push_v := kbd_stb_i = '1' and kbd_count_r /= 8;
         pop_v  := kbd_rd_s = '1' and kbd_rd_r = '0' and kbd_count_r /= 0;

         if kbd_rd_s = '1' and kbd_rd_r = '0' then
            if kbd_count_r /= 0 then
               kbd_data_r <= kbd_fifo_r(to_integer(kbd_rd_ptr_r));
            else
               kbd_data_r <= x"00";
            end if;
         end if;

         if push_v then
            kbd_fifo_r(to_integer(kbd_wr_ptr_r)) <= kbd_byte_i;
            kbd_wr_ptr_r <= kbd_wr_ptr_r + 1;
         end if;

         if pop_v then
            kbd_rd_ptr_r <= kbd_rd_ptr_r + 1;
         end if;

         if push_v and not pop_v then
            kbd_count_r <= kbd_count_r + 1;
         elsif pop_v and not push_v then
            kbd_count_r <= kbd_count_r - 1;
         end if;
      end if;
   end if;
   end process;


-- EEPROM-based games use an alternative ROM page switch.
-- They are not MegaCarts (0xFFC0+page#) and not SGM multipage ROMs (page# written to 0xFFFF).
-- EEPROM games use 0xFF80/0xFF90/0xFFA0/0xFFB0 to switch 4x16kB pages.


end rtl;
