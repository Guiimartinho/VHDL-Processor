library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4_tb is
end;

architecture a_decoder2x4_tb of decoder2x4_tb is
    component decoder2x4
        port (
			x1 : in std_logic;
			x0 : in std_logic;
			y3: out std_logic;
			y2: out std_logic;
			y1: out std_logic;
			y0: out std_logic
		);
    end component;
    signal x1,x0,y1,y2,y3,y0: std_logic;
    
begin
    uut: decoder2x4 port map( 
		x1 => x1,
		x0 => x0,
		y3 => y3,
		y2 => y2,
		y1 => y1,
		y0 => y0
	);

    process
	begin
		x1 <= '0';
		x0 <= '0';
		wait for 50 ns;
		x1 <= '0';
		x0 <= '1';
		wait for 50 ns;
		x1 <= '1';
		x0 <= '0';
		wait for 50 ns;
		x1 <= '1';
		x0 <= '1';
		wait for 50 ns;
		wait;
	end process;
end architecture;
