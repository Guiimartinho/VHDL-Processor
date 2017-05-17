library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlunit is
	port (
		state       : in unsigned(1 downto 0);
		instruction : in unsigned(13 downto 0);
		
		branch_en     : out std_logic;
		
		alu_op      : out unsigned(1 downto 0);
		alu_src_b   : out std_logic;
		
		reg_write_source: out unsigned(1 downto 0);
		reg_write   : out std_logic;
		
		pc_write    : out std_logic;
		flags_write : out std_logic;
		mem_read    : out std_logic
	);
end entity;

architecture a_controlunit of controlunit is
	signal opcode : unsigned(3 downto 0);
begin
	opcode <= instruction(13 downto 10);
	
	branch_en <= '1' when opcode="1101" else '0';
	
	alu_op <= "00" when opcode="0000" or opcode="0001" else -- ADD
			  "01" when opcode="0010" or opcode="0011" or opcode="1100" else -- SUB ou CMP
			  "00";
	
	alu_src_b <= '0' when opcode="0000" or opcode="0010" or opcode="1100" else -- Sem constante
				 '1' when opcode="0001" or opcode="0011" else -- Com constante
				 '0';
				 
	reg_write_source <= "00" when opcode="0000" or opcode="0001" or opcode="0010" or opcode="0011" else -- ADD ou SUB (pega o dado da ULA)
						"01" when opcode="0100" else -- MOV Rs, Rd (pega o dado do banco de registradores)
						"10" when opcode="0101" else -- MOV #imm, Rd (pega o dado da instrução)
						"00"; -- Ainda não implementadas instruções de memória
	
	reg_write <= '1' when state = "10" and (opcode="0000" or opcode="0001" or opcode="0010" or opcode="0011" or opcode="0100" or opcode="0101") else -- Operações que escrevem no banco de registradores
				 '0'; -- Qualquer outra operação
	
	flags_write <= '1' when state = "10" and (opcode="0000" or opcode="0001" or opcode="0010" or opcode="0011" or opcode="1100") else
				   '0';
	
	mem_read <= '1' when state = "00" else '0';
	pc_write <= '1' when state = "10" else '0';
end architecture;