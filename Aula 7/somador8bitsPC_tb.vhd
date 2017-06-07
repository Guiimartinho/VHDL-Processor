library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador8bitsPC_tb is
end;

architecture a_somador8bitsPC_tb of somador8bitsPC_tb is
	component somador8bitsPC is
		port (
			pc_in: in unsigned(7 downto 0);
			add_address: in unsigned(7 downto 0);
			jmp_addr: out unsigned(7 downto 0)
		);
	end component;
	
	signal pc_in : unsigned(7 downto 0);
	signal add_address : unsigned(7 downto 0);
	signal jmp_addr : unsigned(7 downto 0);
	
begin
	uut: somador8bitsPC port map (
		pc_in => pc_in,
		add_address => add_address,
		jmp_addr => jmp_addr
	);
	
	process
	begin
		pc_in <= "00000010";
		add_address <= "00000111";
		wait for 100 ns;
		pc_in <= "00000111";
		add_address <= "11111111";
		wait for 100 ns;
		wait;
	end process;
end architecture;