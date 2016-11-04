onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system/RST_I
add wave -noupdate /system/ClkI_p
add wave -noupdate /system/ClkI_n
add wave -noupdate -divider {Wishbone IPMUX Registers}
add wave -noupdate /system/u0/u14/u4/Clk
add wave -noupdate /system/u0/u14/u4/Rst
add wave -noupdate /system/u0/u14/u4/wb_ipmux_reg_i
add wave -noupdate /system/u0/u14/u4/wb_ipmux_reg_o
add wave -noupdate /system/u0/u14/u4/ack_reg
add wave -noupdate /system/u0/u14/u4/wr_reg
add wave -noupdate /system/u0/u14/u4/rd_reg
add wave -noupdate /system/u0/u14/u4/MAC_Srv
add wave -noupdate /system/u0/u14/u4/MAC_Mod
add wave -noupdate /system/u0/u14/u4/IP_Srv
add wave -noupdate /system/u0/u14/u4/IP_Mod
add wave -noupdate /system/u0/u14/u4/UDP_SrvPrt
add wave -noupdate /system/u0/u14/u4/UDP_ModPrt
add wave -noupdate /system/u0/u14/u4/eth_regs_o
add wave -noupdate /system/u0/u14/u4/CPU_AccGnt
add wave -noupdate /system/u0/u14/u4/reg_tx_request
add wave -noupdate /system/u0/u14/u4/reg_flush
add wave -noupdate /system/u0/u14/u4/Flush
add wave -noupdate -expand /system/u0/u14/u4/CPU_Tx
add wave -noupdate /system/u0/u14/u4/Rx_Empty
add wave -noupdate /system/u0/u14/u4/Tx_Full
add wave -noupdate /system/u0/u14/u4/wb_ipmux_rx_tx_i
add wave -noupdate /system/u0/u14/u4/wb_ipmux_rx_tx_o
add wave -noupdate /system/u0/u14/u4/ack_txrx
add wave -noupdate /system/u0/u14/u4/wr_tx
add wave -noupdate /system/u0/u14/u4/rd_rx
add wave -noupdate /system/u0/u14/u4/cpu_rdreq
add wave -noupdate /system/u0/u14/u4/cpu_rx
add wave -noupdate /system/u0/u14/u0/u0/AddrA
add wave -noupdate /system/u0/u14/u0/u0/Din
add wave -noupdate /system/u0/u14/u0/u0/WeA
add wave -noupdate -divider {Tx to Server PC}
add wave -noupdate /system/Fire
add wave -noupdate /system/u0/u14/WrClk
add wave -noupdate -expand /system/u0/u14/Full
add wave -noupdate -expand /system/u0/u14/WrReq
add wave -noupdate -radix hexadecimal -childformat {{/system/u0/u14/Tx(3) -radix hexadecimal} {/system/u0/u14/Tx(2) -radix hexadecimal} {/system/u0/u14/Tx(1) -radix hexadecimal} {/system/u0/u14/Tx(0) -radix hexadecimal -childformat {{/system/u0/u14/Tx(0).D -radix hexadecimal -childformat {{/system/u0/u14/Tx(0).D(15) -radix hexadecimal} {/system/u0/u14/Tx(0).D(14) -radix hexadecimal} {/system/u0/u14/Tx(0).D(13) -radix hexadecimal} {/system/u0/u14/Tx(0).D(12) -radix hexadecimal} {/system/u0/u14/Tx(0).D(11) -radix hexadecimal} {/system/u0/u14/Tx(0).D(10) -radix hexadecimal} {/system/u0/u14/Tx(0).D(9) -radix hexadecimal} {/system/u0/u14/Tx(0).D(8) -radix hexadecimal} {/system/u0/u14/Tx(0).D(7) -radix hexadecimal} {/system/u0/u14/Tx(0).D(6) -radix hexadecimal} {/system/u0/u14/Tx(0).D(5) -radix hexadecimal} {/system/u0/u14/Tx(0).D(4) -radix hexadecimal} {/system/u0/u14/Tx(0).D(3) -radix hexadecimal} {/system/u0/u14/Tx(0).D(2) -radix hexadecimal} {/system/u0/u14/Tx(0).D(1) -radix hexadecimal} {/system/u0/u14/Tx(0).D(0) -radix hexadecimal}}} {/system/u0/u14/Tx(0).EOD -radix hexadecimal}}}} -expand -subitemconfig {/system/u0/u14/Tx(3) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(2) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(1) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0) {-height 15 -radix hexadecimal -childformat {{/system/u0/u14/Tx(0).D -radix hexadecimal -childformat {{/system/u0/u14/Tx(0).D(15) -radix hexadecimal} {/system/u0/u14/Tx(0).D(14) -radix hexadecimal} {/system/u0/u14/Tx(0).D(13) -radix hexadecimal} {/system/u0/u14/Tx(0).D(12) -radix hexadecimal} {/system/u0/u14/Tx(0).D(11) -radix hexadecimal} {/system/u0/u14/Tx(0).D(10) -radix hexadecimal} {/system/u0/u14/Tx(0).D(9) -radix hexadecimal} {/system/u0/u14/Tx(0).D(8) -radix hexadecimal} {/system/u0/u14/Tx(0).D(7) -radix hexadecimal} {/system/u0/u14/Tx(0).D(6) -radix hexadecimal} {/system/u0/u14/Tx(0).D(5) -radix hexadecimal} {/system/u0/u14/Tx(0).D(4) -radix hexadecimal} {/system/u0/u14/Tx(0).D(3) -radix hexadecimal} {/system/u0/u14/Tx(0).D(2) -radix hexadecimal} {/system/u0/u14/Tx(0).D(1) -radix hexadecimal} {/system/u0/u14/Tx(0).D(0) -radix hexadecimal}}} {/system/u0/u14/Tx(0).EOD -radix hexadecimal}} -expand} /system/u0/u14/Tx(0).D {-height 15 -radix hexadecimal -childformat {{/system/u0/u14/Tx(0).D(15) -radix hexadecimal} {/system/u0/u14/Tx(0).D(14) -radix hexadecimal} {/system/u0/u14/Tx(0).D(13) -radix hexadecimal} {/system/u0/u14/Tx(0).D(12) -radix hexadecimal} {/system/u0/u14/Tx(0).D(11) -radix hexadecimal} {/system/u0/u14/Tx(0).D(10) -radix hexadecimal} {/system/u0/u14/Tx(0).D(9) -radix hexadecimal} {/system/u0/u14/Tx(0).D(8) -radix hexadecimal} {/system/u0/u14/Tx(0).D(7) -radix hexadecimal} {/system/u0/u14/Tx(0).D(6) -radix hexadecimal} {/system/u0/u14/Tx(0).D(5) -radix hexadecimal} {/system/u0/u14/Tx(0).D(4) -radix hexadecimal} {/system/u0/u14/Tx(0).D(3) -radix hexadecimal} {/system/u0/u14/Tx(0).D(2) -radix hexadecimal} {/system/u0/u14/Tx(0).D(1) -radix hexadecimal} {/system/u0/u14/Tx(0).D(0) -radix hexadecimal}}} /system/u0/u14/Tx(0).D(15) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(14) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(13) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(12) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(11) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(10) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(9) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(8) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(7) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(6) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(5) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(4) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(3) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(2) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(1) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).D(0) {-height 15 -radix hexadecimal} /system/u0/u14/Tx(0).EOD {-height 15 -radix hexadecimal}} /system/u0/u14/Tx
add wave -noupdate /system/u0/u4/u4/state
add wave -noupdate /system/u0/u4/u4/Clk
add wave -noupdate /system/u0/u4/u4/Full
add wave -noupdate /system/u0/u4/u4/Rst
add wave -noupdate /system/u0/u4/u4/Single
add wave -noupdate /system/u0/u4/u4/TxFireCPU
add wave -noupdate /system/u0/u4/u4/Tx_Fire
add wave -noupdate /system/u0/u4/u4/UDP_Tx
add wave -noupdate /system/u0/u4/u4/WrReq
add wave -noupdate /system/u0/u4/u4/state
add wave -noupdate -divider TxFifo0
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/clk_rd_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/clk_wr_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/d_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_almost_empty_threshold
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_almost_full_threshold
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_data_width
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_show_ahead
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_size
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_rd_almost_empty
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_rd_almost_full
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_rd_count
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_rd_empty
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_rd_full
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_wr_almost_empty
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_wr_almost_full
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_wr_count
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_wr_empty
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/g_with_wr_full
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/q_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_almost_empty_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_almost_full_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_count_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_empty_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_full_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rd_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/rst_n_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/we_i
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/wr_almost_empty_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/wr_almost_full_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/wr_count_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/wr_empty_o
add wave -noupdate /system/u0/u14/u8/GenTxFifos(0)/tx_data_fifo/wr_full_o
add wave -noupdate -divider TxFifos
add wave -noupdate /system/u0/u14/u8/Din_Intern
add wave -noupdate /system/u0/u14/u8/Dout_Intern
add wave -noupdate /system/u0/u14/u8/Empty_Intern
add wave -noupdate /system/u0/u14/u8/Flush
add wave -noupdate /system/u0/u14/u8/Full
add wave -noupdate /system/u0/u14/u8/NotEmpty_Intern
add wave -noupdate /system/u0/u14/u8/RdClk
add wave -noupdate /system/u0/u14/u8/RdReq
add wave -noupdate /system/u0/u14/u8/RdReq_Intern
add wave -noupdate /system/u0/u14/u8/Rst
add wave -noupdate /system/u0/u14/u8/WrClk(0)
add wave -noupdate /system/u0/u14/u8/WrReq(0)
add wave -noupdate /system/u0/u14/u8/TXi(0).D
add wave -noupdate /system/u0/u14/u8/TXi(0).EOD
add wave -noupdate /system/u0/u14/u8/WrReq_EOD(0)
add wave -noupdate /system/u0/u14/u8/Empty_EOD(0)
add wave -noupdate /system/u0/u14/u8/TXo(0).D
add wave -noupdate /system/u0/u14/u8/TXo(0).EOD
add wave -noupdate /system/u0/u14/u8/Valid(0)
add wave -noupdate /system/u0/u14/u8/Valid
add wave -noupdate /system/u0/u14/u8/Valid_Intern
add wave -noupdate /system/u0/u14/u8/Packet(0)
add wave -noupdate /system/u0/u14/u8/Packet_RdReq(0)
add wave -noupdate -divider TX_PacketBuffer
add wave -noupdate /system/u0/u14/u0/u0/abits
add wave -noupdate /system/u0/u14/u0/u0/dbits
add wave -noupdate /system/u0/u14/u0/u0/AddrA
add wave -noupdate /system/u0/u14/u0/u0/AddrB
add wave -noupdate /system/u0/u14/u0/u0/Clk
add wave -noupdate /system/u0/u14/u0/u0/Din
add wave -noupdate /system/u0/u14/u0/u0/Q
add wave -noupdate /system/u0/u14/u0/u0/Rst
add wave -noupdate /system/u0/u14/u0/u0/WeA
add wave -noupdate /system/u0/u14/u0/u0/rst_n
add wave -noupdate -divider TXBuffers
add wave -noupdate /system/u0/u14/u0/CPU_AccGnt
add wave -noupdate /system/u0/u14/u0/CPU_Tx
add wave -noupdate /system/u0/u14/u0/Connect
add wave -noupdate /system/u0/u14/u0/Connected
add wave -noupdate /system/u0/u14/u0/Dout
add wave -noupdate /system/u0/u14/u0/Dout0
add wave -noupdate /system/u0/u14/u0/EOPout
add wave -noupdate /system/u0/u14/u0/Empty
add wave -noupdate /system/u0/u14/u0/Full
add wave -noupdate /system/u0/u14/u0/PktRdPtr0
add wave -noupdate /system/u0/u14/u0/PktWrPtr
add wave -noupdate /system/u0/u14/u0/PseudoHeader
add wave -noupdate /system/u0/u14/u0/Q
add wave -noupdate /system/u0/u14/u0/SelSm
add wave -noupdate /system/u0/u14/u0/Stream
add wave -noupdate /system/u0/u14/u0/TX_LL_DATA
add wave -noupdate /system/u0/u14/u0/TX_LL_EOP
add wave -noupdate /system/u0/u14/u0/TX_LL_RDREQ
add wave -noupdate /system/u0/u14/u0/TX_LL_VALID
add wave -noupdate /system/u0/u14/u0/u1/Offset
add wave -noupdate /system/u0/u14/u0/WrAddr
add wave -noupdate /system/u0/u14/u0/WrAddr0
add wave -noupdate /system/u0/u14/u0/WrEn
add wave -noupdate /system/u0/u14/u0/WrEn0
add wave -noupdate /system/u0/u14/u0/eth_regs_i
add wave -noupdate /system/u0/u14/u0/src_i
add wave -noupdate /system/u0/u14/u0/src_o
add wave -noupdate -divider tx_pkt2mac
add wave -noupdate /system/u0/u14/u0/u3/Rst
add wave -noupdate /system/u0/u14/u0/u3/Clk
add wave -noupdate -radix hexadecimal /system/u0/u14/u0/u3/Din
add wave -noupdate /system/u0/u14/u0/u3/EOP
add wave -noupdate /system/u0/u14/u0/u3/Empty
add wave -noupdate -radix hexadecimal /system/u0/u14/u0/u3/Offset
add wave -noupdate -radix hexadecimal /system/u0/u14/u0/u3/PktPtr
add wave -noupdate -radix hexadecimal /system/u0/u14/u0/u3/PktRdPtr
add wave -noupdate -radix hexadecimal /system/u0/u14/u0/u3/RdAddr
add wave -noupdate /system/u0/u14/u0/u3/abits
add wave -noupdate -childformat {{/system/u0/u14/u0/u3/src_o.adr -radix hexadecimal} {/system/u0/u14/u0/u3/src_o.dat -radix hexadecimal} {/system/u0/u14/u0/u3/src_o.sel -radix hexadecimal}} -expand -subitemconfig {/system/u0/u14/u0/u3/src_o.adr {-height 15 -radix hexadecimal} /system/u0/u14/u0/u3/src_o.dat {-height 15 -radix hexadecimal} /system/u0/u14/u0/u3/src_o.sel {-height 15 -radix hexadecimal}} /system/u0/u14/u0/u3/src_o
add wave -noupdate -expand /system/u0/u14/u0/u3/src_i
add wave -noupdate /system/u0/u14/u0/u3/state
add wave -noupdate /system/u0/u14/src_o
add wave -noupdate /system/u0/u14/src_i
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /system/u0/u14/snk_i
add wave -noupdate /system/u0/u14/snk_o
add wave -noupdate /system/UDP_Rx
add wave -noupdate /system/UDP_Rx_Empty
add wave -noupdate /system/UDP_Rx_RdReq
add wave -noupdate -divider {New Divider}
add wave -noupdate /system/u0/u14/u1/TXi
add wave -noupdate /system/u0/u14/u1/Validin
add wave -noupdate /system/u0/u14/u1/RdReqOut
add wave -noupdate -divider {New Divider}
add wave -noupdate /system/u0/u14/u1/Validout
add wave -noupdate /system/u0/u14/u1/Stream
add wave -noupdate /system/u0/u14/u1/Dout
add wave -noupdate /system/u0/u14/u1/EODout
add wave -noupdate /system/u0/u14/u1/RdReqin
add wave -noupdate -divider {New Divider}
add wave -noupdate /system/u0/u14/u0/u1/Connected
add wave -noupdate /system/u0/u14/u0/u1/Stream
add wave -noupdate /system/u0/u14/u0/u1/ConnectReq_Intern
add wave -noupdate /system/u0/u14/u0/u1/state
add wave -noupdate /system/u0/u14/u0/u1/CPU_AccGnt
add wave -noupdate /system/u0/u14/u0/u1/Full
add wave -noupdate /system/u0/u14/u6/u1/We
add wave -noupdate /system/u0/u14/u6/u1/We_Int
add wave -noupdate /system/u0/u14/u6/u1/Offset
add wave -noupdate -divider RxPktBufferFlags
add wave -noupdate /system/u0/u14/u6/u4/Empty
add wave -noupdate /system/u0/u14/u6/u4/Full
add wave -noupdate /system/u0/u14/u6/u4/HighLevelPerc
add wave -noupdate /system/u0/u14/u6/u4/LowLevelPerc
add wave -noupdate /system/u0/u14/u6/u4/PktRdPtr
add wave -noupdate /system/u0/u14/u6/u4/PktWrPtr
add wave -noupdate /system/u0/u14/u6/u4/WaterMarkHigh
add wave -noupdate /system/u0/u14/u6/u4/WaterMarkLow
add wave -noupdate /system/u0/u14/u6/u4/abits
add wave -noupdate -divider RxStreamSelect
add wave -noupdate /system/u0/u14/u6/u3/Din
add wave -noupdate /system/u0/u14/u6/u3/EODin
add wave -noupdate /system/u0/u14/u6/u3/EOFin
add wave -noupdate /system/u0/u14/u6/u3/Full
add wave -noupdate /system/u0/u14/u6/u3/Fullout
add wave -noupdate /system/u0/u14/u6/u3/RXo
add wave -noupdate /system/u0/u14/u6/u3/SODin
add wave -noupdate /system/u0/u14/u6/u3/Stream
add wave -noupdate /system/u0/u14/u6/u3/WrReq
add wave -noupdate /system/u0/u14/u6/u3/WrReqin
add wave -noupdate -divider UDP_RX
add wave -noupdate /system/u0/u1/Emptyo
add wave -noupdate /system/u0/u1/RdReqi
add wave -noupdate -expand -subitemconfig {/system/u0/u1/UDP_Rx(0) -expand} /system/u0/u1/UDP_Rx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {512000 ps} 0} {{Cursor 2} {72380100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {372968 ps} {622957 ps}
