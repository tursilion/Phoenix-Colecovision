--------------------------------------------------------------------------------
-- Intellivision for the Phoenix: CP1610, STIC with the system RAMs and ROMs,
-- AY-3-8914 and the cartridge.  After the MiSTer core's intv.vhd, without
-- the ECS, Intellivoice, JLP and the MiSTer I/O.
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

    -- Hand controllers as the AY-3-8914 ports read them (active low):
    -- pa = $1FE (right controller), pb = $1FF (left controller)
    pa_i       : IN  std_logic_vector(7 DOWNTO 0);
    pb_i       : IN  std_logic_vector(7 DOWNTO 0);

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

    -- Sound, unsigned
    sound      : OUT std_logic_vector(11 DOWNTO 0);

    -- For the simulation: bus address and phase
    dbg_ad     : OUT std_logic_vector(15 DOWNTO 0);
    dbg_bdic   : OUT std_logic_vector(2 DOWNTO 0);
    dbg_phi    : OUT std_logic
    );
END ENTITY intv_core;

ARCHITECTURE struct OF intv_core IS

  SIGNAL clkdiv    : uint6 := 0;
  SIGNAL clkdivsnd : uint2 := 0;
  SIGNAL phi_cpu, phi_cpup, phi_snd : std_logic := '0';

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
      ad         => ad,
      snd_dr     => snd_dr,
      snd_dw     => snd_dw,
      snd_wr     => snd_wr,
      cart_dr    => cart_dr,
      cart_dw    => cart_dw,
      cart_rd    => cart_rd,
      cart_wr    => cart_wr,
      cart_pwr   => cart_pwr,
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

  pa_u <= unsigned(pa_i);
  pb_u <= unsigned(pb_i);

  mem_addr    <= std_logic_vector(mem_addr_u);
  mem_wdata   <= std_logic_vector(mem_wdata_u);
  mem_rdata_u <= unsigned(mem_rdata);
  pix_col     <= std_logic_vector(pix_col_u);
  pix_x       <= std_logic_vector(pix_x_u);
  pix_y       <= std_logic_vector(pix_y_u);
  sound       <= std_logic_vector(sound_u);
  dbg_ad      <= std_logic_vector(dw);
  dbg_bdic    <= std_logic_vector(bdic);
  dbg_phi     <= phi_cpu;

END ARCHITECTURE struct;
