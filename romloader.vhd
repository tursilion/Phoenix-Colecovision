--
-- Internal ROM Loader
--
-- Set up as a RAM to allow code flexibility.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity romloader is
   port (
      clock_i        : in  std_logic;
      we_i           : in  std_logic;
      addr_i         : in  std_logic_vector(13 downto 0);
      data_i         : in  std_logic_vector( 7 downto 0);
      data_o         : out std_logic_vector( 7 downto 0)
   );
end;

architecture rtl of romloader is

   type ram_t is array(0 to 16383) of std_logic_vector(7 downto 0);
   signal ram_q : ram_t := (
      -- Set up the following program in RAM at >6000:
      --
      -- DB 55     IN   A,(0x55)
      -- C3 00 00  JP   0x0000
      --
      -- The loader program:
      x"21",x"0E",x"00", -- 0000   21 0E 00               LD   HL,CODE   
      x"11",x"00",x"60", -- 0003   11 00 60               LD   DE,0x6000   
      x"01",x"05",x"00", -- 0006   01 05 00               LD   BC,ENDCODE-CODE   
      x"ED",x"B0",       -- 0009   ED B0                  LDIR      
      x"C3",x"00",x"60", -- 000B   C3 00 60               JP   0x6000   
                         -- 000E                CODE:        
      x"DB",x"55",       -- 000E   DB 55                  IN   A,(0x55)   
      x"C3",x"00",x"00", -- 0010   C3 00 00               JP   0x0000   
                         -- 0013                ENDCODE:      
      x"00",             -- 0013   00                     DB   0   
      others => (others => '0')
   );

begin

   process (clock_i)
   begin
      if rising_edge(clock_i) then
         if we_i = '1' then
            ram_q(to_integer(unsigned(addr_i))) <= data_i;
         end if;
         data_o <= ram_q(to_integer(unsigned(addr_i)));
      end if;
   end process;

end architecture;
