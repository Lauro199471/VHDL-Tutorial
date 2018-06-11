library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity myReg_file_tb is
end;

architecture bench of myReg_file_tb is

  component myReg_file
      generic(
          B : integer := 8 ;
          W : integer := 2
      );
      port (
          clk : in  std_logic;
          rst : in  std_logic;
          write_enable : in  std_logic;
          read_enable  : in  std_logic;
          write_address   : in  std_logic_vector(W-1 downto 0);
          read_address    : in  std_logic_vector(W-1 downto 0);
          write_data : in   std_logic_vector(B-1 downto 0);
          read_data  : out  std_logic_vector(B-1 downto 0)
      );
  end component;

  -- Initial values for I/O
  signal clk: std_logic := '0';
  signal rst: std_logic := '0';
  signal write_enable: std_logic := '0';
  signal read_enable: std_logic := '0';
  signal write_address: std_logic_vector(1 downto 0) := "00";
  signal read_address: std_logic_vector(1 downto 0)  := "00";
  signal write_data: std_logic_vector(7 downto 0) := "00000000";
  signal read_data: std_logic_vector(7 downto 0) := "00000000";

  -- 50 MHz = 20 nanoseconds period
  constant CLOCK_PERIOD : time := 20 ns; 
  
  

begin

  -- Insert values for generic parameters !!
  uut: myReg_file generic map ( B             => 8,
                                W             => 2)
                     port map ( clk           => clk,
                                rst           => rst,
                                write_enable  => write_enable,
                                read_enable   => read_enable,
                                write_address => write_address,
                                read_address  => read_address,
                                write_data    => write_data,
                                read_data     => read_data );

    -- Clock Generator
    p_CLK_GEN : process is
    begin
        wait for CLOCK_PERIOD / 2;
        clk <= not clk;
    end process p_CLK_GEN;
                                

    -- main testing
    process
    begin
    -- Put initialisation code here
    rst <= '1';
    wait for 60 ns;
    rst <= '0';

    -- Put test bench stimulus code here
    -- write
    write_enable <= '1';
    read_enable  <= '0';
    write_address<= "01";
    write_data   <= "01110111";

    wait for 25 ns;

    write_enable <= '1';
    read_enable  <= '0';
    write_address<= "11";
    write_data   <= "01010101";
    
    wait for 25 ns;
    
    -- read
    write_enable <= '0';
    read_enable  <= '1';
    read_address <= "00";

    wait for 25 ns;

    -- read
    write_enable <= '0';
    read_enable  <= '1';
    read_address <= "01";

    wait for 25 ns;

    -- read
    write_enable <= '0';
    read_enable  <= '1';
    read_address <= "10";

    wait for 25 ns;

    -- read
    write_enable <= '0';
    read_enable  <= '1';
    read_address <= "11";

    wait;
    end process;

end;