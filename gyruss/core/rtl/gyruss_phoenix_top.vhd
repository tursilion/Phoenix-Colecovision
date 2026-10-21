--
-- Phoenix Gyruss core top level.
--
-- Same ports and pins as phoenix_top (rtl/phoenix.ucf), so the board
-- constraints are shared.  The game is in gyruss_phoenix.v; this file has
-- the clocking, resets, controllers, HDMI and the board-level pins.  Based
-- on the Dragon's Lair core's top level.
--
-- Controls (MAME keys: 5 = coin, 1 / 2 = start):
--
--                 ColecoVision           SNES pad    PS/2 keyboard
--   player 1      port 1 stick, fire     D-pad, A/B  arrows, Z / X
--   player 2      port 2 stick, fire
--   start 1 / 2   keypad 1 / 2           Start / -   1 / 2
--   coin          keypad 5               Select      5
--   reset game    reset button                       ESC   (hold 1 s: reload)
--
-- Power cycle to change cores.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gyruss_phoenix_top is
port
   ( clock_50m0_i_net   : in     std_logic

   -- Buttons
   ; btn_reset_n_i      : in     std_logic -- Active low, pull-up with RC time of ~10ms

   -- SRAM
   ; sram_addr_o        : out    std_logic_vector(18 downto 0) := (others => '0')
   ; sram_data_io       : inout  std_logic_vector(7 downto 0)  := (others => 'Z')
   ; sram_ce_n_o        : out    std_logic := '1'
   ; sram_oe_n_o        : out    std_logic := '1'
   ; sram_we_n_o        : out    std_logic := '1'

   -- PS2
   ; ps2_clk_io         : inout  std_logic := 'Z'
   ; ps2_data_io        : inout  std_logic := 'Z'

   -- SD Card
   ; sd_cs_n_o          : out    std_logic := '1'
   ; sd_sclk_o          : out    std_logic := '0'
   ; sd_mosi_o          : out    std_logic := 'Z'
   ; sd_miso_i          : in     std_logic
   ; sd_cd_n_i          : in     std_logic -- Card detect, active low, ext pull-up

   -- Joystick
   ; joy_p5_o           : out    std_logic
   ; joy_p8_o           : out    std_logic
   ; joy1_p1_i          : in     std_logic
   ; joy1_p2_i          : in     std_logic
   ; joy1_p3_i          : in     std_logic
   ; joy1_p4_i          : in     std_logic
   ; joy1_p6_i          : in     std_logic
   ; joy1_p7_i          : in     std_logic
   ; joy1_p9_i          : in     std_logic
   ; joy2_p1_i          : in     std_logic
   ; joy2_p2_i          : in     std_logic
   ; joy2_p3_i          : in     std_logic
   ; joy2_p4_i          : in     std_logic
   ; joy2_p6_i          : in     std_logic
   ; joy2_p7_i          : in     std_logic
   ; joy2_p9_i          : in     std_logic

   -- SNES controller
   ; snesjoy_clock_o    : out    std_logic := '1'
   ; snesjoy_latch_o    : out    std_logic := '1'
   ; snesjoy_data_i     : in     std_logic

   -- LVDS
   ; lvds_p_o           : out    std_logic_vector(3 downto 0)
   ; lvds_n_o           : out    std_logic_vector(3 downto 0)

   -- Cartridge (ColecoVision slot, unused by this core)
   ; cart_addr_o        : out    std_logic_vector(14 downto 0) := (others => '0')
   ; cart_data_io       : inout  std_logic_vector( 7 downto 0)
   ; cart_dir_o         : out    std_logic := '0' --Rev6 PCB
   ; cart_oe_n_o        : out    std_logic := '1'
   ; cart_en_80_n_o     : out    std_logic := '1'
   ; cart_en_A0_n_o     : out    std_logic := '1'
   ; cart_en_C0_n_o     : out    std_logic := '1'
   ; cart_en_E0_n_o     : out    std_logic := '1'

   -- LED and RGB-LED
   ; led_o              : out    std_logic := '0'
   ; rgb_led_o          : out    std_logic_vector(2 downto 0) := (others => '1')
);
end entity;


