library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
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

architecture a_processador of processador is
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
	
	component sign_extend_imm is
		port (
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(15 downto 0)
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
			branch_en     : out std_logic;
			alu_op      : out unsigned(1 downto 0);
			alu_src_b   : out std_logic;
			reg_write_source: out unsigned(1 downto 0);
			reg_write   : out std_logic;
			pc_write    : out std_logic;
			flags_write : out std_logic;
			mem_read    : out std_logic
		);
	end component;
    
    component somador8bitsPC is -- Somador 8 bits pra branch no PC
        port (
            pc_in: in unsigned(7 downto 0);
            add_address: in unsigned(7 downto 0);
            pc_result: out unsigned(7 downto 0)
        );
    end component;
	
	-- Sinais do PC
	signal pc_value: unsigned(7 downto 0);
	signal pc_plus_1: unsigned(7 downto 0);
	signal pc_next: unsigned(7 downto 0);
	signal pc_write_s: std_logic;
	signal branch_en_s: std_logic;
	
	-- Sinais da memória de instruções
	signal mem_read_s: std_logic;
	signal instruction_s: unsigned(13 downto 0);
	signal branch_addr: unsigned(7 downto 0);
	signal immediate7bits: unsigned(6 downto 0);
	signal immediate: unsigned(15 downto 0);
	
	-- Sinais de estado
	signal state_s: unsigned(1 downto 0);
	
	-- Sinais da ULA
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
	
	-- Sinais das flags
	signal flags_in_s: unsigned(7 downto 0);
	signal flags_out_s: unsigned(7 downto 0);
	signal flags_wr_en: std_logic;
	signal Nflag_in: std_logic;
	signal Vflag_in: std_logic;
	signal Zflag_in: std_logic;
	signal Nflag_out: std_logic;
	signal Vflag_out: std_logic;
	signal Zflag_out: std_logic;
    
    -- Sinais do somador de 8 bits pra branch no PC
    signal pc_result_s: unsigned(7 downto 0);
	
begin
	pc_reg: reg8bits port map (
		data_in  => pc_next,
		data_out => pc_value,
		clk      => clk,
		wr_en    => pc_write_s,
		rst      => rst
	);
    
	-- Comentado pra evitar treta
    -- pc_address_add: somador8bitsPC port map ( 
        -- pc_in => pc_value, -- São esses os signals?
        -- add_address => , -- Não tenho ctz, tem um branch_addr mas isso já eh o endereço final pelo q parece
        -- pc_result => pc_result_s -- Isso aqui DEVERIA ir pro PC se a condição PC recebe endereço somado
    -- );
    
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
		saida     => alu_output,
		zeroFlag  => Zflag_in,
		overflowFlag => Vflag_in,
		negativeFlag => Nflag_in
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
	
	sign_ex: sign_extend_imm port map (
		data_in  => immediate7bits,
		data_out => immediate
	);
	
	reg_flags: reg8bits port map (
		data_in  => flags_in_s,
		data_out => flags_out_s,
		clk      => clk,
		wr_en    => flags_wr_en,
		rst      => rst
	);
	
	fsm: maq_estados port map (
		estado => state_s,
		clk    => clk,
		rst    => rst
	);
	
	un_controle: controlunit port map (
		state       => state_s,
		instruction => instruction_s,
		branch_en     => branch_en_s,
		pc_write    => pc_write_s,
		alu_op      => alu_op_s,
		alu_src_b   => alu_src_b_s,
		reg_write_source => reg_write_source_s,
		reg_write   => reg_write_s,
		flags_write => flags_wr_en,
		mem_read    => mem_read_s
	);
	
	read_reg1_s <= instruction_s(2 downto 0); -- Rd
	read_reg2_s <= instruction_s(5 downto 3); -- Rs
	
	branch_addr <= instruction_s(7 downto 0);
	pc_next <= pc_plus_1 when branch_en_s = '0' else branch_addr;
	
	immediate7bits <= instruction_s(9 downto 3);
	
	alu_input2 <= read_data2_s when alu_src_b_s = '0' else immediate; -- TODO: Troca esse zero por imediato com sign extend.
	
	write_data_s <= alu_output when reg_write_source_s = "00" else
					read_data2_s when reg_write_source_s = "01" else
					immediate when reg_write_source_s = "10" else -- TODO: Troca esse zero por imediato com sign extend.
					"0000000000000000"; -- Aqui é pra ser o caso de memória de dados, mas não é pra fazer nesse lab.
	
	flags_in_s(7 downto 3) <= "00000";
	flags_in_s(2) <= Vflag_in;
	flags_in_s(1) <= Nflag_in;
	flags_in_s(0) <= Zflag_in;
	
	Vflag_out <= flags_out_s(2);
	Nflag_out <= flags_out_s(1);
	Zflag_out <= flags_out_s(0);
	
	--Pinos do top-level
	pc <= pc_value;
	inst <= instruction_s;
	est <= state_s;
	read_data1_o <= read_data1_s;
	read_data2_o <= read_data2_s;
	alu_out <= alu_output;
end architecture;