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
	-- Teste inicial
	-- 0   => "01010100000001", -- 		MOV #32, R1
	-- 1   => "01010000101010", -- 		MOV #5, R2
	-- 2   => "01110000001010", -- 		MOV R1, @R2
	-- 3   => "01100000010011", -- 		MOV @R2, R3
	-- 4   => "01110000010001", -- 		MOV R2, @R1
	-- 5   => "01100000001100", -- 		MOV @R1, R4
	
	0   => "01000000000011", -- 		MOV R0, R3
	1   => "01010000000100", -- 		MOV #0, R4
	2   => "01010011110101", -- 		MOV #30, R5
	3   => "00000000011100", -- volta: 	ADD R3, R4
	4   => "01110000100011", -- 		MOV R4, @R3
	5   => "00010000001011", -- 		ADD #1, R3
	6   => "11000000101011", -- 		CMP R5, R3
	7   => "10010011111011", -- 		JN volta
	8   => "01000000100101", -- 		MOV R4, R5
	9   => "01110000100000", -- 		MOV R4, @R0
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