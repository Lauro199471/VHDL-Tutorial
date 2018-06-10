library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- VHDL code for FIFO memory

entity fifo is
  Port ( 
    data_out : out std_logic_vector(7 downto 0); -- 8-bits of data out
    
    fifo_full, fifo_empty, fifo_threshold, 
    fifo_overflow, fifo_underflow: out std_logic; -- status-bits

    clk : in std_logic; -- Clock
    rst : in std_logic; -- Reset

    wr : in std_logic; -- Write Enable
    rd : in std_logic; -- Read Enable
    
    data_in : in std_logic_vector(7 downto 0) -- 8-bits of data in
  );
end fifo;

architecture Behavioral of fifo is

begin


end Behavioral;
