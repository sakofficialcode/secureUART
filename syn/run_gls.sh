#!/bin/bash
# Gate-level sim: tb/top_tb.sv against syn/out/top_scan.v with ARM cell models.
# Run from syn/work:   bash ../run_gls.sh
set -e

QUESTA=/opt/mentor/questa-2024/questasim/bin
CELLS=/opt/PDK/TSMC65/ARM/cln65gplus/sc12_base_rvt/r3p0-00eac0/verilog/sc12_cln65gplus_base_rvt.v

rm -rf gls_lib
$QUESTA/vlib gls_lib
$QUESTA/vlog -work gls_lib -timescale 1ns/1ps "$CELLS" ../out/top_scan.v
$QUESTA/vlog -work gls_lib -sv +define+GLS ../../tb/top_tb.sv
$QUESTA/vsim -c -lib gls_lib top_tb -do "run -all; quit -f" | tee gls.log

grep -qE "^# PASS" gls.log && echo "GLS: PASS" || echo "GLS: FAIL (see gls.log)"
