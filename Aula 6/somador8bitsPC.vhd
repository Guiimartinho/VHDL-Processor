library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador8bitsPC is
    port (
        pc_in: in unsigned(7 downto 0);
        add_address: in unsigned(7 downto 0);
        pc_result: out unsigned(7 downto 0)
    );
end entity;

architecture a_somador8bitspc of somador8bitspc is
begin
    pc_result <= pc_in + add_address;
end architecture;