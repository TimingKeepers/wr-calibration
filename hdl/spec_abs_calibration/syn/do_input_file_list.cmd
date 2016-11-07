rem do_input_file_list.cmd  PeterJ,    10-Apr-2014
rem Prepares a .prj file for input to XST
@prompt $$$s

set lst_LM32_Sources=%1%
set lst_WRPC_Sources=%2%
set Arch1Path=%3%
set PrjFile=%4%.prj
rem Output to XISEFile can be used to copy/paste into the ".xise" file of a Xilinx ISE project in order to
rem run the Xilinx GUI .
set XISEFile=%4%.ise

rem LM32
@echo verilog work "%lst_LM32_Sources%\src\lm32_include.v" > %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_include.v" xil_pn:type="FILE_VERILOG"^> > %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\generated\lm32_allprofiles.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\generated\lm32_allprofiles.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_mc_arithmetic.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_mc_arithmetic.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\jtag_cores.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\jtag_cores.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_adder.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_adder.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_addsub.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_addsub.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_dp_ram.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_dp_ram.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_logic_op.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_logic_op.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_ram.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_ram.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\src\lm32_shifter.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\src\lm32_shifter.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\platform\spartan6\lm32_multiplier.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\platform\spartan6\lm32_multiplier.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
rem @echo verilog work "%lst_LM32_Sources%\platform\kintex7\jtag_tap.v" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_LM32_Sources%\platform\kintex7\jtag_tap.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\platform\spartan6\jtag_tap.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\platform\spartan6\jtag_tap.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem General and Generic files WRPC Related
@echo vhdl work "%lst_LM32_Sources%\..\..\genrams\genram_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\..\..\genrams\genram_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_LM32_Sources%\..\wishbone_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\..\wishbone_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_LM32_Sources%\generated\xwb_lm32.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\generated\xwb_lm32.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_fifo_sync.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_fifo_sync.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_eic.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_eic.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_dpssram.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wbgen2\wbgen2_dpssram.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_registers_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_registers_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_tbi_phy\disparity_gen_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_tbi_phy\disparity_gen_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_sync_ffs.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_sync_ffs.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gencores_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gencores_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_pulse_synchronizer.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_pulse_synchronizer.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_pulse_synchronizer2.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_pulse_synchronizer2.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_extend_pulse.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_extend_pulse.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_crc_gen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_crc_gen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_sync_register.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_sync_register.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_frequency_meter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\common\gc_frequency_meter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\gc_shiftreg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\gc_shiftreg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic_shiftreg_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic_shiftreg_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic\generic_sync_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic\generic_sync_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic\generic_async_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\generic\generic_async_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\inferred_sync_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\inferred_sync_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\inferred_async_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\inferred_async_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem WB_Crossbar (xwb_sdb_crossbar)
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\sdb_rom.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\sdb_rom.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\xwb_crossbar.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\xwb_crossbar.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\xwb_sdb_crossbar.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_crossbar\xwb_sdb_crossbar.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem DPRAM (xwb_dpram)
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\memory_loader_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\memory_loader_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram_dualclock.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram_dualclock.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram_sameclock.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram_sameclock.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_dpram.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_spram.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_spram.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_simple_dpram.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\generic_simple_dpram.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_slave_adapter\wb_slave_adapter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_slave_adapter\wb_slave_adapter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_dpram\xwb_dpram.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_dpram\xwb_dpram.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem General PHY files
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_bitslide.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_bitslide.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_phase_align.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_phase_align.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Kintex-7 PHY
rem @echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbit_gtxe2_channel_wrapper_gt.vhd" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbit_gtxe2_channel_wrapper_gt.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
rem @echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtx_phy_kintex7.vhd" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtx_phy_kintex7.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%

