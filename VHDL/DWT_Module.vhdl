library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DWT_Module is
    Port (
        clock      : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        dwt_valid  : out STD_LOGIC;
        inputRow_1   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_2   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_3   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_4   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_5   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_6   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_7   : in  STD_LOGIC_VECTOR(63 downto 0);
		  inputRow_8   : in  STD_LOGIC_VECTOR(63 downto 0);
        outputRow_1  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_2  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_3  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_4  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_5  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_6  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_7  : out STD_LOGIC_VECTOR(63 downto 0);
		  outputRow_8  : out STD_LOGIC_VECTOR(63 downto 0)
		  );
end entity DWT_Module;

architecture Behavioral of DWT_Module is
    signal dwtValidSignal_i : std_logic_vector(3 downto 0) := (others => '0'); -- DWT valid signals for each instantiation

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
--    DWT_Column: for i in 0 to 3 generate 
--
--        Col_instance : Wavelet_2D 
--            port map (
--                clock,
--                reset,
--                inputRow(64*(2*i) + 63 downto (64*(2*i))),
--                inputRow(64*((2*i) + 1) + 63 downto (64*((2*i)+1))),
--                outputRow(64*i + 63 downto (64*i)),
--                outputRow(64*(i + 4) + 63 downto (64*(i+4))),
--                dwtValidSignal_i(i)
--            );	
--    end generate;
    Wavelet_2D_1 : Wavelet_2D port map (clock,reset,inputRow_1,inputRow_2,outputRow_1,outputRow_5,dwtValidSignal_i(0));
    Wavelet_2D_2 : Wavelet_2D port map (clock,reset,inputRow_3,inputRow_4,outputRow_2,outputRow_6,dwtValidSignal_i(1));
	 Wavelet_2D_3 : Wavelet_2D port map (clock,reset,inputRow_5,inputRow_6,outputRow_3,outputRow_7,dwtValidSignal_i(2));
	 Wavelet_2D_4 : Wavelet_2D port map (clock,reset,inputRow_7,inputRow_8,outputRow_4,outputRow_8,dwtValidSignal_i(3));
	 
    process(dwtValidSignal_i)
    begin
        -- AND operation over all dwtValidSignal_i signals
        dwt_valid <= dwtValidSignal_i(0) and dwtValidSignal_i(1) and dwtValidSignal_i(2) and dwtValidSignal_i(3);
    end process;

end Behavioral;
