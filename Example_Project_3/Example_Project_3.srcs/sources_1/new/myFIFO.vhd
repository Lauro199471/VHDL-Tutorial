-- Package Defintion
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package myFIFO is 
    -- Write to Fifo
    --component write_addr
    --    port(

    --    );
    --end component;

    -- Read to Fifo
    component read_addr
        port(
            read_address_out : out std_logic_vector(3 downto 0); -- 4-bit read pointer cause Fifo has 16 locations    

            clk :in std_logic;  -- Clock
            rst: in std_logic;  -- Reset 
            
            read_en: in std_logic;
            fifo_empty : in std_logic;
        
            read_ptr : in std_logic_vector(3 downto 0)
        );
    end component;

end package myFIFO;
