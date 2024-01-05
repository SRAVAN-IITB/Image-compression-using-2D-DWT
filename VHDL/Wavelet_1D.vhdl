library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Wavelet_1D is
    Port (
        clock               : in  STD_LOGIC;
        reset               : in  STD_LOGIC;
        inputRow            : in  STD_LOGIC_VECTOR(63 downto 0);
        outputCombined      : out STD_LOGIC_VECTOR(63 downto 0)
    );
end entity Wavelet_1D;

architecture Behavioral of Wavelet_1D is
    signal rowAveraging, rowSubtraction : STD_LOGIC_VECTOR(31 downto 0);

    component Averaging_Module is
        Port (
            Clock : in STD_LOGIC;
            Reset : in STD_LOGIC;
            pixel1 : in STD_LOGIC_VECTOR(7 downto 0);
            pixel2 : in STD_LOGIC_VECTOR(7 downto 0);
            Average_Output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Subtraction_Module is
        Port (
            Clock : in STD_LOGIC;
            Reset : in STD_LOGIC;
            pixel1 : in STD_LOGIC_VECTOR(7 downto 0);
            pixel2 : in STD_LOGIC_VECTOR(7 downto 0);
            Subtraction_Output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    pairingPixels : for i in 0 to 3 generate
        Averaging_Instance  : Averaging_Module port map (
            clock,
            reset,
            inputRow((16*i + 7) downto (16*i)),
            inputRow((16*i + 15) downto (16*i + 8)),
            rowAveraging((8*i + 7) downto (8*i))
        );

        Subtraction_Instance: Subtraction_Module port map (
            clock,
            reset,
            inputRow((16*i + 7) downto (16*i)),
            inputRow((16*i + 15) downto (16*i + 8)),
            rowSubtraction((8*i + 7) downto (8*i))
        );
    end generate;

    process(clock, reset)
    begin
        if reset = '1' then
            -- Reset condition
            outputCombined <= (others => '0');
        elsif rising_edge(clock) then
            -- Concatenate results to form a 64-bit output
            outputCombined <= rowAveraging & rowSubtraction;
        end if;
    end process;
end Behavioral;
