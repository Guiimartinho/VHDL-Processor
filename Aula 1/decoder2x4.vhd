library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4 is
    port (
		x1 : in std_logic;
        x0 : in std_logic;
        y3: out std_logic;
		y2: out std_logic;
		y1: out std_logic;
		y0: out std_logic
    );
end entity;

architecture a_decoder2x4 of decoder2x4 is
begin
    y3 <= x1 and x0;
	y2 <= x1 and not x0;
	y1 <= not x1 and x0;
	y0 <= not x1 and not x0;
end architecture;
