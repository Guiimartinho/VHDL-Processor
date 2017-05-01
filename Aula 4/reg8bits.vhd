library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg8bits is
    port (
		data_in: in unsigned(7 downto 0);
		data_out: out unsigned(7 downto 0);
		clk: in std_logic;
		wr_en: in std_logic;
		rst: in std_logic
    );
end entity;

architecture a_reg8bits of reg8bits is
	signal dado: unsigned(7 downto 0);

begin
	process(clk,rst,wr_en)
	begin
		if rst='1' then
			dado <= "00000000";
		elsif wr_en='1' then
			if rising_edge(clk) then
				dado <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= dado;
end architecture;