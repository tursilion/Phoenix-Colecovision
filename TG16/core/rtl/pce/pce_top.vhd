-- PC Engine / TurboGrafx-16 for the Phoenix: the MiSTer core's pce_top.vhd
-- (TurboGrafx16_MiSTer) cut down to a HuCard system: HuC6280 CPU, HuC6260
-- VCE, one HuC6270 VDC and 8K of work RAM.  No CD, Arcade Card, SuperGrafx,
-- Populous RAM, backup RAM or cheats.
--
-- The VDC's 64K of video RAM is outside (VRAM_*): VRAM_A is valid on each
-- DCK_CE (VRAM_CE) and VRAM_DI must hold the word read at that address from
-- the next VRAM_CE on, like a block RAM read once per dot clock.
--
-- The ROM is outside too: ROM_RD asks for the byte at ROM_A, and ROM_RDY low
-- holds the CPU until it is there.
--
-- EXT_*: the I/O page's $1800-$1BFF (the CD's place), for the Phoenix
-- loader.  EXT_WR and EXT_RD pulse at the end of a CPU access there.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pce_top is
	port(
		RESET       : in  std_logic;
		CLK         : in  std_logic;   -- 42.95MHz (12 x 3.58MHz)

		ROM_RD      : out std_logic;
		ROM_RDY     : in  std_logic;
		ROM_A       : out std_logic_vector(21 downto 0);
		ROM_DO      : in  std_logic_vector(7 downto 0);
		ROM_SZ      : in  std_logic_vector(11 downto 0);   -- in 1K units, for the mirroring
		ROM_CLKEN   : out std_logic;

		VRAM_A      : out std_logic_vector(15 downto 0);
		VRAM_DI     : in  std_logic_vector(15 downto 0);
		VRAM_DO     : out std_logic_vector(15 downto 0);
		VRAM_WE     : out std_logic;
		VRAM_CE     : out std_logic;

		EXT_A       : out std_logic_vector(9 downto 0);
		EXT_DI      : in  std_logic_vector(7 downto 0);
		EXT_DO      : out std_logic_vector(7 downto 0);
		EXT_WR      : out std_logic;
		EXT_RD      : out std_logic;

		JOY_OUT     : out std_logic_vector(1 downto 0);
		JOY_IN      : in  std_logic_vector(3 downto 0);

		PSG_SL      : out signed(15 downto 0);
		PSG_SR      : out signed(15 downto 0);

		VIDEO_R     : out std_logic_vector(2 downto 0);
		VIDEO_G     : out std_logic_vector(2 downto 0);
		VIDEO_B     : out std_logic_vector(2 downto 0);
		VIDEO_CE    : out std_logic;
		VIDEO_CE_FS : out std_logic;
		VIDEO_VS    : out std_logic;
		VIDEO_HS    : out std_logic;
		VIDEO_HBL   : out std_logic;
		VIDEO_VBL   : out std_logic;
		VIDEO_HCNT  : out std_logic_vector(11 downto 0);  -- VCE clock in the line (0-2729)
		VIDEO_VCNT  : out std_logic_vector(9 downto 0)    -- VCE line (0-262)
	);
end pce_top;

architecture rtl of pce_top is

signal RESET_N			: std_logic := '0';

-- CPU signals
signal CPU_CE			: std_logic;
signal CPU_RD_N		: std_logic;
signal CPU_WR_N		: std_logic;
signal CPU_DI			: std_logic_vector(7 downto 0);
signal CPU_DO			: std_logic_vector(7 downto 0);
signal CPU_A			: std_logic_vector(20 downto 0);
signal CPU_CLKEN		: std_logic;
signal CPU_VCE_SEL_N	: std_logic;
signal CPU_VDC_SEL_N	: std_logic;
signal CPU_RAM_SEL_N	: std_logic;
signal CPU_IO_DO		: std_logic_vector(7 downto 0);
signal CPU_ROM_SEL_N	: std_logic;
signal CPU_PRE_RD		: std_logic;
signal CPU_PRE_WR		: std_logic;

signal RAM_DO			: std_logic_vector(7 downto 0);
signal RAM_WE			: std_logic;

signal VCE_DO			: std_logic_vector(7 downto 0);

signal VDC0_DO			: std_logic_vector(15 downto 0);
signal VDC0_BUSY_N	: std_logic;
signal VDC0_IRQ_N		: std_logic;
signal VDC0_COLNO		: std_logic_vector(8 downto 0);
signal VDC_CLKEN		: std_logic;
signal VDC_CLKEN_F	: std_logic;
signal VDC_DI			: std_logic_vector(15 downto 0);

