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
   generic (
      num_maq_g      : integer := 0;
      compat_rgb_g   : integer := 0
   );
   port (
      clock_i        : in  std_logic;        --  21.47727 (21.739 PLL) MHz
      clock_mem_i    : in  std_logic;        --  42.95454 (43.478 PLL) MHz
      clk_100m0_i    : in  std_logic;
      clk_25m0_i     : in  std_logic;
      clk_en_3m58_i  : in  std_logic;
      clk_en_1m79_i  : in  std_logic;
      reset_i        : in  std_logic;        -- Soft Reset, active high
      por_n_i        : in  std_logic;        -- Power-on Reset, active low

      -- Physical controller interface
      ctrl_p1_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p2_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p3_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p4_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p5_o      : out std_logic;
      ctrl_p6_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p7_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p8_o      : out std_logic;
      ctrl_p9_i      : in  std_logic_vector( 2 downto 1);

--      -- CPU RAM
--      ram_addr_o     : out std_logic_vector(16 downto 0);   -- 128K
--      ram_ce_o       : out std_logic;
--      ram_oe_o       : out std_logic;
--      ram_we_o       : out std_logic;
--      ram_data_i     : in  std_logic_vector( 7 downto 0);
--      ram_data_o     : out std_logic_vector( 7 downto 0);
--      -- Video RAM Interface
--      vram_addr_o    : out std_logic_vector(13 downto 0);   -- 16K
--      vram_ce_o      : out std_logic;
--      vram_oe_o      : out std_logic;
--      vram_we_o      : out std_logic;
--      vram_data_i    : in  std_logic_vector( 7 downto 0);
--      vram_data_o    : out std_logic_vector( 7 downto 0);

      -- Physical cartridge interface
      cart_addr_o    : out std_logic_vector(14 downto 0);   -- 32K
      cart_dir_o     : out std_logic;
      cart_data_io   : inout std_logic_vector( 7 downto 0);
      cart_oe_n_o    : out std_logic;
      cart_en_80_n_o : out std_logic;
      cart_en_a0_n_o : out std_logic;
      cart_en_c0_n_o : out std_logic;
      cart_en_e0_n_o : out std_logic;

      -- Audio output
      audio_o        : out std_logic_vector(7 downto 0);
      audio_signed_o : out signed(7 downto 0);

      -- VGA output
      blank_o        : out std_logic;
      hsync_n_o      : out std_logic;
      vsync_n_o      : out std_logic;
      red_o          : out std_logic_vector( 3 downto 0);
      grn_o          : out std_logic_vector( 3 downto 0);
      blu_o          : out std_logic_vector( 3 downto 0);

      -- External SRAM, 512Kx8, 10ns
      sram_addr_o    : out    std_logic_vector(18 downto 0);
      sram_data_io   : inout  std_logic_vector(7 downto 0);
      sram_ce_n_o    : out    std_logic;
      sram_oe_n_o    : out    std_logic;
      sram_we_n_o    : out    std_logic;

      -- SDcard SPI interface
      sd_miso_i      : in  std_logic;
      sd_mosi_o      : out std_logic;
      sd_sclk_o      : out std_logic;
      sd_cs_n_o      : out std_logic;
      sd_cd_n_i      : in  std_logic      -- Card detect, active low.
   );

end entity;

-- pragma translate_off
use std.textio.all;
-- pragma translate_on

