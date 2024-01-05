library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library std;
use std.textio.all;
--use IEEE.textio.ALL; -- Include the textio library
--use std.textio.all;
entity Testbench is
end entity Testbench;

architecture arch of Testbench is
component DWT_Module is
    Port (
        clock      : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        dwt_valid  : out STD_LOGIC;
		  inputRow   : in STD_LOGIC_VECTOR(511 downto 0);
		  outputRow   : out STD_LOGIC_VECTOR(511 downto 0)
          
    );
end component DWT_Module;

    signal clock      :   STD_LOGIC:= '0';
       signal  reset      :   STD_LOGIC:= '0';
        signal dwt_valid  :  STD_LOGIC;
		  signal inputRow   :  STD_LOGIC_VECTOR(511 downto 0);
		   signal outputRow   :  STD_LOGIC_VECTOR(511 downto 0);
			

begin
   file hex_file : text open read_mode is "final_pixels.hex"; -- Adjust the file path

    -- Variables for reading data from the file
    variable hex_line : line;
    variable hex_data : std_logic_vector(7 downto 0);
    variable row_data : std_logic_vector(63 downto 0);


   
    process
    begin
        wait for 5 ns;  
        clock <= not clock;
    end process;
    
	 read_hex_data: process
begin
    for i in 0 to 1023 loop  -- 8192 rows / 8 rows per update
        readline(hex_file, hex_line);
        read(hex_line, hex_data);
        
        -- Store hex_data in row_data
        row_data(i*8 + 7 downto i*8) := hex_data;
        
        -- If a full set of 8 rows is read, update inputRow
        if (i + 1) mod 8 = 0 then
            inputRow((i div 8)*64 + 63 downto (i div 8)*64) <= row_data; -- Set Input signal with read data
        end if;
    end loop;
    --file_close(hex_file); -- Close the file when done
end process;
file_close(hex_file);

dut_instance : DWT_Module
        port map (
            
            clock     => clock,
            reset     => reset,
            dwt_valid => dwt_valid,
            inputRow  => inputRow,
            outputRow => outputRow
        );
end arch;


