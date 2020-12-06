----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2020 13:57:12
-- Design Name: 
-- Module Name: bit4_components_TB - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.bit4_components_pack.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit4_components_TB is
--  Port ( );
end bit4_components_TB;

architecture Behavioral of bit4_components_TB is
signal x, y : std_logic_vector(3 downto 0) := "0000";
signal c : std_logic := '0';
signal z_mult : std_logic_vector(7 downto 0);
signal z_add, z_hfadd, z_incr, z_decr : std_logic_vector(3 downto 0);
signal c_add, c_hfadd, c_incr, b_decr : std_logic;

begin

c <= not c after 1 ns;

x(0) <= not x(0) after 2 ns;
x(1) <= not x(1) after 4 ns;
x(2) <= not x(2) after 8 ns;
x(3) <= not x(3) after 16 ns;

y(0) <= not y(0) after 32 ns;
y(1) <= not y(1) after 64 ns;
y(2) <= not y(2) after 128 ns;
y(3) <= not y(3) after 256 ns;

mult : bit4_multiplier
port map( x => x,
          y => y,
          z => z_mult
);

half_adder : bit4_half_adder
port map( x => x,
          y => y,
          z => z_hfadd,
          c_out => c_hfadd
);

adder : bit4_adder 
port map( x => x,
          y => y,
          c => c,
          z => z_add,
          c_out => c_add
);

incrementer : bit4_incrementer
port map( x => x,
          c => c,
          z => z_incr,
          c_out => c_incr
);

decrementer : bit4_decrementer
port map( x => x,
          b => c,
          z => z_decr,
          b_out => b_decr
);
end Behavioral;