architecture Behavior of colecovision is

   signal reset_n_s                       : std_logic;

   -- Z80 CPU
   signal clk_en_cpu_s                    : std_logic;
   signal nmi_n_s                         : std_logic;
   signal int_n_s                         : std_logic;
   signal iorq_n_s                        : std_logic;
   signal m1_n_s                          : std_logic;
   signal m1_wait_q                       : std_logic;
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

   -- SN76489 Sound
   signal audio_s                         : signed(7 downto 0);
   signal sn489_ready_s                   : std_logic;
   signal sn489_we_n_s                    : std_logic;

   -- AY-8910 SGM Sound
   signal d_from_wsg_s                    : std_logic_vector(7 downto 0);
   signal wsg_bdir_s                      : std_logic;
   signal wsg_bc_s                        : std_logic;

   signal ay_ch_a_s                       : std_logic_vector( 7 downto 0);
   signal ay_ch_b_s                       : std_logic_vector( 7 downto 0);
   signal ay_ch_c_s                       : std_logic_vector( 7 downto 0);

   -- Audio Mixing
   signal AUDIO_WSG                       : unsigned(7 downto 0);
   signal AUDIO_EX                        : signed(7 downto 0);
   signal AUDIO_EX_A			               : signed(7 downto 0);
   signal AUDIO_EX_B			               : signed(7 downto 0);
   signal AUDIO_EX_C			               : signed(7 downto 0);
   signal AUDIO_SUM                       : signed(8 downto 0);
   signal WSG_CS                          : std_logic;

   -- Internal 1K RAM
   type ram_1k_t is array (0 to 1023) of std_logic_vector(0 to 7);

   signal cv_ram_1k_r                     : ram_1k_t;
   signal cv_ram1k_en_s                   : std_logic;
   signal cv_ram1k_addr_s                 : std_logic_vector( 9 downto 0);
   signal d_from_cv_ram1k_r               : std_logic_vector( 7 downto 0);

   -- SGM RAM
   signal sgm_en_r, sgm_en_x              : std_logic;
   signal sgm_8k_en_r, sgm_8k_en_x        : std_logic;

   -- External SRAM
   signal ext_ram_addr_s                  : std_logic_vector(18 downto 0);
   signal ext_ram_bank_r, ext_ram_bank_x  : std_logic_vector( 3 downto 0) := "0001";
   signal ext_ram_en_s                    : std_logic := '0';
   signal ext_ram_we_n_s                  : std_logic;
   signal d_from_ext512_s                 : std_logic_vector( 7 downto 0);


   -- Data and IO bus
   signal io_decode_s                     : std_logic_vector( 2 downto 0);
   signal cpu_data_mux_s                  : std_logic_vector( 7 downto 0);
   signal io_data_mux_s                   : std_logic_vector( 7 downto 0);
   signal ex_data_mux_s                   : std_logic_vector( 7 downto 0);





   -- Address Decoder
   signal mem_access_s     : std_logic;
   signal io_access_s      : std_logic;
   signal io_read_s        : std_logic;
   signal io_write_s       : std_logic;

   -- machine id
   signal machine_id_cs_s  : std_logic;
   constant machine_id_c   : std_logic_vector( 7 downto 0) := std_logic_vector(to_unsigned(num_maq_g, 8));

   -- Config port
   signal cfg_port_cs_s    : std_logic;
   signal cfg_page_cs_s    : std_logic;
   signal cfg_page_r       : std_logic_vector( 7 downto 0);

   -- Loader
   signal bios_ram_cs_s    : std_logic;
   signal loader_ce_s      : std_logic;
   signal d_from_loader_s  : std_logic_vector( 7 downto 0);
   signal loader_q         : std_logic;
   signal multcart_q       : std_logic;

   -- Internal BIOS
   signal d_from_bios_s    : std_logic_vector( 7 downto 0);
   signal bios_addr_s      : std_logic_vector(12 downto 0);
   signal bios_ce_s        : std_logic;
   signal bios_oe_s        : std_logic;
   signal bios_we_s        : std_logic;




   signal bios_ram_bs_s    : std_logic :='1';
   signal exp_ram_bs_s     : std_logic;
   signal exp_ram_cs_s     : std_logic;


   -- COURTNEY signal
   signal wsg_native_q     : std_logic := '0';





   -- Controller signals
   signal d_from_ctrl_s    : std_logic_vector( 7 downto 0);
   signal ctrl_r_n_s       : std_logic;
   signal ctrl_en_key_n_s  : std_logic;
   signal ctrl_en_joy_n_s  : std_logic;
   signal ctrl_int_n_s     : std_logic;

   -- SDcard SPI
   signal d_from_sd_s      : std_logic_vector( 7 downto 0);
   signal sd_cs_s          : std_logic;
   signal sd_wr_s          : std_logic;
   signal sd_rd_s          : std_logic;

   -- Cartridge
   signal d_from_cart_s    : std_logic_vector( 7 downto 0);
   signal cart_oe_n_s      : std_logic;

   signal ext_cart_en_q    : std_logic;
   signal cart_en_80_n_s   : std_logic;
   signal cart_en_a0_n_s   : std_logic;
   signal cart_en_c0_n_s   : std_logic;
   signal cart_en_e0_n_s   : std_logic;
   signal ext_cart_ce_s    : std_logic;
   signal cart_ce_s        : std_logic;
   signal cart_oe_s        : std_logic;
   signal cart_we_s        : std_logic;


begin

   -- Active-low version of the soft reset.
   reset_n_s <= not reset_i;

   --
   -- Instruction Fetch Wait State Generator.
   --
   -- TODO: Matthew H, Mar 16, 2019
   -- The real ColecoVision has what seems to be a circuit that creates a
   -- wait-state for instruction fetches.  The measured signals on this
   -- circuit are very odd, and the HDL below is not accurate (and never
   -- would have created the single wait-state during the instruction
   -- fetch-cycle to begin with).
   --
   -- It is also unclear why the ColecoVision would have a wait-state on
   -- instruction fetch only, with all other memory accesses not having
   -- the wait-state.
   --
   -- Leaving this out for now.
--   m1_wait: process (clock_i, reset_n_s, m1_n_s)
--   begin
--      if reset_n_s = '0' or m1_n_s = '1' then
--         m1_wait_q   <= '0';
--      elsif rising_edge(clock_i) then
--         if clk_en_3m58_i = '1' then
--            m1_wait_q <= not m1_wait_q;
--         end if;
--      end if;
--   end process m1_wait;

   -- TODO: Matthew H, March 19, 2019
   -- Why is the wait being created via the clock enable instead of the
   -- real WAIT_n input to the CPU?  Is the T80 core WAIT_n broken?
   --
   -- Modified CPU clock enable based on slow devices or the wait state.
