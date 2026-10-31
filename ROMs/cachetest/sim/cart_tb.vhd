-- Runs the cache test image on the core's T80 with a model of the MegaCart
-- or SGM banking and of the VDP's video RAM, then prints the screen.
--
--   ghdl -r --std=08 cart_tb -gIMAGE=../CACHE1M.ROM -gSGM=false -gCYCLES=n
--
-- Reset starts at a JP to the cartridge's start address (the BIOS's test
-- mode).  The image is not cached here: this checks the test program and
-- the image, not the core.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity cart_tb is
   generic ( IMAGE  : string  := "../CACHE1M.ROM"
           ; SGM    : boolean := false
           ; CYCLES : natural := 20000000 );
end entity;

architecture sim of cart_tb is
   type bytes_t is array (natural range <>) of natural range 0 to 255;
   type char_file is file of character;

   impure function load(name : string) return bytes_t is
      file f : char_file open read_mode is name;
      variable img : bytes_t(0 to 2 * 1024 * 1024 - 1) := (others => 0);
      variable c : character;
      variable n : natural := 0;
   begin
      while not endfile(f) and n < img'length loop
         read(f, c);
         img(n) := character'pos(c);
         n := n + 1;
      end loop;
      report "image: " & integer'image(n) & " bytes";
      return img;
   end function;


   signal clk, rst_n : std_logic := '0';
   signal m1_n, mreq_n, iorq_n, rd_n, wr_n : std_logic;
   signal a : std_logic_vector(15 downto 0);
   signal di, do : std_logic_vector(7 downto 0);
   signal done : boolean := false;
begin

   cpu : entity work.T80se
   generic map ( Mode => 0, T2Write => 1, IOWait => 1 )
   port map
   ( RESET_n => rst_n, CLK_n => clk, CLKEN => '1', WAIT_n => '1'
   , INT_n => '1', NMI_n => '1', BUSRQ_n => '1'
   , M1_n => m1_n, MREQ_n => mreq_n, IORQ_n => iorq_n, RD_n => rd_n
   , WR_n => wr_n, RFSH_n => open, HALT_n => open, BUSAK_n => open
   , A => a, DI => di, DO => do );

   clk <= not clk after 5 ns when not done;

   process
      variable img  : bytes_t(0 to 2 * 1024 * 1024 - 1);
      variable ram  : bytes_t(0 to 32767) := (others => 0);
      variable vram : bytes_t(0 to 16383) := (others => 0);
      variable addr, nbanks, bank, pa, pc, pe, vaddr, vlatch, n : natural := 0;
      variable vfirst : boolean := true;
      variable wr_d, mreq_d : std_logic := '1';
      variable l : line;
      variable c : integer;
   begin
      img := load(IMAGE);
      nbanks := 64;                      -- 1M MegaCart
      bank := 63;
      pa := 1; pc := 2; pe := 3;
      ram(0) := 16#C3#; ram(1) := 16#0C#; ram(2) := 16#80#;   -- JP $800C
      rst_n <= '0';
      for i in 0 to 9 loop wait until rising_edge(clk); end loop;
      rst_n <= '1';

      for cyc in 0 to CYCLES loop
         wait until falling_edge(clk);
         addr := to_integer(unsigned(a));

         -- Memory reads
         if addr < 16#8000# then
            di <= std_logic_vector(to_unsigned(ram(addr), 8));
         elsif not SGM then
            if addr < 16#C000# then
               di <= std_logic_vector(to_unsigned(img((nbanks - 1) * 16384 + addr - 16#8000#), 8));
            else
               di <= std_logic_vector(to_unsigned(img(bank * 16384 + addr - 16#C000#), 8));
            end if;
         else
            case (addr - 16#8000#) / 8192 is
            when 0 => n := 0;
            when 1 => n := pa;
            when 2 => n := pc;
            when others => n := pe;
            end case;
            di <= std_logic_vector(to_unsigned(img(n * 8192 + addr mod 8192), 8));
         end if;

         -- MegaCart: any access to $FFC0-$FFFF selects the bank
         if not SGM and mreq_n = '0' and mreq_d = '1' and addr >= 16#FFC0# then
            bank := addr mod 64;
         end if;

         -- Writes: RAM, SGM page registers, VDP
         if wr_n = '0' and wr_d = '1' then
            if mreq_n = '0' then
               if addr < 16#8000# then
                  ram(addr) := to_integer(unsigned(do));
               elsif SGM and addr = 16#FFFC# then pa := to_integer(unsigned(do));
               elsif SGM and addr = 16#FFFD# then pc := to_integer(unsigned(do));
               elsif SGM and addr = 16#FFFE# then pe := to_integer(unsigned(do));
               end if;
            elsif iorq_n = '0' then
               if (addr mod 256) = 16#BF# then
                  if vfirst then
                     vlatch := to_integer(unsigned(do));
                  elsif do(7) = '0' then
                     vaddr := (to_integer(unsigned(do)) mod 64) * 256 + vlatch;
                  end if;
                  vfirst := not vfirst;
               elsif (addr mod 256) = 16#BE# then
                  vram(vaddr) := to_integer(unsigned(do));
                  vaddr := (vaddr + 1) mod 16384;
                  vfirst := true;
               end if;
            end if;
         end if;
         wr_d := wr_n;
         mreq_d := mreq_n;
      end loop;

      -- The name table as text
      for row in 0 to 23 loop
         for col in 0 to 31 loop
            c := vram(16#1800# + row * 32 + col);
            if c >= 32 and c < 127 then
               write(l, character'val(c));
            else
               write(l, '.');
            end if;
         end loop;
         writeline(output, l);
      end loop;
      done <= true;
      wait;
   end process;
end architecture;
