----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2020 13:19:40
-- Design Name: 
-- Module Name: bit8_components_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.bit8_components_pack.all;

entity bit8_components_TB is
--  Port ( );
end bit8_components_TB;

architecture Behavioral of bit8_components_TB is

signal x, y : std_logic_vector(7 downto 0) := (others => '0');
signal c    : std_logic := '0';
signal z_mult : std_logic_vector(15 downto 0);
signal z_incr, z_decr, z_add, z_sub : std_logic_vector(7 downto 0);
signal c_incr, b_decr, c_add, b_sub : std_logic;

begin

multi : bit8_multiplier 
port map( x => x,
          y => y,
          z => z_mult
);

decr : bit8_decrementer
port map( x => x,
          b => c,
          z => z_decr,
          b_out => b_decr
);

incr : bit8_incrementer
port map( x => x,
          c => c,
          z => z_incr,
          c_out => c_incr
);

add : bit8_adder
port map( x => x,
          y => y,
          c => c,
          z => z_add,
          c_out => c_add
);

sub : bit8_subtractor
port map( x => x,
          y => y,
          b => c,
          z => z_sub,
          b_out => b_sub
);

c <= not c after 5 ns;

x(0) <= not x(0) after 10 ns;
x(1) <= not x(1) after 20 ns;
x(2) <= not x(2) after 40 ns;
x(3) <= not x(3) after 80 ns;
x(4) <= not x(4) after 160 ns;
x(5) <= not x(5) after 320 ns;
x(6) <= not x(6) after 640 ns;
x(7) <= not x(7) after 1280 ns;

y(0) <= not y(0) after 2560 ns;
y(1) <= not y(1) after 5120 ns;
y(2) <= not y(2) after 10240 ns;
y(3) <= not y(3) after 20480 ns;
y(4) <= not y(4) after 40960 ns;
y(5) <= not y(5) after 81920 ns;
y(6) <= not y(6) after 163840 ns;
y(7) <= not y(7) after 327680 ns;

end Behavioral;