--   clk_en_cpu_s <= clk_en_3m58_i and sn489_ready_s and not m1_wait_q;
   clk_en_cpu_s <= clk_en_3m58_i and sn489_ready_s;

   -- CPU maskable interrupt input, currently only the controllers.
   int_n_s <= ctrl_int_n_s;

   --
   -- Z80 CPU, synchronous top level with clock enable
   --

   -- TODO: switch back to async Z80 because it registers its outputs.

   inst_t80 : entity work.t80se
   port map (
      RESET_n  => reset_n_s,           -- in std_logic;
      CLK_n    => clock_i,             -- in std_logic;  21.47727 (21.739) MHz
      CLKEN    => clk_en_cpu_s,        -- in std_logic;
      WAIT_n   => '1',                 -- in std_logic;
      INT_n    => int_n_s,             -- in std_logic;
      NMI_n    => nmi_n_s,             -- in std_logic;
      BUSRQ_n  => '1',                 -- in std_logic;
      M1_n     => m1_n_s,              -- out std_logic;
      MREQ_n   => mreq_n_s,            -- out std_logic;
      IORQ_n   => iorq_n_s,            -- out std_logic;
      RD_n     => rd_n_s,              -- out std_logic;
      WR_n     => wr_n_s,              -- out std_logic;
      RFSH_n   => rfsh_n_s,            -- out std_logic;
      HALT_n   => open,                -- out std_logic;
      BUSAK_n  => open,                -- out std_logic;
      A        => cpu_addr_s,          -- out std_logic_vector(15 downto 0);
      DI       => d_to_cpu_s,          -- in std_logic_vector(7 downto 0);
      DO       => d_from_cpu_s         -- out std_logic_vector(7 downto 0)
   );


   -- TODO: hold the system reset longer than the F18A reset.
   --
   -- F18A VDP
   --
   -- The soft button reset is sent to the F18A (unlike the real CV) to ensure
   -- a game will not leave enhanced F18A settings enabled which will cause
   -- problems for legacy or non-F18A games.
   --
   inst_f18a : entity work.f18a_core
   port map (
      clk_100m0_i    => clk_100m0_i,   -- in  std_logic;
      clk_25m0_i     => clk_25m0_i,    -- in  std_logic;

      -- 9918A to Host interface
      reset_n_i      => reset_n_s,     -- in  std_logic; F18A get soft reset
      mode_i         => cpu_addr_s(0), -- in  std_logic;
      csw_n_i        => vdp_w_n_s,     -- in  std_logic;
      csr_n_i        => vdp_r_n_s,     -- in  std_logic;
      int_n_o        => nmi_n_s,       -- out std_logic;
      cd_i           => d_from_cpu_s,  -- in  std_logic_vector(0 to 7);
      cd_o           => d_from_vdp_s,  -- out std_logic_vector(0 to 7);

      -- Video Output
      blank_o        => blank_o,       -- out std_logic;
      hsync_o        => hsync_n_o,     -- out std_logic;
      vsync_o        => vsync_n_o,     -- out std_logic;
      red_o          => red_o,         -- out std_logic_vector(0 to 3);
      grn_o          => grn_o,         -- out std_logic_vector(0 to 3);
      blu_o          => blu_o,         -- out std_logic_vector(0 to 3);

      -- Feature Selection
      sprite_max_i   => '0',           -- in std_logic;   -- Default sprite max, '0' = 32, '1' = 4
      scanlines_i    => '0',           -- in std_logic;   -- Simulated scan lines, '0' = no, '1' = yes

      -- SPI to GPU
      spi_clk_o      => open,          -- out std_logic
      spi_cs_o       => open,          -- out std_logic;
      spi_mosi_o     => open,          -- out std_logic;
      spi_miso_i     => '0'            -- in  std_logic;
   );


   --
   -- SN76489 Programmable Sound Generator
   --
   psg_b : entity work.sn76489_top
   generic map (
      clock_div_16_g => 1
   )
   port map (
      clock_i     => clock_i,
      clock_en_i  => clk_en_3m58_i,
      res_n_i     => reset_n_s,
      ce_n_i      => sn489_we_n_s,
      we_n_i      => sn489_we_n_s,
      ready_o     => sn489_ready_s,
      d_i         => d_from_cpu_s,
      aout_o      => audio_s
   );

   --audio_o         <= std_logic_vector(audio_s);
   --audio_signed_o  <= audio_s;

   AUDIO_EX    <= signed(AUDIO_WSG - 128);
--   AUDIO_SUM      <= (audio_s(7) & audio_s) + (AUDIO_EX(7) & AUDIO_EX);
   AUDIO_EX_A	<= signed(unsigned(ay_ch_a_s) - 128);
	AUDIO_EX_B	<= signed(unsigned(ay_ch_b_s) - 128);
	AUDIO_EX_C	<= signed(unsigned(ay_ch_c_s) - 128);

   AUDIO_SUM   <= (   audio_s(7) & audio_s) +
                  (AUDIO_EX_A(7) & AUDIO_EX_A(7) & AUDIO_EX_A(7) & AUDIO_EX_A(7 downto 2)) +
                  (AUDIO_EX_B(7) & AUDIO_EX_B(7) & AUDIO_EX_B(7) & AUDIO_EX_B(7 downto 2)) +
                  (AUDIO_EX_C(7) & AUDIO_EX_C(7) & AUDIO_EX_C(7) & AUDIO_EX_C(7 downto 2));

   audio_o        <= (others => '0'); --std_logic_vector(AUDIO_SUM); -- OPEN
   audio_signed_o <= AUDIO_SUM(8 downto 1);

   --
   -- COURTNEY (SEX 7264) WAVETABLE SOUND GENERATOR (WSG)
   --
