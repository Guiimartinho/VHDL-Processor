library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regbank16bits_tb is
end;

architecture a_regbank16bits_tb of regbank16bits_tb is
    component regbank16bits
        port (
			read_reg1, read_reg2, write_reg: in unsigned(2 downto 0);
			write_data: in unsigned(15 downto 0);
			write_en, clk, rst: in std_logic;
			read_data1, read_data2: out unsigned(15 downto 0)
		);
    end component;
    signal read_reg1, read_reg2, write_reg: unsigned(2 downto 0);
	signal read_data1, read_data2, write_data: unsigned(15 downto 0);
	signal write_en, clk, rst: std_logic;
    
begin
    uut: regbank16bits port map( 
		read_reg1 => read_reg1,
		read_reg2 => read_reg2,
		write_reg => write_reg,
		read_data1 => read_data1,
		read_data2 => read_data2,
		write_data => write_data,
		write_en => write_en,
		clk => clk,
		rst => rst
	);

	-- Tonight we dine in hell
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		rst <= '0';
		wait for 3300 ns;
		rst <= '1';
		wait for 100 ns;
		wait;
	end process;
	
    process
	begin
		read_reg1 <= "000";
		read_reg2 <= "000";
		
		-- Teste de escrita
		write_en <= '1';
		write_reg <= "000";
		write_data <= "0000000000000001"; -- 0x0001
		wait for 100 ns;
		write_reg <= "001";
		write_data <= "0000000000000011"; -- 0x0003
		wait for 100 ns;
		write_reg <= "010";
		write_data <= "0000000000000111"; -- 0x0007
		wait for 100 ns;
		write_reg <= "011";
		write_data <= "0000000000001111"; -- 0x000F
		wait for 100 ns;
		write_reg <= "100";
		write_data <= "0000000000011111"; -- 0x001F
		wait for 100 ns;
		write_reg <= "101";
		write_data <= "0000000000111111"; -- 0x003F
		wait for 100 ns;
		write_reg <= "110";
		write_data <= "0000000001111111"; -- 0x007F
		wait for 100 ns;
		write_reg <= "111";
		write_data <= "0000000011111111"; -- 0x00FF
		wait for 100 ns;
		
		write_en <= '0';
		write_reg <= "000";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "001";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "010";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "011";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "100";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "101";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "110";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		write_reg <= "111";
		write_data <= "1101111010101101"; -- 0xDEAD
		wait for 100 ns;
		
		-- Teste de leitura
		read_reg1 <= "000";
		read_reg2 <= "001";
		wait for 100 ns;
		read_reg1 <= "010";
		read_reg2 <= "011";
		wait for 100 ns;
		read_reg1 <= "100";
		read_reg2 <= "101";
		wait for 100 ns;
		read_reg1 <= "110";
		read_reg2 <= "111";
		wait for 100 ns;
		
		-- Teste de escrita 2
		write_en <= '1';
		write_reg <= "000";
		write_data <= "1010101010101010"; -- 0xAAAA
		wait for 100 ns;
		write_reg <= "001";
		write_data <= "1010101010101110"; -- 0xAAAE
		wait for 100 ns;
		write_reg <= "010";
		write_data <= "1010101011101110"; -- 0xAAEE
		wait for 100 ns;
		write_reg <= "011";
		write_data <= "1010111011101110"; -- 0xAEEE
		wait for 100 ns;
		write_reg <= "100";
		write_data <= "1110111011101110"; -- 0xEEEE
		wait for 100 ns;
		write_reg <= "101";
		write_data <= "1110111011100000"; -- 0xEEE0
		wait for 100 ns;
		write_reg <= "110";
		write_data <= "1110111000000000"; -- 0xEE00
		wait for 100 ns;
		write_reg <= "111";
		write_data <= "1110000000000000"; -- 0xE000
		wait for 100 ns;
		
		-- Teste de leitura
		read_reg1 <= "000";
		read_reg2 <= "001";
		wait for 100 ns;
		read_reg1 <= "010";
		read_reg2 <= "011";
		wait for 100 ns;
		read_reg1 <= "100";
		read_reg2 <= "101";
		wait for 100 ns;
		read_reg1 <= "110";
		read_reg2 <= "111";
		wait for 100 ns;
		wait;
	end process;
end architecture;
