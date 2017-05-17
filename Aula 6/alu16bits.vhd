library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu16bits is
    port (
		x, y: in unsigned(15 downto 0);
		operation: in unsigned(1 downto 0);
		saida: out unsigned(15 downto 0);
		zeroFlag, overflowFlag, negativeFlag: out std_logic
    );
end entity;

architecture a_alu16bits of alu16bits is
	signal saida_s: unsigned(15 downto 0);
begin
    saida_s <= x + y when operation = "00" else
			   x - y when operation = "01" else
			   "0000000000000001" when (operation = "11") and (x(15) = y(15)) and (x < y) else
			   "0000000000000001" when (operation = "11") and x(15) = '1' and y(15) = '0' else
			   "0000000000000000" when operation = "11" else
			   "0000000000000000";
	
	zeroFlag <= '1' when (saida_s = "0000000000000000") else '0';
	
	overflowFlag <= '1' when (operation = "00") and (x(15) = y(15)) and (y(15) /= saida_s(15)) else
					'0' when (operation = "00") else
					'1' when (operation = "01") and (x(15) /= y(15)) and (y(15) = saida_s(15)) else
					'0' when (operation = "01") else
					'0';
	
	negativeFlag <= '1' when (saida_s(15) = '1') else
					'0';
	
	saida <= saida_s;
end architecture;
