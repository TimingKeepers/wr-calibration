rem fpga-xilinx.cmd  PeterJ,    22-Oct-2012.
@prompt $$$s

set LM32_Sources=..\..\wr-cores\ip_cores\general-cores\modules\wishbone\wb_lm32
set WRPC_Sources=..\..\wr-cores

set UseXST=true
set DesName=fpga
set lm32_wrpc_dpramsize=32768
rem set lm32_wrpc_profile=medium_icache_debug
rem set lm32_2nd_dpramsize=32768
rem set lm32_2nd_profile=medium_icache_debug
rem set clbv2_1=false

rem KC705
rem set PartName=xc7k325t-ffg900-2

rem CLBv2 Proto equipped with 7K160 (speed grade -1 has lowest performance)
set PartName=xc7k160t-fbg676-2

rem CLBv2 Proto equipped with 7K325 (speed grade -1 has lowest performance)
rem set PartName=xc7k325t-fbg676-2

rem set Ac1Path=%WRPC_Sources%\ip_cores\general-cores\modules\genrams\xilinx\kintex7\xilinx_core_generator
set Ac1Path=..\..\..\ipmux\ip_cores
rem set Ac2Path=..\..\..\tdc\modules\ip_cores
set LogName=%DesName%-xilinx.log

@rem ---------------------------------------------------------------------

if %UseXST%==true (
   xtclsh revisiondate.tcl
	 set n=0  
	 for /f "tokens=*" %%a in (revisiondate_log.txt) do call :dosomething %%a
	 goto donext

:dosomething
	 @echo Now working with %1
	 set /a currentdate=0x%currentrevision%
	 set currentrevision=%1
	 goto :eof

:donext
   @echo "current date: %currentdate%"
   @echo "current revision: %currentrevision%"

   rem ---------------------------------------------------------------------
   rem ---- Xilinx XST -----------------------------------------------------
   rem Prepare a .prj file for Xilinx XST; do_input_file_list.cmd contains all input source files
   rem ---------------------------------------------------------------------
   rem call do_input_file_list ..\%LM32_Sources% ..\%WRPC_Sources% ..\%Ac1Path% %DesName% %DesName% %currentdate% %currentrevision% %lm32_wrpc_dpramsize% %lm32_wrpc_profile% %lm32_2nd_dpramsize% %lm32_2nd_profile% %clbv2_1%
   rem WATCH OUT! For some reason I may only pass 9 parameters. The 10-th will pass the first again...?
   call do_input_file_list ..\%LM32_Sources% ..\%WRPC_Sources% ..\%Ac1Path% %DesName% %currentdate% %currentrevision% %lm32_wrpc_dpramsize%
) else (
rem   set Ac_lm32Path=..\syn_LM32\impl
   set Ac_lm32Path=..\..\..\lm32_2nd\syn\syn_lm32\impl
)

mkdir work
cd work
del *.* /S /Q

@echo Started implementation of %DesName% on %date% at %time% > ..\%LogName%

copy ..\impl\%DesName%.edf .
rem copy ..\%DesName%.ucf .
copy ..\%DesName%.ut .

if %UseXST%==true (
   copy ..\%DesName%_xst.ucf %DesName%.ucf
   copy ..\%DesName%_xst.bmm %DesName%.bmm 
   copy ..\lm32_empty_memory.ldr lm32_memory.ldr
   rem Xilinx XST needs a projnav.tmp directory
   mkdir xst\projnav.tmp
   copy ..\%DesName%.xst .
   copy ..\%DesName%.prj .
   rem copy revision generics in temporary ".xst" file
   @echo -generics {g_revision_id=%currentrevision% g_date_id=%currentdate% g_lm32_wrpc_dpram_size=%lm32_wrpc_dpramsize%} >> %DesName%.xst
   @echo xst ... >> ..\%LogName%
   xst -intstyle xflow -ifn %DesName%.xst -ofn %DesName%.syr >> ..\%LogName%

   @echo ngdbuild ... >> ..\%LogName%
   ngdbuild -intstyle xflow -dd . -uc %DesName%.ucf -sd ..\%Ac1Path% -bm %DesName%.bmm -nt timestamp  -p %PartName% %DesName%.ngc %DesName%.ngd >> ..\%LogName%
) else (
   copy ..\%DesName%_precision.ucf %DesName%.ucf
   copy ..\%DesName%_precision.bmm %DesName%.bmm 
   @echo ngdbuild ... >> ..\%LogName%
   ngdbuild -intstyle xflow -dd . -uc %DesName%.ucf -sd ..\%Ac1Path% -sd ..\%Ac_lm32Path% -bm %DesName%.bmm -nt timestamp  -p %PartName% %DesName%.edf >> ..\%LogName%
)

@echo map ... >> ..\%LogName%
map   -intstyle xflow -p %PartName% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -mt off -ir off -pr off -lc off -power off -o %DesName%_map.ncd %DesName%.ngd %DesName%.pcf >> ..\%LogName%

@echo par ... >> ..\%LogName%
par -w -intstyle xflow -ol high -mt off %DesName%_map.ncd %DesName%.ncd %DesName%.pcf >> ..\%LogName%

@echo trce ... >> ..\%LogName%
trce -intstyle xflow -v 3 -s 1 -n 3 -fastpaths -xml %DesName%.twx %DesName%.ncd -o %DesName%.twr %DesName%.pcf >> ..\%LogName%

@echo bitgen ... >> ..\%LogName%
bitgen -intstyle xflow -g UnconstrainedPins:Allow -f %DesName%.ut %DesName%.ncd >> ..\%LogName%

#@echo netgen ... >> ..\%LogName%
#netgen -intstyle xflow -s 2 -pcf %DesName%.pcf -rpw 100 -tpw 0 -ar Structure -a -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim %DesName%.ncd %DesName%_timesim.vhd >> ..\%LogName%

@echo copy bitfile ... >> ..\%LogName%
copy  %DesName%.bit ..\%DesName%.bit
copy  %DesName%_bd.bmm ..\%DesName%_bd.bmm
