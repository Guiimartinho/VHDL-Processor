library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_1_tb is
end;

architecture a_add_1_tb of add_1_tb is
	component add_1 is
		port (
			input : in unsigned(7 downto 0);
			output: out unsigned(7 downto 0)
		);
	end component;

	signal input, output : unsigned(7 downto 0);
	
begin
	uut: add_1 port map (
		input => input,
		output => output
	);
	
	process
	begin
		input <= "00000001";
		wait for 100 ns;
		input <= "00000010";
		wait for 100 ns;
		wait;
	end process;
end architecture;