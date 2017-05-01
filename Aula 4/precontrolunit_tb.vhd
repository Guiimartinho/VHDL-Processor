library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity precontrolunit_tb is
end;

architecture a_precontrolunit_tb of precontrolunit_tb is
	component precontrolunit
		port (
			clk      : in std_logic;
			rst      : in std_logic;
			mem_data : out unsigned(13 downto 0);
			pc_value : out unsigned(7 downto 0);
			t_state  : out std_logic
		);
	end component;
	
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal mem_data : unsigned(13 downto 0);
	signal pc_value : unsigned(7 downto 0);
	signal t_state  : std_logic;

begin
	uut: precontrolunit port map (
		clk => clk,
		rst => rst,
		mem_data => mem_data,
		pc_value => pc_value,
		t_state => t_state
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