library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity simple_design_tb is
end;

architecture bench of simple_design_tb is

  component simple_design
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             A   : in STD_LOGIC;
             Z   : out STD_LOGIC);
  end component;

  -- Initial values for I/O
  signal clk: std_logic := '0';
  signal rst: STD_LOGIC;
  signal Z: STD_LOGIC;
  signal A: STD_LOGIC;
  
  -- 50 MHz = 20 nanoseconds period
  constant CLOCK_PERIOD : time := 20 ns; 

begin
  
  -- Unit Under Test
  uut: simple_design port map ( clk => clk,
                                rst => rst,
                                A => A,
                                Z => Z );
                                
  -- Clock Generator
  p_CLK_GEN : process is
  begin
       wait for CLOCK_PERIOD / 2;
       clk <= not clk;
  end process p_CLK_GEN;
  
  -- Test Bench
  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 60 ns;
    A <= '1';
    

    -- Put test bench stimulus code here

    wait;
  end process;


end;