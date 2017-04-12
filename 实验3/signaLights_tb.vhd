--Author = Zhang Renhui
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity signalLights_tb is
end signalLights_tb;

architecture signalLights_tb_arc of signalLights_tb is
	component signalLights is
	port
	(
		clk_in 		:in		std_logic;
		led1		:out 	std_logic_vector(2 downto 0);--R,G,B
		led2		:out 	std_logic_vector(2 downto 0);
	);
	end component signalLights;
	signal clk_in	:	std_logic;
	signal led1		:	std_logic_vector(2 downto 0);
	signal led2		:	std_logic_vector(2 downto 0);
begin
	U: signalLights port map(clk_in,led1,led2);
	
	process(clk_in)
	begin
		clk_in <= not clk_in after 50 ns;
	end process;
end;