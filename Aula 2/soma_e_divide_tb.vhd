library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_divide_tb is
end;

architecture a_soma_e_divide_tb of soma_e_divide_tb is
    component soma_e_divide
		port (
			x, y: in unsigned(7 downto 0);
			soma, quoc: out unsigned(7 downto 0)
		);
    end component;
    signal x, y, soma, quoc: unsigned(7 downto 0);
    
begin
    uut: soma_e_divide port map( 
		x => x,
		y => y,
		soma => soma,
		quoc => quoc
	);

    process
	begin
		x <= "00000011";
		y <= "00000101";
 		wait for 50 ns;
		x <= "10010110";
		y <= "10010110";
 		wait for 50 ns;
		x <= "00010010";
		y <= "11111101";
		wait for 50 ns;
		wait;
	end process;
end architecture;
