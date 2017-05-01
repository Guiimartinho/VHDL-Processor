library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_tb is
end;

architecture a_mux2x1_tb of mux2x1_tb is
    component mux2x1
		port (
			sel: in std_logic;
			x0, x1: in std_logic;
			en: in std_logic;
			y: out std_logic
		);
    end component;
    signal sel, x0, x1, en, y: std_logic;
    
begin
    uut: mux2x1 port map( 
		sel => sel,
		x0 => x0,
		x1 => x1,
		en => en,
		y => y
	);

    process
	begin
		x0 <= '1';
		x1 <= '1';
		en <= '0';
		sel <= '0';
 		wait for 50 ns;
		x0 <= '1';
		x1 <= '1';
		en <= '0';
		sel <= '1';
 		wait for 50 ns;
		x0 <= '0';
		x1 <= '1';
		en <= '1';
		sel <= '0';
 		wait for 50 ns;
		x0 <= '0';
		x1 <= '1';
		en <= '1';
		sel <= '1';
 		wait for 50 ns;
		x0 <= '1';
		x1 <= '0';
		en <= '1';
		sel <= '0';
 		wait for 50 ns;
		x0 <= '1';
		x1 <= '0';
		en <= '1';
		sel <= '1';
 		wait for 50 ns;
		wait;
	end process;
end architecture;
