library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library my_library;
use my_library.my_package.all;

entity Top_Design is
    Port ( A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           B : in  STD_LOGIC;
           X : out STD_LOGIC;
           Y : out STD_LOGIC);
end Top_Design;

architecture Behavioral of Top_Design is

begin
  and_1 : entity my_library.And_gate(Circuit) 
     port map(in1 => A, in2 => B , in3 => C , out1 => X);
    
  and_2 : entity my_library.Or_gate(Circuit_1)
     port map(in1 => A, in2 => B , in3 => C , out1 => Y);
end Behavioral;
 