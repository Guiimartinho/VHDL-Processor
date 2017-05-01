@echo off

mkdir gtkwave

echo Building alu16bits + testbench
ghdl -a alu16bits.vhd
ghdl -e alu16bits
ghdl -a alu16bits_tb.vhd
ghdl -e alu16bits_tb
ghdl -r alu16bits_tb --wave=gtkwave\alu16bits_tb.ghw

echo Building demux3x8 + testbench
ghdl -a demux3x8.vhd
ghdl -e demux3x8
ghdl -a demux3x8_tb.vhd
ghdl -e demux3x8_tb
ghdl -r demux3x8_tb --wave=gtkwave\demux3x8_tb.ghw

echo Building mux2x1 + testbench
ghdl -a mux2x1.vhd
ghdl -e mux2x1
ghdl -a mux2x1_tb.vhd
ghdl -e mux2x1_tb
ghdl -r mux2x1_tb --wave=gtkwave\mux2x1_tb.ghw

echo Building mux8x3 + testbench
ghdl -a mux8x3.vhd
ghdl -e mux8x3
ghdl -a mux8x3_tb.vhd
ghdl -e mux8x3_tb
ghdl -r mux8x3_tb --wave=gtkwave\mux8x3_tb.ghw

echo Building reg16bits + testbench
ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a reg16bits_tb.vhd
ghdl -e reg16bits_tb
ghdl -r reg16bits_tb --wave=gtkwave\reg16bits_tb.ghw --stop-time=500ns

echo Building regbank16bits + testbench
ghdl -a regbank16bits.vhd
ghdl -e regbank16bits
ghdl -a regbank16bits_tb.vhd
ghdl -e regbank16bits_tb
ghdl -r regbank16bits_tb --wave=gtkwave\regbank16bits_tb.ghw --stop-time=3500ns

echo Building toplevel + testbench
ghdl -a toplevel.vhd
ghdl -e toplevel
ghdl -a toplevel_tb.vhd
ghdl -e toplevel_tb
ghdl -r toplevel_tb --wave=gtkwave\toplevel.ghw --stop-time=700ns

pause