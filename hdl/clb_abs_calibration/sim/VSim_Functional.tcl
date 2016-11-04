set Simulation TRUE
set mach_o 0800
set macl_o 306c2775
set checkpointfile "sim_state_after_lm32_memset"

# Check if there are any arguments added to VSim_Functional.tcl
# no arguments:	Default simulate as normal
# "save" => simulate from scratch and save the simulator status as "sim_state_after_lm32_memset"
# "load" => start simulation from checkpoint "sim_state_after_lm32_memset"
set sim_task ""
if { $argc >= 1 } {
    if { [string tolower $1] == "save" } {
		set sim_task "save"
		puts "Simulator state will be saved after lm32 initialized wrpc..."
	} elseif { [string tolower $1] == "load" } {
        set sim_task "load"
        puts "Simulator state will be loaded..."
	} else {
        puts "### Unknown argument added to VSim_Functional.tcl. Use \"\", \"load\" or \"save\""
		return
	}
}

if {$Simulation} {
      puts "Note: Simulation"
	  set g_simulation 1
	} else {
      puts "Note: Synthesis"
	  set g_simulation 0
	}

if { $sim_task == "load"} {
	if {[file exists $checkpointfile]} {
		vsim -restore $checkpointfile
	} else {
		puts "No checkpoint file yet. First run \"VComFunctional.tcl save\" to create a chekpoint file"
		return
	}
} else {

	source VSim_Current_Revision.tcl

# puts "elf file used for lm32 in WRPC: [set elf_file_lm32_wrpc "..\\..\\..\\sw\\embedded\\WRPC_simu\\wrc.elf"]"
	puts "elf file used for lm32 in WRPC: [set elf_file_lm32_wrpc "..\\..\\..\\sw\\embedded\\wrpc-spec-sw-simu\\wrc.elf"]"
#	puts "elf file used for lm32 in WRPC: [set elf_file_lm32_wrpc "..\\..\\..\\sw\\embedded\\wrpc-sw\\wrc.elf"]"

	# !!! Note !!!: Don't forget to compile the software (elf file) for simulation (avoid printf etc. to speed up simulation time)
	# !!! Note !!!: The double \\ are there since the DOS command below needs backslashes and a single backslash is seen as a switch in tcl

	# Generate a "lm32_memory.mem" file from the "elf" file content
	# Note that ISE 12.4 data2mem produces wrong results; use an older version:
	#exec cmd.exe /c ..\\Software\\data2mem_ise10_1\\data2mem.exe -bd $elf_file_lm32_wrpc -d -o m xil_coregen_ahbrom.mem
	exec cmd.exe /c data2mem.exe -bd $elf_file_lm32_wrpc -d -o m lm32_wrpc_memory.mem
#	exec cmd.exe /c data2mem.exe -bd $elf_file_lm32_2nd -d -o m lm32_2nd_memory.mem

	# Convert the "mem" to a "mif"
	#do mem2mif.tcl lm32_memory
	# Convert the "mem" to a "ldr" (a format used by the White Rabbit "memory_loader_pkg.vhd"
	do mem2ldr.tcl lm32_wrpc_memory

	if {$Simulation} {
		  puts "Note: Simulation"
		  set g_simulation 1
		} else {
		  puts "Note: Synthesis)"
		  set g_simulation 0
		}

	# Note that -novopt causes No Optimization (some internal signals might get non-vivible by optimization)
	# Note that "-L unisim" is needed to find the primitive "BSCANE2" thta is instantiated in "$LM32_Sources/platform/kintex7/jtag_tap.v "
	#suppress warning Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value <> is not in bounds of NATURAL.
	#suppress warning Warning: (vsim-8684) No drivers exist on out port <blabla>
	vsim -voptargs="+acc" -novopt \
		+nowarn151 \
		+nowarn8684 \
		-G/clb_top_tb/g_simulation=$g_simulation \
		-G/clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/g_must_have_init_file=true \
		-G/clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/g_init_file=lm32_wrpc_memory.ldr \
		-t ps -L unisim -lib work work.clb_top_tb

#    -G/clb_top_tb/u2/tx_data_swap=false \


    do wave.tcl

	view signals

	# Force endpoint wishbone registers (entity ep_wishbone_controller regs_o)
	#	force MAC address
  force -freeze /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.mach_o 16#$mach_o
	force -freeze /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.macl_o 16#$macl_o

#  force -freeze /clb_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_pclass 16#0

	#	Packet Filter Enable
#	force -freeze /clb_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.pfcr0_enable_o 1
	#	Packet Transmit Path Enable
#  force -freeze /clb_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.ecr_tx_en_o 1
	#	Packet Receive Path Enable
#  force -freeze /clb_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.ecr_rx_en_o 1
	#	Packet Receive Path, avoid "is_giant" error because mru is still default 0. Set it to 9000 bytes
  #  force -freeze /clb_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb.rfcr_mru_o "10001100101000"

	force -freeze /clb_top_tb/clk_20m_vcxo_p_i 1, 0 25 ns -rep 50 ns
	#force -freeze /clb_top_tb/clk_20m_vcxo_n_i 0, 1 25 ns -rep 50 ns

	force -freeze /clb_top_tb/button1_i 1, 0 4 us
	force -freeze /clb_top_tb/Rx_Fire 0
	force -freeze /clb_top_tb/Fire 0
	force -freeze /clb_top_tb/udp_tstgen_cont 0

	# "Fire" Starts transmission of UDP packets to Linux Server.
	#force -freeze /clb_top_tb/button2_i 1
  #	force -freeze /clb_top_tb/udp_tstgen_cont '0'
  # "Readout" Enables readout (and flush) from Linux Server UDP packets (maybe used to fill the buffer and check pause frame generation)
  #	force -freeze /clb_top_tb/U_WR_CORE/Readout 1
	
  #run 500 us so wrpc lm32 has initialized the endpoint registers
	run 700 us

	# The first packet is dropped in "ep_packet_filter.vhd" because "rst_n_rx_i" was never asserted.
	# This signal is synchrionized to "phy_rx_clk_i" in "wr_endpoind.vhd". Its source is the wr_endpoind "rst_n_i" signal.
	# Signal wr_endpoind "rst_n_i" is connected to "rst_net_n" that originates from "wrc_periph" where it can be toggeled via software:
	# "rst_net_n_o <= not sysc_regs_o.gpsr_net_rst_o;"
	# run 10 us
	# force -freeze /clb_top_tb/U_WR_CORE/u0/U_WR_CORE/WRPC/rst_net_n 0, 1 1 us
	# run 10 us
	# noforce /clb_top_tb/U_WR_CORE/u0/U_WR_CORE/WRPC/rst_net_n

	# THIS FORCE RX_CDR_LOCK 1 SHOULD NOT BE NESECAIRRY! IS THERE STILL SOMETHING NOT OKAY?
	#force -freeze /clb_top_tb/u0/U_GTP/rx_cdr_lock 1

  # Disable any write transfer from the State Machine:
  #force -freeze /clb_top_tb/U_WR_CORE/u16/gen_tdc/wrap_stmach/U_Wrapped_stmach/Wrapped_stmach/U_stmach/wrreqi "00"

  run 18 us

#  stop

}

if { $sim_task == "save"} {
	checkpoint $checkpointfile
}

set testrx false
if { $testrx == true} {
	# Test Receive UDP packets from server PC

	force -freeze /clb_top_tb/Rx_Fire 1,0 128 ns
	
	run 800 ns

    # Test Pause frame generation after WaterMarkHigh
#    force -freeze /clb_top_tb/U_WR_CORE/U_WR_CORE/u6/u2/WaterMarkHigh 1
	run 80 us
#    noforce /clb_top_tb/U_WR_CORE/U_WR_CORE/u6/u2/WaterMarkHigh

	
} else {
	# Test Transmit UDP packets to server PC

#	force -freeze /clb_top_tb/button2_i 0,1 128 ns
	force -freeze /clb_top_tb/udp_tstgen_cont 1
  run 20 us
}
run 1 us

run 12 us

wave zoom full

#
# End
#
