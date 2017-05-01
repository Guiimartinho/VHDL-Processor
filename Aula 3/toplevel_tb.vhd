library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end;

architecture a_toplevel_tb of toplevel_tb is
	component toplevel
		port (
			aluop     : in unsigned(3 downto 0);
			r_reg1    : in unsigned(2 downto 0);
			r_reg2    : in unsigned(2 downto 0);
			w_reg     : in unsigned(2 downto 0);
			immediate : in unsigned(15 downto 0);
			aluSrc    : in std_logic;
			clk       : in std_logic;
			rst       : in std_logic;
			wr_en     : in std_logic;
			saidaALU  : out unsigned(15 downto 0)
		);
	end component;
	signal aluop     : unsigned(3 downto 0);
	signal r_reg1    : unsigned(2 downto 0);
	signal r_reg2    : unsigned(2 downto 0);
	signal w_reg     : unsigned(2 downto 0);
	signal immediate : unsigned(15 downto 0);
	signal aluSrc    : std_logic;
	signal clk       : std_logic;
	signal rst       : std_logic;
	signal wr_en     : std_logic;
	signal saidaALU  : unsigned(15 downto 0);
    
begin
	uut: toplevel port map(
		aluop     => aluop,
		r_reg1    => r_reg1,
		r_reg2    => r_reg2,
		w_reg     => w_reg,
		immediate => immediate,
		aluSrc    => aluSrc,
		clk       => clk,
		rst       => rst,
		wr_en     => wr_en,
		saidaALU  => saidaALU
	);
	
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		rst <= '1';
		wait for 25 ns;
		rst <= '0';
		wait;
	end process;
	
	process
	begin
		aluop     <= "0010"; -- ADD
		r_reg1    <= "001"; -- R1 tem inicialmente 0 (devido ao reset).
		r_reg2    <= "111"; -- R7 tem inicialmente 0 (devido ao reset).
		w_reg     <= "001"; -- Tentará escrever em R1.
		immediate <= "0000000000000001"; -- Seta a constante imediata para 1
		aluSrc    <= '1'; -- Seleciona a constante.
		wr_en     <= '0'; -- Inicialmente não escreve.
		-- A saída da ULA será 1, mas não será armazenada em R1.
		
		wait for 100 ns;
		wr_en <= '1'; -- Agora escreve.
		
		-- R1 contém 0.
		-- A saída da ULA é R1 + 1 = 1, e será armazenada em R1.
		wait for 100 ns;
		
		-- R1 contém 1.
		-- A saída da ULA é R1 + 1 = 2, e será armazenada em R1.
		wait for 100 ns;
		w_reg <= "111"; -- Agora escreverá em R7.
		
		-- R1 contém 2.
		-- A saída da ULA é R1 + 1 = 3, e será armazenada em R7.
		wait for 100 ns;
		aluSrc <= '0'; -- Seleciona o registrador 2
		
		-- R1 contém 2.
		-- R7 contém 3.
		-- A saída da ULA é R1 + R7 = 5, e será armazenada em R7.
		wait for 100 ns;
		
		wr_en <= '0';
		
		-- R1 contém 2.
		-- R7 contém 5.
		-- A saída da ULA é R1 + R7 = 7, mas não será armazenada em R7.
		wait for 100 ns;
		wait;
	end process;
	
end architecture;