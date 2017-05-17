library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_imm_tb is
end;

architecture a_sign_extend_imm_tb of sign_extend_imm_tb is
	component sign_extend_imm is
		port (
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(15 downto 0)
		);
	end component;
	
	signal data_in : unsigned(6 downto 0);
	signal data_out : unsigned(15 downto 0);
	
begin
	uut: sign_extend_imm port map (
		data_in => data_in,
		data_out => data_out
	);
	
	process
	begin
		data_in <= "0000000";
		wait for 100 ns;
		data_in <= "0000001";
		wait for 100 ns;
		data_in <= "1000000";
		wait for 100 ns;
		data_in <= "1111111";
		wait for 100 ns;
		wait;
	end process;
end architecture;