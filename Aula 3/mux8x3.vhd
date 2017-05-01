library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x3 is
    port (
		sel: in unsigned(2 downto 0);
        x0, x1, x2, x3, x4, x5, x6, x7: in unsigned(15 downto 0);
		y: out unsigned(15 downto 0)
    );
end entity;

architecture a_mux8x3 of mux8x3 is
begin
    y <= x0 when sel = "000" else
		 x1 when sel = "001" else
		 x2 when sel = "010" else
		 x3 when sel = "011" else
		 x4 when sel = "100" else
		 x5 when sel = "101" else
		 x6 when sel = "110" else
		 x7 when sel = "111" else
		 "0000000000000000";
end architecture;
