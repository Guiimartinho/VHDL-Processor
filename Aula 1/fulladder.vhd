library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
    port (
		in_a : in std_logic;
        in_b : in std_logic;
		in_carry : in std_logic;
        out_s : out std_logic;
		out_carry : out std_logic
    );
end entity;

architecture a_fulladder of fulladder is
begin
    out_s <= (in_a xor in_b) xor in_carry;
	out_carry <= ((in_a xor in_b) and in_carry) or (in_a and in_b);
end architecture;
