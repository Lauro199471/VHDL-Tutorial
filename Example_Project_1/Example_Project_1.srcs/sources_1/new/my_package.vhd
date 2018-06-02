library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package my_package is
  
   -- Or_gate.vhd
   component Or_gate
      port (
         in1 : in  std_logic;
         in2 : in  std_logic;
         in3 : in  std_logic;
         out1 : out std_logic
      );
   end component;
   
    -- And_gate.vhd
   component And_gate
      port (
         in1 : in  std_logic;
         in2 : in  std_logic;
         in3 : in  std_logic;
         out1 : out std_logic
      );
   end component;
   
end package my_package;