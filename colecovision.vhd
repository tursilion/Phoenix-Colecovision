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
      clock_i        : in  std_logic;        --  21.47727 (21.739) MHz
      clk_100m0_i    : in  std_logic;
      clk_25m0_i     : in  std_logic;
      clk_en_3m58_i  : in  std_logic;
      clk_en_1m79_i  : in  std_logic;
      reset_i        : in  std_logic;        -- Reset, tbem acionado quando por_n_i for 0
      por_n_i        : in  std_logic;        -- Power-on Reset
      -- Controller Interface ---------------------------------------------------
      ctrl_p1_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p2_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p3_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p4_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p5_o      : out std_logic;
      ctrl_p6_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p7_i      : in  std_logic_vector( 2 downto 1);
      ctrl_p8_o      : out std_logic;
      ctrl_p9_i      : in  std_logic_vector( 2 downto 1);
      -- CPU RAM Interface ------------------------------------------------------
      ram_addr_o     : out std_logic_vector(16 downto 0);   -- 128K
      ram_ce_o       : out std_logic;
      ram_oe_o       : out std_logic;
      ram_we_o       : out std_logic;
      ram_data_i     : in  std_logic_vector( 7 downto 0);
      ram_data_o     : out std_logic_vector( 7 downto 0);
      -- Video RAM Interface ----------------------------------------------------
      vram_addr_o    : out std_logic_vector(13 downto 0);   -- 16K
      vram_ce_o      : out std_logic;
      vram_oe_o      : out std_logic;
      vram_we_o      : out std_logic;
      vram_data_i    : in  std_logic_vector( 7 downto 0);
      vram_data_o    : out std_logic_vector( 7 downto 0);
      -- Cartridge ROM Interface ------------------------------------------------
      cart_addr_o    : out std_logic_vector(14 downto 0);   -- 32K
      cart_data_i    : in  std_logic_vector( 7 downto 0);
      cart_oe_n_o    : out std_logic;
      cart_en_80_n_o : out std_logic;
      cart_en_a0_n_o : out std_logic;
      cart_en_c0_n_o : out std_logic;
      cart_en_e0_n_o : out std_logic;
      -- Audio Interface --------------------------------------------------------
      audio_o        : out std_logic_vector(7 downto 0);
      audio_signed_o : out signed(7 downto 0);
      -- VGA Video Output ----------------------------------------------------
      blank_o        : out std_logic;
      hsync_n_o      : out std_logic;
      vsync_n_o      : out std_logic;
      red_o          : out std_logic_vector( 3 downto 0);
      grn_o          : out std_logic_vector( 3 downto 0);
      blu_o          : out std_logic_vector( 3 downto 0);
      -- SPI
      spi_miso_i     : in  std_logic;
      spi_mosi_o     : out std_logic;
      spi_sclk_o     : out std_logic;
      spi_cs_n_o     : out std_logic;
      sd_cd_n_i      : in  std_logic;
      -- DEBUG
      D_cpu_addr     : out std_logic_vector(15 downto 0)
   );

end entity;

-- pragma translate_off
use std.textio.all;
-- pragma translate_on

