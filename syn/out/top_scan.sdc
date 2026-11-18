###################################################################

# Created by write_sdc on Wed Nov 18 00:47:19 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
create_clock [get_ports clk]  -period 543  -waveform {0 271.5}
set_clock_uncertainty -hold 0.1  [get_clocks clk]
set_input_delay -clock clk  50  [get_ports rst_n]
set_input_delay -clock clk  50  [get_ports tx_valid]
set_input_delay -clock clk  50  [get_ports {tx_data[7]}]
set_input_delay -clock clk  50  [get_ports {tx_data[6]}]
set_input_delay -clock clk  50  [get_ports {tx_data[5]}]
set_input_delay -clock clk  50  [get_ports {tx_data[4]}]
set_input_delay -clock clk  50  [get_ports {tx_data[3]}]
set_input_delay -clock clk  50  [get_ports {tx_data[2]}]
set_input_delay -clock clk  50  [get_ports {tx_data[1]}]
set_input_delay -clock clk  50  [get_ports {tx_data[0]}]
set_input_delay -clock clk  50  [get_ports uart_rxd]
set_input_delay -clock clk  50  [get_ports key_in]
set_input_delay -clock clk  50  [get_ports key_load]
set_input_delay -clock clk  50  [get_ports key_sel]
set_input_delay -clock clk  50  [get_ports scan_en]
set_input_delay -clock clk  50  [get_ports bist_start]
set_output_delay -clock clk  50  [get_ports tx_ready]
set_output_delay -clock clk  50  [get_ports uart_txd]
set_output_delay -clock clk  50  [get_ports {rx_data[7]}]
set_output_delay -clock clk  50  [get_ports {rx_data[6]}]
set_output_delay -clock clk  50  [get_ports {rx_data[5]}]
set_output_delay -clock clk  50  [get_ports {rx_data[4]}]
set_output_delay -clock clk  50  [get_ports {rx_data[3]}]
set_output_delay -clock clk  50  [get_ports {rx_data[2]}]
set_output_delay -clock clk  50  [get_ports {rx_data[1]}]
set_output_delay -clock clk  50  [get_ports {rx_data[0]}]
set_output_delay -clock clk  50  [get_ports rx_valid]
set_output_delay -clock clk  50  [get_ports rx_err]
set_output_delay -clock clk  50  [get_ports bist_done]
set_output_delay -clock clk  50  [get_ports bist_pass]
