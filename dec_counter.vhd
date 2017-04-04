library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

entity dec_counter is
	port
	(
		clk		:in		bit;
		clr		:in		bit;
		carry	:out	bit;
		num		:out	bit_vector(4 downto 0)
	);
end dec_counter;

architecture dec_counter_arch of dec_counter is
begin
		process(clr)
		begin
			if rising_edge(CLK) then
				num <= "0000";
				carry <= '0';
			end if;
		end process;
		
		process(clk)
		begin
			carry <= '0';
			if rising_edge(clk) then
				num <= num + 1;
			end if;
			if num = "1001" then
				num <= "0000";
				carry <= '1';
			end if;
		end process;
end dec_counter_arch;