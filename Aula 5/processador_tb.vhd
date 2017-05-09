library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end;

architecture a_processador_tb of processador_tb is
	component processador is
		port (
			rst          : in std_logic;
			clk          : in std_logic;
			est          : out unsigned(1 downto 0);
			pc           : out unsigned(7 downto 0);
			inst         : out unsigned(13 downto 0);
			read_data1_o : out unsigned(15 downto 0);
			read_data2_o : out unsigned(15 downto 0);
			alu_out      : out unsigned(15 downto 0)
		);
	end component;
	
	signal rst: std_logic;
	signal clk: std_logic;
	signal est: unsigned(1 downto 0);
	signal pc: unsigned(7 downto 0);
	signal inst: unsigned(13 downto 0);
	signal read_data1_o: unsigned(15 downto 0);
	signal read_data2_o: unsigned(15 downto 0);
	signal alu_out: unsigned(15 downto 0);
	
begin
	uut: processador port map (
		rst => rst,
		clk => clk,
		est => est,
		pc  => pc,
		inst => inst,
		read_data1_o => read_data1_o,
		read_data2_o => read_data2_o,
		alu_out => alu_out
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