--   WSG : ENTITY work.SEX7264
--   PORT MAP
--   (
--       CLK         => clock_i      ,
--       CLKENA      => clk_en_3m58_i, -- WARNING
--      nRESET       => reset_n_s    ,
--       BDIR        => wsg_bdir_s   ,
--       BC1         => wsg_bc_s     ,
--       DAI         => d_from_cpu_s ,
--       DAO         => d_from_wsg_s ,
--       NATIVE      => wsg_native_q ,
--       DIGITAL_MIX => AUDIO_WSG
--   );

   -- YM-2149, SGM Audio AY-8910 compatible
   ym2149_inst: entity work.YM2149
   port map (
      CLK         => clock_i,
      CE          => clk_en_3m58_i,
      RESET       => reset_i,
      BDIR        => wsg_bdir_s,
      BC          => wsg_bc_s,
      DI          => d_from_cpu_s,
      DO          => d_from_wsg_s,
      CHANNEL_A   => ay_ch_a_s,
      CHANNEL_B   => ay_ch_b_s,
      CHANNEL_C   => ay_ch_c_s,

      SEL         => '0',
      MODE        => '0',

      ACTIVE      => open,

      IOA_in      => x"00",
      IOA_out     => open,

      IOB_in      => x"00",
      IOB_out     => open
   );


   --
   -- Controller ports
   --
   ctrl_b : entity work.cv_ctrl
   port map (
      clk_21m47_i       => clock_i,
      clk_en_3m58_i     => clk_en_3m58_i,
      reset_n_i         => reset_n_s,
      ctrl_en_key_n_i   => ctrl_en_key_n_s,
      ctrl_en_joy_n_i   => ctrl_en_joy_n_s,
      ctrl_p1_i         => ctrl_p1_i,
      ctrl_p2_i         => ctrl_p2_i,
      ctrl_p3_i         => ctrl_p3_i,
      ctrl_p4_i         => ctrl_p4_i,
      ctrl_p5_o         => ctrl_p5_o,
      ctrl_p6_i         => ctrl_p6_i,
      ctrl_p7_i         => ctrl_p7_i,
      ctrl_p8_o         => ctrl_p8_o,
      ctrl_p9_i         => ctrl_p9_i,
      ctrl_sel_i        => cpu_addr_s(1), -- A1=0 read controller 1, A1=1 read controller 2
      ctrl_d_o          => d_from_ctrl_s,
      ctrl_int_n_o      => ctrl_int_n_s
   );


   --
   -- SDcard SPI
   --
   -- TODO: Really use the *enable* as the clock input?
   --
   sd: entity work.spi
   port map (
      clock_i        => clk_en_3m58_i,
      reset_i        => reset_i,
      addr_i         => cpu_addr_s(0),
      cs_i           => sd_cs_s,
      wr_i           => sd_wr_s,
      rd_i           => sd_rd_s,
      data_i         => d_from_cpu_s,
      data_o         => d_from_sd_s,
      -- SD card interface
      spi_cs_o       => sd_cs_n_o,
      spi_sclk_o     => sd_sclk_o,
      spi_mosi_o     => sd_mosi_o,
      spi_miso_i     => sd_miso_i,
      sd_cd_n_i      => sd_cd_n_i      -- Card detect, active low.
   );

   sd_wr_s <= not wr_n_s;
   sd_rd_s <= not rd_n_s;


   --
   -- Loader ROM
   --
   lr: entity work.loaderrom
   port map (
      clk      => clock_i,
      addr     => cpu_addr_s(12 downto 0),
      data     => d_from_loader_s
   );


   --
   -- CV Internal BIOS
   --
   bios: entity work.colecobios
   port map (
      clock_i     => clock_i,
      we_i        => bios_we_s,
      addr_i      => cpu_addr_s(12 downto 0),
      data_i      => d_from_cpu_s,
      data_o      => d_from_bios_s
   );

   -- TODO: Logic for allowing BIOS to be written to.
   bios_we_s <= '0';


   --
   -- CV Internal 1K RAM
   --
   cv_ram_1k : process (clock_i, cv_ram1k_en_s, cv_ram1k_addr_s, wr_n_s)
   begin
   if rising_edge(clock_i) then
      if cv_ram1k_en_s = '1' then
         if wr_n_s = '0' then
            cv_ram_1k_r(to_integer(unsigned(cv_ram1k_addr_s))) <= d_from_cpu_s;
         end if;
         d_from_cv_ram1k_r <= cv_ram_1k_r(to_integer(unsigned(cv_ram1k_addr_s)));
      end if;
   end if;
   end process;

   cv_ram1k_addr_s <= cpu_addr_s(9 downto 0);


   --
   -- External SRAM, 512Kx8, 10ns
   --
   -- When the SGM is enabled, the full 64K address space of the
   -- Z80 will map to physical RAM.  The real SGM only provides
   -- 24K to 32K of RAM in the lower 32K address space, but the
   -- extra memory should not bother anything.
   ext512 : entity work.ext512x8sram
   port map (
      clk_i          => clock_i,
      -- Z80 CPU
      cpu_addr_i     => ext_ram_addr_s,
      cpu_en_i       => ext_ram_en_s,        -- Active high
      cpu_we_n_i     => ext_ram_we_n_s,      -- Active low
      cpu_data_i     => d_from_cpu_s,
      cpu_data_o     => d_from_ext512_s,

      -- External SRAM Interface
      sram_addr_o    => sram_addr_o,
      sram_data_io   => sram_data_io,
      sram_ce_n_o    => sram_ce_n_o,
      sram_oe_n_o    => sram_oe_n_o,
      sram_we_n_o    => sram_we_n_o
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
      cpu_data_mux_s when (mreq_n_s = '0' and rfsh_n_s = '1') else
      io_data_mux_s when cpu_addr_s(7) = '1' else  -- Ports >80 .. >FF
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

   process ( cpu_addr_s, mreq_n_s, rfsh_n_s, wr_n_s,
             d_from_bios_s, d_from_cv_ram1k_r, cart_data_io,
             d_from_ext512_s, sgm_en_r, sgm_8k_en_r,
             ext_ram_bank_r )
   begin

      bios_ce_s      <= '0';  -- Used?

      cv_ram1k_en_s  <= '0';

      cart_en_80_n_s <= '1';
      cart_en_A0_n_s <= '1';
      cart_en_C0_n_s <= '1';
      cart_en_E0_n_s <= '1';

      -- Default to data from a cartridge.
      cpu_data_mux_s <= cart_data_io;

      -- TODO: possibly relocate SGM to the top of the external SRAM if it
      --       makes supporting the MegaCart banking easier.
      -- External 512K SRAM.  Select the SGM (bank 0000) or cartridge loaded
      -- from the SD card.
      if cpu_addr_s(15) = '0' then
         ext_ram_addr_s <= "0000" & cpu_addr_s(14 downto 0);
      else
         ext_ram_addr_s <= ext_ram_bank_r & cpu_addr_s(14 downto 0);
      end if;

      ext_ram_en_s   <= '0';
      ext_ram_we_n_s <= '1';


      -- Memory access that is not a refresh cycle.
      if mreq_n_s = '0' and rfsh_n_s = '1' then

         -- TODO: Add enabled when loaded from SD card.
         -- External SRAM is enabled during a memory cycle when the
         -- SGM is enabled or the cartridge was loaded from the SD card.
         ext_ram_en_s <= sgm_en_r; -- or cart_from_sd_en_r;

         case cpu_addr_s(15 downto 13) is

         when "000" =>                 -- 8K  >0000 .. >1FFF   BIOS or SGM RAM

            -- The SGM must be enabled to be able to switch the BIOS for 8K RAM.
            if sgm_8k_en_r = '0' or sgm_en_r = '0' then
               bios_ce_s      <= '1';
               cpu_data_mux_s <= d_from_bios_s;
            else
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "001" |                  -- 16K >2000 .. >5FFF   SGM 24K RAM, if enabled
              "010" =>

            if sgm_en_r = '1' then
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "011" =>                 -- 8K  >6000 .. >7FFF   CV 1K or SGM 24K RAM

            if sgm_en_r = '0' then
               cv_ram1k_en_s  <= '1';
               cpu_data_mux_s <= d_from_cv_ram1k_r;
            else
               ext_ram_we_n_s <= wr_n_s;
               cpu_data_mux_s <= d_from_ext512_s;
            end if;

         when "100" =>  cart_en_80_n_s <= '0';           -- 8K  >8000 .. >9FFF
         when "101" =>  cart_en_A0_n_s <= '0';           -- 8K  >A000 .. >BFFF
         when "110" =>  cart_en_C0_n_s <= '0';           -- 8K  >C000 .. >DFFF
         when "111" =>  cart_en_E0_n_s <= '0';           -- 8K  >E000 .. >FFFF

         when others => null;
         end case;
      end if;
   end process;

   cart_oe_n_s <= cart_en_80_n_s and cart_en_A0_n_s and cart_en_C0_n_s and cart_en_E0_n_s;


   -- CV I/O Decode
   --
   -- A7 A6 A5 WR
   -- EN 4  2  1
   -- -----------
   -- 1  0  0  0  >80 .. >9F  (W) set controllers to keypad mode
   -- 1  0  0  1  >80 .. >9F  (R) not connected
   -- 1  0  1  0  >A0 .. >BF  (W) VDP csw_n, A0==mode
   -- 1  0  1  1  >A0 .. >BF  (R) VDP csr_n, A0==mode
   -- 1  1  0  0  >C0 .. >DF  (W) set controllers to joystick mode
   -- 1  1  0  1  >C0 .. >DF  (R) not connected
   -- 1  1  1  0  >E0 .. >FF  (W) sound chip (SN76489A)
   -- 1  1  1  1  >E0 .. >FF  (R) read controller data, A1=0 read controller 1, A1=1 read controller 2
   --

   io_decode_s <= cpu_addr_s(6 downto 5) & wr_n_s;

   process ( cpu_addr_s, io_decode_s, iorq_n_s, m1_n_s,
             d_from_ctrl_s, d_from_vdp_s )
   begin
      vdp_w_n_s         <= '1';
      vdp_r_n_s         <= '1';
      sn489_we_n_s      <= '1';
      ctrl_en_key_n_s   <= '1';
      ctrl_en_joy_n_s   <= '1';
      io_data_mux_s     <= d_from_ctrl_s;

      if iorq_n_s = '0' and m1_n_s = '1' and cpu_addr_s(7) = '1' then
         case io_decode_s is
         when "000" =>  ctrl_en_key_n_s   <= '0';
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
   --  >50  xxxxxxxx (W) WSG / SGM-PSG Address Write
   --  >51  xxxxxxxx (W) WSG / SGM-PSG Data Write
   --  >52  xxxxxxxx (R) WSG / SGM-PSG Data Read
   --  >53  xxxxxxxN (W) 0 = SGM disable, 1 = SGM enable
   --       xxxxxxNx (W) 0 = SGM Sound AY-8910, 1 = SGM Sound SEX-7264
   --
   --  >56  xxxxxxxN (W) SPI Control CE_n
   --       xxxxxxxN (R) SPI Control SD-Card Detect input
   --  >57  NNNNNNNN (W) SPI Data Write
   --       xxxxxxxx (R) SPI Data Read
   --
   --  >7F  xxxxxxNx (W) 0 = 8K SGM RAM, 1 = 8K CV BIOS
   --
   process ( cpu_addr_s, iorq_n_s, m1_n_s, wr_n_s, rd_n_s,
             d_from_cpu_s, d_from_wsg_s, sgm_en_r, sgm_8k_en_r,
             ext_ram_bank_r )
   begin
      sgm_en_x    <= sgm_en_r;
      sgm_8k_en_x <= sgm_8k_en_r;

      ext_ram_bank_x <= ext_ram_bank_r;

      wsg_bdir_s     <= '0';  -- bus direction
      wsg_bc_s       <= '0';  -- bus control

      ex_data_mux_s  <= (others => '0');

      if iorq_n_s = '0' and m1_n_s = '1' then
         case cpu_addr_s(7 downto 4) is

         when x"5" =>
            case cpu_addr_s(3 downto 0) is

            when x"0" =>
               if wr_n_s = '0' then
                  wsg_bdir_s  <= '1';
                  wsg_bc_s    <= '1';
               end if;

            when x"1" =>
               if wr_n_s = '0' then
                  wsg_bdir_s  <= '1';
               end if;

            when x"2" =>
               if rd_n_s = '0' then
                  wsg_bc_s       <= '1';
                  ex_data_mux_s  <= d_from_wsg_s;
               end if;

            when x"3" =>
               if wr_n_s = '0' then
                  sgm_en_x <= d_from_cpu_s(0);
               end if;

-- TODO: ports 54 .. 58
--            when x"4" =>
--            when x"5" =>
--            when x"6" =>
--            when x"7" =>
--            when x"8" =>

            when others => null;
            end case;

         when others => null;
         end case;

         if cpu_addr_s(7 downto 0) = x"7F" and wr_n_s = '0' then
            -- The SGM 8K enable, active high.
            sgm_8k_en_x <= not d_from_cpu_s(1);
         end if;
      end if;
   end process;

   process (clock_i, reset_i, clk_en_3m58_i)
   begin
   if rising_edge(clock_i) then
      if reset_i = '1' then
         sgm_en_r       <= '0';
         sgm_8k_en_r    <= '0';
         ext_ram_bank_r <= (others => '0');

      elsif clk_en_3m58_i = '1' then
         sgm_en_r       <= sgm_en_x;
         sgm_8k_en_r    <= sgm_8k_en_x;
         ext_ram_bank_r <= ext_ram_bank_x;

      end if;
   end if;
   end process;

-- Power on or reset:
-- Phoenix BIOS
-- If a cart is present

-- EEPROM-based games use an alternative ROM page switch.
-- They are not MegaCarts (0xFFC0+page#) and not SGM multipage ROMs (page# written to 0xFFFF).
-- EEPROM games use 0xFF80/0xFF90/0xFFA0/0xFFB0 to switch 4x16kB pages.

-- WSG mode with SGM on/off in port >53

-- Port >54
-- BIOS write en
--
--

-- Page port          => 54
-- Config Port        => 55
-- SPI (R/W)          => 56 to 57
-- Machine ID read    => 58
















-- synthesis translate_off

   -- Memory
   bios_addr_s <= ram_addr_s(12 downto 0);
   bios_ce_s   <= '1' when ram_addr_s(16 downto 13) = "0000" and ram_ce_s = '1'  else '0';
   bios_we_s   <= '1' when bios_ce_s = '1' and ram_we_s = '1'                    else '0';

   d_to_cv_s   <= d_from_bios_s when bios_ce_s = '1' else d_from_ram_s;


   -- MUX data CPU
   d_to_cpu_s  <= -- Memory
      d_from_loader_s   when loader_ce_s = '1'     else
      ram_data_i        when bios_ce_s = '1'       else
      ram_data_i        when ram_ce_s  = '1'       else
      ram_data_i        when cart_ce_s = '1'       else
      cart_data_io      when ext_cart_ce_s = '1'   else
      -- I/O
      d_from_vdp_s      when vdp_r_n_s = '0'       else
      d_from_ctrl_s     when ctrl_r_n_s = '0'      else
      d_from_sd_s       when sd_cs_s = '1'         else
      d_from_wsg_s      when WSG_CS = '1'          else
      machine_id_c      when machine_id_cs_s = '1' else
      cfg_page_r        when cfg_page_cs_s = '1'   else
      (others => '1');

   -----------------------------------------------------------------------------
   -- Misc outputs
   -----------------------------------------------------------------------------
   loader_ce_s    <= not rd_n_s and bios_ce_s   when loader_q = '1'  else '0';
   bios_we_s      <= not wr_n_s and bios_ce_s   when loader_q = '1'  else '0';
   bios_oe_s      <= not rd_n_s and bios_ce_s;

   cart_ce_s      <= not (cart_en_80_n_s and cart_en_A0_n_s and cart_en_C0_n_s and cart_en_E0_n_s) and not ext_cart_en_q;
   ext_cart_ce_s  <= not (cart_en_80_n_s and cart_en_A0_n_s and cart_en_C0_n_s and cart_en_E0_n_s) and     ext_cart_en_q;
   cart_oe_s      <= (not rd_n_s) and cart_ce_s;
   cart_we_s      <= (not wr_n_s) and cart_ce_s    when multcart_q = '1'   else '0';

   -- RAM map
   --                                 1 1111 11
   --                                 6 5432 1098 7654 3210
   --                                 - ---- ---- ---- ----
   -- 00000 - 01FFF = SGM RAM   ( 8K) 0 000x xxxx xxxx xxxx
   -- 02000 - 07FFF = RAM       (24K) 0 0ppp xxxx xxxx xxxx ppp = 010 to 111
   -- 08000 - 0FFFF = Multicart (32K) 0 1xxx xxxx xxxx xxxx
   -- 10000 - 17FFF = Cartridge (32K) 1 0xxx xxxx xxxx xxxx
   -- 18000 - 19FFF = BIOS      ( 8K) 1 100x xxxx xxxx xxxx
   --
   ram_addr_o     <=
   --  1111111
   --  6543210
      "1100"    & cpu_addr_s(12 downto 0) when bios_ce_s = '1'                               else  -- 0000-1FFF
--    "0001"    & cpu_addr_s(12 downto 0) when ram_ce_s = '1'  and multcart_q = '1' and exp_ram_bs_s = '0'        else  -- 8K linear RAM
      "00"      & cpu_addr_s(14 downto 0) when ram_ce_s = '1'                                                     else  -- 24K linear RAM
----  "000"     & cpu_addr_s(13 downto 0) when ram_ce_s = '1'                                                     else  -- 24K linear RAM
--    "0001100" & cpu_addr_s( 9 downto 0) when ram_ce_s = '1'  and multcart_q = '0' and exp_ram_bs_s = '0'        else  -- 1K mirrored RAM
      "01"      & cpu_addr_s(14 downto 0) when cart_ce_s = '1' and loader_q = '1'                                 else
      "01"      & cpu_addr_s(14 downto 0) when cart_ce_s = '1' and multcart_q = '1' and cart_oe_s = '1'           else
      "10"      & cpu_addr_s(14 downto 0) when cart_ce_s = '1' and multcart_q = '1' and cart_we_s = '1'           else
      "10"      & cpu_addr_s(14 downto 0) when cart_ce_s = '1' and multcart_q = '0'                               else
      (others => '0');

   ram_data_o     <= d_from_cpu_s;
   ram_ce_o       <= ram_ce_s or bios_ce_s or cart_ce_s;
   ram_we_o       <= (not wr_n_s and ram_ce_s) or bios_we_s or cart_we_s;
   ram_oe_o       <= (not rd_n_s and ram_ce_s) or bios_oe_s or cart_oe_s;

   cart_addr_o    <= cpu_addr_s(14 downto 0);
-- cart_oe_n_o    <= not cart_oe_s;
   cart_oe_n_o    <= '0';
   cart_dir_o     <= '0' when ext_cart_ce_s = '1' and rd_n_s  else '1';
   cart_data_io   <= (others => 'Z') when cart_dir_o = '0' else d_from_cpu_s;
   cart_en_80_n_o <= cart_en_80_n_s or rd_n_s   when ext_cart_en_q = '1'   else '1';
   cart_en_a0_n_o <= cart_en_A0_n_s or rd_n_s   when ext_cart_en_q = '1'   else '1';
   cart_en_c0_n_o <= cart_en_C0_n_s or rd_n_s   when ext_cart_en_q = '1'   else '1';
   cart_en_e0_n_o <= cart_en_E0_n_s or rd_n_s   when ext_cart_en_q = '1'   else '1';

   -- Address decoding
   mem_access_s   <= '1'   when mreq_n_s = '0' and rfsh_n_s = '1'                   else '0';
   io_access_s    <= '1'   when iorq_n_s = '0' and m1_n_s = '1'                     else '0';
   io_read_s      <= '1'   when iorq_n_s = '0' and m1_n_s = '1' and rd_n_s = '0'    else '0';
   io_write_s     <= '1'   when iorq_n_s = '0' and m1_n_s = '1' and wr_n_s = '0'    else '0';

   -- memory
   bios_ce_s      <= '1'   when mem_access_s = '1' and cpu_addr_s(15 downto 13) = "000" and bios_ram_bs_s = '1'   else '0';   -- BIOS         => 0000 to 1FFF
   ram_ce_s       <= '1'   when mem_access_s = '1' and (cpu_addr_s(15 downto 14) = "01" or cpu_addr_s(15 downto 13) = "001" or (cpu_addr_s(15 downto 13) = "000" and bios_ram_bs_s = '0'))      else '0';   -- RAM          => 6000 to 7FFF
   cart_en_80_n_s <= '0'   when mem_access_s = '1' and cpu_addr_s(15 downto 13) = "100"      else '1';   -- Cartridge 80 => 8000 to 9FFF
   cart_en_a0_n_s <= '0'   when mem_access_s = '1' and cpu_addr_s(15 downto 13) = "101"      else '1';   -- Cartridge A0 => A000 to BFFF
   cart_en_c0_n_s <= '0'   when mem_access_s = '1' and cpu_addr_s(15 downto 13) = "110"      else '1';   -- Cartridge C0 => C000 to DFFF
   cart_en_e0_n_s <= '0'   when mem_access_s = '1' and cpu_addr_s(15 downto 13) = "111"      else '1';   -- Cartridge E0 => E000 to FFFF

   -- I/O
   sd_cs_s           <= '1'   when io_access_s = '1' and cpu_addr_s(7 downto 1) = "0101011"  else '0';   -- SPI (R/W)          => 56 to 57
-- exp_ram_cs_s      <= '1'   when io_write_s = '1'  and cpu_addr_s(7 downto 0) = X"53"      else '0';   -- SGM 24k ram enable => 53
   cfg_page_cs_s     <= '1'   when io_access_s = '1' and cpu_addr_s(7 downto 0) = X"54"      else '0';   -- Page port          => 54
   cfg_port_cs_s     <= '1'   when io_write_s = '1'  and cpu_addr_s(7 downto 0) = X"55"      else '0';   -- Config Port        => 55
   machine_id_cs_s   <= '1'   when io_read_s = '1'   and cpu_addr_s(7 downto 0) = X"58"      else '0';   -- Machine ID read    => 58
   bios_ram_cs_s     <= '1'   when io_write_s = '1'  and cpu_addr_s(7 downto 0) = X"7F"      else '0';   -- SGM BIOS ram bankswitch => 7F
   ctrl_en_key_n_s   <= '0'   when io_write_s = '1'  and cpu_addr_s(7 downto 5) = "100"      else '1';   -- Controller key set => 80 to 9F
   vdp_w_n_s         <= '0'   when io_write_s = '1'  and cpu_addr_s(7 downto 5) = "101"      else '1';   -- VDP write          => A0 to BF
   vdp_r_n_s         <= '0'   when io_read_s = '1'   and cpu_addr_s(7 downto 5) = "101"      else '1';   -- VDP read           => A0 to BF
   ctrl_en_joy_n_s   <= '0'   when io_write_s = '1'  and cpu_addr_s(7 downto 5) = "110"      else '1';   -- Controller joy set => C0 to DF
   psg_we_n_s        <= '0'   when io_write_s = '1'  and cpu_addr_s(7 downto 5) = "111"      else '1';   -- PSG write          => E0 to FF
   WSG_CS            <= '1'   when io_access_s = '1' and cpu_addr_s(7 downto 2) = "010100"   else '0';   -- WSG (R/W)          => 60 to 63
   WSG_BDIR          <= '1'   when WSG_CS = '1'      and io_write_s = '1'                    else '0';   -- WSG write          => 60 to 61
   WSG_BC1           <= '1'   when WSG_CS = '1'      and cpu_addr_s(0) = '0'                 else '0';   -- WSG write          => 60/62
   ctrl_r_n_s        <= '0'   when io_read_s = '1'   and cpu_addr_s(7 downto 5) = "111"      else '1';   -- Controller read    => E0 to FF

   -- Write I/O port 55
   process (por_n_i, reset_i, clock_i)
   begin
      if por_n_i = '0' then
         wsg_native_q <= '0';
         ext_cart_en_q  <= '1';
         multcart_q <= '1';
         loader_q   <= '1';
      elsif reset_i = '1' then
         wsg_native_q <= '0';
         multcart_q <= '1';
      elsif rising_edge(clock_i) then
         if clk_en_3m58_i = '1' and cfg_port_cs_s = '1' then
            wsg_native_q   <= d_from_cpu_s(3);
            ext_cart_en_q  <= d_from_cpu_s(2);
            multcart_q <= d_from_cpu_s(1);
            loader_q   <= d_from_cpu_s(0);
         end if;
      end if;
   end process;

   -- Write I/O port 53
   --process (por_n_i, reset_i, clock_i)
   --begin
   -- if por_n_i = '0' then
   --    exp_ram_bs_s   <= '0';
   -- elsif rising_edge(clock_i) then
   --    if clk_en_3m58_i = '1' and exp_ram_cs_s = '1' then
   --       exp_ram_bs_s   <= d_from_cpu_s(0);
   --    end if;
   -- end if;
   --end process;

   -- Write I/O port 7F
   process (por_n_i, reset_i, clock_i)
   begin
      if por_n_i = '0' then
         bios_ram_bs_s  <= '1';
      elsif rising_edge(clock_i) then
         if clk_en_3m58_i = '1' and bios_ram_cs_s = '1' then
            bios_ram_bs_s  <= d_from_cpu_s(1);
         end if;
      end if;
   end process;

   -- Write I/O port 54
   process (por_n_i, clock_i)
   begin
      if por_n_i = '0' then
         cfg_page_r <= (others => '0');
      elsif rising_edge(clock_i) then
         if clk_en_3m58_i = '1' and cfg_page_cs_s = '1' and wr_n_s = '0' then
            cfg_page_r <= d_from_cpu_s;
         end if;
      end if;
   end process;

 -- synthesis translate_on

end architecture;
