--Author = Zhang Renhui
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity segment_scan is
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
end segment_scan;

architecture segment_scan_arc of segment_scan is
	signal in_data 		: bit_vector(15 downto 0) 		:="0000000000111110";
	signal seven_seg	: bit_vector(7 downto 0)		:="00000000";
	signal num			: bit_vector(3 downto 0)		:="0000";
	signal count		: std_logic_vector(4 downto 0)	:="00000";
	signal in_rck		: bit							:='0';
begin
	
	process(clk)
	
	begin
		if rising_edge(clk) then
			case in_rck is
				when '1' => in_data(5 downto 0) <= in_data(5 downto 0) rol 1;
				when others => null;
			end case;
			--从六个数中选一个
			case in_data(5 downto 0) is
				when "111110" => num <= num1;
				when "111101" => num <= num2;
				when "111011" => num <= num3;
				when "110111" => num <= num4;
				when "101111" => num <= num5;
				when "011111" => num <= num6;
				when others => null;
			end case;
			--七段码译码
			case num is
				when "0000" => in_data(14 downto 8)<="0111111";
				when "0001" => in_data(14 downto 8)<="0000110";
				when "0010" => in_data(14 downto 8)<="1011011";
				when "0011" => in_data(14 downto 8)<="1001111";
		
				when "0100" => in_data(14 downto 8)<="1100110";
				when "0101" => in_data(14 downto 8)<="1101101";
				when "0110" => in_data(14 downto 8)<="1111101";
				when "0111" => in_data(14 downto 8)<="0000111";
		
				when "1000" => in_data(14 downto 8)<="1111111";
				when "1001" => in_data(14 downto 8)<="1101111";
				when others => null;
				--when "0010" => indata(14 downto 8)<="1111111";
				--when "0011" => indata(14 downto 8)<="0000110";
		
				--when "0000" => indata(14 downto 8)<="1000000";
				--when "0001" => indata(14 downto 8)<="0000110";
				--when "0010" => indata(14 downto 8)<="1011011";
				--when "0011" => indata(14 downto 8)<="0000110";
			end case;
			--小数点控制
			case dp is
				when "001" => in_data(15) <= not in_data(0);
				when "010" => in_data(15) <= not in_data(1);
				when "011" => in_data(15) <= not in_data(2);
				when "100" => in_data(15) <= not in_data(3);
				when "101" => in_data(15) <= not in_data(4);
				when "110" => in_data(15) <= not in_data(5);
				when others => in_data(15) <= '0';
			end case;
			--16位数据传输
			case count is
				when "00000" => sck <= '0'; data <= in_data(0);
				when "00001" => sck <= '1';
				when "00010" => sck <= '0'; data <= in_data(1);
				when "00011" => sck <= '1';
				when "00100" => sck <= '0'; data <= in_data(2);
				when "00101" => sck <= '1';
				when "00110" => sck <= '0'; data <= in_data(3);
				when "00111" => sck <= '1';
				
				when "01000" => sck <= '0'; data <= in_data(4);
				when "01001" => sck <= '1';
				when "01010" => sck <= '0'; data <= in_data(5);
				when "01011" => sck <= '1';
				when "01100" => sck <= '0'; data <= in_data(6);
				when "01101" => sck <= '1';
				when "01110" => sck <= '0'; data <= in_data(7);
				when "01111" => sck <= '1';
				
				when "10000" => sck <= '0'; data <= in_data(8);
				when "10001" => sck <= '1';
				when "10010" => sck <= '0'; data <= in_data(9);
				when "10011" => sck <= '1';
				when "10100" => sck <= '0'; data <= in_data(10);
				when "10101" => sck <= '1';
				when "10110" => sck <= '0'; data <= in_data(11);
				when "10111" => sck <= '1';
				
				when "11000" => sck <= '0'; data <= in_data(12);
				when "11001" => sck <= '1';
				when "11010" => sck <= '0'; data <= in_data(13);
				when "11011" => sck <= '1';
				when "11100" => sck <= '0'; data <= in_data(14);
				when "11101" => sck <= '1';
				when "11110" => sck <= '0'; data <= in_data(15);
				when "11111" => sck <= '1';
				when others => null;
			end case;
			
			count <= count + 1;
			if count = "11111" then 
				in_rck <= '1';
			else 
				in_rck <= '0';
			end if;
			
			rck <= in_rck;
			
		end if;
	end process;
	
end;