architecture Behavior of colecovision is

   -- Reset
   signal reset_n_s        : std_logic;

   -- CPU signals
   signal clk_en_cpu_s     : std_logic;
   signal nmi_n_s          : std_logic;
   signal int_n_s          : std_logic;
   signal iorq_n_s         : std_logic;
   signal m1_n_s           : std_logic;
   signal m1_wait_q        : std_logic;
   signal rd_n_s           : std_logic;
   signal wr_n_s           : std_logic;
   signal mreq_n_s         : std_logic;
   signal rfsh_n_s         : std_logic;
   signal cpu_addr_s       : std_logic_vector(15 downto 0);
   signal d_to_cpu_s       : std_logic_vector( 7 downto 0);
   signal d_from_cpu_s     : std_logic_vector( 7 downto 0);

   -- Address Decoder
   signal mem_access_s     : std_logic;
   signal io_access_s      : std_logic;
   signal io_read_s        : std_logic;
   signal io_write_s       : std_logic;

   -- machine id
   signal machine_id_cs_s  : std_logic;
   constant machine_id_c   : std_logic_vector(7 downto 0)      := std_logic_vector(to_unsigned(num_maq_g, 8));

   -- Config port
   signal cfg_port_cs_s    : std_logic;
   signal cfg_page_cs_s    : std_logic;
   signal cfg_page_r       : std_logic_vector(7 downto 0);

   -- BIOS
   signal bios_ram_cs_s    : std_logic;
   signal loader_ce_s      : std_logic;
   signal d_from_loader_s  : std_logic_vector( 7 downto 0);
   signal loader_q         : std_logic;
   signal multcart_q       : std_logic;
   signal bios_ce_s        : std_logic;
   signal bios_oe_s        : std_logic;
   signal bios_we_s        : std_logic;

   -- RAM
   signal ram_ce_s         : std_logic;
   signal bios_ram_bs_s    : std_logic                         :='1';
   signal exp_ram_bs_s     : std_logic;
   signal exp_ram_cs_s     : std_logic;

   -- F18A signal
   signal d_from_vdp_s     : std_logic_vector( 7 downto 0);
   signal vdp_r_n_s        : std_logic;
   signal vdp_w_n_s        : std_logic;

   -- SN76489 signal
   signal audio_s          : signed(7 downto 0);
   signal psg_ready_s      : std_logic;
   signal psg_we_n_s       : std_logic;

   -- COURTNEY signal
   signal wsg_native_q     : std_logic;

   signal AUDIO_WSG        : unsigned(7 downto 0);
   signal AUDIO_EX         : signed(7 downto 0);
   signal AUDIO_SUM        : signed(8 downto 0);

   signal d_from_wsg_s     : std_logic_vector(7 downto 0);

   signal WSG_CS           : std_logic;
   signal WSG_BDIR         : std_logic;
   signal WSG_BC1          : std_logic;

   -- Controller signals
   signal d_from_ctrl_s    : std_logic_vector( 7 downto 0);
   signal ctrl_r_n_s       : std_logic;
   signal ctrl_en_key_n_s  : std_logic;
   signal ctrl_en_joy_n_s  : std_logic;
   signal ctrl_int_n_s     : std_logic;

   -- SPI
   signal d_from_spi_s     : std_logic_vector( 7 downto 0);
   signal spi_cs_s         : std_logic;
   signal spi_wr_s         : std_logic;
   signal spi_rd_s         : std_logic;

   -- Cartridge
   signal d_from_cart_s    : std_logic_vector( 7 downto 0);
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

   -- CPU
