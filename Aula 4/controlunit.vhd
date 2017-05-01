library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlunit is
	port (
		state       : in std_logic;
		instruction : in unsigned(13 downto 0);
		jump_en     : out std_logic;
		pc_write    : out std_logic;
		mem_read    : out std_logic
	);
end entity;

architecture a_controlunit of controlunit is
	signal opcode : unsigned(3 downto 0);
begin
	opcode <= instruction(13 downto 10);
	
	jump_en <= '1' when opcode="1111" else '0';
	
	mem_read <= '1' when state = '0' else '0';
	pc_write <= '1' when state = '1' else '0';
end architecture;