rem Spartan-6 PHY
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbitgtp_wrapper_tile.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbitgtp_wrapper_tile.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtp_phy_spartan6.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtp_phy_spartan6.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Fabric
@echo vhdl work "%lst_WRPC_Sources%\modules\fabric\wr_fabric_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\fabric\wr_fabric_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\fabric\xwrf_mux.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\fabric\xwrf_mux.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem EndPoint
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\endpoint_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\endpoint_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\endpoint_private_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\endpoint_private_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_crc32_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_crc32_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_path.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_path.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_header_processor.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_header_processor.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_inject_ctrl.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_inject_ctrl.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_vlan_unit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_vlan_unit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_packet_injection.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_packet_injection.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_crc_inserter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_crc_inserter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_1000basex_pcs.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_1000basex_pcs.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_pcs_16bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_pcs_16bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_pcs_16bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_pcs_16bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_sync_detect_16bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_sync_detect_16bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_pcs_8bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_tx_pcs_8bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_pcs_8bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_pcs_8bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_sync_detect.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_sync_detect.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_pcs_tbi_mdio_wb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_pcs_tbi_mdio_wb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_autonegotiation.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_autonegotiation.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_path.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_path.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_early_address_match.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_early_address_match.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_packet_filter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_packet_filter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_clock_alignment_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_clock_alignment_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_oob_insert.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_oob_insert.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_crc_size_check.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_crc_size_check.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
rem @echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_bypass_queue.vhd" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_bypass_queue.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_vlan_unit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_vlan_unit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rtu_header_extract.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rtu_header_extract.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_buffer.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_buffer.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_status_reg_insert.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_status_reg_insert.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_wb_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_rx_wb_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_timestamping_unit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_timestamping_unit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_ts_counter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_ts_counter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_wishbone_controller.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_wishbone_controller.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\ep_leds_controller.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\ep_leds_controller.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\wr_endpoint.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\wr_endpoint.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_endpoint\xwr_endpoint.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_endpoint\xwr_endpoint.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Mini-NIC
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_mini_nic\minic_wbgen2_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_mini_nic\minic_wbgen2_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_mini_nic\xwr_mini_nic.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_mini_nic\xwr_mini_nic.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_mini_nic\wr_mini_nic.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_mini_nic\wr_mini_nic.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_mini_nic\minic_wb_slave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_mini_nic\minic_wb_slave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem 1-wire
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\sockit_owm.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\sockit_owm.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\wb_onewire_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\wb_onewire_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\xwb_onewire_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_onewire_master\xwb_onewire_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem UART (xwb_simple_uart)
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\simple_uart_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\simple_uart_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\simple_uart_wb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\simple_uart_wb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_async_rx.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_async_rx.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_async_tx.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_async_tx.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_baud_gen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\uart_baud_gen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\wb_simple_uart.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\wb_simple_uart.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\xwb_simple_uart.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_uart\xwb_simple_uart.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem SysCon
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wrc_syscon_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wrc_syscon_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\xwr_syscon_wb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\xwr_syscon_wb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Timing and Soft PLL
@echo vhdl work "%lst_WRPC_Sources%\modules\timing\dmtd_with_deglitcher.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\timing\dmtd_with_deglitcher.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\timing\dmtd_phase_meas.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\timing\dmtd_phase_meas.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\softpll_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\softpll_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_wbgen2_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_wbgen2_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_wb_slave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_wb_slave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_bangbang_pd.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_bangbang_pd.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_period_detect.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_period_detect.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_aligner.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\spll_aligner.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\wr_softpll_ng.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\wr_softpll_ng.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_softpll_ng\xwr_softpll_ng.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_softpll_ng\xwr_softpll_ng.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem 1-PPS gen
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_pps_gen\pps_gen_wb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_pps_gen\pps_gen_wb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_pps_gen\wr_pps_gen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_pps_gen\wr_pps_gen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_pps_gen\xwr_pps_gen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_pps_gen\xwr_pps_gen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem GPIO (xwb_gpio_port)
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_gpio_port\wb_gpio_port.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_gpio_port\wb_gpio_port.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_gpio_port\xwb_gpio_port.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_gpio_port\xwb_gpio_port.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Soft PLL DACs
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_dacs\spec_serial_dac.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_dacs\spec_serial_dac.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wr_dacs\spec_serial_dac_arb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wr_dacs\spec_serial_dac_arb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem WR Core
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wrcore_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wrcore_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wrc_periph.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wrc_periph.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wrc_syscon_wb.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wrc_syscon_wb.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wr_core.vhd" >> %PrjFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wr_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\xwr_core.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\xwr_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem  SPI
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_clgen.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_clgen.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_defines.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_defines.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_shift.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_shift.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_top.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\spi_top.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\timescale.v" >> %PrjFile% 
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\timescale.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\wb_spi.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\wb_spi.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\xwb_spi.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_spi\xwb_spi.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem  I2C
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_bit_ctrl.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_bit_ctrl.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_byte_ctrl.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_byte_ctrl.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_top.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\i2c_master_top.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\wb_i2c_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\wb_i2c_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\xwb_i2c_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_i2c_master\xwb_i2c_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem  Timer
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_simple_timer\wb_tics.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_simple_timer\wb_tics.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_simple_timer\xwb_tics.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\general-cores\modules\wishbone\wb_simple_timer\xwb_tics.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Genum 4124
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\dma_controller_wb_slave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\dma_controller_wb_slave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\dma_controller.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\dma_controller.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\l2p_arbiter.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\l2p_arbiter.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\l2p_dma_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\l2p_dma_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\p2l_decode32.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\p2l_decode32.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\p2l_dma_master.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\p2l_dma_master.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\wbmaster32.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\wbmaster32.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
rem @echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\spec\ip_cores\l2p_fifo.ngc" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\spec\ip_cores\l2p_fifo.ngc" xil_pn:type="FILE_NGC"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\gn4124_core_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\gn4124_core_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\gn4124_core.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\gn4124_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\l2p_ser.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\l2p_ser.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\p2l_des.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\p2l_des.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_1_to_n_clk_pll_s2_diff.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_1_to_n_clk_pll_s2_diff.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_1_to_n_data_s2_se.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_1_to_n_data_s2_se.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_n_to_1_s2_diff.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_n_to_1_s2_diff.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_n_to_1_s2_se.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\serdes_n_to_1_s2_se.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\pulse_sync_rtl.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\gn4124-core\hdl\gn4124core\rtl\spartan6\pulse_sync_rtl.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem Etherbone
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\etherbone_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\etherbone_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_hdr_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_hdr_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_internals_pkg.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_internals_pkg.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_checksum.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_checksum.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_cfg_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_cfg_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_commit_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_commit_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_eth_rx.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_eth_rx.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_eth_tx.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_eth_tx.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_ethernet_slave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_ethernet_slave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_pass_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_pass_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_raw_slave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_raw_slave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_fsm.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_fsm.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_top.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_top.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_stream_narrow.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_stream_narrow.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_stream_widen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_stream_widen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_tag_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_tag_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_tx_mux.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_tx_mux.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_wbm_fifo.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_wbm_fifo.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_core.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\ip_cores\etherbone-core\hdl\eb_slave_core\eb_slave_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem General SPEC related files
@echo vhdl work "%lst_WRPC_Sources%\top\spec_1_1\wr_core_demo\spec_reset_gen.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\top\spec_1_1\wr_core_demo\spec_reset_gen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\ext_pll_10_to_125m.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\ext_pll_10_to_125m.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem SPEC Top Level for FPGA
@echo vhdl work "..\..\top\spec_top.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\top\spec_top.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo     ^<file xil_pn:name="..\..\syn\spec_top.ucf" xil_pn:type="FILE_UCF"^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo     ^<property xil_pn:name="Other Ngdbuild Command Line Options" xil_pn:value="-bm spec_top.bmm -sd %Arch1Path%" xil_pn:valueState="non-default"/^> >> %XISEFile%
@echo     ^<property xil_pn:name="Other Bitgen Command Line Options" xil_pn:value="-g UnconstrainedPins:Allow" xil_pn:valueState="non-default"/^> >> %XISEFile%

