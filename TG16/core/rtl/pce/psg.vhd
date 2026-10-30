library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.psg_vol.all;

entity psg is
	port (
		CLK 	: in std_logic;
		CLKEN	: in std_logic;
		RESET_N	: in std_logic;

		-- CPU Interface
		DI		: in std_logic_vector(7 downto 0);
		A 		: in std_logic_vector(3 downto 0);
		WE		: in std_logic;

		-- DAC Interface
		DAC_LATCH	: in std_logic;
		LDATA		: out std_logic_vector(23 downto 0);
		RDATA		: out std_logic_vector(23 downto 0)
	);
end psg;

architecture rtl of psg is

-- R0 - Channel Selection
signal CHSEL	: integer range 0 to 7;
-- R1 - Main Volume Adjustement
signal LMAL		: std_logic_vector(3 downto 0);
signal RMAL		: std_logic_vector(3 downto 0);

-- R2-R7 - Channel specific registers
type wavedata_t is array(0 to 31) of std_logic_vector(4 downto 0);
-- Phoenix: the channel record is split by the process that writes it
-- (one driver per signal, for GHDL's synthesis): registers, generators
-- and the LFO value.
type chan_r_t is
	record
		FREQ		: std_logic_vector(11 downto 0);
		DDA		: std_logic;
		CHON		: std_logic;
		AL			: std_logic_vector(4 downto 0);
		LAL		: std_logic_vector(3 downto 0);
		RAL		: std_logic_vector(3 downto 0);
		NG_FREQ	: std_logic_vector(4 downto 0);
		NE			: std_logic;
		WF_DATA	: wavedata_t;
		WF_RES	: std_logic;
		WF_INC	: std_logic;
		DA_OUT	: std_logic_vector(4 downto 0);
		LFO_FREQ	: std_logic_vector(7 downto 0);
		LFCTL		: std_logic_vector(1 downto 0);
		LFTRG		: std_logic;
	end record;
type chan_g_t is
	record
		WF_ADDR	: std_logic_vector(4 downto 0);
		WF_CNT	: std_logic_vector(12 downto 0);
		LFSR		: std_logic_vector(17 downto 0);
		NG_CNT	: std_logic_vector(11 downto 0);
		WF_OUT	: std_logic_vector(4 downto 0);
		NG_OUT	: std_logic_vector(4 downto 0);
		GL_OUT	: std_logic_vector(4 downto 0);
		LFO_CNT	: std_logic_vector(7 downto 0);
	end record;
type chanarray_r_t is array(0 to 5) of chan_r_t;
type chanarray_g_t is array(0 to 5) of chan_g_t;
type lfoadd_t is array(0 to 5) of std_logic_vector(11 downto 0);
signal CHR		: chanarray_r_t;
signal CHG		: chanarray_g_t;
signal LFOA		: lfoadd_t;

-- Channels mixing
signal LACC		: std_logic_vector(23 downto 0);
signal RACC		: std_logic_vector(23 downto 0);

signal VT_ADDR	: std_logic_vector(11 downto 0);
signal VT_DATA	: std_logic_vector(23 downto 0);

type mix_t is ( MIX_WAIT, MIX_NEXT, MIX_LREAD, MIX_LNEXT, MIX_RREAD, MIX_RNEXT, MIX_END );
signal MIX		: mix_t;
signal MIX_CNT	: std_logic_vector(2 downto 0);

signal LDATA_FF	: std_logic_vector(23 downto 0);
signal RDATA_FF	: std_logic_vector(23 downto 0);

begin

-- CPU Interface
process( CLK )
begin
	if rising_edge( CLK ) then

		for i in 0 to 5 loop
			CHR(i).WF_RES <= '0';
			CHR(i).WF_INC <= '0';
		end loop;

		if RESET_N = '0' then

			CHSEL <= 0;
			LMAL <= (others => '0');
			RMAL <= (others => '0');

			for i in 0 to 5 loop
				CHR(i).FREQ <= (others => '0');
				CHR(i).DDA <= '0';
				CHR(i).CHON <= '0';
				CHR(i).LAL <= (others => '0');
				CHR(i).RAL <= (others => '0');
				CHR(i).NG_FREQ <= (others => '0');
				CHR(i).NE <= '0';
				CHR(i).DA_OUT <= (others => '0');
				CHR(i).LFO_FREQ <= (others => '0');
				CHR(i).LFCTL <= "00";
				CHR(i).LFTRG <= '0';
			end loop;
		else
			if WE = '1' then
				case A is
				when "0000" =>
					CHSEL <= conv_integer(DI(2 downto 0));

				when "0001" =>
					LMAL <= DI(7 downto 4);
					RMAL <= DI(3 downto 0);

				when "0010" =>
					CHR(CHSEL).FREQ(7 downto 0) <= DI;

				when "0011" =>
					CHR(CHSEL).FREQ(11 downto 8) <= DI(3 downto 0);

				when "0100" =>
					CHR(CHSEL).CHON <= DI(7);
					CHR(CHSEL).DDA <= DI(6);
					CHR(CHSEL).AL <= DI(4 downto 0);
					if CHR(CHSEL).DDA = '1' and DI(6) = '0' then
						CHR(CHSEL).WF_RES <= '1';
					end if;

				when "0101" =>
					CHR(CHSEL).LAL <= DI(7 downto 4);
					CHR(CHSEL).RAL <= DI(3 downto 0);

				when "0110" =>
					if CHR(CHSEL).DDA = '0' then
						CHR(CHSEL).WF_DATA(conv_integer(CHG(CHSEL).WF_ADDR)) <= DI(4 downto 0);
					end if;
					if CHR(CHSEL).CHON = '1' then
						CHR(CHSEL).DA_OUT <= DI(4 downto 0);
					end if;
					if CHR(CHSEL).DDA = '0' and CHR(CHSEL).CHON = '0' then
						CHR(CHSEL).WF_INC <= '1';
					end if;

				when "0111" =>
					if CHSEL = 4 or CHSEL =5 then
						CHR(CHSEL).NE <= DI(7);
						CHR(CHSEL).NG_FREQ <= DI(4 downto 0);
					end if;

				when "1000" =>
					CHR(1).LFO_FREQ <= DI;

				when "1001" =>
					CHR(1).LFCTL <= DI(1 downto 0);
					CHR(1).LFTRG <= DI(7);

				when others => null;
				end case;
			end if;
		end if;
	end if;
end process;


process( CLK ) begin
	if rising_edge( CLK ) then
		for i in 0 to 5 loop
			if RESET_N = '0' then
				CHG(i).GL_OUT <= (others => '0');
				CHG(i).WF_CNT <= (others => '0');
				CHG(i).LFSR <= (others => '0');
				CHG(i).NG_CNT <= (others => '0');
				CHG(i).LFO_CNT <= (others => '0');
			else
				if CHR(i).WF_RES = '1' then
					CHG(i).WF_ADDR <= (others => '0');
				end if;
				if CHR(i).WF_INC = '1' then
					CHG(i).WF_ADDR <= CHG(i).WF_ADDR + 1;
				end if;

				if CHR(i).LFCTL /= "00" then
					CHG(i).WF_OUT <= CHR(i).WF_DATA(conv_integer(CHG(i).WF_ADDR));

					if CHR(i).LFTRG = '1' then
						CHG(i).WF_ADDR <= (others => '0');
						CHG(i).WF_CNT <= (CHR(i).FREQ - 1) & "1";
						CHG(i).LFO_CNT <= CHR(i).LFO_FREQ - 1;
					else
						if CLKEN = '1' then
							CHG(i).LFO_CNT <= CHG(i).LFO_CNT - 1;
							if CHG(i).LFO_CNT = 0 then
								CHG(i).LFO_CNT <= CHR(i).LFO_FREQ - 1;
								CHG(i).WF_CNT <= CHG(i).WF_CNT - 1;
								if CHG(i).WF_CNT = 0 then
									CHG(i).WF_CNT <= (CHR(i).FREQ - 1) & "1";
									CHG(i).WF_ADDR <= CHG(i).WF_ADDR + 1;
								end if;
							end if;
						end if;
					end if;
				elsif CHR(i).CHON = '0' then
					CHG(i).WF_CNT <= (CHR(i).FREQ - 1 + LFOA(i)) & "1";
				elsif CHR(i).DDA = '0' then
					CHG(i).WF_OUT <= CHR(i).WF_DATA(conv_integer(CHG(i).WF_ADDR));

					if CLKEN = '1' then
						CHG(i).WF_CNT <= CHG(i).WF_CNT - 1;
						if CHG(i).WF_CNT = 0 then
							CHG(i).WF_CNT <= (CHR(i).FREQ - 1 + LFOA(i)) & "1";
							CHG(i).WF_ADDR <= CHG(i).WF_ADDR + 1;
						end if;
					end if;
				end if;

				if CHR(i).NE = '0' then
				if CHR(i).NG_FREQ = "11111" then
						CHG(i).NG_CNT <= "000000111111";
					else
						CHG(i).NG_CNT <= ( not(CHR(i).NG_FREQ) - 1) & "1111111";
					end if;
				else
					if CHG(i).LFSR(0) = '0' then
						CHG(i).NG_OUT <= "00000";
					else
						CHG(i).NG_OUT <= "11111";
					end if;

					if CLKEN = '1' then
						CHG(i).NG_CNT <= CHG(i).NG_CNT - 1;
						if CHG(i).NG_CNT = 0 then
							if CHR(i).NG_FREQ = "11111" then
								CHG(i).NG_CNT <= "000000111111";
							else
								CHG(i).NG_CNT <= ( not(CHR(i).NG_FREQ) - 1) & "1111111";
							end if;
							if CHG(i).LFSR = 0 then
								CHG(i).LFSR(0) <= '1';
							else
								CHG(i).LFSR <= (CHG(i).LFSR(0) xor CHG(i).LFSR(1) xor CHG(i).LFSR(11) xor CHG(i).LFSR(12) xor CHG(i).LFSR(17)) & CHG(i).LFSR(17 downto 1);
							end if;
						end if;
					end if;
				end if;

				if CHR(i).CHON = '0' then
					CHG(i).GL_OUT <= "10000";		-- Not zero; this should be midpoint in the range to reduce 'pop' sound
				elsif CHR(i).DDA = '1' then
					CHG(i).GL_OUT <= CHR(i).DA_OUT;
				elsif CHR(i).NE = '1' then
					CHG(i).GL_OUT <= CHG(i).NG_OUT;
				else
					CHG(i).GL_OUT <= CHG(i).WF_OUT;
				end if;
			end if;
		end loop;
	end if;
end process;

process( CLK )
	variable DATA: std_logic_vector(4 downto 0);
begin
	if rising_edge( CLK ) then
		if RESET_N = '0' then
			for i in 0 to 5 loop
				LFOA(i) <= (others => '0');
			end loop;
		else
			DATA := CHR(1).WF_DATA(conv_integer(CHG(1).WF_ADDR)) xor "10000";       -- Phoenix: was "1000" (5-bit sample)
			LFOA(0)(11 downto 8) <= DATA(4) & DATA(4) & DATA(4) & DATA(4);
			case CHR(1).LFCTL is
			when "01" =>   LFOA(0)(7 downto 0) <= DATA(4) & DATA(4) & DATA(4) & DATA;
			when "10" =>   LFOA(0)(7 downto 0) <= DATA(4) & DATA & "00";
			when "11" =>   LFOA(0)(7 downto 0) <= DATA(3 downto 0) & "0000";
			when others => LFOA(0) <= (others => '0');
			end case;
		end if;
	end if;
end process;

-- Channels mixing.  Phoenix: the 4096 x 24 volume ROM is the volume for the
-- attenuation times the sample (psg_vol.vhd), with the same one-clock delay.
process( CLK )
	variable P : signed(23 downto 0);
begin
	if rising_edge( CLK ) then
		P := resize(signed('0' & VOL(to_integer(unsigned(VT_ADDR(6 downto 0))))) *
		            (signed('0' & VT_ADDR(11 downto 7) & '0') - 31), 24);
		VT_DATA <= std_logic_vector(shift_right(P, 1));
	end if;
end process;

process( CLK )
begin
	if rising_edge( CLK ) then
		if RESET_N = '0' then
			LDATA_FF <= (others => '0');
			RDATA_FF <= (others => '0');
			MIX <= MIX_WAIT;
		else
			case MIX is
			when MIX_WAIT =>
				LACC <= (others => '0');
				RACC <= (others => '0');
				MIX_CNT <= (others => '0');
				VT_ADDR <= (others => '1');
				if DAC_LATCH = '1' then
					MIX <= MIX_NEXT;
				end if;

			when MIX_NEXT =>
				VT_ADDR <= CHG(conv_integer(MIX_CNT)).GL_OUT
					& ( "1011101" - CHR(conv_integer(MIX_CNT)).AL - (CHR(conv_integer(MIX_CNT)).LAL & "1") - (LMAL & "1") );
				MIX <= MIX_LREAD;

			when MIX_LREAD =>
				MIX <= MIX_LNEXT;

			when MIX_LNEXT =>
				LACC <= LACC + VT_DATA;
				VT_ADDR <= CHG(conv_integer(MIX_CNT)).GL_OUT
					& ( "1011101" - CHR(conv_integer(MIX_CNT)).AL - (CHR(conv_integer(MIX_CNT)).RAL & "1") - (RMAL & "1") );
				MIX <= MIX_RREAD;

			when MIX_RREAD =>
				MIX <= MIX_RNEXT;

			when MIX_RNEXT =>
				RACC <= RACC + VT_DATA;
				if MIX_CNT = "101" then
					MIX <= MIX_END;
				else
					MIX_CNT <= MIX_CNT + 1;
					MIX <= MIX_NEXT;
				end if;

			when MIX_END =>
				LDATA_FF <= LACC;
				RDATA_FF <= RACC;
				MIX <= MIX_WAIT;

			when others => null;
			end case;
		end if;
	end if;
end process;

LDATA <= LDATA_FF;
RDATA <= RDATA_FF;

end rtl;

