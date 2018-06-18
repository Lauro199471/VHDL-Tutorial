library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity myFIFO_tb is
end;

architecture bench of myFIFO_tb is
  component myFIFO
    generic
    (
      number_of_registers : integer := 4;
      bit_length_registers: integer := 8
    );
    Port 
    ( 
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      EN_WR : in STD_LOGIC;
      EN_RD : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR (7 downto 0);
      data_out : out STD_LOGIC_VECTOR (7 downto 0);
      fifo_full_status : out STD_LOGIC;
      fifo_empty_status : out STD_LOGIC;
      fifo_ptr : out integer
    );
  end component;

  signal clk: STD_LOGIC := '0';
  signal rst: STD_LOGIC := '0';
  signal EN_WR: STD_LOGIC  := '0';
  signal EN_RD: STD_LOGIC  := '0';
  signal data_in: STD_LOGIC_VECTOR (7 downto 0) := x"00";
  signal data_out: STD_LOGIC_VECTOR (7 downto 0);
  signal fifo_full_status: STD_LOGIC;
  signal fifo_empty_status: STD_LOGIC;
  signal fifo_ptr: integer;

  -- 50 MHz = 20 nanoseconds period
  constant CLOCK_PERIOD : time := 20 ns; 

begin

  -- Insert values for generic parameters !!
  uut: myFIFO generic map ( number_of_registers  => 4,
                            bit_length_registers =>  8)
                 port map ( clk                  => clk,
                            rst                  => rst,
                            EN_WR                => EN_WR,
                            EN_RD                => EN_RD,
                            data_in              => data_in,
                            data_out             => data_out,
                            fifo_full_status     => fifo_full_status,
                            fifo_empty_status    => fifo_empty_status,
                            fifo_ptr             => fifo_ptr );

  -- Clock Generator
  p_CLK_GEN : process is
    begin
      wait for CLOCK_PERIOD / 2;
      clk <= not clk;
  end process p_CLK_GEN;

  stimulus: process
  begin
  
    -- Put initialisation code here
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    

    -- Put test bench stimulus code here
    -- ||||||||||||||||||||||||||||||||
    -- ||||        Write          |||||
    -- ||||||||||||||||||||||||||||||||
    EN_RD <= '0';
    EN_WR <= '1';
    data_in <= x"AA";
    wait for 55 ns;
    EN_WR <= '0';
    wait for 55 ns;
    
    
    data_in <= x"BB";
    EN_WR <= '1';
    wait for 47 ns;
    EN_WR <= '0';
    wait for 25 ns;
    
    
    data_in <= x"CC";
    EN_WR <= '1';
    wait for 74 ns;
    EN_WR <= '0';
    wait for 85 ns;

    
    data_in <= x"DD";
    EN_WR <= '1';
    wait for 60 ns;
    EN_WR <= '0';
    wait for 60 ns;

    -- ||||||||||||||||||||||||||||||||
    -- ||||        Read           |||||
    -- ||||||||||||||||||||||||||||||||
    EN_RD <= '1';
    EN_WR <= '0';
    wait for 60 ns;
    EN_RD <= '0';
    wait for 60 ns;

    EN_RD <= '1';
    EN_WR <= '0';
    wait for 60 ns;
    EN_RD <= '0';
    wait for 60 ns;

    EN_RD <= '1';
    EN_WR <= '0';
    wait for 60 ns;
    EN_RD <= '0';
    wait for 60 ns;

    EN_RD <= '1';
    EN_WR <= '0';
    wait for 60 ns;
    EN_RD <= '0';
    wait for 60 ns;

    -- ||||||||||||||||||||||||||||||||
    -- ||||        Write          |||||
    -- ||||||||||||||||||||||||||||||||
    EN_RD <= '0';
    EN_WR <= '1';
    data_in <= x"1F";
    wait for 55 ns;
    EN_WR <= '0';
    wait for 55 ns;
    
    
    data_in <= x"3D";
    EN_WR <= '1';
    wait for 47 ns;
    EN_WR <= '0';
    wait for 25 ns;
    
    
    data_in <= x"24";
    EN_WR <= '1';
    wait for 74 ns;
    EN_WR <= '0';
    wait for 85 ns;

    
    data_in <= x"A1";
    EN_WR <= '1';
    wait for 60 ns;
    EN_WR <= '0';
    wait for 60 ns;

  end process;


end;
  