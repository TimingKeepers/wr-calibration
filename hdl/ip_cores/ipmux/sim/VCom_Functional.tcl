# VCom_Functional.tcl
# compile for functional simulation

set WRPC_Sources "../../wr-cores/"

vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/genram_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wishbone_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_registers_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gencores_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_sync_ffs.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_sync_register.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/generic/generic_sync_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/generic/generic_async_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/inferred_sync_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/inferred_async_fifo.vhd
# DPRAM
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/memory_loader_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_dualclock.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_sameclock.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram.vhd

vcom -work work $WRPC_Sources/modules/fabric/wr_fabric_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/endpoint_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/endpoint_private_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_wb_master.vhd
vcom -work work ../../general_modules/wb_dummys/wb_DummySink.vhd
vcom -work work ../../general_modules/wb_dummys/wb_DummySource.vhd
vcom -work work ../../general_modules/wb_dummys/wb_DummyMaster.vhd
vcom -work work ../../general_modules/ip_cores/cmp_sys_clk_pll.vhd
vcom -work work ../../general_packages/v_array_package.vhd
vcom -work work ../../general_packages/EMAC16bit_package.vhd


vcom -work work ../modules/reg1en.vhd
vcom -work work ../top/system.vhd
