library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port (
		sel: in std_logic;
        x0, x1: in std_logic;
		en: in std_logic;
		y: out std_logic
    );
end entity;

architecture a_mux2x1 of mux2x1 is
begin
    y <= x0 when sel = '0' and en = '1' else
		 x1 when sel = '1' and en = '1' else
		 '0';
end architecture;
