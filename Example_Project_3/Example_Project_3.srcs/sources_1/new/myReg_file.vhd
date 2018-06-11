--  Register : collections of DFF
--  The W generic specifies the number of address bits,
--  which implies that there are 2W words in the file, and the B generic specifies the number of
--  bits in a word.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myReg_file is
    -- Constants
    generic(
        B : integer := 8 ; -- number of bits
        W : integer := 2   -- number of address bits
    );

    port (
        clk : in  std_logic;
        rst : in  std_logic;
        
        write_enable : in  std_logic;
        read_enable  : in  std_logic;

        write_address   : in  std_logic_vector(W-1 downto 0); -- 2-bits
        read_address    : in  std_logic_vector(W-1 downto 0);  -- 2-bits

        write_data : in   std_logic_vector(B-1 downto 0); -- 8-bits
        read_data  : out  std_logic_vector(B-1 downto 0)  -- 8-bits
    );
end myReg_file;

architecture regfile_arch of myReg_file is
 type reg_file_type is array(2**W-1 downto 0) of std_logic_vector(B-1 downto 0);
 signal array_reg : reg_file_type;
begin
    -- writing
    process (clk,rst) begin
        if(rst = '1') then
            array_reg <= (others => (others => '0')); --set all bits to zero
        elsif(rising_edge(clk)) then
            if(write_enable = '1') then
                array_reg(to_integer(unsigned(write_address))) <= write_data;
            end if;    
        end if;
    end process;

    -- reading
    read_data <= array_reg(to_integer(unsigned(read_address))) when read_enable = '1' else (others => '0'); -- tinary

end regfile_arch;