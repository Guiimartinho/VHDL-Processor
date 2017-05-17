library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg8bits_tb is
end;

architecture a_reg8bits_tb of reg8bits_tb is
	component reg8bits
		port (
			data_in: in unsigned(7 downto 0);
			data_out: out unsigned(7 downto 0);
			clk: in std_logic;
			wr_en: in std_logic;
			rst: in std_logic
		);
	end component;
	signal data_in, data_out: unsigned(7 downto 0);
	signal clk, wr_en, rst: std_logic;
	
begin
	uut: reg8bits port map (
		data_in => data_in,
		data_out => data_out,
		clk => clk,
		wr_en => wr_en,
		rst => rst
	);
	
	process
	begin
		clk <= '0';
		wait for 25 ns;
		clk <= '1';
		wait for 25 ns;
	end process;
	
	process
	begin
		rst <= '0';
		wait for 50 ns;
		rst <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		wait for 50 ns;
		wr_en <= '0';
		data_in <= "10101111";
		wait for 50 ns;
		data_in <= "01000010";
		wait for 50 ns;
		wr_en <= '1';
		data_in <= "10101111";
		wait for 50 ns;
		data_in <= "01000010";
		wait for 50 ns;
		wr_en <= '0';
		data_in <= "10101111";
		wait for 50 ns;
		data_in <= "01000010";
		wait for 50 ns;
		wr_en <= '1';
		data_in <= "10101111";
		data_in <= "01000010";
		wait;
	end process;
end architecture;
		
		
		