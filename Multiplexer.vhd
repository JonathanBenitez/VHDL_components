----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2020 14:26:54
-- Design Name: 
-- Module Name: Multiplexer - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package multiplexer_pack is 
component MUX2_1 is
port( d : in std_logic_vector(1 downto 0);
      s  : in std_logic;
      m : out std_logic
);
end component;

component MUX4_1 is
port( d : in std_logic_vector(3 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m : out std_logic
);
end component;

component MUX8_1 is
port( d : in std_logic_vector(7 downto 0);
      s : in std_logic_vector(2 downto 0);
      m : out std_logic
);
end component;

component MUX16_1 is
port( d : in std_logic_vector(15 downto 0);
      s : in std_logic_vector(3 downto 0);
      m : out std_logic
);
end component;

component MUX16_4 is
port( d0 : in std_logic_vector(3 downto 0);
      d1 : in std_logic_vector(3 downto 0);
      d2 : in std_logic_vector(3 downto 0);
      d3 : in std_logic_vector(3 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m  : out std_logic_vector(3 downto 0)
);
end component;

component MUX8_2 is
port( d0 : in std_logic_vector(3 downto 0);
      d1 : in std_logic_vector(3 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m  : out std_logic_vector(3 downto 0)
);
end component;

component MUX8_4 is
port( d0 : in std_logic_vector(3 downto 0);
      d1 : in std_logic_vector(3 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m  : out std_logic_vector(3 downto 0)
);
end component;
end multiplexer_pack;

---------------------------
---- MUX2-to-1  ----
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_1 is
port( d : in std_logic_vector(1 downto 0);
      s : in std_logic;
      m : out std_logic
);
end entity;

architecture behavioral of MUX2_1 is

begin

m <= (d(0) and not(s)) or (d(1) and s);
end behavioral;

---------------------------
------- MUX4-to-1  --------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4_1 is
port( d : in std_logic_vector(3 downto 0);
      s : in std_logic_vector(1 downto 0);
      m : out std_logic
);
end entity;

architecture behavioral of MUX4_1 is

signal s_not, sig : std_logic_vector(1 downto 0);
begin

s_not <= not(s);
sig(0) <= ((d(0) and s_not(0)) or (d(1) and s(0))) and s_not(1);
sig(1) <= ((d(2) and s_not(0)) or (d(2) and s(0))) and s(1);
m <=  sig(0) or sig(1);

end behavioral;

---------------------------
------- MUX8-to-1  --------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8_1 is
port( d  : in std_logic_vector(7 downto 0);
      s  : in std_logic_vector(2 downto 0);
      m : out std_logic
);
end MUX8_1;

architecture behavioral of MUX8_1 is
signal sig0, sig1, s_not : std_logic_vector(2 downto 0);

begin
s_not <= not(s);
sig0(0) <= ((d(0) and s_not(0)) or (d(1) and s(0))) and s_not(1);
sig0(1) <= ((d(2) and s_not(0)) or (d(3) and s(0))) and s(1);
sig0(2) <= (sig0(0) or sig0(1)) and s_not(2);
sig1(0) <= ((d(4) and s_not(0)) or (d(5) and s(0))) and s_not(1);
sig1(1) <= ((d(6) and s_not(0)) or (d(7) and s(0))) and s(1);
sig1(2) <= (sig1(0) or sig1(1)) and s(2);
m <= sig0(2) or sig1(2);
end behavioral;

---------------------------
------- MUX16-to-1  -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16_1 is 
port( d : in std_logic_vector(15 downto 0);
      s : in std_logic_vector(3 downto 0);
      m : out std_logic
);
end MUX16_1;

architecture behavioral of MUX16_1 is
signal sig0, sig1, sig2, sig3: std_logic_vector(2 downto 0);
signal sig4 : std_logic_vector(1 downto 0);
signal s_not : std_logic_vector(3 downto 0);

begin

s_not <= not(s);

sig0(0) <= ((d(0) and s_not(0)) or (d(1) and s(0))) and s_not(1);
sig0(1) <= ((d(2) and s_not(0)) or (d(3) and s(1))) and s(1);
sig0(2) <= (sig0(0) or sig0(1)) and s_not(2);

sig1(0) <= ((d(4) and s_not(0)) or (d(5) and s(0))) and s_not(1);
sig1(1) <= ((d(6) and s_not(0)) or (d(7) and s(0))) and s(1);
sig1(2) <= (sig1(0) or sig1(1)) and s(2);

sig2(0) <= ((d(8) and s_not(0)) or (d(9) and s(0)))   and s_not(1);
sig2(1) <= ((d(10) and s_not(0)) or (d(11) and s(0))) and s(1);
sig2(2) <= (sig2(0) or sig2(1)) and s_not(2);

sig3(0) <= ((d(12) and s_not(0)) or (d(13) and s(0))) and s_not(1);
sig3(1) <= ((d(14) and s_not(0)) or (d(15) and s(0))) and s(1);
sig3(2) <= (sig3(0) or sig3(1)) and s(2);

sig4(0) <= (sig0(2) or sig1(2)) and s_not(3);
sig4(1) <= (sig2(2) or sig3(2)) and s(3);
m <= sig4(0) or sig4(1);
end behavioral;

---------------------------
------ MUX4-to-2  -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4_2 is
port( d0 : in std_logic_vector(1 downto 0);
      d1 : in std_logic_vector(1 downto 0);
      s : in std_logic;
      m : out std_logic_vector(1 downto 0)
);
end MUX4_2;

architecture behavioral of MUX4_2 is

signal s_not : std_logic;
begin
s_not <= s;
m(0) <= (d0(0) and s_not) or (d1(0) and s);
m(1) <= (d0(1) and s_not) or (d1(1) and s);

end behavioral;

---------------------------
------ MUX8-to-4 -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8_4 is
port( d0 : in std_logic_vector(3 downto 0);
      d1 : in std_logic_vector(3 downto 0);
      s  : in std_logic;
      m  : out std_logic_vector(3 downto 0)
);
end MUX8_4;

architecture behavioral of MUX8_4 is

signal s_not : std_logic;
begin

s_not <= not(s);

m(0) <= (d0(0) and s_not) or (d1(0) and s);
m(1) <= (d0(1) and s_not) or (d1(1) and s);
m(2) <= (d0(2) and s_not) or (d1(2) and s);
m(3) <= (d0(3) and s_not) or (d1(3) and s);

end behavioral;

---------------------------
------- MUX8-to-2 ---------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8_2 is
port( d0 : in std_logic_vector(1 downto 0);
      d1 : in std_logic_vector(1 downto 0);
      d2 : in std_logic_vector(1 downto 0);
      d3 : in std_logic_vector(1 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m  : out std_logic_vector(1 downto 0)
);
end MUX8_2;

architecture behavioral of MUX8_2 is

signal sig0, sig1, s_not : std_logic_vector(1 downto 0);

begin

s_not <= not(s);
sig0(0) <= ((d0(0) and s_not(0)) or (d1(0) and s(0))) and s_not(1);
sig0(1) <= ((d2(0) and s_not(0)) or (d3(0) and s(0))) and s(1);

sig1(0) <= ((d0(1) and s_not(0)) or (d1(1) and s(0))) and s_not(1);
sig1(1) <= ((d2(1) and s_not(0)) or (d3(1) and s(0))) and s(1);

m(0) <= (sig0(0) or sig0(1));
m(1) <= (sig1(0) or sig1(1));

end behavioral;

---------------------------
------- MUX16-to-4 ---------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16_4 is
port( d0 : in std_logic_vector(3 downto 0);
      d1 : in std_logic_vector(3 downto 0);
      d2 : in std_logic_vector(3 downto 0);
      d3 : in std_logic_vector(3 downto 0);
      s  : in std_logic_vector(1 downto 0);
      m  : out std_logic_vector(3 downto 0)
);
end MUX16_4;

architecture behavioral of MUX16_4 is

signal sig0, sig1, sig2, sig3, s_not : std_logic_vector(1 downto 0);

begin

s_not <= not(s);

sig0(0) <= ((d0(0) and s_not(0)) or (d1(0) and s(0))) and s_not(1);
sig0(1) <= ((d2(0) and s_not(0)) or (d3(0) and s(0))) and s(1);

sig1(0) <= ((d0(1) and s_not(0)) or (d1(1) and s(0))) and s_not(1);
sig1(1) <= ((d2(1) and s_not(0)) or (d3(1) and s(0))) and s(1);

sig2(0) <= ((d0(2) and s_not(0)) or (d1(2) and s(0))) and s_not(1);
sig2(1) <= ((d2(2) and s_not(0)) or (d3(2) and s(0))) and s(1);

sig3(0) <= ((d0(3) and s_not(0)) or (d1(3) and s(0))) and s_not(1);
sig3(1) <= ((d2(3) and s_not(0)) or (d3(3) and s(0))) and s(1);

m(0) <= sig0(0) or sig0(1);
m(1) <= sig1(0) or sig1(1);
m(2) <= sig2(0) or sig2(1);
m(3) <= sig3(0) or sig3(1);

end behavioral;