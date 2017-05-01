library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tff_tb is
end;

architecture a_tff_tb of tff_tb is
	component tff
		port (
			estado: out std_logic;
			clk:    in std_logic;
			rst:    in std_logic
		);
	end component;
	signal estado, clk, rst: std_logic;

begin
	uut: tff port map (
		estado => estado,
		clk    => clk,
		rst    => rst
	);
	
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		rst <= '1';
		wait for 25 ns;
		rst <= '0';
		wait for 400 ns;
		rst <= '1';
		wait for 200 ns;
		wait;
	end process;
end architecture;
		
		
		