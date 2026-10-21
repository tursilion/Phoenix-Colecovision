--
-- ColecoVision controllers, raw: stick, both fire buttons and the keypad.
-- Same scanner as nes/rtl/cv_pads.vhd (see there for how the halves are
-- selected), but it reports the whole keypad.
--
-- pad_o bits: 0 up, 1 down, 2 left, 3 right, 4 left fire, 5 right fire
-- (1 = pressed), 9:6 the key code on pins 4..1 (active low, "1111" = no
-- key; see the KEY_ constants in gyruss_phoenix_top.vhd).
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cv_pads_gy is
generic
   ( half_clocks_g   : natural := 1250  -- clocks per half, 50us at 25MHz
   );
port
   ( clk_i           : in  std_logic
   ; p5_o            : out std_logic
   ; p8_o            : out std_logic
   -- Pins of each port: bit 0-3 = pins 1-4, bit 4 = pin 6
   ; joy1_i          : in  std_logic_vector(4 downto 0)
   ; joy2_i          : in  std_logic_vector(4 downto 0)
   ; pad1_o          : out std_logic_vector(9 downto 0)
   ; pad2_o          : out std_logic_vector(9 downto 0)
   );
end entity;


architecture rtl of cv_pads_gy is

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

   function to_vec(p : pad_t) return std_logic_vector is
   begin
      return p.key & (not p.fire_r) & (not p.fire_l) & (not p.dirs);
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

   pad1_o <= to_vec(pads_r(1));
   pad2_o <= to_vec(pads_r(2));

end rtl;
