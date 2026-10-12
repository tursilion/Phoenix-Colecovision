--
-- ColecoVision controllers as NES pads.
--
-- A ColecoVision controller shares pins 1-4 and 6 between two halves,
-- chosen by the common select lines (shared by both ports):
--
--   pin 8 low, pin 5 high:  joystick, pins 1-4 = up/down/left/right,
--                           pin 6 = left fire
--   pin 5 low, pin 8 high:  keypad, pins 1-4 = key code, pin 6 = right fire
--
-- All inputs are active low.  The scanner alternates the halves, waiting
-- for the lines to settle before sampling.  A key code must read the same
-- twice in a row, since the code can glitch while a key is pressed or
-- released.
--
-- NES mapping: left fire = B, right fire = A (the NES layout, B on the
-- left), keypad 1 = Select, keypad 2 = Start.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cv_pads is
generic
   ( half_clocks_g   : natural := 1250  -- clocks per half, 50us at 25MHz
   );
port
   ( clk_i           : in  std_logic
   -- Select lines, shared by both ports
   ; p5_o            : out std_logic
   ; p8_o            : out std_logic
   -- Pins of each port: bit 0-3 = pins 1-4, bit 4 = pin 6
   ; joy1_i          : in  std_logic_vector(4 downto 0)
   ; joy2_i          : in  std_logic_vector(4 downto 0)
   -- NES buttons, 1 = pressed (0=A 1=B 2=Select 3=Start 4=Up 5=Down
   -- 6=Left 7=Right)
   ; nes1_o          : out std_logic_vector(7 downto 0)
   ; nes2_o          : out std_logic_vector(7 downto 0)
   );
end entity;


architecture rtl of cv_pads is

   constant KEY_1_c     : std_logic_vector(3 downto 0) := "0111"; -- pins 4..1
   constant KEY_2_c     : std_logic_vector(3 downto 0) := "1011";

   type pad_t is record
      dirs     : std_logic_vector(3 downto 0); -- pins 4..1, active low
      fire_l   : std_logic;
      fire_r   : std_logic;
      key      : std_logic_vector(3 downto 0); -- accepted key code
      key_last : std_logic_vector(3 downto 0); -- previous key code read
   end record;

   constant PAD_IDLE_c  : pad_t := ("1111", '1', '1', "1111", "1111");

   type pads_t is array (1 to 2) of pad_t;
   type pins_t is array (1 to 2) of std_logic_vector(4 downto 0);

   signal pads_r        : pads_t := (others => PAD_IDLE_c);
   signal sync1_r       : pins_t := (others => (others => '1'));
   signal sync2_r       : pins_t := (others => (others => '1'));
   signal cnt_r         : natural range 0 to half_clocks_g - 1 := 0;
   signal keypad_r      : std_logic := '0'; -- '1' = keypad half selected

   function to_nes(p : pad_t) return std_logic_vector is
      variable n : std_logic_vector(7 downto 0);
   begin
      n(0) := not p.fire_r;                                -- A
      n(1) := not p.fire_l;                                -- B
      n(2) := '0';                                         -- Select
      n(3) := '0';                                         -- Start
      if p.key = KEY_1_c then n(2) := '1'; end if;
      if p.key = KEY_2_c then n(3) := '1'; end if;
      n(4) := not p.dirs(0);                               -- Up,    pin 1
      n(5) := not p.dirs(1);                               -- Down,  pin 2
      n(6) := not p.dirs(2);                               -- Left,  pin 3
      n(7) := not p.dirs(3);                               -- Right, pin 4
      return n;
   end function;

begin

   p5_o <= not keypad_r;
   p8_o <= keypad_r;

   process (clk_i)
      variable pins_v : std_logic_vector(4 downto 0);
   begin
   if rising_edge(clk_i) then
      sync1_r(1) <= joy1_i;
      sync1_r(2) <= joy2_i;
      sync2_r    <= sync1_r;

      if cnt_r = half_clocks_g - 1 then
         cnt_r <= 0;

         -- Sample the settled half, then switch to the other one.
         for i in 1 to 2 loop
            pins_v := sync2_r(i);
            if keypad_r = '0' then
               pads_r(i).dirs   <= pins_v(3 downto 0);
               pads_r(i).fire_l <= pins_v(4);
            else
               pads_r(i).fire_r   <= pins_v(4);
               pads_r(i).key_last <= pins_v(3 downto 0);
               if pins_v(3 downto 0) = pads_r(i).key_last then
                  pads_r(i).key <= pins_v(3 downto 0);
               end if;
            end if;
         end loop;

         keypad_r <= not keypad_r;
      else
         cnt_r <= cnt_r + 1;
      end if;
   end if;
   end process;

   nes1_o <= to_nes(pads_r(1));
   nes2_o <= to_nes(pads_r(2));

end rtl;
