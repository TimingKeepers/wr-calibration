onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clb_top_tb/g_simulation
add wave -noupdate /clb_top_tb/u5/RESET
add wave -noupdate /clb_top_tb/u5/u5/Rst
add wave -noupdate /clb_top_tb/u5/clk_20m_vcxo_i
add wave -noupdate /clb_top_tb/u5/FPGA_PLL_REF_CLK0_P
add wave -noupdate /clb_top_tb/u5/clk_20m_vcxo_i
add wave -noupdate /clb_top_tb/u5/SFP_TX_P
add wave -noupdate /clb_top_tb/u5/SFP_RX_P
add wave -noupdate /clb_top_tb/u5/SFP_TX_DISABLE
add wave -noupdate /clb_top_tb/u5/u14/u6/Tx_Fire
add wave -noupdate /clb_top_tb/u5/u14/u6/state
add wave -noupdate /clb_top_tb/u5/u14/g_simulation
add wave -noupdate /clb_top_tb/u5/u14/Fire
add wave -noupdate /clb_top_tb/u5/u14/udp_tstgen_cont
add wave -noupdate /clb_top_tb/u5/u14/u1/Enable
add wave -noupdate /clb_top_tb/u5/u14/u1/Fire
add wave -noupdate -divider Debug
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/rxpcs_fab_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb
add wave -noupdate -divider General
add wave -noupdate /clb_top_tb/u5/g_lm32_wrpc_dpram_size
add wave -noupdate -divider LM32_WRPC
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/g_init_file
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/g_must_have_init_file
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/g_profile
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/g_reset_vector
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/clk_sys_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/rst_n_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/dwb_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/dwb_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_i
add wave -noupdate -divider Instructions_WRPC
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_o.cyc
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_o.stb
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_o.adr
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_i.ack
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/LM32_CORE/iwb_i.dat
add wave -noupdate -divider WB_CON_WRPC
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/clk_sys_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/rst_n_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/slave_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/slave_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/master_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/WB_CON/master_o
add wave -noupdate -divider DPRAM_WRPC
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/clk_sys_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/rst_n_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/slave1_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/slave1_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/slave2_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/DPRAM/slave2_o
add wave -noupdate -divider UART_WRPC
add wave -noupdate -divider XWRF_Mux
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/ep_snk_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/ep_snk_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/ep_src_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/ep_src_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/mux_snk_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/mux_snk_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/mux_src_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_WBP_MUX/mux_src_o
add wave -noupdate -divider MiniNIC
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/snk_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/snk_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/src_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/src_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/mem_addr_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/mem_data_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/mem_data_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/MINI_NIC/mem_wr_o
add wave -noupdate -divider IPMUX-Tx
add wave -noupdate /clb_top_tb/u5/u5/WrClk(3)
add wave -noupdate /clb_top_tb/u5/u5/WrReq(3)
add wave -noupdate /clb_top_tb/u5/u5/Tx(3)
add wave -noupdate /clb_top_tb/u5/u5/Full(3)
add wave -noupdate -divider ep_tx_pcs_16bit
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/rst_n_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/clk_sys_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/pcs_fab_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/phy_tx_disparity_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/phy_tx_clk_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/an_tx_val_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/mdio_mcr_pdown_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/mdio_wr_spec_tx_cal_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/an_tx_en_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/phy_tx_enc_err_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/fifo_almost_full
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/tx_busy
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/tx_error
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/dbg_wr_count_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/phy_tx_k_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/phy_tx_data_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/rmon_tx_underrun
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/timestamp_trigger_p_a_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/pcs_dreq_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/pcs_busy_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/pcs_error_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_16bit/U_TX_PCS/dbg_rd_count_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/dbg_o
add wave -noupdate -divider ep_tx_header_processor
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/txpcs_timestamp_trigger_p_a_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/g_with_timestamper
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/g_force_gap_length
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/g_runt_padding
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/g_with_packet_injection
add wave -noupdate -expand /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/wb_snk_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/wb_snk_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/dbg_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/snk_valid
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/state
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/oob
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/oob_state
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/abort_now
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/abort_p1
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/bitsel_d
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/c_IFG_LENGTH
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/clk_sys_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/counter
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/decoded_status
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/eof_p1
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/ep_ctrl
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/ep_ctrl_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/error_p1
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/fc_flow_enable_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/fc_pause_delay_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/fc_pause_ready_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/fc_pause_req_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/needs_padding
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/pcs_busy_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/pcs_error_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/regs_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/rst_n_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/snk_cyc_d0
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/sof_p1
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/sof_reg
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/src_dreq_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/src_fab_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/stall_int
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/stored_status
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/tx_en
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/tx_pause_delay
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/tx_pause_mode
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txts_timestamp_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txts_timestamp_valid_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_ack_i
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_fid_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_port_id_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_stb_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_ts_incorrect_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/txtsu_ts_value_o
add wave -noupdate /clb_top_tb/u5/u0/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Tx_Path/U_Header_Processor/wb_out
add wave -noupdate -divider WRF
add wave -noupdate /clb_top_tb/u5/u0/wrf_src_o
add wave -noupdate /clb_top_tb/u5/u0/wrf_src_i
add wave -noupdate /clb_top_tb/u5/u0/wrf_snk_o
add wave -noupdate /clb_top_tb/u5/u0/wrf_snk_i
add wave -noupdate -divider {TransmitFrame 16 Bit}
add wave -noupdate /clb_top_tb/u2/Rx_Fire
add wave -noupdate /clb_top_tb/u2/TxCharIsK
add wave -noupdate /clb_top_tb/u2/TxData
add wave -noupdate /clb_top_tb/u2/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 8} {208189056 ps} 0} {{Cursor 3} {742250992 ps} 0} {{Cursor 3} {4092100 ps} 0} {{Cursor 4} {575957611 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 820
configure wave -valuecolwidth 173
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {732682927 ps} {764737805 ps}
