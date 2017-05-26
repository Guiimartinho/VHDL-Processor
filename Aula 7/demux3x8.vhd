library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux3x8 is
    port (
		x: in std_logic;
		bin: in unsigned(2 downto 0);
        y0, y1, y2, y3, y4, y5, y6, y7: out std_logic
    );
end entity;

architecture a_demux3x8 of demux3x8 is
begin
	y0 <= x when bin = "000" else '0';
	y1 <= x when bin = "001" else '0';
	y2 <= x when bin = "010" else '0';
	y3 <= x when bin = "011" else '0';
	y4 <= x when bin = "100" else '0';
	y5 <= x when bin = "101" else '0';
	y6 <= x when bin = "110" else '0';
	y7 <= x when bin = "111" else '0';
end architecture;
