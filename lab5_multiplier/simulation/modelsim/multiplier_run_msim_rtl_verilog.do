transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/control.sv}
vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/shift_8.sv}
vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/nine_bit_adder.sv}
vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/multiplier.sv}

vlog -sv -work work +incdir+C:/Users/ctheld2/multiplier {C:/Users/ctheld2/multiplier/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
