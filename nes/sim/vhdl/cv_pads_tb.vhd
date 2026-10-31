-- Unit test for cv_pads: two ColecoVision controller models.
--   ghdl -a ../../rtl/cv_pads.vhd cv_pads_tb.vhd && ghdl -r cv_pads_tb

library ieee;
use ieee.std_logic_1164.all;

entity cv_pads_tb is
end entity;

architecture sim of cv_pads_tb is

   signal clk     : std_logic := '0';
   signal p5, p8  : std_logic;
   signal j1, j2  : std_logic_vector(4 downto 0);
   signal n1, n2  : std_logic_vector(7 downto 0);
   signal done    : boolean := false;

   -- Controller state, active low.  dirs/key: bit 0-3 = pins 1-4.
   signal dirs1, key1, dirs2, key2 : std_logic_vector(3 downto 0) := "1111";
   signal fl1, fr1, fl2, fr2       : std_logic := '1';

   function pad(p5, p8 : std_logic; dirs, key : std_logic_vector(3 downto 0);
                fl, fr : std_logic) return std_logic_vector is
   begin
      if p8 = '0' and p5 = '1' then
         return fl & dirs;
      elsif p5 = '0' and p8 = '1' then
         return fr & key;
      end if;
      return "11111";
   end function;

begin

   clk <= not clk after 20 ns when not done;

   dut : entity work.cv_pads
   generic map (half_clocks_g => 20)
   port map
   ( clk_i => clk, p5_o => p5, p8_o => p8
   , joy1_i => j1, joy2_i => j2, nes1_o => n1, nes2_o => n2 );

   -- Pins follow the select lines a little later, like the real pads.
   j1 <= pad(p5, p8, dirs1, key1, fl1, fr1) after 100 ns;
   j2 <= pad(p5, p8, dirs2, key2, fl2, fr2) after 100 ns;

   process
      procedure expect(got, want : std_logic_vector; what : string) is
      begin
         assert got = want
            report what & ": got " & to_string(got) & ", want " & to_string(want)
            severity error;
      end procedure;
   begin
      wait for 10 us;
      expect(n1, "00000000", "idle 1");
      expect(n2, "00000000", "idle 2");

      -- Pad 1: up, both fires, #.  Pad 2: right, *.
      dirs1 <= "1110"; fl1 <= '0'; fr1 <= '0'; key1 <= "1010";
      dirs2 <= "0111"; key2 <= "0101";
      wait for 10 us;
      --         RLDUSsBA
      expect(n1, "00011011", "pad 1 up, A, B, Start");
      expect(n2, "10000100", "pad 2 right, Select");

      -- Left fire alone is A, right fire alone is B.
      fr1 <= '1';
      wait for 10 us;
      expect(n1, "00011001", "pad 1 up, left fire = A, Start");
      fl1 <= '1'; fr1 <= '0';
      wait for 10 us;
      expect(n1, "00011010", "pad 1 up, right fire = B, Start");

      -- Release everything.
      dirs1 <= "1111"; fl1 <= '1'; fr1 <= '1'; key1 <= "1111";
      dirs2 <= "1111"; key2 <= "1111";
      wait for 10 us;
      expect(n1, "00000000", "released 1");
      expect(n2, "00000000", "released 2");

      -- Other keys must not map to anything (key 3 = pins 0110, key 1 =
      -- 0111, the old Select).
      key1 <= "0110";
      wait for 10 us;
      expect(n1, "00000000", "key 3 ignored");
      key1 <= "0111";
      wait for 10 us;
      expect(n1, "00000000", "key 1 ignored");

      report "cv_pads_tb done";
      done <= true;
      wait;
   end process;

end architecture;
