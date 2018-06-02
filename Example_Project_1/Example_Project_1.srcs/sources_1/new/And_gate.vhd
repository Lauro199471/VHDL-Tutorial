library ieee;
use ieee.std_logic_1164.all;

entity And_gate is
  port (
   in1 : in  std_logic;
   in2 : in  std_logic;
   in3 : in  std_logic;
          
   out1 : out std_logic
  );
end And_gate;

architecture Circuit of And_gate is
begin
   out1 <= in1 and in2 and in3;
end Circuit;