----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 20.11.2020 14:10:53
-- Design Name: 
-- Module Name: bit4_multiplier - Behavioral
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

package bit4_components_pack is
component bit4_multiplier is
port ( x : in std_logic_vector(3 downto 0);
       y : in std_logic_vector(3 downto 0);
       z : out std_logic_vector(7 downto 0)
);
end component;

component bit4_half_adder is
port( x : in std_logic_vector(3 downto 0);
      y : in std_logic_vector(3 downto 0);
      z : out std_logic_vector(3 downto 0);
      c_out : out std_logic
);
end component;

component bit4_adder is
port ( x : in std_logic_vector(3 downto 0);
       y : in std_logic_vector(3 downto 0);
       c : in std_logic;
       z : out std_logic_vector(3 downto 0);
       c_out : out std_logic
);
end component;

component bit4_incrementer is 
port( x : in std_logic_vector(3 downto 0);
      c : in std_logic;
      z : out std_logic_vector(3 downto 0);
      c_out : out std_logic
);
end component;

component bit4_decrementer is
port( x : in std_logic_vector(3 downto 0);
      b : in std_logic;
      z : out std_logic_vector(3 downto 0);
      b_out : out std_logic
);
end component;

end bit4_components_pack;


---------------------------
---- 4BIT  MULTIPLIER  ----
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_multiplier is
port(x : in std_logic_vector(3 downto 0);
     y : in std_logic_vector(3 downto 0);
     z : out std_logic_vector(7 downto 0)
     );
end bit4_multiplier;

architecture Behavioral of bit4_multiplier is

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

signal c0, c1, c2, z0, z1, z2, a0, b0, b1, b2 : std_logic_vector(3 downto 0);

begin

a0(0) <= x(0) and y(0);
a0(1) <= x(1) and y(0);
a0(2) <= x(2) and y(0);
a0(3) <= x(3) and y(0);

b0(0) <= x(0) and y(1);
b0(1) <= x(1) and y(1);
b0(2) <= x(2) and y(1);
b0(3) <= x(3) and y(1);

b1(0) <= x(0) and y(2);
b1(1) <= x(1) and y(2);
b1(2) <= x(2) and y(2);
b1(3) <= x(3) and y(2);

b2(0) <= x(0) and y(3);
b2(1) <= x(1) and y(3);
b2(2) <= x(2) and y(3);
b2(3) <= x(3) and y(3);

z <= (0 => a0(0), 1 => z0(0), 2 => z1(0), 3 => z2(0), 4 => z2(1), 5 => z2(2), 6 => z2(3), 7 => c2(3));

hf00: half_adder port map (b0(0), a0(1),        z0(0), c0(0));
ff01: full_adder port map (b0(1), a0(2), c0(0), z0(1), c0(1));
ff02: full_adder port map (b0(2), a0(3), c0(1), z0(2), c0(2)); 
hf03: half_adder port map (b0(3), c0(2),        z0(3), c0(3)); 

hf10: half_adder port map (b1(0), z0(1),        z1(0), c1(0));
ff11: full_adder port map (b1(1), z0(2), c1(0), z1(1), c1(1));
ff12: full_adder port map (b1(2), z0(3), c1(1), z1(2), c1(2)); 
ff13: full_adder port map (b1(3), c0(3), c1(2), z1(3), c1(3)); 

hf20: half_adder port map (b2(0), z1(1),        z2(0), c2(0));
ff21: full_adder port map (b2(1), z1(2), c2(0), z2(1), c2(1));
ff22: full_adder port map (b2(2), z1(3), c2(1), z2(2), c2(2)); 
ff23: full_adder port map (b2(3), c1(3), c2(2), z2(3), c2(3)); 

end Behavioral;

---------------------------
------- 4BIT  ADDER -------
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_adder is
  Port ( x     : in std_logic_vector(3 downto 0);
         y     : in std_logic_vector(3 downto 0);
         c     : in std_logic;
         z     : out std_logic_vector(3 downto 0);
         c_out : out std_logic 
         );
end bit4_adder;

