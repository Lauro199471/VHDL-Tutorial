library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity simple_design is
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
    type reg_file_type is array(15 downto 0) of std_logic_vector(31 downto 0);
    
    -- make a signal of new type
    signal reg_file : reg_file_type;

    signal first_stage_outOfProcess , second_stage_outOfProcess : STD_LOGIC;
    signal first_stage_inOfProcess , second_stage_inOfProcess : STD_LOGIC;
-------------------------------------------
--           Begin Circuit               --
-------------------------------------------        
begin
    -- Clear First register and Set Second register
    reg_file(0) <= x"0000_0000"; 
    reg_file(1) <= x"FFFF_FFFF"; 

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
   
end Behavioral;
