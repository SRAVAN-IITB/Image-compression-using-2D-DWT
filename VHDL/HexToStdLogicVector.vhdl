library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_LOGIC_MISC.ALL;
use std.textio.all;
use IEEE.numeric_std.all;

entity HexToStdLogicVector is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_valid : in STD_LOGIC;
           std_logic_vector_data : out STD_LOGIC_VECTOR(7 downto 0);
           done : out STD_LOGIC);
end HexToStdLogicVector;

architecture Behavioral of HexToStdLogicVector is
    signal hex_value : STD_LOGIC_VECTOR(7 downto 0);
    signal conversion_done : BOOLEAN := FALSE;

    file hex_file : TEXT open READ_MODE is "arranged_pixels.hex"; -- Change the file path accordingly
    variable line_buffer : LINE;
    variable hex_string : STRING(1 to 2);
begin
    process (clk, reset)
    begin
        if reset = '1' then
            conversion_done <= FALSE;
        elsif rising_edge(clk) then
            if data_valid = '1' then
                if not endfile(hex_file) then
                    readline(hex_file, line_buffer);
                    read(line_buffer, hex_string);
                    hex_value <= STD_LOGIC_VECTOR(TO_UNSIGNED(CONV_INTEGER(HSTRING'BASE"(hex_string), 16), hex_value'length));
                else
                    conversion_done <= TRUE;
                end if;
            end if;
        end if;
    end process;

    std_logic_vector_data <= hex_value;
    done <= conversion_done;
end Behavioral;