transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/intelFPGA_lite/18.1/elec374/tutorial/RCAdd.vhd}

vcom -93 -work work {C:/intelFPGA_lite/18.1/elec374/tutorial/RCAdd_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  RCAdd_tb

add wave *
view structure
view signals
run 500 ns
