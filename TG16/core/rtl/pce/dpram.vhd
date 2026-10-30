-- Dual-port block RAM for the Phoenix (Xilinx inference), with the ports of
-- the MiSTer core's altsyncram wrapper: one clock, registered address,
-- read data one clock after the address, read-before-write.  q is
-- disable_value while cs is low.  mem_init_file is ignored: the RAM starts
-- as zeros.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dpram is
	generic (
		addr_width    : integer := 8;
		data_width    : integer := 8;
		mem_init_file : string := " ";
		disable_value : std_logic := '1'
	);
	port (
		clock     : in  std_logic;
		address_a : in  std_logic_vector(addr_width-1 downto 0);
		data_a    : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
		enable_a  : in  std_logic := '1';
		wren_a    : in  std_logic := '0';
		q_a       : out std_logic_vector(data_width-1 downto 0);
		cs_a      : in  std_logic := '1';

		address_b : in  std_logic_vector(addr_width-1 downto 0) := (others => '0');
		data_b    : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
		enable_b  : in  std_logic := '1';
		wren_b    : in  std_logic := '0';
		q_b       : out std_logic_vector(data_width-1 downto 0);
		cs_b      : in  std_logic := '1'
	);
end entity;

architecture rtl of dpram is

	type mem_t is array (0 to 2**addr_width-1) of std_logic_vector(data_width-1 downto 0);

	shared variable mem : mem_t := (others => (others => '0'));
	signal q0, q1 : std_logic_vector(data_width-1 downto 0);

begin

	q_a <= q0 when cs_a = '1' else (others => disable_value);
	q_b <= q1 when cs_b = '1' else (others => disable_value);

	process (clock)
	begin
		if rising_edge(clock) then
			if enable_a = '1' then
				q0 <= mem(to_integer(unsigned(address_a)));
				if wren_a = '1' then
					mem(to_integer(unsigned(address_a))) := data_a;
				end if;
			end if;
		end if;
	end process;

	process (clock)
	begin
		if rising_edge(clock) then
			if enable_b = '1' then
				q1 <= mem(to_integer(unsigned(address_b)));
				if wren_b = '1' then
					mem(to_integer(unsigned(address_b))) := data_b;
				end if;
			end if;
		end if;
	end process;

end architecture;