architecture rtl of gyruss_phoenix_top is

   component gyruss_phoenix
   port
      ( clk           : in  std_logic
      ; reset         : in  std_logic
      ; game_reset    : in  std_logic
      ; joy1          : in  std_logic_vector(4 downto 0)
      ; joy2          : in  std_logic_vector(4 downto 0)
      ; sys           : in  std_logic_vector(4 downto 0)
      ; sram_addr     : out std_logic_vector(18 downto 0)
      ; sram_dout     : out std_logic_vector(7 downto 0)
      ; sram_din      : in  std_logic_vector(7 downto 0)
      ; sram_doe      : out std_logic
      ; sram_we_n     : out std_logic
      ; sram_oe_n     : out std_logic
      ; sd_cs_n       : out std_logic
      ; sd_sclk       : out std_logic
      ; sd_mosi       : out std_logic
      ; sd_miso       : in  std_logic
      ; sd_cd_n       : in  std_logic
      ; vid_r         : out std_logic_vector(7 downto 0)
      ; vid_g         : out std_logic_vector(7 downto 0)
      ; vid_b         : out std_logic_vector(7 downto 0)
      ; vid_hsync_n   : out std_logic
      ; vid_vsync_n   : out std_logic
      ; vid_blank     : out std_logic
      ; audio_l       : out std_logic_vector(15 downto 0)
      ; audio_r       : out std_logic_vector(15 downto 0)
      ; boot_mode     : out std_logic
      ; led_err       : out std_logic
      );
   end component;

   -- ColecoVision keypad codes, pins 4..1, active low
   constant KEY_1_c        : std_logic_vector(3 downto 0) := "0111";
   constant KEY_2_c        : std_logic_vector(3 downto 0) := "1011";
   constant KEY_5_c        : std_logic_vector(3 downto 0) := "1001";

   -- Clocks
   signal clk_25m0_s       : std_logic;
   signal clk_100m0_s      : std_logic;
   signal clock_tmds_s     : std_logic;
   signal clock_tmds_n_s   : std_logic;

   -- Resets
   signal rst_cnt_r        : unsigned(7 downto 0) := (others => '1');
   signal por_r            : std_logic := '1';
   signal por_n_s          : std_logic;
   signal btn_meta_r       : std_logic_vector(1 downto 0) := "11";
   signal game_reset_s     : std_logic;
   signal hold_cnt_r       : unsigned(24 downto 0) := (others => '0');
   signal menu_r           : std_logic := '0';
   signal gy_reset_s       : std_logic;

   -- SRAM
   signal sram_dout_s      : std_logic_vector(7 downto 0);
   signal sram_doe_s       : std_logic;

   -- Video and audio
   signal vid_r_s          : std_logic_vector(7 downto 0);
   signal vid_g_s          : std_logic_vector(7 downto 0);
   signal vid_b_s          : std_logic_vector(7 downto 0);
   signal vid_hsync_n_s    : std_logic;
   signal vid_vsync_n_s    : std_logic;
   signal vid_blank_s      : std_logic;
   signal pcm_l_s          : std_logic_vector(15 downto 0);
   signal pcm_r_s          : std_logic_vector(15 downto 0);
   signal tmds_r_s         : std_logic_vector(9 downto 0);
   signal tmds_g_s         : std_logic_vector(9 downto 0);
   signal tmds_b_s         : std_logic_vector(9 downto 0);

   -- Status
   signal boot_mode_s      : std_logic;
   signal led_err_s        : std_logic;

   -- Controllers
   signal joy1_s           : std_logic_vector(4 downto 0);
   signal joy2_s           : std_logic_vector(4 downto 0);
   signal sys_s            : std_logic_vector(4 downto 0);
   signal ps2_keys_s       : std_logic_vector(15 downto 0);
   signal ps2_joy_s        : std_logic_vector(15 downto 0);
   signal cv1_pins_s       : std_logic_vector(4 downto 0);
   signal cv2_pins_s       : std_logic_vector(4 downto 0);
   signal cv1_s            : std_logic_vector(9 downto 0);
   signal cv2_s            : std_logic_vector(9 downto 0);

   signal but_a_s          : std_logic_vector(0 downto 0);
   signal but_b_s          : std_logic_vector(0 downto 0);
   signal but_x_s          : std_logic_vector(0 downto 0);
   signal but_y_s          : std_logic_vector(0 downto 0);
   signal but_start_s      : std_logic_vector(0 downto 0);
   signal but_sel_s        : std_logic_vector(0 downto 0);
   signal but_up_s         : std_logic_vector(0 downto 0);
   signal but_down_s       : std_logic_vector(0 downto 0);
   signal but_left_s       : std_logic_vector(0 downto 0);
   signal but_right_s      : std_logic_vector(0 downto 0);

   -- A key on either keypad
   function key_is(p1, p2 : std_logic_vector(9 downto 0); k : std_logic_vector(3 downto 0))
      return std_logic is
   begin
      if p1(9 downto 6) = k or p2(9 downto 6) = k then
         return '1';
      end if;
      return '0';
   end function;

