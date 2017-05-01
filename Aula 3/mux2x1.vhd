library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
    port (
		sel: in std_logic;
        x0, x1: in unsigned(15 downto 0);
		y: out unsigned(15 downto 0)
    );
end entity;

architecture a_mux2x1 of mux2x1 is
begin
    y <= x0 when sel = '0' else
		 x1 when sel = '1' else
		 "0000000000000000";
end architecture;
