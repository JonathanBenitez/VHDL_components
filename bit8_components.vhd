----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2020 11:27:02
-- Design Name: 
-- Module Name: bit8_components - Behavioral
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

package bit8_components_pack is
component bit8_incrementer is
port( x : in std_logic_vector(7 downto 0);
      c : in std_logic;
      z : out std_logic_vector(7 downto 0);
      c_out : out std_logic
);
end component;

component bit8_decrementer is
port ( x : in std_logic_vector(7 downto 0);
       b : in std_logic;
       z : out std_logic_vector(7 downto 0);
       b_out : out std_logic
);
end component;

component bit8_adder is
port( x : in std_logic_vector(7 downto 0);
      y : in std_logic_vector(7 downto 0);
      c : in std_logic;
      z : out std_logic_vector(7 downto 0);
      c_out : out std_logic
);
end component;

component bit8_multiplier is
port( x : in std_logic_vector(7 downto 0);
      y : in std_logic_vector(7 downto 0);
      z : out std_logic_vector(15 downto 0)
);
end component;
end bit8_components_pack;



---------------------------
---- 8BIT INCREMENTER  ----
---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_incrementer is
Port ( x : in std_logic_vector(7 downto 0);
       c : in std_logic;
       z : out std_logic_vector(7 downto 0);
       c_out : out std_logic
);
end bit8_incrementer;

architecture Behavioral of bit8_incrementer is
component bit4_incrementer is
port ( x : in std_logic_vector(3 downto 0);
       c : in std_logic;
       z : out std_logic_vector(3 downto 0);
       c_out : out std_logic
);

end component;

signal carry : std_logic;
begin

incr0 : bit4_incrementer
port map( x => x(3 downto 0),
          c => c,
          z => z(3 downto 0),
          c_out => carry
);
incr1 :bit4_incrementer
port map( x => x(7 downto 4),
          c => carry,
          z => z(7 downto 4),
          c_out => c_out
);

end Behavioral;

---------------------------
---- 8BIT DECREMENTER  ----
---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_decrementer is
port ( x : in std_logic_vector(7 downto 0);
       b : in std_logic;
       z : out std_logic_vector(7 downto 0);
       b_out : out std_logic
);
end entity;

architecture behavioral of bit8_decrementer is
component bit4_decrementer is
port ( x : in std_logic_vector(3 downto 0);
       b : in std_logic;
       z : out std_logic_vector(3 downto 0);
       b_out : out std_logic
);
end component;
signal borrow : std_logic;

begin

decr0 : bit4_decrementer
port map(x => x(3 downto 0),
         b => b,
         z => z(3 downto 0),
         b_out => borrow
);

decr1 : bit4_decrementer
port map(x => x(7 downto 4),
         b => borrow,
         z => z(7 downto 4),
         b_out => b_out
);

end behavioral;

---------------------------
----    8BIT ADDER     ----
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_adder is 
port( x : in std_logic_vector(7 downto 0);
      y : in std_logic_vector(7 downto 0);
      c : in std_logic;
      z : out std_logic_vector(7 downto 0);
      c_out : out std_logic
);
end bit8_adder;

architecture behavioral of bit8_adder is
component bit4_adder is
port(  x : in std_logic_vector(3 downto 0);
       y : in std_logic_vector(3 downto 0);
       c : in std_logic;
       z : out std_logic_vector(3 downto 0);
       c_out : out std_logic
);
end component;
signal carry : std_logic;

begin

add0 : bit4_adder
port map( x => x(3 downto 0),
          y => y(3 downto 0),
          c => c,
          z => z(3 downto 0),
          c_out => carry
);

add1 : bit4_adder
port map( x => x(7 downto 4),
          y => y(7 downto 4),
          c => carry,
          z => z(7 downto 4),
          c_out => c_out
);

end behavioral;

