library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity everything is
	port (
		rst          : in std_logic;
		clk          : in std_logic;
		est          : out unsigned(1 downto 0);
		pc           : out unsigned(7 downto 0);
		inst         : out unsigned(13 downto 0);
		read_data1_o : out unsigned(15 downto 0);
		read_data2_o : out unsigned(15 downto 0);
		alu_out      : out unsigned(15 downto 0)
	);
end entity;

architecture a_everything of everything is
	component reg8bits is -- PC
		port (
			data_in  : in unsigned(7 downto 0);
			data_out : out unsigned(7 downto 0);
			clk      : in std_logic;
			wr_en    : in std_logic;
			rst      : in std_logic
		);
	end component;
	
	component add_1 is -- Somador do PC
		port (
			input  : in unsigned(7 downto 0);
			output : out unsigned(7 downto 0)
		);
	end component;
	
	component rom is -- Memoria de instrucoes
		port (
			clk      : in std_logic;
			enable   : in std_logic;
			endereco : in unsigned(7 downto 0);
			dado     : out unsigned(13 downto 0)
		);
	end component;
	
	component alu16bits is -- Unidade Lógica e Aritmética
		port (
			x, y: in unsigned(15 downto 0);
			operation: in unsigned(1 downto 0);
			saida: out unsigned(15 downto 0);
			zeroFlag, overflowFlag, negativeFlag: out std_logic
		);
	end component;
	
	component regbank16bits is -- Banco de registradores
		port (
			read_reg1, read_reg2, write_reg: in unsigned(2 downto 0);
			write_data: in unsigned(15 downto 0);
			write_en, clk, rst: in std_logic;
			read_data1, read_data2: out unsigned(15 downto 0)
		);
	end component;
	
	component maq_estados is -- Maquina de estados
		port( 
			clk,rst: in std_logic;
			estado: out unsigned(1 downto 0)
		);
	end component;
	
	component controlunit is -- Unidade de Controle
		port (
			state       : in unsigned(1 downto 0);
			instruction : in unsigned(13 downto 0);
			jump_en     : out std_logic;
			alu_op      : out unsigned(1 downto 0);
			alu_src_b   : out std_logic;
			reg_write_source: out unsigned(1 downto 0);
			reg_write   : out std_logic;
			pc_write    : out std_logic;
			mem_read    : out std_logic
		);
	end component;
	
	-- Sinais do PC
	signal pc_value: unsigned(7 downto 0);
	signal pc_plus_1: unsigned(7 downto 0);
	signal pc_next: unsigned(7 downto 0);
	signal pc_write_s: std_logic;
	signal jump_en_s: std_logic;
	
	-- Sinais da memória de instruções
	signal mem_read_s: std_logic;
	signal instruction_s: unsigned(13 downto 0);
	signal jump_addr: unsigned(7 downto 0);
	signal immediate: unsigned(15 downto 0);
	
	-- Sinais de estado
	signal state_s: unsigned(1 downto 0);
	
	-- Sinais da ULA
	signal alu_input1: unsigned(15 downto 0);
	signal alu_input2: unsigned(15 downto 0);
	signal alu_op_s: unsigned(1 downto 0);
	signal alu_output: unsigned(15 downto 0);
	signal alu_src_b_s: std_logic;
	
	-- Sinais do banco de registradores
	signal read_reg1_s: unsigned(2 downto 0);
	signal read_reg2_s: unsigned(2 downto 0);
	signal write_data_s: unsigned(15 downto 0);
	signal reg_write_s: std_logic;
	signal read_data1_s: unsigned(15 downto 0);
	signal read_data2_s: unsigned(15 downto 0);
	signal reg_write_source_s: unsigned(1 downto 0);
	
begin
	pc_reg: reg8bits port map (
		data_in  => pc_next,
		data_out => pc_value,
		clk      => clk,
		wr_en    => pc_write_s,
		rst      => rst
	);
	
	pc_inc: add_1 port map (
		input  => pc_value,
		output => pc_plus_1
	);
	
	inst_mem: rom port map (
		clk      => clk,
		enable   => mem_read_s,
		endereco => pc_value,
		dado     => instruction_s
	);
	
	alu: alu16bits port map (
		x         => read_data1_s, -- Eh sempre o Rd
		y         => alu_input2, -- Pode ser tanto Rs quanto constante imediata
		operation => alu_op_s,
		saida     => alu_output
		-- Por enquanto ignoramos as flags, pois não tem jump condicional
	);
	
	regbank: regbank16bits port map (
		read_reg1  => read_reg1_s, -- Eh sempre o Rd
		read_reg2  => read_reg2_s, -- Eh sempre o Rs
		write_reg  => read_reg1_s, -- Eh sempre o Rd
		write_data => write_data_s, -- Pode ser saída da ULA, Rs, constante imediata, ou saída da memória de dados
		write_en   => reg_write_s,
		clk        => clk,
		rst        => rst,
		read_data1 => read_data1_s, -- Eh o valor do Rd
		read_data2 => read_data2_s  -- Eh o valor do Rs
	);
	
	fsm: maq_estados port map (
		estado => state_s,
		clk    => clk,
		rst    => rst
	);
	
	un_controle: controlunit port map (
		state       => state_s,
		instruction => instruction_s,
		jump_en     => jump_en_s,
		pc_write    => pc_write_s,
		alu_op      => alu_op_s,
		alu_src_b   => alu_src_b_s,
		reg_write_source => reg_write_source_s,
		reg_write   => reg_write_s,
		mem_read    => mem_read_s
	);
	
	jump_addr <= instruction_s(7 downto 0);
	pc_next <= pc_plus_1 when jump_en_s = '0' else jump_addr;
	
	alu_input2 <= read_data2_s when alu_src_b_s = '0' else "0000000000000000"; -- TODO: Troca esse zero por imediato com sign extend.
	
	write_data_s <= alu_output when reg_write_source_s = "00" else
					read_data2_s when reg_write_source_s = "01" else
					"0000000000000000" when reg_write_source_s = "10" else -- TODO: Troca esse zero por imediato com sign extend.
					"0000000000000000"; -- Aqui é pra ser o caso de memória de dados, mas não é pra fazer nesse lab.
	
	--Pinos do top-level
	pc <= pc_value;
	inst <= instruction_s;
	est <= state_s;
	read_data1_o <= read_data1_s;
	read_data2_o <= read_data2_s;
	alu_out <= alu_output;
end architecture;