architecture Behavioral of bit4_adder is
component full_adder is
port ( x : in std_logic;
       y : in std_logic;
       c : in std_logic;
       z : out std_logic;
       c_out : out std_logic
);
end component;
    signal carry : std_logic_vector(2 downto 0);
begin

f0_add : full_adder
port map(
        x => x(0),
        y => y(0),
        c => c,
        z => z(0),
        c_out => carry(0)
);

f1_add : full_adder
port map(
        x => x(1),
        y => y(1),
        c => carry(0),
        z => z(1),
        c_out => carry(1)
);

f2_add : full_adder
port map(
        x => x(2),
        y => y(2),
        c => carry(1),
        z => z(2),
        c_out => carry(2)
);

f3_add : full_adder
port map(
        x => x(3),
        y => y(3),
        c => carry(2),
        z => z(3),
        c_out => c_out
);

end Behavioral;

---------------------------
---- 4BIT INCREMENTER  ----
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_incrementer is
port (x : in std_logic_vector(3 downto 0);
      c : in std_logic;
      z : out std_logic_vector(3 downto 0);
      c_out : out std_logic
       );
end bit4_incrementer;

architecture Behavioral of bit4_incrementer is
component half_adder is
port( x, y : in std_logic;
      z, c_out : out std_logic
);
end component;

signal carry : std_logic_vector(2 downto 0);

begin

hf0 : half_adder 
port map(
    x => x(0),
    y => c,
    z => z(0),
    c_out => carry(0)
);

hf1 : half_adder 
port map(
    x => x(1),
    y => carry(0),
    z => z(1),
    c_out => carry(1)
);

hf2 : half_adder 
port map(
    x => x(2),
    y => carry(1),
    z => z(2),
    c_out => carry(2)
);

hf3 : half_Adder
port map(
    x => x(3),
    y => carry(2),
    z => z(3),
    c_out => c_out
);

end Behavioral;

---------------------------
---- 4BIT DECREMENTER  ----
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_decrementer is
port( x : in std_logic_vector(3 downto 0);
      b : in std_logic;
      z : out std_logic_vector(3 downto 0);
      b_out :out std_logic
);
end entity;

architecture behavioral of bit4_decrementer is 
component half_sub is
port( x, y : in std_logic;
      z, b_out : out std_logic);
end component;

signal borrow : std_logic_vector(2 downto 0);

begin

hs0: half_sub
port map(
    x => x(0),
    y => b,
    z => z(0),
    b_out => borrow(0)
);

hs1: half_sub
port map(
   x => x(1),
   y => borrow(0),
   z => z(1),
   b_out => borrow(1)
);

hs2: half_sub
port map(
   x => x(2),
   y => borrow(1),
   z => z(2),
   b_out => borrow(2)
);
hs3: half_sub
port map(
   x => x(3),
   y => borrow(2),
   z => z(3),
   b_out => b_out
);
end behavioral;

---------------------------
---- 4BIT Half-Adder   ----
---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_half_adder is
  Port ( x     : in std_logic_vector(3 downto 0);
         y     : in std_logic_vector(3 downto 0);
         z     : out std_logic_vector(3 downto 0);
         c_out : out std_logic 
         );
end bit4_half_adder;

architecture Behavioral of bit4_half_adder is
component full_adder is
port ( x : in std_logic;
       y : in std_logic;
       c : in std_logic;
       z : out std_logic;
       c_out : out std_logic
);
end component;

component half_adder is
port ( x : in std_logic;
       y : in std_logic;
       z : out std_logic;
       c_out : out std_logic
);
end component;

    signal c : std_logic_vector(2 downto 0);
begin

f0_add : half_adder
port map(
        x => x(0),
        y => y(0),
        z => z(0),
        c_out => c(0)
);

f1_add : full_adder
port map(
        x => x(1),
        y => y(1),
        c => c(0),
        z => z(1),
        c_out => c(1)
);

f2_add : full_adder
port map(
        x => x(2),
        y => y(2),
        c => c(1),
        z => z(2),
        c_out => c(2)
);

f3_add : full_adder
port map(
        x => x(3),
        y => y(3),
        c => c(2),
        z => z(3),
        c_out => c_out
);

end Behavioral;

