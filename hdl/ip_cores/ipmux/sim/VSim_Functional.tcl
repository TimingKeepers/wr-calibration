set Simulation TRUE
 
source VSim_Current_Revision.tcl

#vsim -t ps -L unisim -voptargs="+acc" -novopt -GSimulation=$Simulation work.functional
vsim -t ps -L unisim -voptargs="+acc" -novopt -GSimulation=$Simulation work.system

if {$Simulation} {
      puts "Note: Simulation"
	} else {
      puts "Note: Synthesis)"
	}
   
do wave.tcl
do test_scripts/test.tcl
run 200 us

wave zoom full
