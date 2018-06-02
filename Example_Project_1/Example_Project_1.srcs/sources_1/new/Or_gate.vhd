library ieee;
use ieee.std_logic_1164.all;

entity Or_gate is
  port (
   in1 : in  std_logic;
   in2 : in  std_logic;
   in3 : in  std_logic;
          
   out1 : out std_logic
  );
end Or_gate;

architecture Circuit_1 of Or_gate is
begin
   out1 <= in1 or in2 or in3;
end Circuit_1;