signal VS_N				: std_logic;
signal HS_N				: std_logic;
signal VCE_HSYNC_F, VCE_HSYNC_R, VCE_VSYNC_F, VCE_VSYNC_R: std_logic;

signal PCE_SL			: std_logic_vector(23 downto 0);
signal PCE_SR			: std_logic_vector(23 downto 0);

signal CPU_WAIT_N		: std_logic;
signal CPU_IRQ1_N		: std_logic;
signal CPU_K			: std_logic_vector(7 downto 0);
signal VDC0_BORDER	: std_logic;
signal VDC0_GRID		: std_logic_vector(1 downto 0);
signal VCE_BORDER		: std_logic;
signal VCE_GRID		: std_logic_vector(1 downto 0);
signal VIDEO_BW		: std_logic;

signal rombank			: std_logic_vector(1 downto 0);

signal EXT_SEL_N		: std_logic;

begin

CPU_WAIT_N <= ROM_RDY;
CPU_IRQ1_N <= VDC0_IRQ_N;
CPU_K      <= "1011" & JOY_IN;      -- no CD, US region bit as in MiSTer

CPU : entity work.HUC6280
port map(
	CLK 		=> CLK,
	RST_N		=> RESET_N,
	WAIT_N	=> CPU_WAIT_N,

	IRQ1_N	=> CPU_IRQ1_N,
	IRQ2_N	=> '1',
	NMI_N		=> '1',

	DI			=> CPU_DI,
	DO 		=> CPU_DO,

	A 			=> CPU_A,
	WR_N 		=> CPU_WR_N,
	RD_N		=> CPU_RD_N,

	RDY		=> VDC0_BUSY_N,

	CE			=> CPU_CE,
	CEK_N		=> CPU_VCE_SEL_N,
	CE7_N		=> CPU_VDC_SEL_N,
	CER_N		=> CPU_RAM_SEL_N,
	PRE_RD   => CPU_PRE_RD,
	PRE_WR   => CPU_PRE_WR,

	HSM		=> open,

	K			=> CPU_K,
	O			=> CPU_IO_DO,

	VDCNUM   => '0',

	AUD_LDATA=> PCE_SL,
	AUD_RDATA=> PCE_SR
);

JOY_OUT <= CPU_IO_DO(1 downto 0);

CPU_CLKEN <= CPU_CE when rising_edge( CLK );

VIDEO_CE <= VDC_CLKEN;
VIDEO_VS <= not VS_N;
VIDEO_HS <= not HS_N;

VCE : entity work.huc6260
port map(
	CLK 		=> CLK,
	RESET_N	=> RESET_N,

	A			=> CPU_A(2 downto 0),
	CE_N		=> CPU_VCE_SEL_N,
	WR_N		=> CPU_WR_N,
	RD_N		=> CPU_RD_N,
	DI			=> CPU_DO,
	DO 		=> VCE_DO,

	COLNO		=> VDC0_COLNO,
	CLKEN		=> VDC_CLKEN,
	CLKEN_F  => VDC_CLKEN_F,
	HSYNC_F	=> VCE_HSYNC_F,
	HSYNC_R	=> VCE_HSYNC_R,
	VSYNC_F	=> VCE_VSYNC_F,
	VSYNC_R	=> VCE_VSYNC_R,
	CLKEN_FS => VIDEO_CE_FS,
	RVBL		=> '1',     -- 242 lines, from line 19

	GRID_EN	=> "00",
	BORDER_EN=> '0',
	BORDER	=> VCE_BORDER,
	GRID		=> VCE_GRID,

	R			=> VIDEO_R,
	G			=> VIDEO_G,
	B			=> VIDEO_B,
	BW			=> VIDEO_BW,
	VS_N		=> VS_N,
	HS_N		=> HS_N,
	HBL		=> VIDEO_HBL,
	VBL		=> VIDEO_VBL,
	H_CNT_O	=> VIDEO_HCNT,
	V_CNT_O	=> VIDEO_VCNT
);

VCE_BORDER <= VDC0_BORDER;
VCE_GRID   <= VDC0_GRID;

VDC_DI <= "00000000" & CPU_DO;

