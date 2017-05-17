library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x3_tb is
end;

architecture a_mux8x3_tb of mux8x3_tb is
    component mux8x3
		port (
			sel: in unsigned(2 downto 0);
			x0, x1, x2, x3, x4, x5, x6, x7: in unsigned(15 downto 0);
			y: out unsigned(15 downto 0)
		);
    end component;
    signal sel: unsigned(2 downto 0);
	signal y, x0, x1, x2, x3, x4, x5, x6, x7: unsigned(15 downto 0);
    
begin
    uut: mux8x3 port map( 
		sel => sel,
		x0 => x0,
		x1 => x1,
		x2 => x2,
		x3 => x3,
		x4 => x4,
		x5 => x5,
		x6 => x6,
		x7 => x7,
		y => y
	);

    process
	begin
		x0 <= "0000000000000001"; -- 0x0001
		x1 <= "0000000000000011"; -- 0x0003
		x2 <= "0000000000000111"; -- 0x0007
		x3 <= "0000000000001111"; -- 0x000F
		x4 <= "0000000000011111"; -- 0x001F
		x5 <= "0000000000111111"; -- 0x003F
		x6 <= "0000000001111111"; -- 0x007F
		x7 <= "0000000011111111"; -- 0x00FF
		sel <= "000";
		wait for 50 ns;
		sel <= "001";
		wait for 50 ns;
		sel <= "010";
		wait for 50 ns;
		sel <= "011";
		wait for 50 ns;
		sel <= "100";
		wait for 50 ns;
		sel <= "101";
		wait for 50 ns;
		sel <= "110";
		wait for 50 ns;
		sel <= "111";
		wait for 50 ns;
		wait;
	end process;
end architecture;
