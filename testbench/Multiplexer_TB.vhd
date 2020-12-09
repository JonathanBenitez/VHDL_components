----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2020 16:27:54
-- Design Name: 
-- Module Name: Multiplexer_TB - Behavioral
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
use work.Multiplexer_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer_TB is
--  Port ( );
end Multiplexer_TB;

architecture Behavioral of Multiplexer_TB is

signal input : std_logic_vector(15 downto 0) := (others => '0');
signal ctrl :  std_logic_vector(3 downto 0) := (others => '0');
signal out2, out4, out8, out16 : std_logic;

begin
ctrl(0) <= not ctrl(0) after 50 ps;
ctrl(1) <= not ctrl(1) after 100 ps;
ctrl(2) <= not ctrl(2) after 200 ps;
ctrl(3) <= not ctrl(3) after 400 ps;

input(0) <= not(input(0)) after 800ps;
input(1) <= not(input(1)) after 1.6ns;
input(2) <= not(input(2)) after 3.2ns;
input(3) <= not(input(3)) after 6.4ns;
input(4) <= not(input(4)) after 12.8ns;
input(5) <= not(input(5)) after 25.6ns;
input(6) <= not(input(6)) after 51.2ns;
input(7) <= not(input(7)) after 102.4ns;
input(8) <= not(input(8)) after 204.8ns;
input(9) <= not(input(9)) after 409.6ns;
input(10) <= not(input(10)) after 819.2ns;
input(11) <= not(input(11)) after 1638.4ns;
input(12) <= not(input(12)) after 3276.8ns;
input(13) <= not(input(10)) after 6553600 ps;
input(14) <= not(input(11)) after 13107200 ps;
input(15) <= not(input(12)) after 26214400 ps;


m2_1 : MUX2_1
port map( d => input(1 downto 0),
          s => ctrl(0),
          m => out2
);

m4_1 :MUX4_1
port map( d => input(3 downto 0),
          s => ctrl(1 downto 0),
          m => out4
);

m8_1 : MUX8_1
port map( d => input(7 downto 0),
          s => ctrl(2 downto 0),
          m => out8
);

m16_1: MUX16_1
port map( d => input(15 downto 0),
          s => ctrl(3 downto 0),
          m => out16
);

end Behavioral;
