# VCom_Functional.tcl
# compile for functional simulation

set WRPC_Sources "../../wr-cores"

# =================================================================
# WRPC files
# =================================================================

# LM32
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/generated/lm32_allprofiles.v 
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_mc_arithmetic.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/jtag_cores.v 
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_adder.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_addsub.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_dp_ram.v 
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_logic_op.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_ram.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_shifter.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/platform/kintex7/lm32_multiplier_simu.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/platform/kintex7/jtag_tap.v 

# General and Generic files WRPC Related
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/genram_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wishbone_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_lm32/generated/xwb_lm32.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_fifo_sync.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_eic.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_dpssram.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_registers_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_tbi_phy/disparity_gen_pkg.vhd

vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_sync_ffs.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gencores_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_pulse_synchronizer.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_pulse_synchronizer2.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_extend_pulse.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_crc_gen.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_sync_register.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/common/gc_frequency_meter.vhd

vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/gc_shiftreg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/generic_shiftreg_fifo.vhd

vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/generic/generic_sync_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/generic/generic_async_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/inferred_sync_fifo.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/inferred_async_fifo.vhd

# WB_Crossbar
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_crossbar/sdb_rom.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_crossbar/xwb_crossbar.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_crossbar/xwb_sdb_crossbar.vhd

# DPRAM
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/memory_loader_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_dualclock.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_sameclock.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_dpram.vhd

#vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/genrams/xilinx/generic_spram.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_slave_adapter/wb_slave_adapter.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_dpram/xwb_dpram.vhd

# General PHY files
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/gtp_bitslide.vhd
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/gtp_phase_align.vhd

# Kintex-7 PHY
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/whiterabbit_gtxe2_channel_wrapper_gt.vhd
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/wr_gtx_phy_kintex7.vhd

# Spartan-6 PHY
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/whiterabbitgtp_wrapper_tile.vhd
vcom -work work $WRPC_Sources/platform/xilinx/wr_gtp_phy/wr_gtp_phy_spartan6.vhd

# Fabric
vcom -work work $WRPC_Sources/modules/fabric/wr_fabric_pkg.vhd
vcom -work work $WRPC_Sources/modules/fabric/xwrf_mux.vhd

# EndPoint
vcom -work work $WRPC_Sources/modules/wr_endpoint/endpoint_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/endpoint_private_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_crc32_pkg.vhd

#vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_framer.vhd      ===>>> obsolete! Now ep_tx_path
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_path.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_header_processor.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_inject_ctrl.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_vlan_unit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_packet_injection.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_crc_inserter.vhd

vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_1000basex_pcs.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_pcs_16bit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_pcs_16bit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_sync_detect_16bit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_tx_pcs_8bit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_pcs_8bit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_sync_detect.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_pcs_tbi_mdio_wb.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_autonegotiation.vhd

vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_path.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_early_address_match.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_packet_filter.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_clock_alignment_fifo.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_oob_insert.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_crc_size_check.vhd
#vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_bypass_queue.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_vlan_unit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rtu_header_extract.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_buffer.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_status_reg_insert.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_rx_wb_master.vhd
 
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_timestamping_unit.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_ts_counter.vhd

vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_wishbone_controller.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/ep_leds_controller.vhd

vcom -work work $WRPC_Sources/modules/wr_endpoint/wr_endpoint.vhd
vcom -work work $WRPC_Sources/modules/wr_endpoint/xwr_endpoint.vhd

# Mini-NIC
vcom -work work $WRPC_Sources/modules/wr_mini_nic/minic_wbgen2_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_mini_nic/xwr_mini_nic.vhd
vcom -work work $WRPC_Sources/modules/wr_mini_nic/wr_mini_nic.vhd
vcom -work work $WRPC_Sources/modules/wr_mini_nic/minic_wb_slave.vhd

# 1-wire
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_onewire_master/sockit_owm.v
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_onewire_master/wb_onewire_master.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_onewire_master/xwb_onewire_master.vhd

# UART
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/simple_uart_pkg.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/simple_uart_wb.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/uart_async_rx.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/uart_async_tx.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/uart_baud_gen.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/wb_simple_uart.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_uart/xwb_simple_uart.vhd

