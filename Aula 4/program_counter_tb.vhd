library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end;

architecture a_program_counter_tb of program_counter_tb is
	component program_counter
		port (
			wr_en    : in std_logic;
			clk      : in std_logic;
			rst      : in std_logic;
			data_out : out unsigned(7 downto 0)
		);
	end component;
	
	signal wr_en    : std_logic;
	signal clk      : std_logic;
	signal rst      : std_logic;
	signal data_out : unsigned(7 downto 0);

begin
	uut: program_counter port map (
		wr_en    => wr_en,
		clk      => clk,
		rst      => rst,
		data_out => data_out
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
		wr_en <= '1';
		wait for 25 ns;
		rst <= '0';
		wait;
	end process;
end architecture;