----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2020 15:28:36
-- Design Name: 
-- Module Name: components - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

package components_pack is

component half_adder is
port( x : in std_logic;
      y : in std_logic;
      z : out std_logic;
      c_out : out std_logic
);
end component;

component full_adder is
port( x : in std_logic;
      y : in std_logic;
      c : in std_logic;
      z : out std_logic;
      c_out : out std_logic
);
end component;

component half_sub is
port( x : in std_logic;
      y : in std_logic;
      z : out std_logic;
      c_out : out std_logic
);
end component;

component debouncer is
port( clk : in std_logic;
      rst : in std_logic;
      button_in : in std_logic;
      button_out : out std_logic
);
end component;

component falling_edge_detector is
port( input : in std_logic;
      clk   : in std_logic;
      rst   : in std_logic;
      edge  : out std_logic
);
end component;

component rising_edge_detector is
port( input : in std_logic;
      clk   : in std_logic;
      rst   : in std_logic;
      edge  : out std_logic
);
end component;

end components_pack;
---------------------------
------- HALF  ADDER -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
Port ( x : in std_logic;
       y : in std_logic;
       z : out std_logic;
       c_out : out std_logic
       );
end half_adder;

architecture Behavioral of half_adder is

begin

z <= x xor y;
c_out <= x and y;

end Behavioral;


---------------------------
------- FULL  ADDER -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
Port ( x : in std_logic;
       y : in std_logic;
       c : in std_logic; 
       z : out std_logic;
       c_out : out std_logic
       );
end full_adder;

architecture Behavioral of full_adder is

begin

z <= x xor y xor c;
c_out <= (x and y) or (x and c) or (y and c);

end Behavioral;

---------------------------
----- HALF SUBTRACTOR -----
---------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_sub is 
port( x : in std_logic;
      y : in std_logic;
      z : out std_logic;
      c_out : out std_logic
    );
end half_sub;

architecture behavioral of half_sub is
begin

z <= x xor y;
c_out <= (not x) and y;

end behavioral;

---------------------------
-------- DEBOUNCER --------
---------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
   port ( clk        : in  std_logic;
          rst        : in  std_logic;
          button_in  : in  std_logic;
          button_out : out std_logic
        );
end debouncer;

architecture behavioral of debouncer is

   signal count      : unsigned(19 downto 0);  -- Range to count 20ms with 50 MHz clock
   signal button_tmp : std_logic;
   
begin

process ( clk )
begin
   if clk'event and clk = '1' then
      if rst = '1' then
         count <= (others => '0');
      else
         count <= count + 1;
         button_tmp <= button_in;
         
         if (count = 0) then
            button_out <= button_tmp;
         end if;
      end if;
  end if;
end process;

end behavioral;

---------------------------
-- FALLING EDGE DETECTOR --
---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity falling_edge_detector is
port ( input : in std_logic;
       clk   : in std_logic;
       rst   : in std_logic;
       edge  : out std_logic
       );
end falling_edge_detector;

architecture edge_detector_arch of falling_edge_detector is
signal reg : std_logic;

begin

seq: process( clk, rst)
begin
    if rising_edge(clk) then
        reg <= input;
        
        if rst = '1' then
            reg <= '0';
        end if;        
    end if;
end process;

edge <= (reg and (not input));

end edge_detector_arch;

---------------------------
-- RISING EDGE DETECTOR -- 
---------------------------

library ieee;
use ieee.std_logic_1164.all;

entity rising_edge_detector is
port ( input : in std_logic;
       clk   : in std_logic;
       rst   : in std_logic;
       edge  : out std_logic
       );
end rising_edge_detector;

architecture edge_detector_arch of rising_edge_detector is
signal reg : std_logic;

begin

seq: process( clk, rst)
begin
    if rising_edge(clk) then
        reg <= input;

        if rst = '1' then
            reg <= '0';
        end if;
                
    end if;
end process;

edge <= (not reg and (input));

end edge_detector_arch;