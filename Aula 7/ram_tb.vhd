library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end;

architecture a_ram_tb of ram_tb is
	component ram
		port (
			clk      : in std_logic;
			wr_en    : in std_logic;
			endereco : in unsigned(15 downto 0);
			dado_in  : in unsigned(15 downto 0);
			dado_out : out unsigned(15 downto 0)
		);
	end component;
	signal clk      : std_logic;
	signal wr_en    : std_logic;
	signal endereco : unsigned(15 downto 0);
	signal dado_in  : unsigned(15 downto 0);
	signal dado_out : unsigned(15 downto 0);

begin
	uut: ram port map (
		clk      => clk,
		wr_en    => wr_en,
		endereco => endereco,
		dado_in  => dado_in,
		dado_out => dado_out
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
		wr_en <= '1';
		dado_in <= "1111111111111111";
		endereco <= "0000000000000000";
		wait for 100 ns;
		dado_in <= "1111111111111110";
		endereco <= "0000000000000001";
		wait for 100 ns;
		dado_in <= "1111111111111101";
		endereco <= "0000000000000010";
		wait for 100 ns;
		dado_in <= "1111111111111100";
		endereco <= "0000000000000011";
		wait for 100 ns;
		wr_en <= '0';
		dado_in <= "1111111111111011";
		endereco <= "0000000000000100";
		wait for 100 ns;
		wait;
	end process;
end architecture;