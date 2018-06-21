library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
  Port 
  ( 
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 1 input 4-bit for selecting function
    ALU_Out   : out  STD_LOGIC_VECTOR(7 downto 0); -- 1 output 8-bit 
    Carryout : out std_logic        -- Carryout flag
  );
end ALU;

architecture Behavioral of ALU is
    signal ALU_Result : std_logic_vector (7 downto 0);
    signal tmp: std_logic_vector (8 downto 0);
begin


end Behavioral;
