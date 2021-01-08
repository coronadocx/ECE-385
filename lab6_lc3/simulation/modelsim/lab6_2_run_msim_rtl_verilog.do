transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/tristate.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/register.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/reg_file.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/bus.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/alu.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/addr_alu.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/ben.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/pc.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/mdr.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/datapath.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/slc3.sv}
vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6/provided {C:/Users/chris/Documents/School/ECE385/Lab6/provided/lab6_toplevel.sv}

vlog -sv -work work +incdir+C:/Users/chris/Documents/School/ECE385/Lab6 {C:/Users/chris/Documents/School/ECE385/Lab6/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 5000 ns
