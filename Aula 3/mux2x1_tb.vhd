library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_tb is
end;

architecture a_mux2x1_tb of mux2x1_tb is
    component mux2x1
		port (
			sel: in std_logic;
			x0, x1: in unsigned(15 downto 0);
			y: out unsigned(15 downto 0)
		);
    end component;
    signal sel: std_logic;
	signal x0, x1, y: unsigned(15 downto 0);
    
begin
    uut: mux2x1 port map( 
		sel => sel,
		x0 => x0,
		x1 => x1,
		y => y
	);

    process
	begin
		x0 <= "0000000000000000";
		x1 <= "1111111111111111";
		sel <= '0';
 		wait for 50 ns;
		x0 <= "0000000000000000";
		x1 <= "1111111111111111";
		sel <= '1';
 		wait for 50 ns;
		x0 <= "1111111111111111";
		x1 <= "0000000000000000";
		sel <= '0';
 		wait for 50 ns;
		x0 <= "1111111111111111";
		x1 <= "0000000000000000";
		sel <= '1';
 		wait for 50 ns;
		wait;
	end process;
end architecture;
