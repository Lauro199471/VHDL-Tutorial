library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;--fines some types and basic arithmetic operations for representing integers in standard ways.


entity read_addr is
   Port ( 
    read_address_out : out std_logic_vector(3 downto 0); -- 4-bit read pointer cause Fifo has 16 locations    
    
    clk :in std_logic;  -- Clock
    rst: in boolean;  -- Reset 
    
    read_en: in boolean;
    fifo_empty : in boolean;

    read_ptr : in std_logic_vector(3 downto 0) -- 4-bit read pointer cause Fifo has 16 locations    
   );
end read_addr;

architecture Behavioral of read_addr is
    signal read_address:std_logic_vector(3 downto 0);    
begin

    read_address_out <= read_address;

    process(clk,rst) is
    begin
        if(rst) then
            read_address <= "0000";
        elsif(rising_edge(clk)) then
            -- If you AND two STD_LOGIC's, the result is a STD_LOGIC, not a boolean. 
            if(read_en and (not fifo_empty)) then 
                read_address <= read_ptr;
            end if;       
        end if;
    end process;    


end Behavioral;
