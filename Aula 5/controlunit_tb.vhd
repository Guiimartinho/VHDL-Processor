library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlunit_tb is
end;

architecture a_controlunit_tb of controlunit_tb is
	component controlunit is
		port (
			state       : in unsigned(1 downto 0);
			instruction : in unsigned(13 downto 0);
			
			branch_en     : out std_logic;
			
			alu_op      : out unsigned(1 downto 0);
			alu_src_b   : out std_logic;
			
			reg_write_source: out unsigned(1 downto 0);
			reg_write   : out std_logic;
			
			pc_write    : out std_logic;
			mem_read    : out std_logic
		);
	end component;
	
	signal state       : unsigned(1 downto 0);
	signal instruction : unsigned(13 downto 0);
	       
	signal branch_en   : std_logic;
	       
	signal alu_op      : unsigned(1 downto 0);
	signal alu_src_b   : std_logic;
	       
	signal reg_write_source: unsigned(1 downto 0);
	signal reg_write   : std_logic;
	       
	signal pc_write    : std_logic;
	signal mem_read    : std_logic;

begin
	uut: controlunit port map (
		state       =>       state,
        instruction =>       instruction,
                             
        branch_en   =>       branch_en,
                             
        alu_op      =>       alu_op,  
        alu_src_b   =>       alu_src_b,
                             
        reg_write_source =>  reg_write_source,
        reg_write   =>       reg_write,
                             
        pc_write    =>       pc_write,
        mem_read    =>       mem_read
	);
	
	process
	begin
		state <= "00";
		instruction <= "00000000000000";
		wait for 100 ns;
		state <= "01";
		wait for 100 ns;
		state <= "10";
		wait for 100 ns;
		state <= "00";
		instruction <= "00000000101110"; -- ADD R5, R6
		wait for 100 ns;
		instruction <= "00010000101110"; -- ADD #0x05, R6
		wait for 100 ns;
		instruction <= "00100000101110"; -- SUB R5, R6
		wait for 100 ns;
		instruction <= "00110000101110"; -- SUB #0x05, R6
		wait for 100 ns;
		instruction <= "01000000101110"; -- MOV R5, R6
		wait for 100 ns;
		instruction <= "01010000101110"; -- MOV #0x05, R6
		wait for 100 ns;
		instruction <= "11010000000110"; -- BR label (instrucao numero 6)
		wait for 100 ns;
		wait;
	end process;
end architecture;
		
		
		