library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Averaging_Module is
    Port (
	     Clock : in STD_LOGIC;
        Reset : in STD_LOGIC;
        pixel1 : in STD_LOGIC_VECTOR(7 downto 0);
        pixel2 : in STD_LOGIC_VECTOR(7 downto 0);
        Average_Output : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Averaging_Module;

architecture Behavioral of Averaging_Module is
    signal shifted_pixel1, shifted_pixel2 : STD_LOGIC_VECTOR(8 downto 0);
    signal sum_result : STD_LOGIC_VECTOR(8 downto 0);
begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            -- Reset condition
            sum_result <= (others => '0');
        elsif rising_edge(Clock) then
            -- Right shift the inputs
            shifted_pixel1 <= '0' & pixel1;
            shifted_pixel2 <= '0' & pixel2;

            -- Add the right-shifted inputs
            sum_result <= shifted_pixel1 + shifted_pixel2;

            -- Divide the sum by 2 (right shift)
            Average_Output <= sum_result(8 downto 1);
        end if;
    end process;
end Behavioral;
