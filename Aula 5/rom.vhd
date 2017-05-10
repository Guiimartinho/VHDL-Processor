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
	2   => "01010000000101", -- dest2:	MOV #0, R5
	3   => "00000000011101", -- 		ADD R3, R5
	4   => "00000000100101", -- 		ADD R4, R5
	5   => "00110000001101", -- 		SUB #1, R5
	6   => "11010000010100", -- 		BR dest1
	7   => "00000000000000", -- 		NOP
	8   => "00000000000000", -- 		NOP
	9   => "00000000000000", -- 		NOP
	10  => "00000000000000", -- 		NOP
	11  => "00000000000000", -- 		NOP
	12  => "00000000000000", -- 		NOP
	13  => "00000000000000", -- 		NOP
	14  => "00000000000000", -- 		NOP
	15  => "00000000000000", -- 		NOP
	16  => "00000000000000", -- 		NOP
	17  => "00000000000000", -- 		NOP
	18  => "00000000000000", -- 		NOP
	19  => "00000000000000", -- 		NOP
	20  => "01000000101011", -- dest1:	MOV R5, R3
	21  => "11010000000010", -- 		BR dest2
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