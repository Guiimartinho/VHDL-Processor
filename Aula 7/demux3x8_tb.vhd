library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux3x8_tb is
end;

architecture a_demux3x8_tb of demux3x8_tb is
    component demux3x8
		port (
			x: in std_logic;
			bin: in unsigned(2 downto 0);
			y0, y1, y2, y3, y4, y5, y6, y7: out std_logic
		);
    end component;
	signal bin: unsigned(2 downto 0);
    signal x, y0, y1, y2, y3, y4, y5, y6, y7: std_logic;
    
begin
    uut: demux3x8 port map(
		x => x,
		bin => bin,
		y0 => y0,
		y1 => y1,
		y2 => y2,
		y3 => y3,
		y4 => y4,
		y5 => y5,
		y6 => y6,
		y7 => y7
	);

    process
	begin
		x <= '1';
		bin <= "000";
		wait for 50 ns;
		bin <= "001";
		wait for 50 ns;
		bin <= "010";
		wait for 50 ns;
		bin <= "011";
		wait for 50 ns;
		bin <= "100";
		wait for 50 ns;
		bin <= "101";
		wait for 50 ns;
		bin <= "110";
		wait for 50 ns;
		bin <= "111";
		wait for 50 ns;
		wait;
	end process;
end architecture;
