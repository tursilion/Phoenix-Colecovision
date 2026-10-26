--------------------------------------------------------------------------------
-- Intellivision
--------------------------------------------------------------------------------
-- JLP Extensions 
--------------------------------------------------------------------------------
-- DO 10/2024
--
-- Phoenix version (intellivision/core): from the MiSTer Intv core, release
-- 20261001, without the RAM (it is in the cartridge's SRAM) and without
-- the flash (no save games yet: the flash registers report no rows).
-- Only the register ranges $8000-$803F and $9F80-$9FFF come here.
-- $9F80-$9F8F read back the last value written, as the RAM under them did.
--------------------------------------------------------------------------------

-- Additional RAM
-- Additional ROM
-- Hardware acceleration for MUL, DIV, CRC, Random numbers
-- Flash storage

-- 8000 8035  JLP FLASH Commands
-- 8023 : RO : First Valid Flash Row Number
-- 8024 : RO : Last  Valid Flash Row Number
-- 8025 : WO : Address in RAM to operate on
-- 8026 : WO : Flash Row to operate on
-- 802D : WO : Copy RAM to FLASH.  Write xC0DE
-- 802E : WO : Copy FLASH to RAM.  Write xDEC0
-- 802F : WO : Erase FLASH sector. Write xBEEF

-- 8040 9F7F  JLP RAM

-- 9F80 9FFF  JLP Accelerator
-- 9F80       RW : MPY_SS1
-- 9F81       RW : MPY_SS2
-- 9F82       RW : MPY_SU1
-- 9F83       RW : MPY_SU2
-- 9F84       RW : MPY_US1
-- 9F85       RW : MPY_US2
-- 9F86       RW : MPY_UU1
-- 9F87       RW : MPY_UU2
-- 9F88       RW : DIV_SS1 dividend
-- 9F89       RW : DIV_SS2 divisor
-- 9F8A       RW : DIV_UU1
-- 9F8B       RW : DIV_UU2

-- 9F8E       RO : Result L / Quotient
-- 9F8F       RO : Result H / Remainder

-- 9FFC       WO : CRC Write
-- 9FFD       RW : CRC Read

-- 9FFE       RO : Random number

-- 8000 9FFF  ROM Page Switch
-- A000 DFFF  ROM
-- E000 EFFF  ROM Pages
-- F000 FFFF  ROM


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.base_pack.ALL;

ENTITY jlp IS
  PORT (
    --------------------------
    -- CPU BUS
    ad       : IN  uv16;
    dw       : IN  uv16;
    dr       : OUT uv16;
    wr       : IN  std_logic;
    

    --------------------------
    clk      : IN  std_logic;
    reset_na : IN  std_logic
    );
END ENTITY jlp;


ARCHITECTURE rtl OF jlp IS
  
  ------------------------------------------------
  SIGNAL op1,      op2      : uv16;
  SIGNAL op1_sign, op2_sign : std_logic;
  SIGNAL recalc : std_logic;

  SIGNAL mul1a : uv17;
  SIGNAL mul2a : uv32;
  
  SIGNAL res_lo, res_hi : uv16;
  SIGNAL count : natural RANGE 0 TO 31;

  SIGNAL op : std_logic;
  CONSTANT OPMUL : std_logic := '0';
  CONSTANT OPDIV : std_logic := '1';

  CONSTANT ZERO17 : unsigned(16 DOWNTO 0) := (OTHERS =>'0');
  CONSTANT ZERO15 : unsigned(14 DOWNTO 0) := (OTHERS =>'0');

  TYPE enum_mulstate IS (sINIT,sCALC,sSIGN,sDONE);
  SIGNAL mulstate : enum_mulstate;

  SIGNAL drr, drm : uv16;
  SIGNAL dr_force : std_logic;

  SIGNAL op1a_sign, op2a_sign : std_logic;

  SIGNAL mul, mul2 : uv32;
  SIGNAL rmd, rmd2, quo, quo2 : uv16;

  SIGNAL div1a, div2a : unsigned(32 DOWNTO 0);
  
  SIGNAL crc_wr, crc_wr2, crc_set : std_logic;
  SIGNAL crc, crc_dw : uv16;
  SIGNAL crccount : natural RANGE 0 TO 16;

  SIGNAL lfsr : uv32;
  
  SIGNAL shadow : arr_uv16(0 TO 15); -- what was written to $9F80-$9F8F

  CONSTANT FIRST_FLASH_ROW : uv16 := x"00C0";
  --CONSTANT LAST_FLASH_ROW  : uv16 := x"03FF";
  SIGNAL last_row : uv16;

  SIGNAL flash_ad  : unsigned(12 DOWNTO 0);
  SIGNAL flash_row : uv16;

BEGIN

  -----------------------------------------------------------------------------
  -- $9F80-$9F8F read back
  ShadowRegs:PROCESS(clk) IS
  BEGIN
    IF rising_edge(clk) THEN
      drm <= shadow(to_integer(ad(3 DOWNTO 0)));
      IF wr='1' AND ad(15 DOWNTO 4)=x"9F8" THEN
        shadow(to_integer(ad(3 DOWNTO 0))) <= dw;
      END IF;
    END IF;
  END PROCESS ShadowRegs;

  dr <= drr WHEN dr_force='1' ELSE drm;

  -----------------------------------------------------------------------------
  -- Registers
  Reg:PROCESS(clk,reset_na) IS
  BEGIN
    IF reset_na='0' THEN
      recalc <= '0';

    ELSIF rising_edge(clk) THEN

      recalc  <= '0';

      crc_wr  <= '0';
      crc_set <= '0';

      dr_force <= '0';

      last_row <= FIRST_FLASH_ROW - 1; -- no flash
      
      -----------------------------------------------------
      IF ad < x"8040" THEN
        drr <= x"FFFF";
        dr_force <= '1';
      ELSIF ad >= x"9F90" AND ad < x"9FFC" THEN
        drr <= x"FFFF";
        dr_force <= '1';
      END IF;
      
      CASE ad IS
        WHEN x"8023" => -- RO : First Valid Flash Row Number
          drr <= FIRST_FLASH_ROW;
          dr_force <= '1';

        WHEN x"8024" => -- RO : Last  Valid Flash Row Number
          drr <= last_row;
          dr_force <= '1';

        WHEN x"8025" => -- WO : Address in RAM to operate on
          IF wr='1' THEN
            flash_ad <= dw(12 DOWNTO 0);
          END IF;
          drr <= "000" & flash_ad;
          dr_force <= '1';

        WHEN x"8026" => -- WO : Flash Row to operate on
          IF wr='1' THEN
            flash_row <= dw;
          END IF;
          drr <= flash_row;
          dr_force <= '1';

        WHEN x"802D" => -- WO : Copy RAM to FLASH.  Write xC0DE
          drr <= x"0000";
          dr_force <= '1';

        WHEN x"802E" => -- WO : Copy FLASH to RAM.  Write xDEC0
          drr <= x"0000";
          dr_force <= '1';

        WHEN x"802F" => -- WO : Erase FLASH sector. Write xBEEF
          drr <= x"0000";
          dr_force <= '1';

        WHEN x"9F80" => -- MPY_SS1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '1';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F81" => -- MPY_SS2
          IF wr='1' THEN
            op2      <= dw;
            op2_sign <= '1';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F82" => -- MPY_SU1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '1';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F83" => -- MPY_SU2
          IF wr='1' THEN
            op2      <= dw;
            op2_sign <= '0';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F84" => -- MPY_US1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '0';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F85" => -- MPY_US2
          IF wr='1' THEN
            op2      <= dw;
            op2_sign <= '1';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F86" => -- MPY_UU1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '0';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F87" => -- MPY_UU2
          IF wr='1' THEN
            op2      <= dw;
            op2_sign <= '0';
            op       <= OPMUL;
            recalc   <= '1';
          END IF;

        WHEN x"9F88" => -- DIV_SS1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '1';
            op2_sign <= '1';
            op       <= OPDIV;
            recalc   <= '1';
          END IF;

        WHEN x"9F89" => -- DIV_SS2
          IF wr='1' THEN
            op2      <= dw;
            op1_sign <= '1';
            op2_sign <= '1';
            op       <= OPDIV;
            recalc   <= '1';
          END IF;

        WHEN x"9F8A" => -- DIV_UU1
          IF wr='1' THEN
            op1      <= dw;
            op1_sign <= '0';
            op2_sign <= '0';
            op       <= OPDIV;
            recalc   <= '1';
          END IF;

        WHEN x"9F8B" => -- DIV_UU2
          IF wr='1' THEN
            op2      <= dw;
            op1_sign <= '0';
            op2_sign <= '0';
            op       <= OPDIV;
            recalc   <= '1';
          END IF;

        WHEN x"9F8E" => -- Result Low  / Quotient
          drr <= res_lo;
          dr_force <= '1';

        WHEN x"9F8F" => -- Result High / Remainder
          drr <= res_hi;
          dr_force <= '1';
        
        WHEN x"9FFC" => -- CRC Write
          drr      <= crc;
          dr_force <= '1';
          crc_dw  <= dw;
          crc_wr  <= wr;

        WHEN x"9FFD" => -- CRC Read
          drr      <= crc;
          dr_force <= '1';
          crc_dw  <= dw;
          crc_set <= wr;

        WHEN x"9FFE" => -- Random num read
          drr      <= lfsr(15 DOWNTO 0);
          dr_force <= '1';

        WHEN x"9FFF" => -- Zero
          drr      <= x"0000";
          dr_force <= '1';

        WHEN OTHERS =>
          
      END CASE;
      

      ---------------------------------------------------
    END IF;
  END PROCESS Reg;

  -----------------------------------------------------------------------------
  Muldiv:PROCESS(clk,reset_na) IS
    VARIABLE div_v : unsigned(32 DOWNTO 0);
  BEGIN
    IF reset_na='0' THEN
      mulstate <=sINIT;

    ELSIF rising_edge(clk) THEN

      IF recalc ='1' THEN
        mulstate <= sINIT;
      ELSE
        CASE mulstate IS
          -------------------------------
          WHEN sINIT =>
            mulstate <=sCALC;
            -- MUL
            mul1a <= '0' & op1;
            IF op1_sign='1' AND op1(15)='1' THEN
              mul1a <= ZERO17 - ('1' & op1);
            END IF;

            mul2a <= x"0000" & op2;
            IF op2_sign='1' AND op2(15)='1' THEN
              mul2a <= x"0000_0000" - (x"FFFF" & op2);
            END IF;

            -- DIV
            div1a <= '0' & x"0000" & op1; -- Dividend
            IF op1_sign='1' AND op1(15)='1' THEN
              div1a <= (ZERO17 & x"0000") - ('1' & x"FFFF" & op1);
            END IF;

            div2a <= "00" & op2 & ZERO15; -- Divider
            IF op2_sign='1' AND op2(15)='1' THEN
              div2a <= (ZERO17 & x"0000") - ("11" & op2 & ZERO15);
            END IF;

            op1a_sign <= op1_sign AND op1(15);
            op2a_sign <= op2_sign AND op2(15);

            count <= 0;
            mul <= x"0000_0000";

            -- 1234 0000   F49D FFFC
            -- 1234 0000   07F9 0009

          -------------------------------
          WHEN sCALC =>
            count <= count + 1;
            IF count = 15 THEN
              mulstate <= sSIGN;
            END IF;
            
            -- MUL
            IF mul1a(count)='1' THEN
              mul <= mul + mul2a;
            END IF;
            mul2a<=mul2a(30 DOWNTO 0) & '0';

            -- DIV
            div_v := div1a - div2a;
            quo(15-count)<=NOT div_v(32);
            IF div_v(32)='1' THEN
              div_v:=div1a;
            END IF;
            div1a <= div_v(31 DOWNTO 0) & '0';
            
          -------------------------------
          WHEN sSIGN =>
            mul2 <= mul;
            quo2 <= quo;
            rmd2 <= div1a(31 DOWNTO 16);
            IF (op1a_sign='1' OR  op2a_sign='1') AND NOT
               (op1a_sign='1' AND op2a_sign='1') THEN
              -- Negative result
              mul2 <= x"0000_0000" - mul;
              quo2 <= x"0000" - quo;
            END IF;
            IF op1a_sign='1' THEN
              rmd2 <= x"0000" - div1a(31 DOWNTO 16);
            END IF;
            mulstate <= sDONE;
          
          -------------------------------
          WHEN sDONE =>
            IF op=OPMUL THEN
              res_lo <= mul2(15 DOWNTO 0);
              res_hi <= mul2(31 DOWNTO 16);
            ELSE
              res_lo <= quo2;
              res_hi <= rmd2;
            END IF;

          -------------------------------
        END CASE;
      END IF;
    END IF;
  END PROCESS Muldiv;

  -----------------------------------------------------------------------------
  -- Synchronous reset here: XST made a latch of crccount's reset value.
  Cyclic:PROCESS(clk) IS
    CONSTANT POLY  : uv16 := x"AD52";

  BEGIN
    IF rising_edge(clk) THEN
      ---------------------------------
      -- CRC
      IF crc_set='1' THEN
        crc <= crc_dw;
      END IF;

      crc_wr2 <= crc_wr;
      IF crc_wr='1' AND crc_wr2='0' THEN
        crccount <= 0;
        crc <= crc XOR crc_dw;
      END  IF;

      IF crccount < 16 THEN
        crccount <= crccount + 1;
        IF crc(0)='1' THEN
          crc <= ('0' & crc(15 DOWNTO 1)) XOR POLY;
        ELSE
          crc <= ('0' & crc(15 DOWNTO 1));
        END IF;
      END IF;
      
      ---------------------------------
      -- Random generator. For now just a LFSR
      lfsr <= lfsr(30 DOWNTO 0) &
        (lfsr(31) XOR lfsr(30) XOR lfsr(29) XOR lfsr(9));

      IF reset_na='0' THEN
        crc <= x"0000";
        lfsr <= x"0000_0001";
        crccount <= 16;
      END IF;

    END IF;
  END PROCESS Cyclic;
  
END ARCHITECTURE rtl;
