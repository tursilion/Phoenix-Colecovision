--------------------------------------------------------------------------------
-- Intellivision for the Phoenix: CP1610, STIC with the system RAMs and ROMs,
-- AY-3-8914, the cartridge, and the ECS, Intellivoice and JLP extensions.
-- After the MiSTer core's intv.vhd, without the MiSTer I/O.
--------------------------------------------------------------------------------
-- clk is 12 times the 3.58MHz pixel clock (about 43MHz).  The CPU runs at
-- clk / 48, the sound chip at clk / 192.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.base_pack.ALL;

ENTITY intv_core IS
  PORT (
    clk        : IN  std_logic;
    reset_n    : IN  std_logic;

    ecs        : IN  std_logic;  -- ECS (ROM, RAM, second AY-3-8914) present
    jlp        : IN  std_logic;  -- JLP registers present
    ivoice     : IN  std_logic;  -- Intellivoice present

    -- BIOS loading, while reset_n is low: rom_sel 0 EXEC, 1 GROM,
    -- 2-4 ECS ROM ($2000, $7000, $E000), 5 SP0256; rom_a is the word
    -- (byte for GROM and SP0256) address in that ROM.
    rom_we     : IN  std_logic;
    rom_sel    : IN  std_logic_vector(2 DOWNTO 0);
    rom_a      : IN  std_logic_vector(11 DOWNTO 0);
    rom_d      : IN  std_logic_vector(9 DOWNTO 0);

    -- Hand controllers as the AY-3-8914 ports read them (active low):
    -- pa = $1FE (right controller), pb = $1FF (left controller)
    pa_i       : IN  std_logic_vector(7 DOWNTO 0);
    pb_i       : IN  std_logic_vector(7 DOWNTO 0);

    -- ECS AY-3-8917 ports: the keyboard rows (out) and columns (in)
    pa2_o      : OUT std_logic_vector(7 DOWNTO 0);
    pa2_en     : OUT std_logic;
    pa2_i      : IN  std_logic_vector(7 DOWNTO 0);
    pb2_i      : IN  std_logic_vector(7 DOWNTO 0);

    paged_mask : IN  std_logic_vector(15 DOWNTO 0);

    -- SRAM, one byte per request (see intv_cart.vhd)
    mem_req    : OUT std_logic;
    mem_we     : OUT std_logic;
    mem_addr   : OUT std_logic_vector(18 DOWNTO 0);
    mem_wdata  : OUT std_logic_vector(7 DOWNTO 0);
    mem_rdata  : IN  std_logic_vector(7 DOWNTO 0);
    mem_ack    : IN  std_logic;

    -- Video: one pixel every 12 clocks, and the start of each frame
    hvsync     : OUT std_logic;
    pix_we     : OUT std_logic;
    pix_col    : OUT std_logic_vector(3 DOWNTO 0);
    pix_x      : OUT std_logic_vector(8 DOWNTO 0);
    pix_y      : OUT std_logic_vector(8 DOWNTO 0);

    -- Sound: both AY-3-891x and the Intellivoice, signed
    audio      : OUT std_logic_vector(15 DOWNTO 0);

    -- For the simulation: bus address and phase
    dbg_ad     : OUT std_logic_vector(15 DOWNTO 0);
    dbg_bdic   : OUT std_logic_vector(2 DOWNTO 0);
    dbg_phi    : OUT std_logic
    );
END ENTITY intv_core;

