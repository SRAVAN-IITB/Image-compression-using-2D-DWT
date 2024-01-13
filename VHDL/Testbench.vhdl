library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity Testbench is
end entity Testbench;
architecture Behave of Testbench is

  signal clock : std_logic := '0';
  signal reset : std_logic := '0';
  signal dwt_valid   : std_logic;
  signal inputRow_1  : std_logic_vector(63 downto 0);
  signal inputRow_2  : std_logic_vector(63 downto 0);
  signal inputRow_3  : std_logic_vector(63 downto 0);
  signal inputRow_4  : std_logic_vector(63 downto 0);
  signal inputRow_5  : std_logic_vector(63 downto 0);
  signal inputRow_6  : std_logic_vector(63 downto 0);
  signal inputRow_7  : std_logic_vector(63 downto 0);
  signal inputRow_8  : std_logic_vector(63 downto 0);
  signal outputRow_1 : std_logic_vector(63 downto 0);
  signal outputRow_2 : std_logic_vector(63 downto 0);
  signal outputRow_3 : std_logic_vector(63 downto 0);
  signal outputRow_4 : std_logic_vector(63 downto 0);
  signal outputRow_5 : std_logic_vector(63 downto 0);
  signal outputRow_6 : std_logic_vector(63 downto 0);
  signal outputRow_7 : std_logic_vector(63 downto 0);
  signal outputRow_8 : std_logic_vector(63 downto 0);

  
  component DWT_Module is
  Port (
    clock       : in  STD_LOGIC;
    reset       : in  STD_LOGIC;
    dwt_valid   : out STD_LOGIC;
    inputRow_1  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_2  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_3  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_4  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_5  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_6  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_7  : in  STD_LOGIC_VECTOR(63 downto 0);
    inputRow_8  : in  STD_LOGIC_VECTOR(63 downto 0);
    outputRow_1 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_2 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_3 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_4 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_5 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_6 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_7 : out STD_LOGIC_VECTOR(63 downto 0);
    outputRow_8 : out STD_LOGIC_VECTOR(63 downto 0)
  );
end component;
  type Memory_data_type is Array (0 to 7) of std_logic_vector(63 downto 0);
   signal init_data : Memory_data_type := (others=>"0000000000000000000000000000000000000000000000000000000000000000");
   signal out_data : Memory_data_type := (others=>"0000000000000000000000000000000000000000000000000000000000000000");
	impure function init_mem return Memory_data_type is
	
		file text_file : text open read_mode is "D:\IIT-B\E.E. DD\2nd Year\Autumn Semester\EE 214\New folder\Image-compression-using-2D-DWT\VHDL\outputBIN_arranged.txt";
		variable text_line : line;
		variable mem_content : Memory_data_type;	
		begin
			for i in 0 to 7 loop
				readline(text_file, text_line);
				read(text_line, mem_content(i));
			end loop;	
		return mem_content;
	end function;
	
	impure function write_output_to_file (output_data : Memory_data_type; dwt_valid_signal : std_logic) return BOOLEAN is
    file text_file : text open write_mode is "D:\IIT-B\E.E. DD\2nd Year\Autumn Semester\EE 214\New folder\Image-compression-using-2D-DWT\VHDL\output_result.txt";
    variable text_line : line;
begin
    if dwt_valid_signal = '1' then
        for i in 0 to 7 loop
            write(text_line, output_data(i));
            writeline(text_file, text_line);
        end loop;
        return true;
    else
        return false;
    end if;
end function;

	
	begin
	 init_data<=init_mem;
	 inputRow_1 <= init_data(0);
	 inputRow_2 <= init_data(1);
	 inputRow_3 <= init_data(2);
	 inputRow_4 <= init_data(3);
	 inputRow_5 <= init_data(4);
	 inputRow_6 <= init_data(5);
	 inputRow_7 <= init_data(6);
	 inputRow_8 <= init_data(7);
	 uut :  DWT_Module port map (clock,reset,dwt_valid,inputRow_1,inputRow_2,inputRow_3,inputRow_4,inputRow_5,
	            inputRow_6,inputRow_7,inputRow_8,outputRow_1,outputRow_2,outputRow_3,outputRow_4,
					outputRow_5,outputRow_6,outputRow_7,outputRow_8);
					-- After the DWT module has processed the input data
					 out_data(0) <= outputRow_1;
		  out_data(1) <= outputRow_2;
		  out_data(2) <= outputRow_3;
		  out_data(3) <= outputRow_4;
		  out_data(4) <= outputRow_5;
		  out_data(5) <= outputRow_6;
		  out_data(6) <= outputRow_7;
		  out_data(7) <= outputRow_8;
		 
   process
    begin
        while now < 1000 ns loop
            clock <= not clock;
            wait for 5 ns; 	
        end loop;
        wait;
		 
		    if write_output_to_file(out_data, dwt_valid) then
    report "Output data written to file successfully." severity NOTE;
   else
    report "Output data not written to file due to dwt_valid = '0'." severity NOTE;
   end if;
    end process;
	 
	
	

    
end Behave;

