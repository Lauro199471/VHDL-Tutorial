library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simple_design is
    generic
    (
        number_of_registers  : integer := 16; -- 16 registers each with 32 bits
        bit_length_registers : integer := 32
    );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC; 

           A : in  STD_LOGIC; 
           Z : out STD_LOGIC;

           B : in  STD_LOGIC; 
           Y : out STD_LOGIC;
           
           C : in STD_LOGIC;
           X : out STD_LOGIC
          );
end simple_design;

architecture Behavioral of simple_design is
-------------------------------------------
--       Initilaze some types            --
-------------------------------------------        
    -- -- Declare an array type for a register file. The number of registers is 16 registters of 32 bits each
    type reg_file_type is array(number_of_registers - 1 downto 0) of std_logic_vector(bit_length_registers - 1 downto 0);
    
    -- make a signal of new type
    signal reg_file : reg_file_type;

    signal first_stage_outOfProcess , second_stage_outOfProcess : STD_LOGIC;
    signal first_stage_inOfProcess , second_stage_inOfProcess : STD_LOGIC;
-------------------------------------------
--           Begin Circuit               --
-------------------------------------------        
begin
    -- This is essentially just doing Z <= A 
    Z <= second_stage_outOfProcess;
    second_stage_outOfProcess <= first_stage_outOfProcess;
    first_stage_outOfProcess <= A;

    -- D-Flip Flop going so takes 2 clock cycles to pass B to Y
    simple_process  : process(clk,rst)
    variable first_stage_inOfProcess_var , second_stage_inOfProcess_var : STD_LOGIC;
    begin
        if(rising_edge(clk)) then
            Y <= second_stage_inOfProcess;
            second_stage_inOfProcess <= first_stage_inOfProcess;
            first_stage_inOfProcess <= B;

            X <= second_stage_inOfProcess_var;
            second_stage_inOfProcess_var := first_stage_inOfProcess_var;
            first_stage_inOfProcess_var := C;

        end if;
    end process;

    -- D-Flip Flop going so takes 2 clock cycles to pass B to Y
    reset_process  : process(clk,rst)
    begin
        if(rising_edge(clk)) then
           if(rst = '1') then
             identifier : for i in 0 to 15 loop
                 reg_file(i) <= x"1234_5678";
             end loop ; -- identifier
            end if;
        end if;
    end process;
    
end Behavioral;
