library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top_Design_TB is
end;

architecture bench of Top_Design_TB is

  component TOP_Design
      Port ( A : in  STD_LOGIC;
             C : in  STD_LOGIC;
             B : in  STD_LOGIC;
             X : out STD_LOGIC;
             Y : out STD_LOGIC);
  end component;

  signal A: STD_LOGIC;
  signal C: STD_LOGIC;
  signal B: STD_LOGIC;
  signal X: STD_LOGIC;
  signal Y: STD_LOGIC;

begin

  uut: TOP_Design port map ( A => A,
                             C => C,
                             B => B,
                             X => X,
                             Y => Y );

  stimulus: process
  begin
  
    -- Put initialisation code here
    A <= '0';
    B <= '0';
    C <= '0';
    wait for 10 ns;
    
    A <= '0';
    B <= '0';
    C <= '1';
    wait for 10 ns;
    
    A <= '0';
    B <= '1';
    C <= '0';
    wait for 10 ns;
    
    A <= '0';
    B <= '1';
    C <= '1';
    wait for 10 ns;
    
    A <= '1';
    B <= '0';
    C <= '0';
    wait for 10 ns;
    
    A <= '1';
    B <= '0';
    C <= '1';
    wait for 10 ns;
    
    A <= '1';
    B <= '1';
    C <= '0';
    wait for 10 ns;
    
    A <= '1';
    B <= '1';
    C <= '1';
    wait for 10 ns;
    
    A <= '0';
    B <= '0';
    C <= '0';
    wait for 10 ns;
    -- Put test bench stimulus code here

    wait;
  end process;


end;
  