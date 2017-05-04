library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity precontrolunit is
	port (
		clk      : in std_logic;
		rst      : in std_logic;
		mem_data : out unsigned(13 downto 0);
		pc_value : out unsigned(7 downto 0);
		t_state  : out std_logic -- Só para debug
	);
end entity;

architecture a_precontrolunit of precontrolunit is
	component program_counter is
		port (
			wr_en    : in std_logic;
			clk      : in std_logic;
			rst      : in std_logic;
			data_out : out unsigned(7 downto 0)
		);
	end component;
	
	component rom is
		port (
			clk      : in std_logic;
			enable   : in std_logic;
			endereco : in unsigned(7 downto 0);
			dado     : out unsigned(13 downto 0)
		);
	end component;
	
	component tff is
		port (
			estado: out std_logic;
			clk:    in std_logic;
			rst:    in std_logic
		);
	end component;
	
	signal address : unsigned(7 downto 0);
	signal pc_en   : std_logic;
	signal rom_en  : std_logic;
	signal state   : std_logic;

begin
	pc: program_counter port map (
		wr_en => pc_en,
		clk => clk,
		rst => rst,
		data_out => address
	);
	
	mem: rom port map (
		clk => clk,
		enable => rom_en,
		endereco => address,
		dado => mem_data
	);
	
	fsm: tff port map (
		estado => state,
		clk => clk,
		rst => rst
	);
	
	pc_value <= address;
	rom_en <= '1' when state = '0' else '0';
	pc_en <= '1' when state = '1' else '0';
	t_state <= state; -- Só para debug
end architecture;