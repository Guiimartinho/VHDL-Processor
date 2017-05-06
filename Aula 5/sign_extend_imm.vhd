library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_imm is
	port (
		data_in  : in unsigned(6 downto 0);
		data_out : out unsigned(15 downto 0)
	);
end entity;

architecture a_sign_extend_imm of sign_extend_imm is
	signal sign: std_logic;
begin
	sign <= data_in(6);
	
	data_out(6 downto 0) <= data_in;
	data_out(7) <= sign;
	data_out(8) <= sign;
	data_out(9) <= sign;
	data_out(10) <= sign;
	data_out(11) <= sign;
	data_out(12) <= sign;
	data_out(13) <= sign;
	data_out(14) <= sign;
	data_out(15) <= sign;
end architecture;