VDC0 : entity work.HUC6270
port map(
	CLK 		=> CLK,
	RST_N		=> RESET_N,
	CLR_MEM  => '0',

	CPU_CE	=> CPU_CE,
	BYTEWORD => '1',
	A			=> CPU_A(1 downto 0),
	CS_N		=> CPU_VDC_SEL_N,
	WR_N		=> CPU_WR_N,
	RD_N		=> CPU_RD_N,
	DI			=> VDC_DI,
	DO 		=> VDC0_DO,
	BUSY_N	=> VDC0_BUSY_N,
	IRQ_N		=> VDC0_IRQ_N,

	DCK_CE	=> VDC_CLKEN,
	DCK_CE_F => VDC_CLKEN_F,
	HSYNC_F	=> VCE_HSYNC_F,
	HSYNC_R	=> VCE_HSYNC_R,
	VSYNC_F	=> VCE_VSYNC_F,
	VSYNC_R	=> VCE_VSYNC_R,
	VD			=> VDC0_COLNO,

	BORDER	=> VDC0_BORDER,
	GRID		=> VDC0_GRID,
	SP64     => '0',

	RAM_A		=> VRAM_A,
	RAM_DI	=> VRAM_DI,
	RAM_DO	=> VRAM_DO,
	RAM_WE	=> VRAM_WE,

	BG_EN		=> '1',
	SPR_EN	=> '1'
);

VRAM_CE <= VDC_CLKEN;

CPU_ROM_SEL_N <= CPU_A(20);

-- CPU data bus
CPU_DI <= RAM_DO               when CPU_RAM_SEL_N = '0'
			else EXT_DI          when EXT_SEL_N     = '0'
			else ROM_DO          when CPU_ROM_SEL_N = '0'
			else VCE_DO          when CPU_VCE_SEL_N = '0'
			else VDC0_DO(7 downto 0) when CPU_VDC_SEL_N = '0'
			else X"FF";

-- HuCard mirroring (from the MiSTer core):
-- 128K AAAAAAAA, 256K ABABABAB, 384K ABABCCCC, 512K ABCDABCD,
-- 768K ABCDEFEF, 2560K Street Fighter II (banks at $1FF0-$1FF3), others
-- straight.
ROM_A <=   "00000"&CPU_A(16 downto 0)                                       when ROM_SZ = X"080" -- 128K
      else "0000"&CPU_A(17 downto 0)                                        when ROM_SZ = X"100" -- 256K
      else "000"&CPU_A(19)&(CPU_A(17) and not CPU_A(19))&CPU_A(16 downto 0) when ROM_SZ = X"180" -- 384K
      else "000"&CPU_A(18 downto 0)                                         when ROM_SZ = X"200" -- 512K
      else "00" &CPU_A(19)&(CPU_A(18) and not CPU_A(19))&CPU_A(17 downto 0) when ROM_SZ = X"300" -- 768K
      else (CPU_A(19) and (rombank(0) and rombank(1)))
          &(CPU_A(19) and (rombank(0) xor rombank(1)))
          &(CPU_A(19) and not rombank(0))&CPU_A(18 downto 0)                when ROM_SZ = X"A00" -- SF2
      else "00"&CPU_A(19 downto 0);

ROM_RD    <= CPU_PRE_RD and not CPU_ROM_SEL_N;
ROM_CLKEN <= CPU_CLKEN;

process( CLK ) begin
	if rising_edge( CLK ) then
		if RESET = '1' then
			rombank <= "00";
		elsif CPU_CE = '1' then
			if CPU_A(20) = '0' and ('0' & CPU_A(12 downto 2)) = X"7FC" and CPU_WR_N = '0' then
				rombank <= CPU_A(1 downto 0);
			end if;
		end if;
		RESET_N <= not RESET;
	end if;
end process;

-- Loader I/O: page $FF, $1800-$1BFF
EXT_SEL_N <= '0' when CPU_A(20 downto 10) = x"FF" & "110" else '1';
EXT_A     <= CPU_A(9 downto 0);
EXT_DO    <= CPU_DO;
EXT_WR    <= CPU_CE and not EXT_SEL_N and not CPU_WR_N;
EXT_RD    <= CPU_CE and not EXT_SEL_N and not CPU_RD_N;

-- 8K work RAM
RAM_WE <= CPU_CE and not CPU_RAM_SEL_N and not CPU_WR_N;

RAM : entity work.dpram generic map (13,8)
port map (
	clock		=> CLK,
	address_a=> CPU_A(12 downto 0),
	data_a	=> CPU_DO,
	wren_a	=> RAM_WE,
	q_a		=> RAM_DO
);

PSG_SR <= signed(PCE_SR(23 downto 8));
PSG_SL <= signed(PCE_SL(23 downto 8));

end rtl;
