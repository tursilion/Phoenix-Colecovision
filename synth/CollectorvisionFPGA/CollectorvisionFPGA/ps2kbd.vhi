
-- VHDL Instantiation Created from source file ps2kbd.vhd -- 14:06:35 08/20/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ps2kbd
	PORT(
		Rst_n : IN std_logic;
		Clk : IN std_logic;
		Tick1us : IN std_logic;
		PS2_Clk : IN std_logic;
		PS2_Data : IN std_logic;          
		Press : OUT std_logic;
		Release : OUT std_logic;
		Reset : OUT std_logic;
		ScanCode : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_ps2kbd: ps2kbd PORT MAP(
		Rst_n => ,
		Clk => ,
		Tick1us => ,
		PS2_Clk => ,
		PS2_Data => ,
		Press => ,
		Release => ,
		Reset => ,
		ScanCode => 
	);


