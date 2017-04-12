--Author = Zhang Renhui
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity signalLights is
port
(
	clk_in 		:in		std_logic;
	led1		:out 	std_logic_vector(2 downto 0);--R,G,B
	led2		:out 	std_logic_vector(2 downto 0);
);
end signalLights;

architecture signalLights_arc of signalLights is
	signal state 	:bit_vector(3 downto 0)			:= "0001";
	signal red		:std_logic_vector(2 downto 0)	:= "011";
	signal green	:std_logic_vector(2 downto 0)	:= "101";
	signal yellow	:std_logic_vector(2 downto 0)	:= "100";
begin
	process(clk_in)
	begin 
		if rising_edge(clk_in) then
			state <= state rol 1;
			case state is
				when "0001" => led1 <= green;	led2 <= red;
				when "0010" => led1 <= yellow; 	led2 <= red;
				when "0100" => led1 <= red;		led2 <= green;
				when "1000" => led1 <= red;		led1 <= yellow;
				when others => null;
			end case;
		end if;
	end process;
end;