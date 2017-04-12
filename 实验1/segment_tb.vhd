--Author = Zhang Renhui
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity segment_tb is
end segment_tb;

architecture segment_tb_arc of segment_tb is
	component segment_scan is
	port
	(
		clk 	:in 	std_logic;
		num1	:in 	bit_vector(3 downto 0);		--六个二进制数
		num2	:in 	bit_vector(3 downto 0);
		num3	:in 	bit_vector(3 downto 0);
		num4	:in 	bit_vector(3 downto 0);
		num5	:in 	bit_vector(3 downto 0);
		num6	:in 	bit_vector(3 downto 0);
		dp     	:in 	bit_vector(2 downto 0);
		rck		:out 	bit;						--输出信号
		sck		:out 	bit;						--移位信号
		data	:out 	bit						--数据传输
	);
	end component segment_scan;

	signal clk		:	std_logic;
	signal num1 	:	bit_vector(3 downto 0) := "0001";
	signal num2		:  	bit_vector(3 downto 0) := "1110";
	signal dp		:	bit_vector(2 downto 0);
	signal rck		:	bit;
	signal sck		:	bit;
	signal data		:	bit;
begin
	U : segment_scan port map
	(
		clk,
		num1,
		num1,
		num1,
		num2,
		num2,
		num2,
		dp,
		rck,
		sck,
		data
	);

	process(clk)
	begin
		clk = not clk after 5 ns;
	end process;
	
	process(num1,num2)
	begin
		num1 = num1 rol 1 after 80 ns;
		num2 = num2 rol 1 after 80 ns;
	end process;
	
	
end;