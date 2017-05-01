library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
	port (
		wr_en    : in std_logic;
		clk      : in std_logic;
		rst      : in std_logic;
		data_out : out unsigned(7 downto 0)
	);
end entity;

architecture a_program_counter of program_counter is
	component reg8bits is
		port (
			data_in  : in  unsigned(7 downto 0);
			data_out : out unsigned(7 downto 0);
			clk      : in  std_logic;
			wr_en    : in  std_logic;
			rst      : in  std_logic
		);
	end component;
	
	component add_1 is
		port (
			input  : in unsigned(7 downto 0);
			output : out unsigned(7 downto 0)
		);
	end component;
	
	signal pc_plus_one : unsigned(7 downto 0);
	signal pc          : unsigned(7 downto 0);
	
begin
	pc_reg: reg8bits port map (
		data_in => pc_plus_one,
		data_out => pc,
		clk => clk,
		wr_en => wr_en,
		rst => rst
	);
	
	pc_increment: add_1 port map (
		input => pc,
		output => pc_plus_one
	);
	
	data_out <= pc;
end architecture;