ARCHITECTURE struct OF intv_core IS

  SIGNAL clkdiv    : uint6 := 0;
  SIGNAL clkdivsnd : uint2 := 0;
  SIGNAL clkdivivoice : uint4 := 0;
  SIGNAL phi_cpu, phi_cpup, phi_snd, phi_ivoice : std_logic := '0';

  SIGNAL snd2_dr, snd2_dw : uv8;
  SIGNAL snd2_wr : std_logic;
  SIGNAL pa2_o_u, pb2_o, pa2_u, pb2_u : uv8;
  SIGNAL pb2_en : std_logic;
  SIGNAL sound2 : uv12;
  SIGNAL ivoice_dr, ivoice_dw : uv16;
  SIGNAL ivoice_wr : std_logic;
  SIGNAL sound_iv : sv16;
  SIGNAL jlp_dr, jlp_dw : uv16;
  SIGNAL jlp_wr : std_logic;
  SIGNAL boot, voice_we : std_logic;
  SIGNAL rom_sel_u : uv3;
  SIGNAL rom_a_u : uv12;
  SIGNAL rom_d_u : uv10;
  SIGNAL voice_a : unsigned(10 DOWNTO 0);
  SIGNAL voice_d : uv8;

  SIGNAL dr, dw, ad, cart_dr, cart_dw : uv16;
  SIGNAL snd_dr, snd_dw : uv8;
  SIGNAL snd_wr, cart_wr, cart_rd, cart_pwr : std_logic;
  SIGNAL bdic : uv3;
  SIGNAL bdrdy, busrq, busak, intrm : std_logic;
  SIGNAL pa_o, pb_o : uv8;
  SIGNAL pa_en, pb_en : std_logic;
  SIGNAL pa_u, pb_u : uv8;
  SIGNAL sound_u : uv12;

  SIGNAL mem_addr_u  : unsigned(18 DOWNTO 0);
  SIGNAL mem_wdata_u : uv8;
  SIGNAL mem_rdata_u : uv8;
  SIGNAL pix_col_u   : uv4;
  SIGNAL pix_x_u, pix_y_u : uv9;

