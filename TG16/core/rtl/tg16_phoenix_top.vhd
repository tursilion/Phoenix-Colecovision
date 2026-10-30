--
-- Phoenix PC Engine / TurboGrafx-16 core top level.
--
-- Same ports and pins as phoenix_top (rtl/phoenix.ucf), so the board
-- constraints are shared.  The system is in tg16_phoenix.v; this file has
-- the clocks, resets, controllers, HDMI and the board-level pins.  Based on
-- the Game Boy core's top level.
--
-- Clocks: the shared PLL makes 25MHz (HDMI pixels) and the TMDS clocks; a
-- DCM_CLKGEN makes 42.78MHz (25MHz x 77 / 45) for the PC Engine, which
-- reaches the core twice: clk_i always, clk_g through a BUFGCE that the
-- frame lock stops at the top of each PC Engine frame.
--
-- Controls: see README.md.  The reset button or ESC resets the game; hold
-- either for a second to go back to the menu.  Power cycle to change cores.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity tg16_phoenix_top is
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


architecture rtl of tg16_phoenix_top is

   component tg16_phoenix
   port
      ( clk25         : in  std_logic
      ; clk_i         : in  std_logic
      ; clk_g         : in  std_logic
      ; run           : out std_logic
      ; reset         : in  std_logic
      ; game_reset    : in  std_logic
      ; cv1           : in  std_logic_vector(9 downto 0)
      ; cv2           : in  std_logic_vector(9 downto 0)
      ; snes          : in  std_logic_vector(11 downto 0)
      ; kb_keys       : in  std_logic_vector(15 downto 0)
      ; kb_joy        : in  std_logic_vector(4 downto 0)
      ; sram_addr     : out std_logic_vector(18 downto 0)
      ; sram_dout     : out std_logic_vector(7 downto 0)
      ; sram_din      : in  std_logic_vector(7 downto 0)
      ; sram_doe      : out std_logic_vector(7 downto 0)
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
      ; dbg           : out std_logic_vector(31 downto 0)
      );
   end component;

   -- Clocks
   signal clk_25m0_s       : std_logic;
   signal clk_100m0_s      : std_logic;
   signal clock_tmds_s     : std_logic;
   signal clock_tmds_n_s   : std_logic;
   signal clk_fx_s         : std_logic;
   signal clk_i_s          : std_logic;
   signal clk_g_s          : std_logic;
   signal run_s            : std_logic;

   -- Resets
   signal rst_cnt_r        : unsigned(7 downto 0) := (others => '1');
   signal por_r            : std_logic := '1';
   signal por_n_s          : std_logic;
   signal btn_meta_r       : std_logic_vector(1 downto 0) := "11";
   signal game_reset_s     : std_logic;
   signal hold_cnt_r       : unsigned(24 downto 0) := (others => '0');
   signal menu_r           : std_logic := '0';
   signal sys_reset_s      : std_logic;

   -- SRAM
   signal sram_dout_s      : std_logic_vector(7 downto 0);
   signal sram_doe_s       : std_logic_vector(7 downto 0);

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
   signal ps2_keys_s       : std_logic_vector(15 downto 0);
   signal ps2_joy_s        : std_logic_vector(15 downto 0);
   signal kb_joy_s         : std_logic_vector(4 downto 0);
   signal cv1_pins_s       : std_logic_vector(4 downto 0);
   signal cv2_pins_s       : std_logic_vector(4 downto 0);
   signal cv1_s            : std_logic_vector(9 downto 0);
   signal cv2_s            : std_logic_vector(9 downto 0);
   signal snes_s           : std_logic_vector(11 downto 0);

   signal but_a_s          : std_logic_vector(0 downto 0);
   signal but_b_s          : std_logic_vector(0 downto 0);
   signal but_x_s          : std_logic_vector(0 downto 0);
   signal but_y_s          : std_logic_vector(0 downto 0);
   signal but_l_s          : std_logic_vector(0 downto 0);
   signal but_r_s          : std_logic_vector(0 downto 0);
   signal but_start_s      : std_logic_vector(0 downto 0);
   signal but_sel_s        : std_logic_vector(0 downto 0);
   signal but_up_s         : std_logic_vector(0 downto 0);
   signal but_down_s       : std_logic_vector(0 downto 0);
   signal but_left_s       : std_logic_vector(0 downto 0);
   signal but_right_s      : std_logic_vector(0 downto 0);

begin

   --
   -- Clocking: the ColecoVision core's PLL for the HDMI clocks, and the
   -- PC Engine clock from 25MHz.
   --
   clock_system : entity work.clk_sys_pll
   port map
   ( clk_50m0_i         => clock_50m0_i_net
   , clk_25m0_o         => clk_25m0_s
   , clk_100m0_o        => clk_100m0_s
   , clk_125m0_o        => clock_tmds_s
   , clk_125m0_n_o      => clock_tmds_n_s
   );

   pce_clkgen : DCM_CLKGEN
   generic map
   ( CLKFX_MULTIPLY     => 77
   , CLKFX_DIVIDE       => 45
   , CLKIN_PERIOD       => 40.0
   , CLKFX_MD_MAX       => 1.72
   , SPREAD_SPECTRUM    => "NONE"
   , STARTUP_WAIT       => FALSE
   )
   port map
   ( CLKIN              => clk_25m0_s
   , CLKFX              => clk_fx_s
   , CLKFX180           => open
   , CLKFXDV            => open
   , LOCKED             => open
   , PROGDONE           => open
   , STATUS             => open
   , FREEZEDCM          => '0'
   , PROGCLK            => '0'
   , PROGDATA           => '0'
   , PROGEN             => '0'
   , RST                => '0'
   );

   pce_clk_buf : BUFG
   port map
   ( I => clk_fx_s
   , O => clk_i_s
   );

   pce_clk_gate : BUFGCE
   port map
   ( I  => clk_fx_s
   , CE => run_s
   , O  => clk_g_s
   );


   --
   -- Resets: power-on starts the menu; the reset button and ESC reset the
   -- game, and holding either for a second goes back to the menu.
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

   sys_reset_s <= por_r or menu_r;


   --
   -- The system
   --
   system : tg16_phoenix
   port map
   ( clk25         => clk_25m0_s
   , clk_i         => clk_i_s
   , clk_g         => clk_g_s
   , run           => run_s
   , reset         => sys_reset_s
   , game_reset    => game_reset_s
   , cv1           => cv1_s
   , cv2           => cv2_s
   , snes          => snes_s
   , kb_keys       => ps2_keys_s
   , kb_joy        => kb_joy_s
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
   , dbg           => open
   );

   sram_bus : for i in 0 to 7 generate
      sram_data_io(i) <= sram_dout_s(i) when sram_doe_s(i) = '1' else 'Z';
   end generate;
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

   cv_pads_inst : entity work.cv_pads_ga
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
   , rx_byte_o       => open
   , rx_stb_o        => open
   );

   kb_joy_s <= ps2_joy_s(4 downto 0);

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
   , but_tl_o           => but_l_s
   , but_tr_o           => but_r_s
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

   -- SNES pad, active high for tg16_phoenix
   snes_s <= not ( but_right_s(0) & but_left_s(0) & but_down_s(0) & but_up_s(0)
                 & but_r_s(0) & but_l_s(0) & but_sel_s(0) & but_start_s(0)
                 & but_y_s(0) & but_x_s(0) & but_b_s(0) & but_a_s(0) );


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