---------------------------
---- 8BIT MULTIPLIER   ----
---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_multiplier is
port( x : in std_logic_vector(7 downto 0);
      y : in std_logic_vector(7 downto 0);
      z : out std_logic_vector(15 downto 0)     
);
end bit8_multiplier;

architecture behavioral of bit8_multiplier is
component bit4_half_adder is
port( x : in std_logic_vector(3 downto 0);
      y : in std_logic_vector(3 downto 0);
      z : out std_logic_vector(3 downto 0);
      c_out : out std_logic
);
end component;

component bit4_adder is
port( x : in std_logic_vector(3 downto 0);
      y : in std_logic_vector(3 downto 0);
      c : in std_logic;
      z : out std_logic_vector(3 downto 0);
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

component half_adder is
port( x : in std_logic;
      y : in std_logic;
      z : out std_logic;
      c_out : out std_logic
);
end component;

signal z0, z1, z2, z3, z4, z5, z6, a0, b0, b1, b2, b3, b4, b5, b6 : std_logic_vector(7 downto 0);
signal a1, a2, a3, a4, a5, a6 : std_logic_vector(3 downto 0);
signal c0 : std_logic_vector(4 downto 0);
signal c1, c2, c3, c4, c5, c6 : std_logic_vector(1 downto 0);

begin

z <= (0 => a0(0), 1 => z0(0), 2 => z1(0), 3 => z2(0), 4 => z3(0), 5 => z4(0), 6 => z5(0), 7 => z6(0), 8 => z6(1),
9 => z6(2), 10 => z6(3), 11 => z6(4), 12 => z6(5), 13 => z6(6), 14 => z6(7), 15 => c6(1));

add00 : bit4_half_adder
port map( x => b0(3 downto 0),
          y => a0(4 downto 1),
          z => z0(3 downto 0),
          c_out => c0(0)
);
ff01 : full_adder
port map( x => b0(4),
          y => a0(5),
          c => c0(0),
          z => z0(4),
          c_out => c0(1)
);
ff02 : full_adder
port map( x => b0(5),
          y => a0(6),
          c => c0(1),
          z => z0(5),
          c_out =>c0(2)
); 
ff03 : full_adder
port map( x => b0(6),
          y => a0(7),
          c => c0(2),
          z => z0(6),
          c_out => c0(3)
);
hf04 : half_adder
port map( x => b0(7),
          y => c0(3),
          z => z0(7),
          c_out => c0(4)
);

add10 : bit4_half_adder
port map( x => b1(3 downto 0),
          y => z0(4 downto 1),
          z => z1(3 downto 0),
          c_out => c1(0)
);
add11 : bit4_adder
port map( x => b1(7 downto 4),
          y => a1,
          c => c1(0),
          z => z1(7 downto 4),
          c_out => c1(1)
);

add20 : bit4_half_adder
port map( x => b2(3 downto 0),
          y => z1(4 downto 1),
          z => z2(3 downto 0),
          c_out => c2(0)
);
add21 : bit4_adder
port map( x => b2(7 downto 4),
          y => a2,
          c => c2(0),
          z => z2(7 downto 4),
          c_out => c2(1)
);

add30 : bit4_half_adder
port map( x => b3(3 downto 0),
          y => z2(4 downto 1),
          z => z3(3 downto 0),
          c_out => c3(0)
);
add31 : bit4_adder
port map( x => b3(7 downto 4),
          y => a3,
          c => c3(0),
          z => z3(7 downto 4),
          c_out => c3(1)
);             

add40 : bit4_half_adder
port map( x => b4(3 downto 0),
          y => z3(4 downto 1),
          z => z4(3 downto 0),
          c_out => c4(0)
);
add41 : bit4_adder
port map( x => b4(7 downto 4),
          y => a4,
          c => c4(0),
          z => z4(7 downto 4),
          c_out => c4(1)
);

add50 : bit4_half_adder
port map( x => b5(3 downto 0),
          y => z4(4 downto 1),
          z => z5(3 downto 0),
          c_out => c5(0)
);
add51 : bit4_adder
port map( x => b5(7 downto 4),
          y => a5,
          c => c5(0),
          z => z5(7 downto 4),
          c_out => c5(1)
);

add60 : bit4_half_adder
port map( x => b6(3 downto 0),
          y => z5(4 downto 1),
          z => z6(3 downto 0),
          c_out => c6(0)
);
add61 : bit4_adder
port map( x => b6(7 downto 4),
          y => a6,
          c => c6(0),
          z => z6(7 downto 4),
          c_out => c6(1)
);

a1 <= (0 => z0(5), 1 => z0(6), 2 => z0(7), 3 => c0(4));
a2 <= (0 => z1(5), 1 => z1(6), 2 => z1(7), 3 => c1(1));
a3 <= (0 => z2(5), 1 => z2(6), 2 => z2(7), 3 => c2(1));
a4 <= (0 => z3(5), 1 => z3(6), 2 => z3(7), 3 => c3(1));
a5 <= (0 => z4(5), 1 => z4(6), 2 => z4(7), 3 => c4(1));
a6 <= (0 => z5(5), 1 => z5(6), 2 => z5(7), 3 => c5(1));

a0(0) <= x(0) and y(0);
a0(1) <= x(1) and y(0);
a0(2) <= x(2) and y(0);
a0(3) <= x(3) and y(0);
a0(4) <= x(4) and y(0);
a0(5) <= x(5) and y(0);
a0(6) <= x(6) and y(0);
a0(7) <= x(7) and y(0);

b0(0) <= x(0) and y(1);
b0(1) <= x(1) and y(1);
b0(2) <= x(2) and y(1);
b0(3) <= x(3) and y(1);
b0(4) <= x(4) and y(1);
b0(5) <= x(5) and y(1);
b0(6) <= x(6) and y(1);
b0(7) <= x(7) and y(1);

b1(0) <= x(0) and y(2);
b1(1) <= x(1) and y(2);
b1(2) <= x(2) and y(2);
b1(3) <= x(3) and y(2);
b1(4) <= x(4) and y(2);
b1(5) <= x(5) and y(2);
b1(6) <= x(6) and y(2);
b1(7) <= x(7) and y(2);

b2(0) <= x(0) and y(3);
b2(1) <= x(1) and y(3);
b2(2) <= x(2) and y(3);
b2(3) <= x(3) and y(3);
b2(4) <= x(4) and y(3);
b2(5) <= x(5) and y(3);
b2(6) <= x(6) and y(3);
b2(7) <= x(7) and y(3);

b3(0) <= x(0) and y(4);
b3(1) <= x(1) and y(4);
b3(2) <= x(2) and y(4);
b3(3) <= x(3) and y(4);
b3(4) <= x(4) and y(4);
b3(5) <= x(5) and y(4);
b3(6) <= x(6) and y(4);
b3(7) <= x(7) and y(4);

b4(0) <= x(0) and y(5);
b4(1) <= x(1) and y(5);
b4(2) <= x(2) and y(5);
b4(3) <= x(3) and y(5);
b4(4) <= x(4) and y(5);
b4(5) <= x(5) and y(5);
b4(6) <= x(6) and y(5);
b4(7) <= x(7) and y(5);

b5(0) <= x(0) and y(6);
b5(1) <= x(1) and y(6);
b5(2) <= x(2) and y(6);
b5(3) <= x(3) and y(6);
b5(4) <= x(4) and y(6);
b5(5) <= x(5) and y(6);
b5(6) <= x(6) and y(6);
b5(7) <= x(7) and y(6);

b6(0) <= x(0) and y(7);
b6(1) <= x(1) and y(7);
b6(2) <= x(2) and y(7);
b6(3) <= x(3) and y(7);
b6(4) <= x(4) and y(7);
b6(5) <= x(5) and y(7);
b6(6) <= x(6) and y(7);
b6(7) <= x(7) and y(7);

end behavioral;