BEGIN

  -- CPU and sound clock enables, as in intv.vhd (without the pause and the
  -- fast CFG parser mode).
  Clepsydre:PROCESS(clk) IS
  BEGIN
    IF rising_edge(clk) THEN
      phi_cpup <= '0';
      IF clkdiv /= 3*4*4-1 THEN
        clkdiv <= clkdiv + 1;
      ELSE
        clkdiv   <= 0;
        phi_cpup <= '1';
      END IF;
      phi_cpu <= phi_cpup;

      IF clkdivivoice=11 THEN
        phi_ivoice   <= '1';
        clkdivivoice <= 0;
      ELSE
        phi_ivoice   <= '0';
        clkdivivoice <= clkdivivoice + 1;
      END IF;

      phi_snd <= '0';
      IF phi_cpu='1' THEN
        clkdivsnd <= (clkdivsnd + 1) MOD 4;
        IF clkdivsnd=0 THEN
          phi_snd <= '1';
        END IF;
      END IF;
    END IF;
  END PROCESS Clepsydre;

  i_cp1610: ENTITY work.cp1610
    PORT MAP (
      dr       => dr,
      dw       => dw,
      bdic     => bdic,
      ebci     => x"0000",
      msync    => '0',
      bdrdy    => bdrdy,
      intr     => '0',
      intrm    => intrm,
      tci      => OPEN,
      pci      => '0',
      pct      => OPEN,
      busrq    => busrq,
      busak    => busak,
      stpst    => '0',
      halt     => OPEN,
      phi      => phi_cpu,
      phip     => phi_cpup,
      clk      => clk,
      reset_na => reset_n);

  i_stic: ENTITY work.stic
    PORT MAP (
      dw         => dw,
      dr         => dr,
      bdic       => bdic,
      bdrdy      => bdrdy,
      busrq      => busrq,
      busak      => busak,
      intrm      => intrm,
      phi        => phi_cpu,
      pal        => '0',
      pause      => '0',
      ecs        => ecs,
      ivoice     => ivoice,
      jlp        => jlp,
      ad         => ad,
      snd_dr     => snd_dr,
      snd_dw     => snd_dw,
      snd_wr     => snd_wr,
      snd2_dr    => snd2_dr,
      snd2_dw    => snd2_dw,
      snd2_wr    => snd2_wr,
      ivoice_dr  => ivoice_dr,
      ivoice_dw  => ivoice_dw,
      ivoice_wr  => ivoice_wr,
      jlp_dr     => jlp_dr,
      jlp_dw     => jlp_dw,
      jlp_wr     => jlp_wr,
      cart_dr    => cart_dr,
      cart_dw    => cart_dw,
      cart_rd    => cart_rd,
      cart_wr    => cart_wr,
      cart_pwr   => cart_pwr,
      boot       => boot,
      rom_we     => rom_we,
      rom_sel    => rom_sel_u,
      rom_a      => rom_a_u,
      rom_d      => rom_d_u,
      hvsync     => hvsync,
      pix_we     => pix_we,
      pix_col    => pix_col_u,
      pix_x      => pix_x_u,
      pix_y      => pix_y_u,
      clk        => clk,
      cpureset_n => reset_n);

  i_cart: ENTITY work.intv_cart
    PORT MAP (
      ad         => ad,
      cart_dw    => cart_dw,
      cart_rd    => cart_rd,
      cart_wr    => cart_wr,
      cart_pwr   => cart_pwr,
      cart_dr    => cart_dr,
      paged_mask => paged_mask,
      mem_req    => mem_req,
      mem_we     => mem_we,
      mem_addr   => mem_addr_u,
      mem_wdata  => mem_wdata_u,
      mem_rdata  => mem_rdata_u,
      mem_ack    => mem_ack,
      phi        => phi_cpu,
      clk        => clk,
      reset_na   => reset_n);

  -- AY-3-8914: sound and the two hand controller ports
  i_snd: ENTITY work.snd
    PORT MAP (
      ad       => ad,
      dw       => snd_dw,
      dr       => snd_dr,
      wr       => snd_wr,
      sound    => sound_u,
      pa_i     => pa_u,
      pa_o     => pa_o,
      pa_en    => pa_en,
      pb_i     => pb_u,
      pb_o     => pb_o,
      pb_en    => pb_en,
      tick     => phi_snd,
      clk      => clk,
      reset_na => reset_n);

  -- ECS audio AY-3-8917, with the keyboard on its ports
  i_snd2: ENTITY work.snd
    PORT MAP (
      ad       => ad,
      dw       => snd2_dw,
      dr       => snd2_dr,
      wr       => snd2_wr,
      sound    => sound2,
      pa_i     => pa2_u,
      pa_o     => pa2_o_u,
      pa_en    => pa2_en,
      pb_i     => pb2_u,
      pb_o     => pb2_o,
      pb_en    => pb2_en,
      tick     => phi_snd,
      clk      => clk,
      reset_na => reset_n);

  -- Intellivoice
  i_ivoice: ENTITY work.ivoice
    PORT MAP (
      ad       => ad,
      dw       => ivoice_dw,
      dr       => ivoice_dr,
      wr       => ivoice_wr,
      phi_cpu  => phi_cpu,
      phi      => phi_ivoice,
      divi     => 358,
      sound    => sound_iv,
      gain     => "01",
      boot     => boot,
      rom_we   => voice_we,
      rom_a    => voice_a,
      rom_d    => voice_d,
      clksys   => clk,
      reset_na => reset_n);

  -- JLP registers
  i_jlp: ENTITY work.jlp
    PORT MAP (
      ad       => ad,
      dw       => jlp_dw,
      dr       => jlp_dr,
      wr       => jlp_wr,
      clk      => clk,
      reset_na => reset_n);

  -- Mix as the MiSTer core does
  Mix:PROCESS(clk) IS
    VARIABLE ay_v : uv12;
    VARIABLE ay16_v, iv16_v : sv16;
  BEGIN
    IF rising_edge(clk) THEN
      ay_v := sound_u;
      IF ecs='1' THEN
        ay_v := sound_u + sound2;
      END IF;
      ay16_v := signed(resize(ay_v, 16));
      iv16_v := resize(sound_iv(15 DOWNTO 8), 16);
      audio <= std_logic_vector(shift_left(ay16_v, 3) + shift_left(iv16_v, 3));
    END IF;
  END PROCESS Mix;

  boot      <= NOT reset_n;
  rom_sel_u <= unsigned(rom_sel);
  rom_a_u   <= unsigned(rom_a);
  rom_d_u   <= unsigned(rom_d);
  voice_we  <= rom_we WHEN rom_sel="101" ELSE '0';
  voice_a   <= unsigned(rom_a(10 DOWNTO 0));
  voice_d   <= unsigned(rom_d(7 DOWNTO 0));

  pa2_o <= std_logic_vector(pa2_o_u);
  pa2_u <= unsigned(pa2_i);
  pb2_u <= unsigned(pb2_i);

  pa_u <= unsigned(pa_i);
  pb_u <= unsigned(pb_i);

  mem_addr    <= std_logic_vector(mem_addr_u);
  mem_wdata   <= std_logic_vector(mem_wdata_u);
  mem_rdata_u <= unsigned(mem_rdata);
  pix_col     <= std_logic_vector(pix_col_u);
  pix_x       <= std_logic_vector(pix_x_u);
  pix_y       <= std_logic_vector(pix_y_u);
  dbg_ad      <= std_logic_vector(dw);
  dbg_bdic    <= std_logic_vector(bdic);
  dbg_phi     <= phi_cpu;

END ARCHITECTURE struct;
