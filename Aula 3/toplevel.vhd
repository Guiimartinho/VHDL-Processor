library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
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
end entity;

architecture a_toplevel of toplevel is
	component alu16bits is
		port (
			x, y: in unsigned(15 downto 0);
			operation: in unsigned(3 downto 0);
			saida: out unsigned(15 downto 0);
			zeroFlag, overflowFlag: out std_logic
		);
	end component;
	
	component regbank16bits is
		port (
			read_reg1, read_reg2, write_reg: in unsigned(2 downto 0);
			write_data: in unsigned(15 downto 0);
			write_en, clk, rst: in std_logic;
			read_data1, read_data2: out unsigned(15 downto 0)
		);
	end component;
	
	component mux2x1 is
		port (
			sel: in std_logic;
			x0, x1: in unsigned(15 downto 0);
			y: out unsigned(15 downto 0)
		);
	end component;
	
	signal aludata   : unsigned(15 downto 0);
	signal bankdata1 : unsigned(15 downto 0);
	signal bankdata2 : unsigned(15 downto 0);
	signal muxdata   : unsigned(15 downto 0);

begin
	alu: alu16bits port map (
		x         => bankdata1,
		y         => muxdata,
		operation => aluop,
		saida     => aludata
	);
	
	regbank: regbank16bits port map (
		read_reg1  => r_reg1,
		read_reg2  => r_reg2,
		write_reg  => w_reg,
		write_data => aludata,
		write_en   => wr_en,
		clk        => clk,
		rst        => rst,
		read_data1 => bankdata1,
		read_data2 => bankdata2
	);
	
	mux: mux2x1 port map (
		sel => aluSrc,
		x0  => bankdata2,
		x1  => immediate,
		y   => muxdata
	);
	
	saidaALU <= aludata;
end architecture;
