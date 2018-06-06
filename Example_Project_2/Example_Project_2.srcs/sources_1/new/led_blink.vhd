----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2018 09:01:11 AM
-- Design Name: 
-- Module Name: led_blink - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_blink is
    Port ( i_clock : in STD_LOGIC;
           i_enable : in STD_LOGIC;
           i_switch_1 : in STD_LOGIC;
           i_switch_2 : in STD_LOGIC;
           o_led : out STD_LOGIC);
end led_blink;

architecture Behavioral of led_blink is

begin


end Behavioral;
