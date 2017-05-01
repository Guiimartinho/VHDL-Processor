library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu16bits is
    port (
		x, y: in unsigned(15 downto 0);
		operation: in unsigned(3 downto 0);
		saida: out unsigned(15 downto 0);
		zeroFlag, overflowFlag: out std_logic
    );
end entity;

architecture a_alu16bits of alu16bits is
	signal saida_s: unsigned(15 downto 0);
begin
    saida_s <= x and y when operation = "0000" else
			   x or y when operation = "0001" else
			   x + y when operation = "0010" else
			   x - y when operation = "0110" else
			   "0000000000000001" when (operation = "0111") and (x(15) = y(15)) and (x < y) else
			   "0000000000000001" when (operation = "0111") and x(15) = '1' and y(15) = '0' else
			   "0000000000000000" when operation = "0111" else
			   x nor y when operation = "1100" else
			   "0000000000000000";
	zeroFlag <= '1' when (saida_s = "0000000000000000") else '0';
	overflowFlag <= '1' when (operation = "0010") and (x(15) = y(15)) and (y(15) /= saida_s(15)) else
					'0' when (operation = "0010") else
					'1' when (operation = "0110") and (x(15) /= y(15)) and (y(15) = saida_s(15)) else
					'0' when (operation = "0110") else
					'0';
	saida <= saida_s;
end architecture;
