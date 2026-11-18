# Secure UART: synthesis + scan insertion for `top`
# Run from syn/work:   dc_shell -f ../dc_top.tcl | tee dc_top.log
# Outputs:  syn/out/      netlist, ddc, sdc, test protocol
#           syn/reports/  area, cells, timing, scan chain

set RTL_DIR ../../rtl
set OUT_DIR ../out
set RPT_DIR ../reports
file mkdir $OUT_DIR $RPT_DIR

# ---------------------------------------------------------------- libraries
set LIB_DB /opt/PDK/TSMC65/ARM/cln65gplus/sc12_base_rvt/r3p0-00eac0/db/sc12_cln65gplus_base_rvt_tt_typical_max_1p00v_25c.db
set_app_var search_path   ". $RTL_DIR $search_path"
set_app_var target_library $LIB_DB
set_app_var link_library   "* $LIB_DB"

# Tie cells are dont_use by default; allow them so constants become TIEHI/TIELO
# cells instead of 1'b0/1'b1 literals (which Virtuoso import can't place).
remove_attribute [get_lib_cells */TIE*] dont_use

# ---------------------------------------------------------------- read RTL
set RTL_FILES {
    lfsr.sv
    baud_gen.sv
    sync_2ff.sv
    uart_tx.sv
    uart_rx.sv
    sg_cipher.sv
    sec_ctrl.sv
    bist_ctrl.sv
    top.sv
}
analyze -format sverilog $RTL_FILES
elaborate top
current_design top
link
check_design > $RPT_DIR/check_design.rpt

# ---------------------------------------------------------------- constraints
# 1.8432 MHz -> 542.5 ns. Loose I/O budgets; nothing here is timing-critical.
create_clock -name clk -period 543 [get_ports clk]
set_input_delay  50 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 50 -clock clk [all_outputs]

# Hand-routed clock = no CTS, so skew is unknown. Budget 0.5 ns of hold margin
# and let DC insert delay cells (mostly on scan-chain Q->SI hops). Setup has
# hundreds of ns of slack, so this costs nothing but a few cells.
set_clock_uncertainty -hold 0.5 [get_clocks clk]
set_fix_hold [get_clocks clk]

# No assign statements / literal constants in the netlist (clean Virtuoso import)
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

# ---------------------------------------------------------------- scan spec (before compile)
set_scan_configuration -style multiplexed_flip_flop -chain_count 1

# Security: cipher state is the key, and scan_force_rst_q is the scan lock.
# These must stay plain DFFs, never in the chain.
set_scan_element false [get_cells {tx_cipher rx_cipher}]
set_scan_element false [get_cells sec/scan_force_rst_q_reg]

# ---------------------------------------------------------------- compile
# -no_autoungroup / -no_boundary_optimization keep every module and its ports
# intact so the layout can be split by block.
compile_ultra -scan -no_autoungroup -no_boundary_optimization

# ---------------------------------------------------------------- DFT
create_port -direction in  scan_in
create_port -direction out scan_out

set_dft_signal -view existing_dft -type ScanClock  -port clk      -timing {45 55}
set_dft_signal -view spec         -type ScanEnable -port scan_en  -active_state 1
set_dft_signal -view spec         -type ScanDataIn  -port scan_in
set_dft_signal -view spec         -type ScanDataOut -port scan_out
set_scan_path chain0 -view spec -scan_data_in scan_in -scan_data_out scan_out

create_test_protocol
dft_drc                         > $RPT_DIR/dft_drc_pre.rpt
preview_dft                     > $RPT_DIR/preview_dft.rpt
insert_dft
dft_drc -coverage_estimate      > $RPT_DIR/dft_drc_post.rpt

# Re-apply after insert_dft (new nets/ports), then a light incremental pass
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
compile_ultra -scan -incremental -no_autoungroup -no_boundary_optimization

# ---------------------------------------------------------------- reports
report_area      -hierarchy                   > $RPT_DIR/area.rpt
report_reference -hierarchy                   > $RPT_DIR/reference.rpt
report_timing    -delay_type max -max_paths 5 > $RPT_DIR/timing_setup.rpt
report_timing    -delay_type min -max_paths 5 > $RPT_DIR/timing_hold.rpt
report_constraint -all_violators              > $RPT_DIR/violators.rpt
report_scan_path -view existing_dft -chain all > $RPT_DIR/scan_chain.rpt
report_scan_path -view existing_dft -cell  all > $RPT_DIR/scan_cells.rpt

# ---------------------------------------------------------------- write
change_names -rules verilog -hierarchy
set_app_var verilogout_no_tri true
write -format verilog -hierarchy -output $OUT_DIR/top_scan.v
write -format ddc     -hierarchy -output $OUT_DIR/top_scan.ddc
write_sdc                              $OUT_DIR/top_scan.sdc
write_test_protocol -output            $OUT_DIR/top_scan.spf

echo "DONE: netlist at $OUT_DIR/top_scan.v"
exit
