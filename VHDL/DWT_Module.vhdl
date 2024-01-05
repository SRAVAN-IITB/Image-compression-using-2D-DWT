library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DWT_Module is
    Port (
        clock      : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        dwt_valid  : out STD_LOGIC;
        inputRow   : in  STD_LOGIC_VECTOR(511 downto 0);
        outputRow  : out STD_LOGIC_VECTOR(511 downto 0)
    );
end entity DWT_Module;

architecture Behavioral of DWT_Module is
    signal dwtValidSignal_i : std_logic_vector(3 downto 0) := (others => '0'); -- DWT valid signals for each instantiation
    signal dwtValidSignal_i_temp : std_logic := '0'; -- Temporary DWT valid signal for the current instantiation

    component Wavelet_2D is
        Port (
            clock        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            inputRow1    : in  STD_LOGIC_VECTOR(63 downto 0);
            inputRow2    : in  STD_LOGIC_VECTOR(63 downto 0);
            outputRow1   : out STD_LOGIC_VECTOR(63 downto 0);
            outputRow2   : out STD_LOGIC_VECTOR(63 downto 0);
            dwtValid     : out STD_LOGIC
        );
    end component;

begin
    DWT_Column: for i in 0 to 3 generate 

        Col_instance : Wavelet_2D 
            port map (
                clock,
                reset,
                inputRow(64*(2*i) + 63 downto (64*(2*i))),
                inputRow(64*((2*i) + 1) + 63 downto (64*((2*i)+1))),
                outputRow(64*i + 63 downto (64*i)),
                outputRow(64*(i + 4) + 63 downto (64*(i+4))),
                dwtValidSignal_i_temp
            );
		dwtValidSignal_i(i) <= dwtValidSignal_i_temp;


    process(clock, reset)
    begin
        if reset = '1' then
            dwtValidSignal_i_temp <= '0'; -- Assuming DWT is not valid during reset
        elsif rising_edge(clock) then
            if dwt_valid = '1' then
                dwtValidSignal_i_temp <= '1';
            else
                dwtValidSignal_i_temp <= '0';
            end if;
        end if;
    end process;
    end generate;
	 
    process(dwtValidSignal_i)
    begin
        -- AND operation over all dwtValidSignal_i signals
        dwt_valid <= dwtValidSignal_i(0) and dwtValidSignal_i(1) and dwtValidSignal_i(2) and dwtValidSignal_i(3);
    end process;

end Behavioral;
