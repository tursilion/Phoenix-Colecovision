-- Simulation stand-in for the F18A: vdp_spy.v (a TMS9918 register and
-- VRAM model without video).
library ieee;
use ieee.std_logic_1164.all;

entity f18a_core is
   port
   ( clk_100m0_i          : in  std_logic
   ; clk_25m0_i           : in  std_logic
   ; reset_n_i            : in  std_logic
   ; mode_i               : in  std_logic
   ; csw_n_i              : in  std_logic
   ; csr_n_i              : in  std_logic
   ; int_n_o              : out std_logic
   ; cd_i                 : in  std_logic_vector(0 to 7)
   ; cd_o                 : out std_logic_vector(0 to 7)
   ; blank_o              : out std_logic
   ; hsync_o              : out std_logic
   ; vsync_o              : out std_logic
   ; red_o                : out std_logic_vector(0 to 3)
   ; grn_o                : out std_logic_vector(0 to 3)
   ; blu_o                : out std_logic_vector(0 to 3)
   ; sprite_max_i         : in std_logic
   ; scanlines_i          : in std_logic
   ; spi_clk_o            : out std_logic
   ; spi_cs_o             : out std_logic
   ; spi_mosi_o           : out std_logic
   ; spi_miso_i           : in  std_logic
   );
end entity;

architecture sim of f18a_core is
   component vdp_spy
   port ( clk : in std_logic; mode : in std_logic; csw_n : in std_logic; csr_n : in std_logic
        ; din : in std_logic_vector(7 downto 0); dout : out std_logic_vector(7 downto 0)
        ; int_n : out std_logic );
   end component;
   signal din_s, dout_s : std_logic_vector(7 downto 0);
begin
   din_s <= cd_i(0) & cd_i(1) & cd_i(2) & cd_i(3) & cd_i(4) & cd_i(5) & cd_i(6) & cd_i(7);
   cd_o  <= dout_s(7) & dout_s(6) & dout_s(5) & dout_s(4) & dout_s(3) & dout_s(2) & dout_s(1) & dout_s(0);
   spy : vdp_spy port map ( clk => clk_25m0_i, mode => mode_i, csw_n => csw_n_i, csr_n => csr_n_i
                          , din => din_s, dout => dout_s, int_n => int_n_o );
   blank_o <= '0'; hsync_o <= '1'; vsync_o <= '1';
   red_o <= "0000"; grn_o <= "0000"; blu_o <= "0000";
   spi_clk_o <= '0'; spi_cs_o <= '1'; spi_mosi_o <= '0';
end architecture;