# SysCon
vcom -work work $WRPC_Sources/modules/wrc_core/wrc_syscon_pkg.vhd
vcom -work work $WRPC_Sources/modules/wrc_core/xwr_syscon_wb.vhd

# Timing and Soft PLL
vcom -work work $WRPC_Sources/modules/timing/dmtd_with_deglitcher.vhd
vcom -work work $WRPC_Sources/modules/timing/dmtd_phase_meas.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/softpll_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/spll_wbgen2_pkg.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/spll_wb_slave.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/spll_bangbang_pd.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/spll_period_detect.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/spll_aligner.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/wr_softpll_ng.vhd
vcom -work work $WRPC_Sources/modules/wr_softpll_ng/xwr_softpll_ng.vhd

# 1-PPS gen
vcom -work work $WRPC_Sources/modules/wr_pps_gen/pps_gen_wb.vhd
vcom -work work $WRPC_Sources/modules/wr_pps_gen/wr_pps_gen.vhd
vcom -work work $WRPC_Sources/modules/wr_pps_gen/xwr_pps_gen.vhd

# GPIO
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_gpio_port/wb_gpio_port.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_gpio_port/xwb_gpio_port.vhd

# Soft PLL DACs
vcom -work work $WRPC_Sources/modules/wr_dacs/spec_serial_dac.vhd
vcom -work work $WRPC_Sources/modules/wr_dacs/spec_serial_dac_arb.vhd

# WR Core
vcom -work work $WRPC_Sources/modules/wrc_core/wrcore_pkg.vhd
vcom -work work $WRPC_Sources/modules/wrc_core/wrc_periph.vhd
vcom -work work $WRPC_Sources/modules/wrc_core/wrc_syscon_wb.vhd
# wr_core and xwr_core are contained in clb_wrpc.vhd
#vcom -work work $WRPC_Sources/modules/wrc_core/wr_core.vhd
#vcom -work work $WRPC_Sources/modules/wrc_core/xwr_core.vhd
# CLB_WRPC related
vcom -explicit  -93 -work work ../../ip_cores/clb_wrpc/top/clb_wrpc.vhd

# SPI
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/spi_clgen.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/spi_defines.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/spi_shift.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/spi_top.v
vlog -reportprogress 300 -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/timescale.v
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/wb_spi.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_spi/xwb_spi.vhd

# I2C
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_bit_ctrl.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_byte_ctrl.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_top.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_i2c_master/wb_i2c_master.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_i2c_master/xwb_i2c_master.vhd

# Timer
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_simple_timer/wb_tics.vhd
vcom -work work $WRPC_Sources/ip_cores/general-cores/modules/wishbone/wb_simple_timer/xwb_tics.vhd

# General and Generic files CLB Related
vcom -explicit  -93 -work work ../../general_packages/V_ARRAY_package.vhd
vcom -explicit  -93 -work work ../../general_packages/EMAC16bit_package.vhd
vcom -explicit  -93 -work work ../../modules/wb_dummys/wb_DummyMaster.vhd
vcom -explicit  -93 -work work ../../modules/wb_dummys/wb_DummySlave.vhd
vcom -explicit  -93 -work work ../../modules/wb_dummys/wb_DummySink.vhd
vcom -explicit  -93 -work work ../../modules/wb_dummys/wb_DummySource.vhd
vcom -explicit  -93 -work work ../../modules/stimuli/ClkRstGen.vhd
vcom -explicit  -93 -work work ../../modules/stimuli/TransmitFrame16bit.vhd
vcom -explicit  -93 -work work ../../modules/metastabilizer.vhd


# IPMUX related
vcom -explicit  -93 -work work ../../ip_cores/ipmux/modules/clkdist.vhd
vcom -explicit  -93 -work work ../../ip_cores/ipmux/modules/reg1en.vhd
vcom -explicit  -93 -work work ../../ip_cores/ipmux/top/ipmux.vhd

# General SPEC related files
#vcom -work work $WRPC_Sources/top/spec_1_1/wr_core_demo/spec_reset_gen.vhd
#vcom -work work $WRPC_Sources/platform/xilinx/ext_pll_10_to_125m.vhd

# CLB TestBench
vcom -explicit  -93 -work work ../top/clb_top_tb.vhd
