library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port (
		clk      : in std_logic;
		enable   : in std_logic;
		endereco : in unsigned(7 downto 0);
		dado     : out unsigned(13 downto 0)
	);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 255) of unsigned(13 downto 0);
	constant conteudo_rom : mem := (
	0   => "00000000000010", -- Nada
	1   => "00100000000000", -- Nada
	2   => "11110000000100", -- Jump para instrução 4
	3   => "00000000000000",
	4   => "00100000000000", -- Nada
	5   => "00000000000010", -- Nada
	6   => "00111100000011", -- Nada
	7   => "00000000000010", -- Nada
	8   => "00000000000010", -- Nada
	9   => "11110000000000", -- Jump para instrução 0
	others => (others => '0')
	);
begin
	process(enable,clk)
	begin
		if enable='1' then
			if(rising_edge(clk)) then
				dado <= conteudo_rom(to_integer(endereco));
			end if;
		end if;
	end process;
end architecture;