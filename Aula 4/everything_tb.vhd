library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity everything_tb is
end;

architecture a_everything_tb of everything_tb is
	component everything is
		port (
			clk : in std_logic;
			rst : in std_logic;
			
			-- Debug
			pc   : out unsigned(7 downto 0);
			inst : out unsigned(13 downto 0);
			est  : out std_logic
		);
	end component;
	
	signal clk  : std_logic;
	signal rst  : std_logic;
	signal pc   : unsigned(7 downto 0);
	signal inst : unsigned(13 downto 0);
	signal est  : std_logic;
	
begin
	uut: everything port map (
		clk => clk,
		rst => rst,
		pc => pc,
		inst => inst,
		est => est
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
		wait;
	end process;
end architecture;