begin

   --
   -- Clocking, same PLL as the ColecoVision core.  Everything runs from the
   -- 25MHz pixel clock.
   --
   clock_system : entity work.clk_sys_pll
   port map
   ( clk_50m0_i         => clock_50m0_i_net
   , clk_25m0_o         => clk_25m0_s
   , clk_100m0_o        => clk_100m0_s
   , clk_125m0_o        => clock_tmds_s
   , clk_125m0_n_o      => clock_tmds_n_s
   );


   --
   -- Resets: power-on starts the boot loader; the reset button and ESC
   -- reset the game, and holding either for a second loads it again.
   --
   process (clk_25m0_s)
   begin
   if rising_edge(clk_25m0_s) then
      if rst_cnt_r /= 0 then
         rst_cnt_r <= rst_cnt_r - 1;
      else
         por_r <= '0';
      end if;
      btn_meta_r <= btn_meta_r(0) & btn_reset_n_i;
   end if;
   end process;

   por_n_s      <= not por_r;
   game_reset_s <= (not btn_meta_r(1)) or ps2_keys_s(8);

   process (clk_25m0_s)
   begin
   if rising_edge(clk_25m0_s) then
      if game_reset_s = '0' then
         hold_cnt_r <= (others => '0');
         menu_r     <= '0';
      elsif hold_cnt_r = 25000000 then
         menu_r     <= '1';
      else
         hold_cnt_r <= hold_cnt_r + 1;
      end if;
   end if;
   end process;

   gy_reset_s <= por_r or menu_r;


   --
   -- The game
   --
   game : gyruss_phoenix
   port map
   ( clk           => clk_25m0_s
   , reset         => gy_reset_s
   , game_reset    => game_reset_s
   , joy1          => joy1_s
   , joy2          => joy2_s
   , sys           => sys_s
   , sram_addr     => sram_addr_o
   , sram_dout     => sram_dout_s
   , sram_din      => sram_data_io
   , sram_doe      => sram_doe_s
   , sram_we_n     => sram_we_n_o
   , sram_oe_n     => sram_oe_n_o
   , sd_cs_n       => sd_cs_n_o
   , sd_sclk       => sd_sclk_o
   , sd_mosi       => sd_mosi_o
   , sd_miso       => sd_miso_i
   , sd_cd_n       => sd_cd_n_i
   , vid_r         => vid_r_s
   , vid_g         => vid_g_s
   , vid_b         => vid_b_s
   , vid_hsync_n   => vid_hsync_n_s
   , vid_vsync_n   => vid_vsync_n_s
   , vid_blank     => vid_blank_s
   , audio_l       => pcm_l_s
   , audio_r       => pcm_r_s
   , boot_mode     => boot_mode_s
   , led_err       => led_err_s
   );

   sram_data_io <= sram_dout_s when sram_doe_s = '1' else (others => 'Z');
   sram_ce_n_o  <= '0';


   --
   -- Unused cartridge slot: everything disabled.
   --
   cart_addr_o    <= (others => '0');
   cart_data_io   <= (others => 'Z');
   cart_dir_o     <= '0';
   cart_oe_n_o    <= '1';
   cart_en_80_n_o <= '1';
   cart_en_A0_n_o <= '1';
   cart_en_C0_n_o <= '1';
   cart_en_E0_n_o <= '1';


   --
   -- LEDs.  As wired, never drive the LED output high, only '0' (off) or
   -- 'Z' (on).  See phoenix_top.vhd.
   --
   led_o <= 'Z' when por_r = '1' or led_err_s = '1' else '0';
   rgb_led_o <= "001";


   --
   -- Controllers
   --
   cv1_pins_s <= joy1_p6_i & joy1_p4_i & joy1_p3_i & joy1_p2_i & joy1_p1_i;
   cv2_pins_s <= joy2_p6_i & joy2_p4_i & joy2_p3_i & joy2_p2_i & joy2_p1_i;

   cv_pads_inst : entity work.cv_pads_gy
   port map
   ( clk_i           => clk_25m0_s
   , p5_o            => joy_p5_o
   , p8_o            => joy_p8_o
   , joy1_i          => cv1_pins_s
   , joy2_i          => cv2_pins_s
   , pad1_o          => cv1_s
   , pad2_o          => cv2_s
   );

   ps2if_inst : entity work.colecoKeyboard
   port map
   ( clk             => clk_25m0_s
   , reset           => por_r -- active high
   , ps2_clk         => ps2_clk_io
   , ps2_data        => ps2_data_io
   , keys            => ps2_keys_s
   , joy             => ps2_joy_s
   , core_reload_o   => open
   , home_o          => open
   );

   snespads_b : entity work.snespad
   generic map
   ( num_pads_g         => 1
   , reset_level_g      => 0
   , button_level_g     => 0
   , clocks_per_6us_g   => 150 -- 6us @ 25MHz = 150
   )
   port map
   ( clk_i              => clk_25m0_s
   , reset_i            => por_n_s -- active low
   , pad_clk_o          => snesjoy_clock_o
   , pad_latch_o        => snesjoy_latch_o
   , pad_data_i(0)      => snesjoy_data_i
   , but_a_o            => but_a_s
   , but_b_o            => but_b_s
   , but_x_o            => but_x_s
   , but_y_o            => but_y_s
   , but_start_o        => but_start_s
   , but_sel_o          => but_sel_s
   , but_tl_o           => open
   , but_tr_o           => open
   , but_up_o           => but_up_s
   , but_down_o         => but_down_s
   , but_left_o         => but_left_s
   , but_right_o        => but_right_s
   , but_0_o            => open
   , but_1_o            => open
   , but_2_o            => open
   , but_3_o            => open
   , but_4_o            => open
   , but_5_o            => open
   , but_6_o            => open
   , but_7_o            => open
   , but_8_o            => open
   , but_9_o            => open
   , but_star_o         => open
   , but_num_o          => open
   , but_dot_o          => open
   , but_clear_o        => open
   , but_equal_o        => open
   );

   -- Player 1: ColecoVision port 1, the SNES pad and the keyboard.
   -- Player 2: ColecoVision port 2 (the game reads it only in cocktail
   -- mode, or for player 2's turn when the cabinet DIP says cocktail).
   -- SNES pad inputs are active low, the others active high.
   joy1_s(0) <= cv1_s(0) or not but_up_s(0)    or ps2_joy_s(0);
   joy1_s(1) <= cv1_s(1) or not but_down_s(0)  or ps2_joy_s(1);
   joy1_s(2) <= cv1_s(2) or not but_left_s(0)  or ps2_joy_s(2);
   joy1_s(3) <= cv1_s(3) or not but_right_s(0) or ps2_joy_s(3);
   joy1_s(4) <= cv1_s(4) or cv1_s(5) or not but_a_s(0) or not but_b_s(0)
                or not but_x_s(0) or not but_y_s(0) or ps2_joy_s(4) or ps2_keys_s(0);

   joy2_s(3 downto 0) <= cv2_s(3 downto 0);
   joy2_s(4)          <= cv2_s(4) or cv2_s(5);

   sys_s(0) <= key_is(cv1_s, cv2_s, KEY_5_c) or not but_sel_s(0) or ps2_keys_s(3);  -- coin 1
   sys_s(1) <= '0';                                                                  -- coin 2
   sys_s(2) <= '0';                                                                  -- service
   sys_s(3) <= key_is(cv1_s, cv2_s, KEY_1_c) or not but_start_s(0) or ps2_keys_s(13); -- start 1
   sys_s(4) <= key_is(cv1_s, cv2_s, KEY_2_c) or ps2_keys_s(7);                       -- start 2


   --
   -- HDMI, same settings as the ColecoVision core.
   --
   tmds : entity work.hdmi
   generic map
   ( FREQ   => 25000000
   , FS     => 48000
   , CTS    => 25000
   , N      => 6144
   )
   port map
   ( I_CLK_PIXEL     => clk_25m0_s
   , I_R             => vid_r_s
   , I_G             => vid_g_s
   , I_B             => vid_b_s
   , I_BLANK         => vid_blank_s
   , I_HSYNC         => vid_hsync_n_s
   , I_VSYNC         => vid_vsync_n_s
   , I_AUDIO_ENABLE  => '1'
   , I_AUDIO_PCM_L   => pcm_l_s
   , I_AUDIO_PCM_R   => pcm_r_s
   , O_RED           => tmds_r_s
   , O_GREEN         => tmds_g_s
   , O_BLUE          => tmds_b_s
   );

   tmds_out : entity work.hdmi_out_xilinx
   port map
   ( clock_pixel_i   => clk_25m0_s
   , clock_tdms_i    => clock_tmds_s
   , clock_tdms_n_i  => clock_tmds_n_s
   , red_i           => tmds_r_s
   , green_i         => tmds_g_s
   , blue_i          => tmds_b_s
   , tmds_out_p      => lvds_p_o
   , tmds_out_n      => lvds_n_o
   );

end rtl;
