library ieee;
use ieee.std_logic_1164.all;

entity fulladder_tb is
end;

architecture a_fulladder_tb of fulladder_tb is
    component fulladder
        port (
			in_a : in std_logic;
			in_b : in std_logic;
			in_carry : in std_logic;
			out_s : out std_logic;
			out_carry : out std_logic
		);
    end component;
    signal in_a,in_b,in_carry,out_s,out_carry: std_logic;
    
begin
    uut: fulladder port map( 
		in_a => in_a,
		in_b => in_b,
		in_carry => in_carry,
		out_s => out_s,
		out_carry => out_carry
	);

    process
	begin
		in_a <= '0';
		in_b <= '0';
		in_carry <= '0';
		wait for 50 ns;
		in_a <= '0';
		in_b <= '0';
		in_carry <= '1';
		
		wait for 50 ns;
		in_a <= '0';
		in_b <= '1';
		in_carry <= '0';
		wait for 50 ns;
		in_a <= '0';
		in_b <= '1';
		in_carry <= '1';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '0';
		in_carry <= '0';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '0';
		in_carry <= '1';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '1';
		in_carry <= '0';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '1';
		in_carry <= '1';
		wait for 50 ns;
		wait;
	end process;
end architecture;
