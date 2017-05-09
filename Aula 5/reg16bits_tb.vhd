library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end;

architecture a_reg16bits_tb of reg16bits_tb is
	component reg16bits
		port (
			data_in: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0);
			clk: in std_logic;
			wr_en: in std_logic;
			rst: in std_logic
		);
	end component;
	signal data_in, data_out: unsigned(15 downto 0);
	signal clk, wr_en, rst: std_logic;
	
begin
	uut: reg16bits port map (
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
		data_in <= "1010111111111111";
		wait for 50 ns;
		data_in <= "0000000001000010";
		wait for 50 ns;
		wr_en <= '1';
		data_in <= "1010111111111111";
		wait for 50 ns;
		data_in <= "0000000001000010";
		wait for 50 ns;
		wr_en <= '0';
		data_in <= "1010111111111111";
		wait for 50 ns;
		data_in <= "0000000001000010";
		wait for 50 ns;
		wr_en <= '1';
		data_in <= "1010111111111111";
		wait for 50 ns;
		data_in <= "0000000001000010";
		wait;
	end process;
end architecture;
		
		
		