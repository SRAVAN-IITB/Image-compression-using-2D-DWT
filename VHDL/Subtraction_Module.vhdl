library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Subtraction_Module is
    Port (
	     Clock : in STD_LOGIC;
        Reset : in STD_LOGIC;
        pixel1 : in STD_LOGIC_VECTOR(7 downto 0);
        pixel2 : in STD_LOGIC_VECTOR(7 downto 0);
        Subtraction_Output : out STD_LOGIC_VECTOR(7 downto 0)  
    );
end Subtraction_Module;

architecture Behavioral of Subtraction_Module is
    signal shifted_pixel1, shifted_pixel2 : STD_LOGIC_VECTOR(8 downto 0);
    signal subtracted_result : STD_LOGIC_VECTOR(8 downto 0);
begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            -- Reset condition
            subtracted_result <= (others => '0');
        elsif rising_edge(Clock) then
            -- Right shift the inputs
            shifted_pixel1 <= '0' & pixel1;
            shifted_pixel2 <= '0' & pixel2;

            -- Subtract the right-shifted inputs
            subtracted_result <= shifted_pixel1 - shifted_pixel2;

            -- Divide the result by 2 (right shift)
            Subtraction_Output <= subtracted_result(8 downto 1);
        end if;
    end process;
end Behavioral;
