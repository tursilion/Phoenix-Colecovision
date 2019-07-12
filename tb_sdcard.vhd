--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:03:39 05/04/2019
-- Design Name:   
-- Module Name:   P:/Code/FPGA/coleco_f18a/collectorvision-game-system/tb_sdcard.vhd
-- Project Name:  collectorvision_ise
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sdcard
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_sdcard IS
END tb_sdcard;
 
ARCHITECTURE behavior OF tb_sdcard IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sdcard
    PORT(
         clk_21m74_i : IN  std_logic;
         reset_i : IN  std_logic;
         slow_clk_i : IN  std_logic;
         cs_n_i : IN  std_logic;
         trig8_n_i : IN  std_logic;
         wr_n_i : IN  std_logic;
         data_i : IN  std_logic_vector(7 downto 0);
         data_o : OUT  std_logic_vector(7 downto 0);
         wait_n_o : OUT  std_logic;
         spi_cs_n_o : OUT  std_logic;
         spi_sclk_o : OUT  std_logic;
         spi_mosi_o : OUT  std_logic;
         spi_miso_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_21m74_i : std_logic := '0';
   signal reset_i : std_logic := '1';
   signal slow_clk_i : std_logic := '0';
   signal cs_n_i : std_logic := '1';
   signal trig8_n_i : std_logic := '1';
   signal wr_n_i : std_logic := '1';
   signal data_i : std_logic_vector(7 downto 0) := (others => '0');
   signal spi_miso_i : std_logic := '0';

 	--Outputs
   signal wait_n_o : std_logic;
   signal data_o : std_logic_vector(7 downto 0);
   signal spi_cs_n_o : std_logic;
   signal spi_sclk_o : std_logic;
   signal spi_mosi_o : std_logic;

   -- Clock period definitions
   constant clk_21m74_i_period : time := 45.88 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sdcard PORT MAP (
          clk_21m74_i => clk_21m74_i,
          reset_i => reset_i,
          slow_clk_i => slow_clk_i,
          cs_n_i => cs_n_i,
          trig8_n_i => trig8_n_i,
          wr_n_i => wr_n_i,
          data_i => data_i,
          data_o => data_o,
          wait_n_o => wait_n_o,
          spi_cs_n_o => spi_cs_n_o,
          spi_sclk_o => spi_sclk_o,
          spi_mosi_o => spi_mosi_o,
          spi_miso_i => spi_miso_i
        );

   -- Clock process definitions
   clk_21m74_i_process :process
   begin
		clk_21m74_i <= '0';
		wait for clk_21m74_i_period/2;
		clk_21m74_i <= '1';
		wait for clk_21m74_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset_i <= '1';
      cs_n_i  <= '1';
      trig8_n_i <= '1';
      wr_n_i <= '1';
      data_i  <= x"9A";
      spi_miso_i <= '1';
      slow_clk_i <= '0';

      wait for clk_21m74_i_period*2;

      -- insert stimulus here 

      reset_i <= '0';
      wait for clk_21m74_i_period*2;

      cs_n_i <= '0';

      wait for clk_21m74_i_period;
      trig8_n_i <= '0';
      wr_n_i <= '0';
      wait until wait_n_o = '0';
      wait until wait_n_o = '1';
      trig8_n_i <= '1';
      wait for clk_21m74_i_period;

      data_i  <= x"5C";

      wait for clk_21m74_i_period;
      trig8_n_i <= '0';
      wr_n_i <= '1';
      wait until wait_n_o = '0';
      wait until wait_n_o = '1';
      trig8_n_i <= '1';
      wait for clk_21m74_i_period;

      cs_n_i <= '1';

      wait;
   end process;

END;
