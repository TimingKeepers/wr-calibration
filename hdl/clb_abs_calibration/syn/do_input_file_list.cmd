rem do_input_file_list.cmd  PeterJ,    10-Apr-2014
rem Prepares a .prj file for input to XST
@prompt $$$s

set lst_LM32_Sources=%1%
set lst_WRPC_Sources=%2%
set lst_Arch1Path=%3%
set PrjFile=%4%.prj
rem Output to XISEFile can be used to copy/paste into the ".xise" file of a Xilinx ISE project in order to
rem run the Xilinx GUI .
set XISEFile=%4%.ise
set lst_currentdate=%5%
set lst_currentrevision=%6%
set lst_lm32wrpc_dpramsize=%7%
rem set lst_lm32_2nd_dpramsize=%8%
rem set lst_clbv2_1=%9%

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
@echo verilog work "%lst_LM32_Sources%\platform\generic\lm32_multiplier.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\platform\generic\lm32_multiplier.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo verilog work "%lst_LM32_Sources%\platform\kintex7\jtag_tap.v" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_LM32_Sources%\platform\kintex7\jtag_tap.v" xil_pn:type="FILE_VERILOG"^> >> %XISEFile%
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

rem Kintex-7 PHY
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbit_gtxe2_channel_wrapper_gt.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\whiterabbit_gtxe2_channel_wrapper_gt.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_bitslide.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\gtp_bitslide.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtx_phy_kintex7.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\platform\xilinx\wr_gtp_phy\wr_gtx_phy_kintex7.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
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
rem wr_core and xwr_core are contained in clb_wrpc.vhd
rem @echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\wr_core.vhd" >> %PrjFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\wr_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
rem @echo vhdl work "%lst_WRPC_Sources%\modules\wrc_core\xwr_core.vhd" >> %PrjFile%
rem @echo     ^<file xil_pn:name="%lst_WRPC_Sources%\modules\wrc_core\xwr_core.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\ip_cores\clb_wrpc\top\clb_wrpc.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\ip_cores\clb_wrpc\top\clb_wrpc.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
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

rem General and Generic files CLB Related
@echo vhdl work "..\..\..\general_packages\v_array_package.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_packages\v_array_package.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_packages\EMAC16bit_package.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_packages\EMAC16bit_package.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\wb_dummys\wb_DummyMaster.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\wb_dummys\wb_DummyMaster.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\wb_dummys\wb_DummySlave.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\wb_dummys\wb_DummySlave.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\wb_dummys\wb_DummySource.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\wb_dummys\wb_DummySource.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\wb_dummys\wb_DummySink.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\wb_dummys\wb_DummySink.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
rem @echo vhdl work "..\..\..\general_modules\wrpc_stimuli\ClkRstGen.vhd" >> %PrjFile%
rem @echo     ^<file xil_pn:name="..\..\..\general_modules\wrpc_stimuli\ClkRstGen.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
rem @echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
rem @echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\stimuli\TransmitFrame16bit.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\stimuli\TransmitFrame16bit.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem IPMUX related
@echo vhdl work "..\..\..\ip_cores\ipmux\top\ipmux.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\ip_cores\ipmux\top\ipmux.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\ip_cores\ipmux\modules\reg1en.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\ip_cores\ipmux\modules\reg1en.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\ip_cores\ipmux\modules\clkdist.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\ip_cores\ipmux\modules\clkdist.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem General files
@echo vhdl work "%lst_WRPC_Sources%\top\kintex7_ref_design\wr_core_demo\ext_pll_10_to_62_5m.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="%lst_WRPC_Sources%\top\kintex7_ref_design\wr_core_demo\ext_pll_10_to_62_5m.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%
@echo vhdl work "..\..\..\general_modules\metastabilizer.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\..\general_modules\metastabilizer.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem CLB Top Level for FPGA
@echo vhdl work "..\..\top\fpga.vhd" >> %PrjFile%
@echo     ^<file xil_pn:name="..\..\top\fpga.vhd" xil_pn:type="FILE_VHDL"^> >> %XISEFile%
@echo       ^<association xil_pn:name="BehavioralSimulation"/^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

@echo     ^<file xil_pn:name=".\fpga.ucf" xil_pn:type="FILE_UCF"^> >> %XISEFile%
@echo       ^<association xil_pn:name="Implementation"/^> >> %XISEFile%
@echo     ^</file^> >> %XISEFile%

rem @echo     ^<property xil_pn:name="Generics, Parameters" xil_pn:value="g_date_id=%lst_currentdate% g_revision_id=%lst_currentrevision% g_lm32_wrpc_dpram_size=%lst_lm32wrpc_dpramsize% g_lm32_wrpc_profile=%lst_lm32wrpc_profile% g_lm32_2nd_dpram_size=%lst_lm32_2nd_dpramsize% g_lm32_2nd_profile=%lst_lm32_2nd_profile% g_use_clbv2_1=%lst_clbv2_1%" xil_pn:valueState="non-default"/^> >> %XISEFile%
@echo     ^<property xil_pn:name="Generics, Parameters" xil_pn:value="g_date_id=%lst_currentdate% g_revision_id=%lst_currentrevision% g_lm32_wrpc_dpram_size=%lst_lm32wrpc_dpramsize%" xil_pn:valueState="non-default"/^> >> %XISEFile%
@echo     ^<property xil_pn:name="Other Ngdbuild Command Line Options" xil_pn:value="-bm fpga.bmm -sd %lst_Arch1Path%" xil_pn:valueState="non-default"/^> >> %XISEFile%
@echo     ^<property xil_pn:name="Other Bitgen Command Line Options" xil_pn:value="-g UnconstrainedPins:Allow" xil_pn:valueState="non-default"/^> >> %XISEFile%

rem @echo     ^<property xil_pn:name="Generics, Parameters" xil_pn:value="u11/LM32_CORE/gen_profile_medium_icache_debug.U_Wrapped_LM32/jtag_cores/jtag_tap/bscan.JTAG_CHAIN = 2" xil_pn:valueState="non-default"/^> >> %XISEFile%
 rem set_attribute -name JTAG_CHAIN -value 2 -instance {u0.U_WR_CORE_WRPC.LM32_CORE.gen_profile_medium_icache_debug_U_Wrapped_LM32.jtag_cores.jtag_tap_bscan}
 rem set_attribute -name JTAG_CHAIN -value 2 -instance {u11.LM32_CORE.gen_profile_medium_icache_debug_U_Wrapped_LM32.jtag_cores.jtag_tap_bscan}
