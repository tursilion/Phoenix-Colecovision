--------------------------------------------------------------------------------
-- Intellivision cartridge for the Phoenix: a page table and the 512Kx8 SRAM.
--------------------------------------------------------------------------------
-- The boot loader works out the cartridge's memory map (from the .CFG file,
-- the Intellicart .ROM header, or the CRC of a raw .BIN) and writes it to a
-- page table at the top of the SRAM before it starts the game:
--
--   4096 entries of 2 bytes at SRAM 7E000, indexed by page & A[15:8]:
--     byte 0  bit 7 readable, bit 6 writable, bit 5 8-bit RAM,
--             bits 1:0 SRAM page bits 9:8
--     byte 1  SRAM page bits 7:0
--   The word at CPU address A is at SRAM byte address
--   {page[9:0], A[7:0], 0} (high byte) and +1 (low byte).  8-bit RAM uses
--   the low byte only.
--
-- page is the 4K zone's page register for the zones set in paged_mask
-- (jzintv's "PAGE n" mappings, switched by writing $xA5y to $xFFF), else 0.
--
-- One access per CPU bus phase, started 5 clocks after phi like the MiSTer
-- core's cartridge: two table reads, then the data reads or writes.  The
-- SRAM port is one byte per request, acknowledged when done.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.base_pack.ALL;

ENTITY intv_cart IS
  PORT (
    ad         : IN  uv16;
    cart_dw    : IN  uv16;
    cart_rd    : IN  std_logic;
    cart_wr    : IN  std_logic;
    cart_pwr   : IN  std_logic;
    cart_dr    : OUT uv16;

    paged_mask : IN  std_logic_vector(15 DOWNTO 0);

    -- SRAM, one byte per request
    mem_req    : OUT std_logic;
    mem_we     : OUT std_logic;
    mem_addr   : OUT unsigned(18 DOWNTO 0);
    mem_wdata  : OUT uv8;
    mem_rdata  : IN  uv8;
    mem_ack    : IN  std_logic;

    phi        : IN  std_logic;
    clk        : IN  std_logic;
    reset_na   : IN  std_logic
    );
END ENTITY intv_cart;

ARCHITECTURE rtl OF intv_cart IS

  CONSTANT TABLE_BASE : unsigned(18 DOWNTO 13) := "111111"; -- 7E000

  TYPE enum_state IS (sIDLE, sTAB_HI, sTAB_LO, sDECIDE, sDATA_HI, sDATA_LO);
  SIGNAL state : enum_state;

  SIGNAL phi_d : unsigned(4 DOWNTO 0);
  SIGNAL pages : arr_uv4(0 TO 15);
  SIGNAL zone  : uint4;
  SIGNAL idx   : uv12;
  SIGNAL ent_hi : uv8;
  SIGNAL spage : unsigned(9 DOWNTO 0);
  SIGNAL wr    : std_logic;
  SIGNAL req   : std_logic;
  SIGNAL dri   : uv16;

BEGIN

  zone <= to_integer(ad(15 DOWNTO 12));
  mem_req <= req;
  cart_dr <= dri;

  PROCESS (clk, reset_na) IS
  BEGIN
    IF reset_na='0' THEN
      pages <= (OTHERS => x"0");
      state <= sIDLE;
      req   <= '0';
      dri   <= x"FFFF";
      phi_d <= (OTHERS => '0');

    ELSIF rising_edge(clk) THEN
      phi_d <= phi_d(3 DOWNTO 0) & phi;

      -- Page registers: $xA5y written to $xFFF selects page y of zone x.
      IF cart_pwr='1' AND ad(11 DOWNTO 0)=x"FFF" AND
         cart_dw(11 DOWNTO 4)=x"A5" AND cart_dw(15 DOWNTO 12)=ad(15 DOWNTO 12) AND
         paged_mask(zone)='1' THEN
        pages(zone) <= cart_dw(3 DOWNTO 0);
      END IF;

      CASE state IS
        WHEN sIDLE =>
          IF phi_d(4)='1' AND (cart_rd='1' OR cart_wr='1') THEN
            wr <= cart_wr;
            IF paged_mask(zone)='1' THEN
              idx <= pages(zone) & ad(15 DOWNTO 8);
            ELSE
              idx <= x"0" & ad(15 DOWNTO 8);
            END IF;
            state <= sTAB_HI;
          END IF;

        WHEN sTAB_HI =>
          mem_addr <= TABLE_BASE & idx & '0';
          mem_we   <= '0';
          req      <= '1';
          IF mem_ack='1' THEN
            req    <= '0';
            ent_hi <= mem_rdata;
            state  <= sTAB_LO;
          END IF;

        WHEN sTAB_LO =>
          mem_addr <= TABLE_BASE & idx & '1';
          req      <= '1';
          IF mem_ack='1' THEN
            req    <= '0';
            spage  <= ent_hi(1 DOWNTO 0) & mem_rdata;
            state  <= sDECIDE;
          END IF;

        WHEN sDECIDE =>
          IF wr='0' AND ent_hi(7)='1' THEN
            -- Read: 16-bit words high byte first, 8-bit RAM low byte only
            IF ent_hi(5)='1' THEN
              state <= sDATA_LO;
            ELSE
              state <= sDATA_HI;
            END IF;
          ELSIF wr='0' THEN
            dri   <= x"FFFF"; -- nothing there
            state <= sIDLE;
          ELSIF ent_hi(6)='1' THEN
            IF ent_hi(5)='1' THEN
              state <= sDATA_LO;
            ELSE
              state <= sDATA_HI;
            END IF;
          ELSE
            state <= sIDLE; -- write to ROM or nothing
          END IF;

        WHEN sDATA_HI =>
          mem_addr  <= spage & ad(7 DOWNTO 0) & '0';
          mem_we    <= wr;
          mem_wdata <= cart_dw(15 DOWNTO 8);
          req       <= '1';
          IF mem_ack='1' THEN
            req   <= '0';
            dri(15 DOWNTO 8) <= mem_rdata;
            state <= sDATA_LO;
          END IF;

        WHEN sDATA_LO =>
          mem_addr  <= spage & ad(7 DOWNTO 0) & '1';
          mem_we    <= wr;
          mem_wdata <= cart_dw(7 DOWNTO 0);
          req       <= '1';
          IF mem_ack='1' THEN
            req   <= '0';
            dri(7 DOWNTO 0) <= mem_rdata;
            IF ent_hi(5)='1' THEN
              dri(15 DOWNTO 8) <= x"00";
            END IF;
            state <= sIDLE;
          END IF;
      END CASE;
    END IF;
  END PROCESS;

END ARCHITECTURE rtl;