--   cpu: entity work.T80a
--   generic map (
--      mode_g      => 0
--   )
--   port map (
--      clock_i     => clock_i,
--      clock_en_i  => clk_en_cpu_s,
--      reset_n_i   => reset_n_s,
--      address_o   => cpu_addr_s,
--      data_i      => d_to_cpu_s,
--      data_o      => d_from_cpu_s,
--      wait_n_i    => '1',
--      int_n_i     => '1',
--      nmi_n_i     => nmi_n_s,
--      m1_n_o      => m1_n_s,
--      mreq_n_o    => mreq_n_s,
--      iorq_n_o    => iorq_n_s,
--      rd_n_o      => rd_n_s,
--      wr_n_o      => wr_n_s,
--      refresh_n_o => rfsh_n_s,
--      halt_n_o    => open,
--      busrq_n_i   => '1',
--      busak_n_o   => open
--   );

   -- Z80 CPU, synchronous top level with clock enable
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

   -- CPU maskable interrupts, currently only the controllers.
   int_n_s <= ctrl_int_n_s;

   -- Loader
   lr: entity work.loaderrom
   port map (
      clk      => clock_i,
      addr     => cpu_addr_s(12 downto 0),
      data     => d_from_loader_s
   );


   --
   -- F18A
   --

   inst_f18a : entity work.f18a_core
   port map (
      clk_100m0_i    => clk_100m0_i,   -- in  std_logic;
      clk_25m0_i     => clk_25m0_i,    -- in  std_logic;

      -- 9918A to Host interface
      reset_n_i      => por_n_i,       -- in  std_logic;
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


   -----------------------------------------------------------------------------
   -- SN76489 Programmable Sound Generator
   -----------------------------------------------------------------------------
   psg_b : entity work.sn76489_top
   generic map (
      clock_div_16_g => 1
   )
   port map (
      clock_i     => clock_i,
      clock_en_i  => clk_en_3m58_i,
      res_n_i     => reset_n_s,
      ce_n_i      => psg_we_n_s,
      we_n_i      => psg_we_n_s,
      ready_o     => psg_ready_s,
      d_i         => d_from_cpu_s,
      aout_o      => audio_s
   );

   --audio_o         <= std_logic_vector(audio_s);
   --audio_signed_o  <= audio_s;

   AUDIO_EX       <= signed(AUDIO_WSG - 128);
   AUDIO_SUM      <= (audio_s(7) & audio_s) + (AUDIO_EX(7) & AUDIO_EX);

   audio_o        <= (others => '0'); --std_logic_vector(AUDIO_SUM); -- OPEN
   audio_signed_o <= AUDIO_SUM(8 downto 1);

   -----------------------------------------------------------------------------
   -- COURTNEY (SEX 7264) WAVETABLE SOUND GENERATOR (WSG)
   -----------------------------------------------------------------------------
   WSG : ENTITY work.SEX7264
   PORT MAP
   (
       CLK         => clock_i      ,
       CLKENA      => clk_en_3m58_i, -- WARNING
      nRESET       => reset_n_s    ,
       BDIR        => WSG_BDIR     ,
       BC1         => WSG_BC1      ,
       DAI         => d_from_cpu_s ,
       DAO         => d_from_wsg_s ,
       NATIVE      => wsg_native_q ,
       DIGITAL_MIX => AUDIO_WSG
   )
   ;
   -----------------------------------------------------------------------------
   -- Controller ports
   -----------------------------------------------------------------------------
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
   

   -- SPI
   sd: entity work.spi
   port map (
      clock_i        => clk_en_3m58_i,
      reset_i        => reset_i,
      addr_i         => cpu_addr_s(0),
      cs_i           => spi_cs_s,
      wr_i           => spi_wr_s,
      rd_i           => spi_rd_s,
      data_i         => d_from_cpu_s,
      data_o         => d_from_spi_s,
      -- SD card interface
      spi_cs_o       => spi_cs_n_o,
      spi_sclk_o     => spi_sclk_o,
      spi_mosi_o     => spi_mosi_o,
      spi_miso_i     => spi_miso_i,
      sd_cd_n_i      => sd_cd_n_i
   );

   spi_wr_s    <= not wr_n_s;
   spi_rd_s    <= not rd_n_s;

   -- Glue
   reset_n_s      <= not reset_i;
   clk_en_cpu_s   <= clk_en_3m58_i and psg_ready_s and not m1_wait_q;


   -----------------------------------------------------------------------------
   -- Process m1_wait
   --
   -- Purpose:
   --   Implements flip-flop U8A which asserts a wait states controlled by M1.
   --
   m1_wait: process (clock_i, reset_n_s, m1_n_s)
   begin
      if reset_n_s = '0' or m1_n_s = '1' then
         m1_wait_q   <= '0';
      elsif rising_edge(clock_i) then
         if clk_en_3m58_i = '1' then
            m1_wait_q <= not m1_wait_q;
         end if;
      end if;
   end process m1_wait;

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
   spi_cs_s          <= '1'   when io_access_s = '1' and cpu_addr_s(7 downto 1) = "0101011"  else '0';   -- SPI (R/W)          => 56 to 57
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

   -- MUX data CPU
   d_to_cpu_s  <= -- Memory
                  d_from_loader_s            when loader_ce_s = '1'     else
                  ram_data_i                 when bios_ce_s = '1'       else
                  ram_data_i                 when ram_ce_s  = '1'       else
                  ram_data_i                 when cart_ce_s = '1'       else
                  cart_data_i                when ext_cart_ce_s = '1'   else
                  -- I/O
                  d_from_vdp_s               when vdp_r_n_s = '0'       else
                  d_from_ctrl_s              when ctrl_r_n_s = '0'      else
                  d_from_spi_s               when spi_cs_s = '1'        else
                  d_from_wsg_s               when WSG_CS = '1'          else
                  machine_id_c               when machine_id_cs_s = '1' else
                  cfg_page_r                 when cfg_page_cs_s = '1'   else
                  (others => '1');

   -- Debug
   D_cpu_addr  <= cpu_addr_s;


end architecture;
