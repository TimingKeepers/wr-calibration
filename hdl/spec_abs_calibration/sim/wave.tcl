onerror {resume}
quietly virtual signal -install /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_RX_Wishbone_Master { /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_RX_Wishbone_Master/src_wb_o.dat(7 downto 0)} databuslow
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Config and Reset}
add wave -noupdate /spec_top_tb/u5/button1_i
add wave -noupdate /spec_top_tb/u5/button2_i
add wave -noupdate /spec_top_tb/u5/clk_125m_pllref_p_i
add wave -noupdate /spec_top_tb/u5/fpga_pll_ref_clk_101_p_i
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_rbclk_o
add wave -noupdate /spec_top_tb/u5/clk_20m_vcxo_i
add wave -noupdate /spec_top_tb/u5/sfp_txp_o
add wave -noupdate /spec_top_tb/u5/sfp_rxp_i
add wave -noupdate /spec_top_tb/u5/sfp_tx_disable_o
add wave -noupdate /spec_top_tb/u5/cmp_clk_dmtd_buf/O
add wave -noupdate /spec_top_tb/u5/cmp_clk_sys_buf/O
add wave -noupdate /spec_top_tb/u5/L_RST_N
add wave -noupdate -divider Debug
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/rxpcs_fab_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/phy_rx_clk_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/phy_rx_data_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/phy_rx_k_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/rx_even
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/rx_state
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_data
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_k
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_even
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_spd
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_preamble_char
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_sfd_char
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_is_comma
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/d_err
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_PCS_1000BASEX/gen_8bit/U_RX_PCS/rx_synced
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb
add wave -noupdate -divider {TimeStamp Signals}
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/rxts_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/txts_o
add wave -noupdate -divider ep_packet_filter
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/rst_n_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/g_size
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/g_data_width
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/g_dual_clock
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/clka_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/bwea_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/aa_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/da_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/qa_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/clkb_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/bweb_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/ab_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_microcode_ram/db_i
add wave -noupdate -divider General
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_ref_clk_i
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_tx_data_i
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_tx_k_i
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_bitslide_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_rbclk_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_data_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_k_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_enc_err_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rx_bitslide_o
add wave -noupdate /spec_top_tb/u5/U_GTP/ch1_rst_i
add wave -noupdate -divider LM32_WRPC
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/g_init_file
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/g_must_have_init_file
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/g_profile
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/g_reset_vector
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/clk_sys_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/rst_n_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/dwb_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/dwb_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_i
add wave -noupdate -divider Instructions_WRPC
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_o.cyc
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_o.stb
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_o.adr
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_i.ack
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/LM32_CORE/iwb_i.dat
add wave -noupdate -divider WB_CON_WRPC
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/clk_sys_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/rst_n_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/slave_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/slave_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/master_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/WB_CON/master_o
add wave -noupdate -divider DPRAM_WRPC
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/clk_sys_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/rst_n_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/slave1_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/slave1_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/slave2_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/DPRAM/slave2_o
add wave -noupdate -divider UART_WRPC
add wave -noupdate /spec_top_tb/u5/uart_rxd_i
add wave -noupdate /spec_top_tb/u5/uart_txd_o
add wave -noupdate -divider Endpoint_RX_Path
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fab_pipe
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gen_with_packet_filter/U_packet_filter/U_backlog_ram/gen_single_clk/U_RAM_SC/ram
add wave -noupdate -divider ep_rx_path
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_dpi_classifier
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_early_match
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_pf_class
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_pclass
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_pclass_o
add wave -noupdate -divider ep_rx_status_reg
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_valid_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_ack_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_drop_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_pclass_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_is_hp_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/mbuf_is_pause_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/rmon_pfilter_drop_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/dreq_mask
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/embed_status
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/sreg
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/U_Gen_Status/state
add wave -noupdate -divider XWRF_Mux
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/ep_snk_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/ep_snk_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/ep_src_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/ep_src_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/mux_snk_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/mux_snk_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/mux_src_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/U_WBP_MUX/mux_src_o
add wave -noupdate -divider MiniNIC
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/snk_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/snk_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/src_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/src_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/mem_addr_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/mem_data_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/mem_data_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/WRPC/MINI_NIC/mem_wr_o
add wave -noupdate -divider WRF
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/wrf_src_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/wrf_src_i
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/wrf_snk_o
add wave -noupdate /spec_top_tb/u5/U_WR_CORE/wrf_snk_i
add wave -noupdate -divider {TransmitFrame 16 Bit}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 8} {208189056 ps} 0} {{Cursor 3} {718867608 ps} 0} {{Cursor 3} {4000000 ps} 0} {{Cursor 4} {575957611 ps} 0}
quietly wave cursor active 3
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
WaveRestoreZoom {0 ps} {852390 ns}
