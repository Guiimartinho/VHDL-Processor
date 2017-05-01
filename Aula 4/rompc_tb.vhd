library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rompc_tb is
end;

architecture a_rompc_tb of rompc_tb is
	component rompc
		port (
			wr_en    : in std_logic;
			rom_en   : in std_logic;
			clk      : in std_logic;
			rst      : in std_logic;
			mem_data : out unsigned(13 downto 0)
		);
	end component;
	
	signal wr_en    : std_logic;
	signal rom_en   : std_logic;
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal mem_data : unsigned(13 downto 0);

begin
	uut: rompc port map (
		wr_en => wr_en,
		rom_en => rom_en,
		clk => clk,
		rst => rst,
		mem_data => mem_data
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
		rom_en <= '1';
		wait for 25 ns;
		rst <= '0';
		wait;
	end process;
end architecture;