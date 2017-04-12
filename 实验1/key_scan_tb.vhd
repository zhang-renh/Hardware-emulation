--Author = Zhang Renhui
library ieee;

entity key_scan_tb is

end key_scan_tb;

architecture key_scan_tb_arc of key_scan_tb is
	component key_scan is
	port
	(
		clk_5ms		:in		std_logic;	
		col_scan	:in		bit_vector(3 downto 0);
		row_scan	:out	bit_vector(3 downto 0);
		key_out		:out 	bit_vector(15 downto 0);
		key_flag	:out 	bit
	);
	end component key_scan;
	signal clk_5ms	: std_logic := '0';
	signal col_scan : bit_vector(3 downto 0);
	signal row_scan	: bit_vector(3 downto 0);
	signal key_out	: bit_vector(15 downto 0);
	signal key_flag	: bit;
	
	
	
begin
	U : key_scan port map (clk_5ms,col_scan,row_scan,key_out,key_flag);
	
	process(clk_5ms)
	begin
		clk_5ms = not clk_5ms after 50 ns;
	end process;
	
	process(col_scan)
	begin
		col_scan <= col_scan sla 1 after 200 ns;
	end
	
				
end;