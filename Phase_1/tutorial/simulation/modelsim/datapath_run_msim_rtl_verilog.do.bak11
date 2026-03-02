transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/RCA.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/edgeRegister.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/BiDirectionalBus.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/DataPath.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/XorGate.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/OrGate.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/AndGate.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/NotGate.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Sub32.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Mul32.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/RCA32_Cout.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Neg32.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Abs32.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Add33.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Neg33.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Div32_Signed_NonRestoring.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/SHR.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/SHRA.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/SHL.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/ROR.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/ROL.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/ALU.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/tutorial {C:/intelFPGA_lite/18.1/elec374/tutorial/Phase1_DataPath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Phase1_DataPath_tb

add wave *
view structure
view signals
run 2500 ns
