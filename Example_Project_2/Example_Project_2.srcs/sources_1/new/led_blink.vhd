-- Integer Types: 
--               NATURAL  : is a subtype that limits the range from 0 to +2147483647.
--               POSITVES : is a subtype that covers 1 to 2147483647.
--               INTEGERS : is a data type that covers integer values from -2147483647 to +2147483647.

-- <= is for signals, := is for variables, except for initial values that both use :=

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- for the signed, unsigned types and arithmetic ops

entity led_blink is
    Port ( 
        i_clock :    in STD_LOGIC;
        i_enable :   in STD_LOGIC;
        i_switch_1 : in STD_LOGIC;
        i_switch_2 : in STD_LOGIC;
        o_led :      out STD_LOGIC);
end led_blink;

architecture rtl of led_blink is
    -- Constants to create the frequencies needed:
    -- Formula is: ((Clock) Hz / (desired freq) Hz * 50% duty cycle) - 1 
    -- 4   Hz: 50,000,000 / 4   * 0.5 =  6,249,999
    -- 2   Hz: 50,000,000 / 2   * 0.5 = 12,499,999
    -- 1   Hz: 50,000,000 / 1   * 0.5 = 24,999,999
    -- 1/2 Hz: 50,000,000 / 1/2 * 0.5 = 49,999,999
    constant freq_4Hz     : natural := 6249999;
    constant freq_2Hz     : natural := 12499999;
    constant freq_1Hz     : natural := 24999999;
    constant freq_1_2Hz   : natural := 49999999;

    -- These signals will be the counters:
    signal cntr_4Hz     : natural range 0 to freq_4Hz; -- Range : will find the corrent number of bits 
    signal cntr_2Hz     : natural range 0 to freq_2Hz;
    signal cntr_1Hz     : natural range 0 to freq_1Hz;
    signal cntr_1_2Hz   : natural range 0 to freq_1_2Hz;

    -- These signals will toggle at the frequencies needed:
    signal toggle_4Hz   : std_logic := '0';
    signal toggle_2Hz   : std_logic := '0';
    signal toggle_1Hz   : std_logic := '0';
    signal toggle_1_2Hz : std_logic := '0';
begin
    -- All processes toggle a specific signal at a different frequency.
    process_4Hz : process (i_clock) is
    begin 
        if rising_edge(i_clock) then
            if cntr_4Hz = freq_4Hz then
                toggle_4Hz <= not toggle_4Hz;
                cntr_4Hz <= 0;
            else 
                cntr_4Hz <= cntr_4Hz + 1;
            end if;
        end if;
    end process process_4Hz;
end rtl;
