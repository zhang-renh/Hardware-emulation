library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity key_scan is
	port
	(
		clk_5ms		:in		std_logic;	
		col_scan	:in		bit_vector(3 downto 0);
		row_scan	:out	bit_vector(3 downto 0);
		key_out		:out 	bit_vector(15 downto 0);--???buffer
		key_flag	:out 	bit
	);
end key_scan;

architecture key_scan_arch of key_scan is
	
begin
	process(clk_5ms)
		variable row 	: bit_vector(3 downto 0);
		variable key	: bit_vector(15 downto 0);
		variable ceshi	: bit_vector(3 downto 0);
	begin
		row := "1110"; 
		if rising_edge(clk_5ms) then
			row :=row sla 1;
			case row is
				when "1110" => key(3 downto 0) := col_scan;
								--row := "1101";
				when "1101" => key(7 downto 4) := col_scan;
								--row :="1011";
				when "1011" => key(11 downto 8) := col_scan;
								--row :="0111";
				when "0111" => key(15 downto 12) := col_scan;
								--row :="1110";	
				when others => null;
			end case;
			if key /="1111111111111111" then
				key_flag <= '1';
			else
				key_flag <= '0';
			end if;
		end if;
		row_scan <= row;
		key_out <= key;
	end process;
end key_scan_arch;