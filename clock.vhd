library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

entity clock is
	port
	(
		clk		:in 	bit;
		freq1	:out 	bit;
		freq2	:out 	bit
	);
end clock;

architecture clock_arch of clock is
begin

	process(clk)
	variable clk_cnt : bit_vector(28 downto 0); 
	begin
		if rising_edge(clk) then
			clk_cnt := clk_cnt + 1;
			time_20ms := clk_cnt(18);		--大约20ms
			time_1s := clk_cnt(24);		--大约1s
		end if;
	end process;

end clock_arch;