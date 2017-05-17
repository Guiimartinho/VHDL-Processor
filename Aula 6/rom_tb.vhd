library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end;

architecture a_rom_tb of rom_tb is
	component rom
		port (
			clk      : in std_logic;
			enable   : in std_logic;
			endereco : in unsigned(7 downto 0);
			dado     : out unsigned(13 downto 0)
		);
	end component;
	signal clk      : std_logic;
	signal enable   : std_logic;
	signal endereco : unsigned(7 downto 0);
	signal dado     : unsigned(13 downto 0);

begin
	uut: rom port map (
		clk      => clk,
		enable   => enable,
		endereco => endereco,
		dado     => dado
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
		enable <= '1';
		endereco <= "00000000";
		wait for 100 ns;
		endereco <= "00000001";
		wait for 100 ns;
		endereco <= "00000010";
		wait for 100 ns;
		endereco <= "00000011";
		wait for 100 ns;
		endereco <= "00000100";
		wait for 100 ns;
		endereco <= "00000101";
		wait for 100 ns;
		endereco <= "00000110";
		wait for 100 ns;
		endereco <= "00000111";
		wait for 100 ns;
		endereco <= "00001000";
		wait for 100 ns;
		endereco <= "00001001";
		wait for 100 ns;
		endereco <= "00001010";
		wait for 100 ns;
		endereco <= "00001011";
		wait for 100 ns;
		enable <= '0';
		endereco <= "00000000";
		wait for 100 ns;
		wait;
	end process;
end architecture;