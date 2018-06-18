library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity myFIFO is
    generic
    (
        number_of_registers : integer := 4; -- 4 registers each with 8 bits
        bit_length_registers: integer := 8
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           EN_WR : in STD_LOGIC;
           EN_RD : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           fifo_full_status : out STD_LOGIC;
           fifo_empty_status : out STD_LOGIC;
           fifo_ptr : out integer range 2 downto 0); -- This can be a whole number not '1' or '0' or 'Z'
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
    signal fifo_write_ptr_reg : integer range 2 downto 0 := 0;
    signal fifo_read_ptr_reg  : integer range 2 downto 0 := 0;

    signal en_dff : STD_LOGIC := '0';
    signal pulse  : STD_LOGIC := '0';

    signal data_out_reg : STD_LOGIC_VECTOR(7 downto 0) := x"00";
    
    signal full_status_reg : STD_LOGIC := '0';

begin
    
    data_out <= data_out_reg;
    fifo_ptr <= fifo_write_ptr_reg;
    pulse <= EN_WR and not en_dff;
    
    -- Check if FIFO is full
    fifo_full_status <= full_status_reg;
    full_status_reg <= '1' when fifo_write_ptr_reg > 3 else '0';



    enable_DFF : process(clk,rst) 
    begin
        if(rising_edge(clk)) then
            -- If Reset is asserted
            if(rst = '1') then
                en_dff <= '0';
            -- Else If Enable is assert write to data
            else 
                en_dff <= EN_WR;          
            end if;
        end if;
    end process; 
    
    -- Writing to FIFO
    writing_process : process(clk,rst) 
    begin
        if(rising_edge(clk)) then
            -- If Reset is asserted
            if(rst = '1') then
                for i in 0 to number_of_registers - 1 loop
                    reg_file(i) <= (others => '0');
                end loop ; -- loop
                fifo_write_ptr_reg <= 0;
                fifo_empty_status <= '1'; -- CHANGE LOGIC
            -- Else If Enable is assert write to data
            elsif (pulse ='1' and full_status_reg = '0') then
                reg_file(fifo_write_ptr_reg) <= data_in; 
                fifo_write_ptr_reg <= fifo_write_ptr_reg + 1;
            end if;
        end if;
    end process;
    
    -- Reading from FIFO
    reading_process : process(clk,rst) 
    begin
        if(rising_edge(clk)) then
            -- If Reset is asserted
            if(rst = '1') then
                data_out_reg <= (others => '0');
            -- Else If Enable is assert write to data
            elsif (EN_RD = '1') then
                data_out_reg <= reg_file(fifo_read_ptr_reg);
                fifo_read_ptr_reg <= fifo_read_ptr_reg + 1;
                reg_file(0) <= reg_file(1);
                reg_file(1) <= reg_file(2);
                reg_file(0) <= (others => '0');
            else
                data_out_reg <= (others => 'X'); -- Unknown Values
            end if;
        end if;
    end process;

end Behavioral;
