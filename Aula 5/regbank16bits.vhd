library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regbank16bits is
	port (
		read_reg1, read_reg2, write_reg: in unsigned(2 downto 0);
		write_data: in unsigned(15 downto 0);
		write_en, clk, rst: in std_logic;
		read_data1, read_data2: out unsigned(15 downto 0)
	);
end entity;

architecture a_regbank16bits of regbank16bits is
	component reg16bits is
		port (
			data_in  : in  unsigned(15 downto 0);
			data_out : out unsigned(15 downto 0);
			clk      : in  std_logic;
			wr_en    : in  std_logic;
			rst      : in  std_logic
		);
	end component;
	
	component mux8x3 is
		port (
			sel: in unsigned(2 downto 0);
			x0, x1, x2, x3, x4, x5, x6, x7: in unsigned(15 downto 0);
			y: out unsigned(15 downto 0)
		);
	end component;
	
	component demux3x8 is
		port (
			x: in std_logic;
			bin: in unsigned(2 downto 0);
			y0, y1, y2, y3, y4, y5, y6, y7: out std_logic
		);
	end component;
	
	signal zero: unsigned(15 downto 0);
	signal data0, data1, data2, data3, data4, data5, data6, data7: unsigned(15 downto 0);
	signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;
	
begin
	reg0: reg16bits port map (
		data_in => zero,
		data_out => data0,
		clk => clk,
		wr_en => wr_en0,
		rst => rst
	);
	reg1: reg16bits port map (
		data_in => write_data,
		data_out => data1,
		clk => clk,
		wr_en => wr_en1,
		rst => rst
	);
	reg2: reg16bits port map (
		data_in => write_data,
		data_out => data2,
		clk => clk,
		wr_en => wr_en2,
		rst => rst
	);
	reg3: reg16bits port map (
		data_in => write_data,
		data_out => data3,
		clk => clk,
		wr_en => wr_en3,
		rst => rst
	);
	reg4: reg16bits port map (
		data_in => write_data,
		data_out => data4,
		clk => clk,
		wr_en => wr_en4,
		rst => rst
	);
	reg5: reg16bits port map (
		data_in => write_data,
		data_out => data5,
		clk => clk,
		wr_en => wr_en5,
		rst => rst
	);
	reg6: reg16bits port map (
		data_in => write_data,
		data_out => data6,
		clk => clk,
		wr_en => wr_en6,
		rst => rst
	);
	reg7: reg16bits port map (
		data_in => write_data,
		data_out => data7,
		clk => clk,
		wr_en => wr_en7,
		rst => rst
	);
	
	demuxwrite: demux3x8 port map (
		x => write_en,
		bin => write_reg,
		y0 => wr_en0,
		y1 => wr_en1,
		y2 => wr_en2,
		y3 => wr_en3,
		y4 => wr_en4,
		y5 => wr_en5,
		y6 => wr_en6,
		y7 => wr_en7
	);
	
	muxread1: mux8x3 port map (
		sel => read_reg1,
		x0 => data0,
		x1 => data1,
		x2 => data2,
		x3 => data3,
		x4 => data4,
		x5 => data5,
		x6 => data6,
		x7 => data7,
		y => read_data1
	);
	muxread2: mux8x3 port map (
		sel => read_reg2,
		x0 => data0,
		x1 => data1,
		x2 => data2,
		x3 => data3,
		x4 => data4,
		x5 => data5,
		x6 => data6,
		x7 => data7,
		y => read_data2
	);
	
	zero <= "0000000000000000";
end architecture;