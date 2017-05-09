@echo off

mkdir gtkwave

echo Building add_1 + testbench
ghdl -a add_1.vhd
ghdl -e add_1
ghdl -a add_1_tb.vhd
ghdl -e add_1_tb
ghdl -r add_1_tb --wave=gtkwave\add_1_tb.ghw

echo Building alu16bits + testbench
ghdl -a alu16bits.vhd
ghdl -e alu16bits
ghdl -a alu16bits_tb.vhd
ghdl -e alu16bits_tb
ghdl -r alu16bits_tb --wave=gtkwave\alu16bits_tb.ghw

echo Building controlunit
ghdl -a controlunit.vhd
ghdl -e controlunit
ghdl -a controlunit_tb.vhd
ghdl -e controlunit_tb
ghdl -r controlunit_tb --wave=gtkwave\controlunit_tb.ghw

echo Building demux3x8 + testbench
ghdl -a demux3x8.vhd
ghdl -e demux3x8
ghdl -a demux3x8_tb.vhd
ghdl -e demux3x8_tb
ghdl -r demux3x8_tb --wave=gtkwave\demux3x8_tb.ghw

echo Building maq_estados + testbench
ghdl -a maq_estados.vhd
ghdl -e maq_estados
ghdl -a maq_estados_tb.vhd
ghdl -e maq_estados_tb
ghdl -r maq_estados_tb --wave=gtkwave\maq_estados_tb.ghw --stop-time=1000ns

echo Building mux8x3 + testbench
ghdl -a mux8x3.vhd
ghdl -e mux8x3
ghdl -a mux8x3_tb.vhd
ghdl -e mux8x3_tb
ghdl -r mux8x3_tb --wave=gtkwave\mux8x3_tb.ghw

echo Building reg8bits + testbench
ghdl -a reg8bits.vhd
ghdl -e reg8bits
ghdl -a reg8bits_tb.vhd
ghdl -e reg8bits_tb
ghdl -r reg8bits_tb --wave=gtkwave\reg8bits_tb.ghw --stop-time=500ns

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

echo Building rom + testbench
ghdl -a rom.vhd
ghdl -e rom
ghdl -a rom_tb.vhd
ghdl -e rom_tb
ghdl -r rom_tb --wave=gtkwave\rom_tb.ghw --stop-time=1500ns

echo Building sign_extend_imm + testbench
ghdl -a sign_extend_imm.vhd
ghdl -e sign_extend_imm
ghdl -a sign_extend_imm_tb.vhd
ghdl -e sign_extend_imm_tb
ghdl -r sign_extend_imm_tb --wave=gtkwave\sign_extend_imm.ghw

echo Building processador + testbench
ghdl -a processador.vhd
ghdl -e processador
ghdl -a processador_tb.vhd
ghdl -e processador_tb
ghdl -r processador_tb --wave=gtkwave\processador_tb.ghw --stop-time=6000ns

pause