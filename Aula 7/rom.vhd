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
	
	-- Segundo teste
	-- 0   => "01000000000011", -- 		MOV R0, R3
	-- 1   => "01010000000100", -- 		MOV #0, R4
	-- 2   => "01010011110101", -- 		MOV #30, R5
	-- 3   => "00000000011100", -- volta: 	ADD R3, R4
	-- 4   => "01110000100011", -- 		MOV R4, @R3
	-- 5   => "00010000001011", -- 		ADD #1, R3
	-- 6   => "11000000101011", -- 		CMP R5, R3
	-- 7   => "10010011111011", -- 		JN volta
	-- 8   => "01000000100101", -- 		MOV R4, R5
	-- 9   => "01110000100000", -- 		MOV R4, @R0
	
	-- 0   => "01010000000001", -- 		MOV #0, R1
	-- 1   => "01010100000111", -- 		MOV #32, R7
	-- 2   => "00010000001001", -- write:	ADD #1, R1
	-- 3   => "01110000001001", -- 		MOV R1, @R1
	-- 4   => "11000000111001", -- 		CMP R7, R1
	-- 5   => "10010011111100", -- 		JN write
	-- 6   => "01010000010001", -- 		MOV #2, R1
	-- 7   => "01000000001010", -- primo:	MOV R1, R2
	-- 8   => "00000000001010", -- zerar:	ADD R1, R2
	-- 9   => "11000000010111", -- 		CMP R2, R7
	-- 10  => "10010000000011", -- 		JN next
	-- 11  => "01110000000010", -- 		MOV R0, @R2
	-- 12  => "11000000111010", -- 		CMP R7, R2
	-- 13  => "10010011111010", -- 		JN zerar
	-- 14  => "00010000001001", -- next:	ADD #1, R1
	-- 15  => "11000000001111", -- 		CMP R1, R7
	-- 16  => "10010000000100", -- 		JN out
	-- 17  => "01100000001011", -- 		MOV @R1, R3
	-- 18  => "11000000000011", -- 		CMP R0, R3
	-- 19  => "10100011111010", -- 		JEQ next
	-- 20  => "10000011110010", -- 		JMP primo
	-- 21  => "00000000000000", -- out:	NOP
	
	0   => "01010000000100", -- 		MOV #0, R4
	1   => "01010111111011", -- 		MOV #127, R3 -- Nesse aqui não toca mais
	2   => "01110000100100", -- prench:	MOV R4, @R4 -- Coloca valor x em ram[x]
	3   => "00010000001100", -- 		ADD #1, R4
	4   => "11000000011100", -- 		CMP R3, R4
	5   => "10010011111100", -- 		JN prench
	6   => "01010000001100", -- 		MOV #1, R4 -- Apenas pra iniciar o loop em 2
	7   => "00010000001100", -- loop:	ADD #1, R4
	8   => "11000000100011", -- 		CMP R4, R3 -- Condição de saida do for
	9   => "10010000001001", -- 		JN acabo -- Aki sai do for se der a condição
	10  => "01100000100101", -- 		MOV @R4, R5
	11  => "11000000101000", -- 		CMP R5, R0
	12  => "10100011111010", -- 		JEQ loop -- Equivalente if ram[i] == 0
	13  => "01000000100110", -- 		MOV R4, R6
	14  => "00000000100110", -- addcri:	ADD R4, R6 -- Equivalente crivador = i+i
	15  => "11000000110011", -- 		CMP R6, R3
	16  => "10010011110110", -- 		JN loop -- Pula se o crivador ficar maior que 127
	17  => "01110000000110", -- 		MOV R0, @R6
	18  => "10000011111011", -- 		JMP addcri -- Loop while
	19  => "00000000000000", -- acabo: -- Aki vai a saída pra "printa" os primos   

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