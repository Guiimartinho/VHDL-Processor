library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_1 is
	port (
		input : in unsigned(7 downto 0);
		output: out unsigned(7 downto 0)
	);
end entity;

architecture a_add_1 of add_1 is
begin
	output <= input + "00000001";
end architecture;