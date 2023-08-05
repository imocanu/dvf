top_tb_name = top
work = work

INF = 	\
		../../src/common/dvf_clk_rst_if.sv
TST = axi_test.sv
TB  = axi_tb_top.sv

DVF_LIB = ../../src/dvf_lib/dvf_lib_pkg.sv


RTL= \
	axi_ram.sv

run_compile:
	xvlog -work $(work) -i . -sv  $(DVF_LIB) $(INF) $(RTL) $(TB) -L uvm
	xelab work.$(top_tb_name) -s $(top_tb_name)_sim -L uvm -timescale 1ns/1ps -debug all

run_sim:
	xsim -runall -log session.log $(top_tb_name)_sim 

run_sim_wave:
	xsim -wdb sim.wdb -log session.log -t run_all.tcl $(top_tb_name)_sim 
	xsim sim.wdb -gui

clean:
	rm -rf modelsim.* transcript* vlog.* work 
	rm -rf vsim.wlf *.log *hbs *Xil xsim.dir .Xil
	rm -rf *.jou *.pb
	rm -rf *.wdb
	rm -rf *.vcd
	rm -rf *.covdb
	clear

run_all:
	make clean
	make run_compile
	make run_sim

run_gui:
	make clean
	make run_compile
	make run_sim
	make run_sim_wave
