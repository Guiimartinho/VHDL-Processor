library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity everything is
	port (
		clk : in std_logic;
		rst : in std_logic;
		
		-- Debug
		pc   : out unsigned(7 downto 0);
		inst : out unsigned(13 downto 0);
		est  : out unsigned(1 downto 0)
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
			pc_write    : out std_logic;
			mem_read    : out std_logic
		);
	end component;
	
	signal pc_value: unsigned(7 downto 0);
	signal pc_plus_1: unsigned(7 downto 0);
	signal pc_next: unsigned(7 downto 0);
	signal pc_write_s: std_logic;
	
	signal mem_read_s: std_logic;
	signal instruction_s: unsigned(13 downto 0);
	
	signal state_s: unsigned(1 downto 0);
	
	signal jump_en_s: std_logic;
	signal jump_addr: unsigned(7 downto 0);

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
		mem_read    => mem_read_s
	);
	
	jump_addr <= instruction_s(7 downto 0);
	pc_next <= pc_plus_1 when jump_en_s = '0' else jump_addr;
	
	-- Debug
	pc <= pc_value;
	inst <= instruction_s;
	est <= state_s;
end architecture;