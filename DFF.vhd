library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-----------------------------
entity MY_DFF is	
	port(
		D,CLK	:in std_logic;
		Q		:out std_logic);
end MY_DFF;
------------------------------
architecture MY_DFF_arch of MY_DFF is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
		    --falling_edge
			Q<=D;
		end if;
	end process;
end MY_DFF_arch;