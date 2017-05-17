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
	0   => "01010000101011", -- 		MOV #5, R3
	1   => "01010001000100", -- 		MOV #8, R4
	2   => "00000000100011", -- 		ADD R4, R3
	3   => "00110001000100", -- 		SUB #8, R4
	4   => "00010111111100", -- 		ADD #63, R4
	5   => "11000000011100", -- 		CMP R3, R4
	6   => "00000000100100", -- loop:	ADD R4, R4
	7   => "11010000000110", -- 		BR loop
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