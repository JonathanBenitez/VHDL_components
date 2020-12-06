----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2020 14:43:31
-- Design Name: 
-- Module Name: components_TB - Behavioral
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
use work.components_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity components_TB is
--  Port ( );
end components_TB;

architecture Behavioral of components_TB is

signal x, y, c, clk : std_logic := '0';
signal z_hfadd, z_add, z_hfsub, z_sub : std_logic;
signal c_hfadd, c_add, b_hfsub, b_sub : std_logic;
signal input, button_in : std_logic := '1';
signal edge_rising, edge_falling, button_out : std_logic;
signal rst : std_logic :='1';

begin

rst <= '0' after 100 ns;
clk <= not clk after 1 ns;
c <= not c after 1 ns;
x <= not x after 2 ns;
y <= not y after 4 ns;
input <= not input after 250 ns;
button_in <= not button_in after 1050000 ns;

hfadder : half_adder
port map( x => x,
          y => y,
          z => z_hfadd,
          c_out => c_hfadd
);

fadder : full_adder
port map( x => x,
          y => y,
          c => c,
          z => z_add,
          c_out => c_add
); 

hfsub : half_sub
port map( x => x,
          y => y,
          z => z_hfsub,
          b_out => b_hfsub
);

fsub : full_sub
port map( x => x,
          y => y,
          b => c,
          z => z_sub,
          b_out => b_sub
);

debounce : debouncer
port map( clk => clk,
          rst => rst,
          button_in => button_in,
          button_out => button_out
);

redge : rising_edge_detector
port map( input => input,
          clk => clk,
          rst => rst,
          edge => edge_rising
);

fedge : falling_edge_detector
port map( input => input,
          clk => clk,
          rst => rst,
          edge => edge_falling
);

end Behavioral;
