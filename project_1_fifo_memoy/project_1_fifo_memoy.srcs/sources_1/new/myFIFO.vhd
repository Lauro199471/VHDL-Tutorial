-- MAKE Enable PULSE

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFIFO is
    generic
    (
        number_of_registers : integer := 4; -- 4 registers each with 8 bits
        bit_length_registers: integer := 8
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           EN : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           fifo_full_status : out STD_LOGIC;
           fifo_empty_status : out STD_LOGIC;
           fifo_ptr : out integer); -- This can be a whole number not '1' or '0' or 'Z'
end myFIFO;

architecture Behavioral of myFIFO is
-------------------------------------------
--       Initilaze some types            --
-------------------------------------------    
    -- Declare an array type for a register file. The number of registers is 4 registters of 8 bits each
    type reg_file_type is array(number_of_registers - 1 downto 0) of std_logic_vector(bit_length_registers - 1 downto 0);
    -- Make a signal of new type
    signal reg_file : reg_file_type;

    -- ptr initilazing
    signal fifo_ptr_reg : integer := 0;

    signal en_dff : STD_LOGIC := '0';
    signal pulse  : STD_LOGIC := '0';
begin
    fifo_ptr <= fifo_ptr_reg;

    pulse <= EN and not en_dff;

    enable_DFF : process(clk,rst) 
    begin
        if(rising_edge(clk)) then
            -- If Reset is asserted
            if(rst = '1') then
                en_dff <= '0';
            -- Else If Enable is assert write to data
            else 
                en_dff <= EN;          
            end if;
        end if;
    end process; 
    

    writing_process : process(clk,rst) 
    begin
        if(rising_edge(clk)) then
            -- If Reset is asserted
            if(rst = '1') then
                for i in 0 to number_of_registers - 1 loop
                    reg_file(i) <= (others => '0');
                end loop ; -- loop

            -- Else If Enable is assert write to data
            elsif (EN ='1') then
                reg_file(fifo_ptr_reg) <= data_in;
                fifo_ptr_reg <= fifo_ptr_reg + 1;
                
            end if;
        end if;
    end process;    


end Behavioral;
