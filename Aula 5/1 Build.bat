@echo off

mkdir gtkwave

echo Building add_1
ghdl -a add_1.vhd
ghdl -e add_1

echo Building reg8bits + testbench
ghdl -a reg8bits.vhd
ghdl -e reg8bits
ghdl -a reg8bits_tb.vhd
ghdl -e reg8bits_tb
ghdl -r reg8bits_tb --wave=gtkwave\reg16bits_tb.ghw --stop-time=500ns

echo Building rom + testbench
ghdl -a rom.vhd
ghdl -e rom
ghdl -a rom_tb.vhd
ghdl -e rom_tb
ghdl -r rom_tb --wave=gtkwave\rom_tb.ghw --stop-time=1500ns

echo Building tff + testbench
ghdl -a tff.vhd
ghdl -e tff
ghdl -a tff_tb.vhd
ghdl -e tff_tb
ghdl -r tff_tb --wave=gtkwave\tff_tb.ghw --stop-time=700ns

echo Building program_counter + testbench
ghdl -a program_counter.vhd
ghdl -e program_counter
ghdl -a program_counter_tb.vhd
ghdl -e program_counter_tb
ghdl -r program_counter_tb --wave=gtkwave\program_counter_tb.ghw --stop-time=2000ns

echo Building rompc + testbench
ghdl -a rompc.vhd
ghdl -e rompc
ghdl -a rompc_tb.vhd
ghdl -e rompc_tb
ghdl -r rompc_tb --wave=gtkwave\rompc_tb.ghw --stop-time=2000ns

echo Building precontrolunit + testbench
ghdl -a precontrolunit.vhd
ghdl -e precontrolunit
ghdl -a precontrolunit_tb.vhd
ghdl -e precontrolunit_tb
ghdl -r precontrolunit_tb --wave=gtkwave\precontrolunit_tb.ghw --stop-time=4000ns

echo Building controlunit
ghdl -a controlunit.vhd
ghdl -e controlunit

echo Building everything + testbench
ghdl -a everything.vhd
ghdl -e everything
ghdl -a everything_tb.vhd
ghdl -e everything_tb
ghdl -r everything_tb --wave=gtkwave\everything_tb.ghw --stop-time=4000ns

pause