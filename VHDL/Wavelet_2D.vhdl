library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Wavelet_2D is
    Port (
        clock        : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        inputRow1    : in  STD_LOGIC_VECTOR(63 downto 0);
        inputRow2    : in  STD_LOGIC_VECTOR(63 downto 0);
        outputRow1   : out STD_LOGIC_VECTOR(63 downto 0);
        outputRow2   : out STD_LOGIC_VECTOR(63 downto 0);
        dwtValid     : out STD_LOGIC
    );
end entity Wavelet_2D;

architecture Behavioral of Wavelet_2D is
    signal output1Averaging, output1Subtraction : STD_LOGIC_VECTOR(31 downto 0);
    signal output2Averaging, output2Subtraction : STD_LOGIC_VECTOR(31 downto 0);
    signal dwtValidSignal : STD_LOGIC := '0'; -- Initialize to '0'

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

    LL1 : Averaging_Module port map (clock, reset, inputRow1(63 downto 56), inputRow2(63 downto 56), output1Averaging(31 downto 24));
    LL2 : Averaging_Module port map (clock, reset, inputRow1(55 downto 48), inputRow2(55 downto 48), output1Averaging(23 downto 16));
    LL3 : Averaging_Module port map (clock, reset, inputRow1(47 downto 40), inputRow2(47 downto 40), output1Averaging(15 downto 8));
    LL4 : Averaging_Module port map (clock, reset, inputRow1(39 downto 32), inputRow2(39 downto 32), output1Averaging(7 downto 0));

    LH1 : Subtraction_Module port map (clock, reset, inputRow1(63 downto 56), inputRow2(63 downto 56), output1Subtraction(31 downto 24));
    LH2 : Subtraction_Module port map (clock, reset, inputRow1(55 downto 48), inputRow2(55 downto 48), output1Subtraction(23 downto 16));
    LH3 : Subtraction_Module port map (clock, reset, inputRow1(47 downto 40), inputRow2(47 downto 40), output1Subtraction(15 downto 8));
    LH4 : Subtraction_Module port map (clock, reset, inputRow1(39 downto 32), inputRow2(39 downto 32), output1Subtraction(7 downto 0));

    HL1 : Averaging_Module port map (clock, reset, inputRow1(31 downto 24), inputRow2(31 downto 24), output2Averaging(31 downto 24));
    HL2 : Averaging_Module port map (clock, reset, inputRow1(23 downto 16), inputRow2(23 downto 16), output2Averaging(23 downto 16));
    HL3 : Averaging_Module port map (clock, reset, inputRow1(15 downto 8), inputRow2(15 downto 8), output2Averaging(15 downto 8));
    HL4 : Averaging_Module port map (clock, reset, inputRow1(7 downto 0), inputRow2(7 downto 0), output2Averaging(7 downto 0));

    HH1 : Subtraction_Module port map (clock, reset, inputRow1(31 downto 24), inputRow2(31 downto 24), output2Subtraction(31 downto 24));
    HH2 : Subtraction_Module port map (clock, reset, inputRow1(23 downto 16), inputRow2(23 downto 16), output2Subtraction(23 downto 16));
    HH3 : Subtraction_Module port map (clock, reset, inputRow1(15 downto 8), inputRow2(15 downto 8), output2Subtraction(15 downto 8));
    HH4 : Subtraction_Module port map (clock, reset, inputRow1(7 downto 0), inputRow2(7 downto 0), output2Subtraction(7 downto 0));

    process(clock, reset)
    begin
        if reset = '1' then
            -- Reset condition
            outputRow1 <= (others => '0');
            outputRow2 <= (others => '0');
            dwtValidSignal <= '0'; -- Reset DWT valid signal

        elsif rising_edge(clock) then
            -- Output the results
            outputRow1 <= output1Averaging & output2Averaging;
            outputRow2 <= output1Subtraction & output2Subtraction;
            dwtValidSignal <= '1'; -- Set DWT valid signal when output is valid
        end if;
    end process;

    dwtValid <= dwtValidSignal;

end Behavioral;
