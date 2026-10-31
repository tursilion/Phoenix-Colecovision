-- Simulation stand-in for the menu ROM (the real build merges
-- phoenixBoot.rom into the block RAM after synthesis): rom_sim.v.
library ieee;
use ieee.std_logic_1164.all;

entity romloader is
   port ( clock_i : in  std_logic
        ; we_n_i  : in  std_logic
        ; addr_i  : in  std_logic_vector(14 downto 0)
        ; data_i  : in  std_logic_vector( 7 downto 0)
        ; data_o  : out std_logic_vector( 7 downto 0) );
end;

architecture sim of romloader is
   component rom_sim
   port ( clk : in std_logic; addr : in std_logic_vector(14 downto 0)
        ; dout : out std_logic_vector(7 downto 0) );
   end component;
begin
   rom : rom_sim port map ( clk => clock_i, addr => addr_i, dout => data_o );
end architecture;
