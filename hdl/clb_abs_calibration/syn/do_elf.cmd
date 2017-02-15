rem do_elf.cmd  PeterJ,    18-Oct-2013.
@prompt $$$s

rem Set the pointers to the elf files that need to be loaded in the ADDRESS_SPACEs defined in the _bd.bmm file
rem The names of the ADDRESS_SPACEs will be tags for data2mem such that data2mem "knows" where to place one and
rem the other "elf" file.

Rem reference design software
rem set elf_file_lm32_wrpc=..\..\..\sw\embedded\precompiled\wrpc-clb-sw\wrc.elf

Rem calibration software
rem set elf_file_lm32_wrpc=..\..\..\sw\embedded\precompiled\wrpc-clb-cal-sw\wrc.elf
set elf_file_lm32_wrpc=..\..\..\..\InSituAlpha\wrpc-sw\wrc.elf

set tag_lm32_wrpc="lm32_wrpc_memory"

set DesName=fpga
set ImplName=%DesName%_elf

if exist "%DesName%.bit" (
      rem it is assumed that there is a valid bit file (with empty" Block RAMs)
	) else (
		echo Run do_xilinx.cmd first to create a bit file.
		exit
)

@echo Place ELF file content into bit file and netgen simualtion file of %DesName% on %date% at %time% > %ImplName%.log
@echo
@echo data2mem ... >> %ImplName%.log
@echo The Block RAMs in the original bit file are "empty" (=0x00). >> %ImplName%.log
@echo A new bitfile "%DesName%_elf.bit" will be created in which the Block RAMs are filled with the >> %ImplName%.log
@echo lm32 WRPC content of:    %elf_file_lm32_wrpc% >> %ImplName%.log
rem @echo lm32 2nd  content of:    %elf_file_lm32_2nd% >> %ImplName%.log

rem data2mem -bm %DesName%_bd.bmm -bd %elf_file_lm32_wrpc% tag %tag_lm32_wrpc% -bd %elf_file_lm32_2nd% tag %tag_lm32_2nd% -bt %DesName%.bit -o b %ImplName%.bit >> %ImplName%.log
data2mem -bm %DesName%_bd.bmm -bd %elf_file_lm32_wrpc% tag %tag_lm32_wrpc% -bt %DesName%.bit -o b %ImplName%.bit >> %ImplName%.log

if "%1" == "dump" (
   @echo >> %ImplName%.log
   @echo For debugging purposes, dump %ImplName%.bit into dump_bit.txt >> %ImplName%.log
   data2mem -bm %DesName%_bd.bmm -bt %ImplName%.bit -d > dump_bit.txt
)

rem 
rem @echo netgen ... >> %ImplName%.log
rem @echo The Block RAMs in the original netgen\par\%DesName%_timesim.vhd are "empty" (=0x00). >> %ImplName%.log
rem @echo A new netgen\par\%DesName%_timesim_elf.vhd will be created in which the Block RAMs are filled with the >> %ImplName%.log
rem @echo content of:    %elf_file_lm32_wrpc% >> %ImplName%.log

@rem -xon true


