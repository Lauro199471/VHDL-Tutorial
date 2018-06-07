--type Time is range --implementation defined-- ;
--  units
--     fs;            -- femtosecond
--     ps  = 1000 fs; -- picosecond
--     ns  = 1000 ps; -- nanosecond
--     us  = 1000 ns; -- microsecond
--     ms  = 1000 us; -- millisecond
--     sec = 1000 ms; -- second
--     min = 60  sec; -- minute
--     hr  = 60  min; -- hour
--  end units;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- for the signed, unsigned types and arithmetic ops

entity led_blink_tb is
end led_blink_tb;

architecture behave of led_blink_tb is

  -- 50 MHz = 20 nanoseconds period
  constant CLOCK_PERIOD : time := 20 ns; 

  -- Initial values for I/O
  signal CLOCK     : std_logic := '0';
  signal ENABLE    : std_logic := '0';
  signal SWITCH_1  : std_logic := '0';
  signal SWITCH_2  : std_logic := '0';
  signal led_out   : std_logic; 
  
  -- Component declaration for the Unit Under Test (UUT)
  component led_blink is
    port (
      i_clock     : in  std_logic;
      i_enable    : in  std_logic;
      i_switch_1  : in  std_logic;
      i_switch_2  : in  std_logic;
      o_led       : out std_logic);
  end component led_blink;
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT : led_blink
    port map (
      i_clock     => CLOCK,
      i_enable    => ENABLE,
      i_switch_1  => SWITCH_1,
      i_switch_2  => SWITCH_2,
      o_led => led_out
    );

    -- Clock Generator
    p_CLK_GEN : process is
    begin
        wait for CLOCK_PERIOD / 2;
        CLOCK <= not CLOCK;
    end process p_CLK_GEN; 

    -- main testing
    process begin
        ENABLE <= '0';
        wait for 5 sec;

        ENABLE <= '1';
        wait for 5 sec;

        SWITCH_1 <= '0';
        SWITCH_2 <= '0';
        wait for 5 sec;
    
        SWITCH_1 <= '0';
        SWITCH_2 <= '1';
        wait for 5 sec;
    
        SWITCH_1 <= '1';
        SWITCH_2 <= '0';
        wait for 5 sec;
    
        SWITCH_1 <= '1';
        SWITCH_2 <= '1';
        wait for 5 sec;

        ENABLE <= '0';
  end process;
end behave;
