/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7-1
// Date      : Wed Nov 18 00:47:19 2026
/////////////////////////////////////////////////////////////


module baud_gen_test_1 ( VDD, VSS, clk, rst_n, bit_tick, test_si, test_so, test_se );
  inout VDD, VSS;
  input clk, rst_n, test_si, test_se;
  output bit_tick, test_so;
  wire   counter_2_, counter_1_, counter_0_, N7, N8, N9, N10, n1, n2, n3, n4,
         n5;

  SDFFQ_X1M_A12TR counter_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N7), .SI(test_si), .SE(test_se), .CK(clk), .Q(counter_0_) );
  SDFFQ_X1M_A12TR counter_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N8), .SI(counter_0_), .SE(test_se), .CK(
        clk), .Q(counter_1_) );
  SDFFQ_X1M_A12TR counter_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N9), .SI(counter_1_), .SE(test_se), .CK(
        clk), .Q(counter_2_) );
  SDFFQ_X1M_A12TR counter_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N10), .SI(counter_2_), .SE(test_se), 
        .CK(clk), .Q(test_so) );
  NAND3_X0P5A_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(counter_0_), .B(counter_1_), .C(counter_2_), .Y(n3) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(test_so), .Y(n2) );
  NOR2_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n3), .B(n2), .Y(bit_tick) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .Y(n1) );
  NOR2_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(counter_0_), .B(n1), .Y(N7) );
  AOI211_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n3), .A1(n2), .B0(bit_tick), .C0(n1), .Y(N10) );
  NAND2_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(counter_0_), .B(counter_1_), .Y(n5) );
  INV_X0P5B_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n5), .Y(n4) );
  OA211_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n4), .A1(counter_2_), .B0(n3), .C0(rst_n), .Y(N9) );
  OA211_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(counter_0_), .A1(counter_1_), .B0(rst_n), .C0(n5), .Y(N8) );
endmodule


module uart_tx_test_1 ( VDD, VSS, clk, rst_n, tx_valid, tx_data, bit_tick, ks_bit, 
        tx_keyed, tx_ready, ks_consume, txd, test_si, test_se );
  inout VDD, VSS;
  input [7:0] tx_data;
  input clk, rst_n, tx_valid, bit_tick, ks_bit, tx_keyed, test_si, test_se;
  output tx_ready, ks_consume, txd;
  wire   n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n37, n38;
  wire   [1:0] state_q;
  wire   [2:0] bit_cnt_q;
  wire   [7:0] data_reg_q;

  SDFFQ_X1M_A12TR bit_cnt_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n59), .SI(test_si), .SE(test_se), .CK(
        clk), .Q(bit_cnt_q[0]) );
  SDFFQ_X1M_A12TR state_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n57), .SI(data_reg_q[7]), .SE(test_se), 
        .CK(clk), .Q(state_q[0]) );
  SDFFQ_X1M_A12TR state_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n61), .SI(state_q[0]), .SE(test_se), 
        .CK(clk), .Q(state_q[1]) );
  SDFFQ_X1M_A12TR bit_cnt_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n58), .SI(bit_cnt_q[0]), .SE(test_se), 
        .CK(clk), .Q(bit_cnt_q[1]) );
  SDFFQ_X1M_A12TR bit_cnt_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n60), .SI(bit_cnt_q[1]), .SE(test_se), 
        .CK(clk), .Q(bit_cnt_q[2]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n56), .SI(data_reg_q[6]), .SE(test_se), .CK(clk), .Q(data_reg_q[7]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n55), .SI(data_reg_q[5]), .SE(test_se), .CK(clk), .Q(data_reg_q[6]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n54), .SI(data_reg_q[4]), .SE(test_se), .CK(clk), .Q(data_reg_q[5]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n53), .SI(data_reg_q[3]), .SE(test_se), .CK(clk), .Q(data_reg_q[4]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n52), .SI(data_reg_q[2]), .SE(test_se), .CK(clk), .Q(data_reg_q[3]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n63), .SI(bit_cnt_q[2]), .SE(test_se), 
        .CK(clk), .Q(data_reg_q[0]) );
  SDFFQ_X1M_A12TR txd_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n62), .SI(state_q[1]), .SE(test_se), .CK(clk), 
        .Q(txd) );
  SDFFQ_X0P5M_A12TR data_reg_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n51), .SI(data_reg_q[1]), .SE(
        test_se), .CK(clk), .Q(data_reg_q[2]) );
  NOR2_X1P4M_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n27), .B(n33), .Y(n25) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_tick), .Y(n34) );
  INV_X0P5B_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .Y(n10) );
  NOR2_X0P5M_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n34), .B(n10), .Y(n2) );
  INV_X0P5B_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[1]), .Y(n26) );
  INV_X0P5B_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[0]), .Y(n29) );
  NAND2_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n26), .B(n29), .Y(n32) );
  NAND2_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[1]), .B(state_q[0]), .Y(n33) );
  AOI21_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(tx_valid), .A1(tx_keyed), .B0(state_q[1]), .Y(n1) );
  OA21_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n1), .A1(n34), .B0(rst_n), .Y(n23) );
  AOI31_X1M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n2), .A1(n32), .A2(n33), .B0(n23), .Y(n35) );
  INV_X0P5B_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n2), .Y(n27) );
  NOR3_X1P4A_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n23), .B(n32), .C(n27), .Y(n38) );
  AOI22_X0P5M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[3]), .B0(n25), .B1(
        data_reg_q[4]), .Y(n3) );
  OAI2XB1_X0P5M_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[3]), .A0(n35), .B0(n3), .Y(n52) );
  AOI22_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[1]), .B0(n25), .B1(
        data_reg_q[2]), .Y(n4) );
  OAI2XB1_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[1]), .A0(n35), .B0(n4), .Y(n50) );
  AOI22_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[6]), .B0(n25), .B1(
        data_reg_q[7]), .Y(n5) );
  OAI2XB1_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[6]), .A0(n35), .B0(n5), .Y(n55) );
  AOI22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[0]), .B0(data_reg_q[1]), .B1(
        n25), .Y(n6) );
  OAI2XB1_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[0]), .A0(n35), .B0(n6), .Y(n63) );
  AOI22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[4]), .B0(n25), .B1(
        data_reg_q[5]), .Y(n7) );
  OAI2XB1_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[4]), .A0(n35), .B0(n7), .Y(n53) );
  AOI22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[5]), .B0(n25), .B1(
        data_reg_q[6]), .Y(n8) );
  OAI2XB1_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[5]), .A0(n35), .B0(n8), .Y(n54) );
  AOI22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[2]), .B0(n25), .B1(
        data_reg_q[3]), .Y(n9) );
  OAI2XB1_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(data_reg_q[2]), .A0(n35), .B0(n9), .Y(n51) );
  AOI21_X0P5M_A12TR U31 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(txd), .A1(n34), .B0(n10), .Y(n13) );
  NAND2_X0P5M_A12TR U32 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(data_reg_q[0]), .B(ks_bit), .Y(n11) );
  OAI211_X0P5M_A12TR U33 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(data_reg_q[0]), .A1(ks_bit), .B0(state_q[1]), 
        .C0(n11), .Y(n12) );
  AOI32_X0P5M_A12TR U34 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state_q[0]), .A1(n13), .A2(n12), .B0(n27), .B1(
        n13), .Y(n62) );
  OAI21_X0P5M_A12TR U35 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n29), .A1(n34), .B0(rst_n), .Y(n22) );
  INV_X0P5B_A12TR U36 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .Y(n16) );
  NAND3_X0P5A_A12TR U37 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .B(bit_cnt_q[1]), .C(bit_cnt_q[2]), .Y(n17)
         );
  NAND2_X0P5M_A12TR U38 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .B(bit_cnt_q[0]), .Y(n14) );
  OAI211_X0P5M_A12TR U39 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_cnt_q[1]), .A1(bit_cnt_q[0]), .B0(n25), 
        .C0(n14), .Y(n15) );
  OAI211_X0P5M_A12TR U40 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n22), .A1(n16), .B0(n17), .C0(n15), .Y(n58) );
  INV_X0P5B_A12TR U41 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .Y(n21) );
  INV_X0P5B_A12TR U42 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[0]), .Y(n18) );
  OAI221_X0P5M_A12TR U43 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_cnt_q[0]), .A1(n21), .B0(n18), .B1(n22), 
        .C0(n17), .Y(n59) );
  NAND3_X0P5A_A12TR U44 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .B(bit_cnt_q[1]), .C(bit_cnt_q[0]), .Y(n20)
         );
  INV_X0P5B_A12TR U45 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[2]), .Y(n19) );
  AOI22_X0P5M_A12TR U46 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n22), .A1(n21), .B0(n20), .B1(n19), .Y(n60) );
  NAND3_X0P5A_A12TR U47 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .B(bit_cnt_q[0]), .C(bit_cnt_q[2]), 
        .Y(n24) );
  AOI21_X0P5M_A12TR U48 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n25), .A1(n24), .B0(n23), .Y(n30) );
  OAI22_X0P5M_A12TR U49 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n30), .A1(n26), .B0(n29), .B1(n27), .Y(n61) );
  NAND2_X0P5M_A12TR U50 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n26), .B(n30), .Y(n28) );
  OAI22_X0P5M_A12TR U51 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n30), .A1(n29), .B0(n28), .B1(n27), .Y(n57) );
  INV_X0P5B_A12TR U52 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(tx_keyed), .Y(n31) );
  NOR3_X0P5A_A12TR U53 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n32), .B(n34), .C(n31), .Y(tx_ready) );
  NOR2_X0P5M_A12TR U54 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n34), .B(n33), .Y(ks_consume) );
  INV_X0P5B_A12TR U55 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n35), .Y(n37) );
  AO22_X0P5M_A12TR U56 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(tx_data[7]), .B0(data_reg_q[7]), .B1(
        n37), .Y(n56) );
  SDFFQ_X0P5M_A12TR data_reg_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n50), .SI(data_reg_q[0]), .SE(
        test_se), .CK(clk), .Q(data_reg_q[1]) );
endmodule


module sync_2ff_test_1 ( VDD, VSS, clk, rst_n, d, q, test_si, test_so, test_se );
  inout VDD, VSS;
  input clk, rst_n, d, test_si, test_se;
  output q, test_so;
  wire   n4, n1;

  A2SDFFQ_X0P5M_A12TR q2_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .B(n4), .A(rst_n), .SI(n4), .SE(test_se), .CK(
        clk), .Q(test_so) );
  A2SDFFQ_X0P5M_A12TR q1_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .B(rst_n), .A(n1), .SI(test_si), .SE(test_se), 
        .CK(clk), .Q(n4) );
  INV_X0P5B_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(d), .Y(n1) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(test_so), .Y(q) );
endmodule


module uart_rx_test_1 ( VDD, VSS, clk, rst_n, rx_in, ks_bit, rx_data, rx_valid, rx_err, 
        ks_consume, test_si2, test_si1, test_so1, test_se );
  inout VDD, VSS;
  output [7:0] rx_data;
  input clk, rst_n, rx_in, ks_bit, test_si2, test_si1, test_se;
  output rx_valid, rx_err, ks_consume, test_so1;
  wire   state_q_0_, N75, N76, N77, N78, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40;
  wire   [2:0] bit_cnt_q;
  wire   [3:0] phase_cnt_q;

  SDFFQ_X1M_A12TR phase_cnt_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N75), .SI(rx_data[6]), .SE(test_se), 
        .CK(clk), .Q(phase_cnt_q[0]) );
  SDFFQ_X1M_A12TR bit_cnt_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n60), .SI(bit_cnt_q[1]), .SE(test_se), 
        .CK(clk), .Q(bit_cnt_q[2]) );
  SDFFQ_X1M_A12TR state_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n70), .SI(phase_cnt_q[3]), .SE(test_se), 
        .CK(clk), .Q(state_q_0_) );
  SDFFQ_X1M_A12TR state_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n71), .SI(state_q_0_), .SE(test_se), 
        .CK(clk), .Q(test_so1) );
  SDFFQ_X1M_A12TR phase_cnt_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N76), .SI(phase_cnt_q[0]), .SE(
        test_se), .CK(clk), .Q(phase_cnt_q[1]) );
  SDFFQ_X1M_A12TR phase_cnt_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N77), .SI(phase_cnt_q[1]), .SE(
        test_se), .CK(clk), .Q(phase_cnt_q[2]) );
  SDFFQ_X1M_A12TR phase_cnt_q_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N78), .SI(phase_cnt_q[2]), .SE(
        test_se), .CK(clk), .Q(phase_cnt_q[3]) );
  SDFFQ_X1M_A12TR bit_cnt_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n62), .SI(test_si1), .SE(test_se), 
        .CK(clk), .Q(bit_cnt_q[0]) );
  SDFFQ_X1M_A12TR bit_cnt_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n61), .SI(bit_cnt_q[0]), .SE(test_se), 
        .CK(clk), .Q(bit_cnt_q[1]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n64), .SI(rx_data[4]), .SE(test_se), 
        .CK(clk), .Q(rx_data[5]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n65), .SI(rx_data[3]), .SE(test_se), 
        .CK(clk), .Q(rx_data[4]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n66), .SI(rx_data[2]), .SE(test_se), 
        .CK(clk), .Q(rx_data[3]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n67), .SI(rx_data[1]), .SE(test_se), 
        .CK(clk), .Q(rx_data[2]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n68), .SI(rx_data[0]), .SE(test_se), 
        .CK(clk), .Q(rx_data[1]) );
  SDFFQ_X1M_A12TR data_reg_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n72), .SI(bit_cnt_q[2]), .SE(test_se), 
        .CK(clk), .Q(rx_data[0]) );
  SDFFQ_X0P5M_A12TR data_reg_q_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n69), .SI(test_si2), .SE(test_se), 
        .CK(clk), .Q(rx_data[7]) );
  NAND2_X0P5M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(phase_cnt_q[0]), .B(phase_cnt_q[1]), .Y(n33) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(phase_cnt_q[2]), .Y(n19) );
  NOR2_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n33), .B(n19), .Y(n21) );
  NAND3_X0P5A_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(test_so1), .B(n21), .C(phase_cnt_q[3]), .Y(n1) );
  NOR2_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q_0_), .B(n1), .Y(ks_consume) );
  INV_X0P5B_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rx_in), .Y(n37) );
  INV_X0P5B_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n1), .Y(n4) );
  NAND2_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q_0_), .B(n4), .Y(n31) );
  NOR2_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n31), .Y(rx_valid) );
  NAND3_X0P5A_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(test_so1), .C(n1), .Y(n6) );
  INV_X0P5B_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q_0_), .Y(n12) );
  AOI21_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(rx_in), .A1(n12), .B0(test_so1), .Y(n3) );
  INV_X0P5B_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n21), .Y(n10) );
  NOR2_X0P7M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(phase_cnt_q[3]), .B(n10), .Y(n13) );
  NAND3_X0P5A_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .B(bit_cnt_q[0]), .C(bit_cnt_q[2]), 
        .Y(n20) );
  OAI222_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(test_so1), .A1(n13), .B0(test_so1), .B1(
        state_q_0_), .C0(state_q_0_), .C1(n20), .Y(n2) );
  OAI211_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n4), .A1(n3), .B0(rst_n), .C0(n2), .Y(n5) );
  OAI21_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n6), .A1(n12), .B0(n5), .Y(n70) );
  AOI21_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n13), .A1(n37), .B0(n12), .Y(n8) );
  INV_X0P5B_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(test_so1), .Y(n9) );
  NAND2_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n12), .B(n9), .Y(n15) );
  NAND2_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(n15), .Y(n7) );
  OAI21_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n8), .A1(n7), .B0(n6), .Y(n71) );
  NAND2_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n13), .B(n9), .Y(n14) );
  OAI211_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(rx_in), .A1(n14), .B0(rst_n), .C0(n15), .Y(n32)
         );
  AOI21_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n10), .A1(phase_cnt_q[3]), .B0(n13), .Y(n11) );
  NOR2_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n32), .B(n11), .Y(N78) );
  NOR2_X0P5M_A12TR U31 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(phase_cnt_q[0]), .B(n32), .Y(N75) );
  NAND2_X0P5M_A12TR U32 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(ks_consume), .Y(n25) );
  NAND2_X0P5M_A12TR U33 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .B(bit_cnt_q[0]), .Y(n18) );
  NAND2_X0P5M_A12TR U34 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n12), .B(rst_n), .Y(n27) );
  AOI22_X0P5M_A12TR U35 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state_q_0_), .A1(n14), .B0(n13), .B1(rx_in), .Y(
        n16) );
  INV_X0P5B_A12TR U36 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .Y(n35) );
  AOI21_X0P5M_A12TR U37 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n16), .A1(n15), .B0(n35), .Y(n23) );
  OAI2XB1_X0P5M_A12TR U38 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A1N(n27), .A0(n23), .B0(bit_cnt_q[2]), .Y(n17) );
  OAI21_X0P5M_A12TR U39 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n25), .A1(n18), .B0(n17), .Y(n60) );
  AOI211_X0P5M_A12TR U40 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n33), .A1(n19), .B0(n21), .C0(n32), .Y(N77) );
  AOI31_X0P5M_A12TR U41 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(phase_cnt_q[3]), .A1(n21), .A2(n20), .B0(n27), 
        .Y(n22) );
  NOR2_X0P5M_A12TR U42 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n23), .B(n22), .Y(n26) );
  INV_X0P5B_A12TR U43 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[0]), .Y(n24) );
  AOI22_X0P5M_A12TR U44 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_cnt_q[0]), .A1(n26), .B0(n25), .B1(n24), .Y(
        n62) );
  INV_X0P5B_A12TR U45 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bit_cnt_q[1]), .Y(n29) );
  INV_X0P5B_A12TR U46 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .Y(n40) );
  OAI21_X0P5M_A12TR U47 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_cnt_q[0]), .A1(n27), .B0(n26), .Y(n28) );
  AOI32_X0P5M_A12TR U48 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_cnt_q[0]), .A1(n29), .A2(n40), .B0(
        bit_cnt_q[1]), .B1(n28), .Y(n30) );
  INV_X0P5B_A12TR U49 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n30), .Y(n61) );
  NOR2_X0P5M_A12TR U50 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rx_in), .B(n31), .Y(rx_err) );
  INV_X0P5B_A12TR U51 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n32), .Y(n34) );
  OA211_X0P5M_A12TR U52 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(phase_cnt_q[0]), .A1(phase_cnt_q[1]), .B0(n34), 
        .C0(n33), .Y(N76) );
  NOR2_X1M_A12TR U53 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(ks_consume), .B(n35), .Y(n38) );
  AO22_X0P5M_A12TR U54 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[7]), .B0(n38), .B1(rx_data[6]), 
        .Y(n63) );
  AO22_X0P5M_A12TR U55 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[6]), .B0(n38), .B1(rx_data[5]), 
        .Y(n64) );
  AO22_X0P5M_A12TR U56 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[3]), .B0(n38), .B1(rx_data[2]), 
        .Y(n67) );
  AO22_X0P5M_A12TR U57 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[2]), .B0(n38), .B1(rx_data[1]), 
        .Y(n68) );
  AO22_X0P5M_A12TR U58 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[4]), .B0(n38), .B1(rx_data[3]), 
        .Y(n66) );
  AO22_X0P5M_A12TR U59 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[1]), .B0(n38), .B1(rx_data[0]), 
        .Y(n72) );
  AO22_X0P5M_A12TR U60 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(rx_data[5]), .B0(n38), .B1(rx_data[4]), 
        .Y(n65) );
  INV_X0P5B_A12TR U61 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(ks_bit), .Y(n36) );
  OAI22_X0P5M_A12TR U62 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n37), .A1(ks_bit), .B0(n36), .B1(rx_in), .Y(n39)
         );
  AO22_X0P5M_A12TR U63 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n40), .A1(n39), .B0(n38), .B1(rx_data[7]), .Y(n69) );
  SDFFQ_X0P5M_A12TR data_reg_q_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n63), .SI(rx_data[5]), .SE(test_se), 
        .CK(clk), .Q(rx_data[6]) );
endmodule


module sec_ctrl ( VDD, VSS, clk, rst_n, key_in, key_load, key_sel, scan_en, bist_clr, 
        tx_key_load, rx_key_load, key_bit, sec_clr );
  inout VDD, VSS;
  input clk, rst_n, key_in, key_load, key_sel, scan_en, bist_clr;
  output tx_key_load, rx_key_load, key_bit, sec_clr;
  wire   scan_force_rst_q, N3;

  DFFQ_X0P5M_A12TR scan_force_rst_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(N3), .CK(clk), .Q(
        scan_force_rst_q) );
  NOR2XB_X1M_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .BN(key_load), .A(key_sel), .Y(tx_key_load) );
  AND2_X0P5M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(key_load), .B(key_sel), .Y(rx_key_load) );
  BUF_X0P7B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(key_in), .Y(key_bit) );
  OR3_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(scan_en), .B(scan_force_rst_q), .C(bist_clr), .Y(
        sec_clr) );
  OA21_X0P5M_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(scan_en), .A1(scan_force_rst_q), .B0(rst_n), .Y(N3) );
endmodule


module lfsr_17_12000_1c94b_1 ( VDD, VSS, clk, rst_n, clr, load_en, load_bit, step, out, 
        state );
  inout VDD, VSS;
  output [16:0] state;
  input clk, rst_n, clr, load_en, load_bit, step;
  output out;
  wire   n2, n3, n4, n5, n6, n7, n8, n10, n15, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n1, n9, n11, n12, n13, n14, n16, n26, n27;

  DFFQ_X0P5M_A12TR state_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n25), .CK(clk), .Q(state[0]) );
  A2DFFQN_X0P5M_A12TR state_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n10), .CK(clk), .QN(state[1])
         );
  DFFQ_X0P5M_A12TR state_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n24), .CK(clk), .Q(state[2]) );
  A2DFFQN_X0P5M_A12TR state_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n8), .CK(clk), .QN(state[3])
         );
  DFFQ_X0P5M_A12TR state_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n23), .CK(clk), .Q(state[4]) );
  DFFQ_X0P5M_A12TR state_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n22), .CK(clk), .Q(state[5]) );
  A2DFFQN_X0P5M_A12TR state_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n7), .CK(clk), .QN(state[6])
         );
  DFFQ_X0P5M_A12TR state_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n21), .CK(clk), .Q(state[7]) );
  A2DFFQN_X0P5M_A12TR state_reg_8_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n6), .CK(clk), .QN(state[8])
         );
  DFFQ_X0P5M_A12TR state_reg_9_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n20), .CK(clk), .Q(state[9]) );
  DFFQ_X0P5M_A12TR state_reg_10_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n19), .CK(clk), .Q(state[10]) );
  A2DFFQN_X0P5M_A12TR state_reg_11_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n5), .CK(clk), .QN(state[11]) );
  DFFQ_X0P5M_A12TR state_reg_12_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n18), .CK(clk), .Q(state[12]) );
  DFFQ_X0P5M_A12TR state_reg_13_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n17), .CK(clk), .Q(state[13]) );
  A2DFFQN_X0P5M_A12TR state_reg_14_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n4), .CK(clk), .QN(state[14]) );
  A2DFFQN_X0P5M_A12TR state_reg_15_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n3), .CK(clk), .QN(state[15]) );
  A2DFFQN_X0P5M_A12TR state_reg_16_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n2), .CK(clk), .QN(out) );
  NOR2_X2M_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n9), .B(n12), .Y(n11) );
  BUF_X0P7B_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(state[16]) );
  NAND2B_X0P5M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(clr), .B(rst_n), .Y(n12) );
  NOR3_X0P5A_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .B(load_en), .C(n12), .Y(n1) );
  BUF_X0P8B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n1), .Y(n27) );
  NOR2_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .B(load_en), .Y(n9) );
  AOI22_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[8]), .B0(n11), .B1(state[7]), .Y(
        n6) );
  AOI22_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[1]), .B0(state[0]), .B1(n11), 
        .Y(n10) );
  AOI22_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[6]), .B0(n11), .B1(state[5]), 
        .Y(n7) );
  AOI22_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[15]), .B0(n11), .B1(state[14]), 
        .Y(n3) );
  AOI22_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[3]), .B0(n11), .B1(state[2]), 
        .Y(n8) );
  AOI22_X0P5M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[11]), .B0(n11), .B1(state[10]), 
        .Y(n5) );
  AOI22_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[14]), .B0(state[13]), .B1(n11), 
        .Y(n4) );
  AOI22_X0P5M_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(out), .B0(n11), .B1(state[15]), .Y(n2)
         );
  INV_X0P5B_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n12), .Y(n15) );
  INV_X0P5B_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(n14) );
  INV_X0P5B_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[13]), .Y(n13) );
  OAI221_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(state[13]), .B0(n14), .B1(n13), .C0(
        step), .Y(n26) );
  AOI22_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(load_en), .A1(load_bit), .B0(n27), .B1(state[0]), 
        .Y(n16) );
  OAI211_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(load_en), .A1(n26), .B0(n15), .C0(n16), .Y(n25)
         );
  AO22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[13]), .B0(n11), .B1(state[12]), 
        .Y(n17) );
  AO22_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[5]), .B0(n11), .B1(state[4]), .Y(
        n22) );
  AO22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[4]), .B0(n11), .B1(state[3]), .Y(
        n23) );
  AO22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[10]), .B0(n11), .B1(state[9]), 
        .Y(n19) );
  AO22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[9]), .B0(n11), .B1(state[8]), .Y(
        n20) );
  AO22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[7]), .B0(n11), .B1(state[6]), .Y(
        n21) );
  AO22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[2]), .B0(n11), .B1(state[1]), .Y(
        n24) );
  AO22_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[12]), .B0(n11), .B1(state[11]), 
        .Y(n18) );
endmodule


module lfsr_15_6000_70ae_1 ( VDD, VSS, clk, rst_n, clr, load_en, load_bit, step, out, 
        state );
  inout VDD, VSS;
  output [14:0] state;
  input clk, rst_n, clr, load_en, load_bit, step;
  output out;
  wire   n3, n4, n5, n6, n7, n8, n9, n11, n14, n17, n18, n19, n20, n21, n22,
         n23, n1, n2, n10, n12, n13, n15, n16, n24, n25, n26, n27;

  DFFQ_X0P5M_A12TR state_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n23), .CK(clk), .Q(state[0]) );
  A2DFFQN_X0P5M_A12TR state_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n11), .CK(clk), .QN(state[1])
         );
  A2DFFQN_X0P5M_A12TR state_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n9), .CK(clk), .QN(state[2])
         );
  A2DFFQN_X0P5M_A12TR state_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n8), .CK(clk), .QN(state[3])
         );
  DFFQ_X0P5M_A12TR state_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n22), .CK(clk), .Q(state[4]) );
  A2DFFQN_X0P5M_A12TR state_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n7), .CK(clk), .QN(state[5])
         );
  DFFQ_X0P5M_A12TR state_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n21), .CK(clk), .Q(state[6]) );
  A2DFFQN_X0P5M_A12TR state_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n6), .CK(clk), .QN(state[7])
         );
  DFFQ_X0P5M_A12TR state_reg_8_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n20), .CK(clk), .Q(state[8]) );
  DFFQ_X0P5M_A12TR state_reg_9_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n19), .CK(clk), .Q(state[9]) );
  DFFQ_X0P5M_A12TR state_reg_10_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n18), .CK(clk), .Q(state[10]) );
  DFFQ_X0P5M_A12TR state_reg_11_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n17), .CK(clk), .Q(state[11]) );
  A2DFFQN_X0P5M_A12TR state_reg_12_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n5), .CK(clk), .QN(state[12]) );
  A2DFFQN_X0P5M_A12TR state_reg_13_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n4), .CK(clk), .QN(state[13]) );
  A2DFFQN_X0P5M_A12TR state_reg_14_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n3), .CK(clk), .QN(out) );
  BUF_X0P7B_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(state[14]) );
  NOR2XB_X1M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .BN(rst_n), .A(clr), .Y(n14) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .Y(n24) );
  INV_X0P5B_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(load_en), .Y(n12) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[13]), .Y(n2) );
  INV_X0P5B_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(n1) );
  AOI22_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(state[13]), .B0(n2), .B1(n1), .Y(n10)
         );
  AOI32_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n12), .A2(n10), .B0(load_en), .B1(
        load_bit), .Y(n15) );
  NOR2_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(load_en), .B(step), .Y(n25) );
  NAND2_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n25), .Y(n16) );
  INV_X0P5B_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[0]), .Y(n13) );
  OAI22_X0P5M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n24), .A1(n15), .B0(n16), .B1(n13), .Y(n23) );
  INV_X0P7B_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n16), .Y(n27) );
  NOR2_X1P4M_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .B(n24), .Y(n26) );
  AOI22_X0P5M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[5]), .B0(n26), .B1(state[4]), 
        .Y(n7) );
  AOI22_X0P5M_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[1]), .B0(state[0]), .B1(n26), 
        .Y(n11) );
  AOI22_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[12]), .B0(n26), .B1(state[11]), 
        .Y(n5) );
  AOI22_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(n27), .B0(state[13]), .B1(n26), .Y(n3)
         );
  AOI22_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state[13]), .A1(n27), .B0(n26), .B1(state[12]), 
        .Y(n4) );
  AOI22_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[3]), .B0(n26), .B1(state[2]), 
        .Y(n8) );
  AOI22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[2]), .B0(n26), .B1(state[1]), 
        .Y(n9) );
  AOI22_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[7]), .B0(n26), .B1(state[6]), 
        .Y(n6) );
  AO22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[8]), .B0(n26), .B1(state[7]), .Y(
        n20) );
  AO22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[10]), .B0(n26), .B1(state[9]), 
        .Y(n18) );
  AO22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[9]), .B0(n26), .B1(state[8]), .Y(
        n19) );
  AO22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[11]), .B0(n26), .B1(state[10]), 
        .Y(n17) );
  AO22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[6]), .B0(n26), .B1(state[5]), .Y(
        n21) );
  AO22_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[4]), .B0(n26), .B1(state[3]), .Y(
        n22) );
endmodule


module sg_cipher_1 ( VDD, VSS, clk, rst_n, clr, key_load, key_in, ks_consume, ks_bit, 
        ks_ready, keyed );
  inout VDD, VSS;
  input clk, rst_n, clr, key_load, key_in, ks_consume;
  output ks_bit, ks_ready, keyed;
  wire   step, a_out, s_out, n1, n12, n13, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8,
         SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10,
         SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12,
         SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14,
         SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16,
         SYNOPSYS_UNCONNECTED_17, SYNOPSYS_UNCONNECTED_18,
         SYNOPSYS_UNCONNECTED_19, SYNOPSYS_UNCONNECTED_20,
         SYNOPSYS_UNCONNECTED_21, SYNOPSYS_UNCONNECTED_22,
         SYNOPSYS_UNCONNECTED_23, SYNOPSYS_UNCONNECTED_24,
         SYNOPSYS_UNCONNECTED_25, SYNOPSYS_UNCONNECTED_26,
         SYNOPSYS_UNCONNECTED_27, SYNOPSYS_UNCONNECTED_28,
         SYNOPSYS_UNCONNECTED_29, SYNOPSYS_UNCONNECTED_30,
         SYNOPSYS_UNCONNECTED_31, SYNOPSYS_UNCONNECTED_32;

  DFFQ_X0P5M_A12TR keyed_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n12), .CK(clk), .Q(keyed) );
  DFFQ_X0P5M_A12TR ks_bit_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n13), .CK(clk), .Q(ks_bit) );
  DFFQ_X0P5M_A12TR ks_ready_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n10), .CK(clk), .Q(n1) );
  INV_X0P5B_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(key_load), .Y(n2) );
  OAI21_X0P5M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n1), .A1(ks_consume), .B0(n2), .Y(n4) );
  NOR2_X0P7M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(clr), .B(n4), .Y(step) );
  NOR2_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n1), .B(ks_consume), .Y(n3) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .Y(n5) );
  NOR2_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(clr), .B(n5), .Y(n9) );
  AND3_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(step), .C(s_out), .Y(n8) );
  AOI31_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n3), .A1(n9), .A2(n2), .B0(n8), .Y(n10) );
  INV_X0P5B_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n4), .Y(n6) );
  AOI211_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n6), .A1(s_out), .B0(clr), .C0(n5), .Y(n7) );
  AO22_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(a_out), .A1(n8), .B0(ks_bit), .B1(n7), .Y(n13) );
  INV_X0P5B_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n1), .Y(ks_ready) );
  OA21_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(key_load), .A1(keyed), .B0(n9), .Y(n12) );
  lfsr_17_12000_1c94b_1 A ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(clr), .load_en(
        key_load), .load_bit(key_in), .step(step), .out(a_out), .state({
        SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, 
        SYNOPSYS_UNCONNECTED_4, SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6, 
        SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8, SYNOPSYS_UNCONNECTED_9, 
        SYNOPSYS_UNCONNECTED_10, SYNOPSYS_UNCONNECTED_11, 
        SYNOPSYS_UNCONNECTED_12, SYNOPSYS_UNCONNECTED_13, 
        SYNOPSYS_UNCONNECTED_14, SYNOPSYS_UNCONNECTED_15, 
        SYNOPSYS_UNCONNECTED_16, SYNOPSYS_UNCONNECTED_17}) );
  lfsr_15_6000_70ae_1 S ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(clr), .load_en(
        key_load), .load_bit(a_out), .step(step), .out(s_out), .state({
        SYNOPSYS_UNCONNECTED_18, SYNOPSYS_UNCONNECTED_19, 
        SYNOPSYS_UNCONNECTED_20, SYNOPSYS_UNCONNECTED_21, 
        SYNOPSYS_UNCONNECTED_22, SYNOPSYS_UNCONNECTED_23, 
        SYNOPSYS_UNCONNECTED_24, SYNOPSYS_UNCONNECTED_25, 
        SYNOPSYS_UNCONNECTED_26, SYNOPSYS_UNCONNECTED_27, 
        SYNOPSYS_UNCONNECTED_28, SYNOPSYS_UNCONNECTED_29, 
        SYNOPSYS_UNCONNECTED_30, SYNOPSYS_UNCONNECTED_31, 
        SYNOPSYS_UNCONNECTED_32}) );
endmodule


module lfsr_17_12000_1c94b_0 ( VDD, VSS, clk, rst_n, clr, load_en, load_bit, step, out, 
        state );
  inout VDD, VSS;
  output [16:0] state;
  input clk, rst_n, clr, load_en, load_bit, step;
  output out;
  wire   n1, n9, n11, n12, n13, n14, n16, n26, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45;

  DFFQ_X0P5M_A12TR state_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n28), .CK(clk), .Q(state[0]) );
  A2DFFQN_X0P5M_A12TR state_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n38), .CK(clk), .QN(state[1])
         );
  DFFQ_X0P5M_A12TR state_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n29), .CK(clk), .Q(state[2]) );
  A2DFFQN_X0P5M_A12TR state_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n39), .CK(clk), .QN(state[3])
         );
  DFFQ_X0P5M_A12TR state_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n30), .CK(clk), .Q(state[4]) );
  DFFQ_X0P5M_A12TR state_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n31), .CK(clk), .Q(state[5]) );
  A2DFFQN_X0P5M_A12TR state_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n40), .CK(clk), .QN(state[6])
         );
  DFFQ_X0P5M_A12TR state_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n32), .CK(clk), .Q(state[7]) );
  A2DFFQN_X0P5M_A12TR state_reg_8_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n41), .CK(clk), .QN(state[8])
         );
  DFFQ_X0P5M_A12TR state_reg_9_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n33), .CK(clk), .Q(state[9]) );
  DFFQ_X0P5M_A12TR state_reg_10_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n34), .CK(clk), .Q(state[10]) );
  A2DFFQN_X0P5M_A12TR state_reg_11_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n42), .CK(clk), .QN(
        state[11]) );
  DFFQ_X0P5M_A12TR state_reg_12_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n35), .CK(clk), .Q(state[12]) );
  DFFQ_X0P5M_A12TR state_reg_13_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n36), .CK(clk), .Q(state[13]) );
  A2DFFQN_X0P5M_A12TR state_reg_14_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n43), .CK(clk), .QN(
        state[14]) );
  A2DFFQN_X0P5M_A12TR state_reg_15_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n44), .CK(clk), .QN(
        state[15]) );
  A2DFFQN_X0P5M_A12TR state_reg_16_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n37), .B(n45), .CK(clk), .QN(out) );
  NOR2_X2M_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(n13), .Y(n16) );
  BUF_X0P7B_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(state[16]) );
  NAND2B_X0P5M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(clr), .B(rst_n), .Y(n13) );
  INV_X0P5B_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n13), .Y(n37) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(n9) );
  INV_X0P5B_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[13]), .Y(n1) );
  OAI221_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(state[13]), .B0(n9), .B1(n1), .C0(step), .Y(n12) );
  NOR3_X3M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .B(load_en), .C(n13), .Y(n26) );
  AOI22_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(load_en), .A1(load_bit), .B0(n26), .B1(state[0]), 
        .Y(n11) );
  OAI211_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(load_en), .A1(n12), .B0(n37), .C0(n11), .Y(n28)
         );
  NOR2_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .B(load_en), .Y(n14) );
  AOI22_X0P5M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[6]), .B0(n16), .B1(state[5]), 
        .Y(n40) );
  AOI22_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[8]), .B0(n16), .B1(state[7]), 
        .Y(n41) );
  AOI22_X0P5M_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[3]), .B0(n16), .B1(state[2]), 
        .Y(n39) );
  AOI22_X0P5M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[11]), .B0(n16), .B1(state[10]), 
        .Y(n42) );
  AOI22_X0P5M_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[14]), .B0(state[13]), .B1(n16), 
        .Y(n43) );
  AOI22_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[1]), .B0(state[0]), .B1(n16), 
        .Y(n38) );
  AOI22_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[15]), .B0(n16), .B1(state[14]), 
        .Y(n44) );
  AOI22_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(out), .B0(n16), .B1(state[15]), .Y(n45) );
  AO22_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[13]), .B0(n16), .B1(state[12]), 
        .Y(n36) );
  AO22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[12]), .B0(n16), .B1(state[11]), 
        .Y(n35) );
  AO22_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[10]), .B0(n16), .B1(state[9]), 
        .Y(n34) );
  AO22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[9]), .B0(n16), .B1(state[8]), .Y(
        n33) );
  AO22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[7]), .B0(n16), .B1(state[6]), .Y(
        n32) );
  AO22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[5]), .B0(n16), .B1(state[4]), .Y(
        n31) );
  AO22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[4]), .B0(n16), .B1(state[3]), .Y(
        n30) );
  AO22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n26), .A1(state[2]), .B0(n16), .B1(state[1]), .Y(
        n29) );
endmodule


module lfsr_15_6000_70ae_0 ( VDD, VSS, clk, rst_n, clr, load_en, load_bit, step, out, 
        state );
  inout VDD, VSS;
  output [14:0] state;
  input clk, rst_n, clr, load_en, load_bit, step;
  output out;
  wire   n1, n2, n10, n12, n13, n15, n16, n24, n25, n26, n27, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44;

  DFFQ_X0P5M_A12TR state_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n29), .CK(clk), .Q(state[0]) );
  A2DFFQN_X0P5M_A12TR state_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n37), .CK(clk), .QN(state[1])
         );
  A2DFFQN_X0P5M_A12TR state_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n38), .CK(clk), .QN(state[2])
         );
  A2DFFQN_X0P5M_A12TR state_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n39), .CK(clk), .QN(state[3])
         );
  DFFQ_X0P5M_A12TR state_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n30), .CK(clk), .Q(state[4]) );
  A2DFFQN_X0P5M_A12TR state_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n40), .CK(clk), .QN(state[5])
         );
  DFFQ_X0P5M_A12TR state_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n31), .CK(clk), .Q(state[6]) );
  A2DFFQN_X0P5M_A12TR state_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n41), .CK(clk), .QN(state[7])
         );
  DFFQ_X0P5M_A12TR state_reg_8_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n32), .CK(clk), .Q(state[8]) );
  DFFQ_X0P5M_A12TR state_reg_9_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n33), .CK(clk), .Q(state[9]) );
  DFFQ_X0P5M_A12TR state_reg_10_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n34), .CK(clk), .Q(state[10]) );
  DFFQ_X0P5M_A12TR state_reg_11_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n35), .CK(clk), .Q(state[11]) );
  A2DFFQN_X0P5M_A12TR state_reg_12_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n42), .CK(clk), .QN(
        state[12]) );
  A2DFFQN_X0P5M_A12TR state_reg_13_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n43), .CK(clk), .QN(
        state[13]) );
  A2DFFQN_X0P5M_A12TR state_reg_14_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n44), .CK(clk), .QN(out) );
  BUF_X0P7B_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(state[14]) );
  NOR2XB_X1M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .BN(rst_n), .A(clr), .Y(n36) );
  INV_X0P5B_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .Y(n24) );
  INV_X0P5B_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(load_en), .Y(n12) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[13]), .Y(n2) );
  INV_X0P5B_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(out), .Y(n1) );
  AOI22_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(state[13]), .B0(n2), .B1(n1), .Y(n10)
         );
  AOI32_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n12), .A2(n10), .B0(load_en), .B1(
        load_bit), .Y(n15) );
  NOR2_X0P5M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(load_en), .B(step), .Y(n25) );
  NAND2_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .B(n25), .Y(n16) );
  INV_X0P5B_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[0]), .Y(n13) );
  OAI22_X0P5M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n24), .A1(n15), .B0(n16), .B1(n13), .Y(n29) );
  INV_X0P7B_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n16), .Y(n27) );
  NOR2_X1P4M_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .B(n24), .Y(n26) );
  AOI22_X0P5M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[2]), .B0(n26), .B1(state[1]), 
        .Y(n38) );
  AOI22_X0P5M_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(out), .A1(n27), .B0(state[13]), .B1(n26), .Y(n44) );
  AOI22_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[5]), .B0(n26), .B1(state[4]), 
        .Y(n40) );
  AOI22_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[12]), .B0(n26), .B1(state[11]), 
        .Y(n42) );
  AOI22_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[7]), .B0(n26), .B1(state[6]), 
        .Y(n41) );
  AOI22_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[1]), .B0(state[0]), .B1(n26), 
        .Y(n37) );
  AOI22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state[13]), .A1(n27), .B0(n26), .B1(state[12]), 
        .Y(n43) );
  AOI22_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[3]), .B0(n26), .B1(state[2]), 
        .Y(n39) );
  AO22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[4]), .B0(n26), .B1(state[3]), .Y(
        n30) );
  AO22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[6]), .B0(n26), .B1(state[5]), .Y(
        n31) );
  AO22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[9]), .B0(n26), .B1(state[8]), .Y(
        n33) );
  AO22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[10]), .B0(n26), .B1(state[9]), 
        .Y(n34) );
  AO22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[11]), .B0(n26), .B1(state[10]), 
        .Y(n35) );
  AO22_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n27), .A1(state[8]), .B0(n26), .B1(state[7]), .Y(
        n32) );
endmodule


module sg_cipher_0 ( VDD, VSS, clk, rst_n, clr, key_load, key_in, ks_consume, ks_bit, 
        ks_ready, keyed );
  inout VDD, VSS;
  input clk, rst_n, clr, key_load, key_in, ks_consume;
  output ks_bit, ks_ready, keyed;
  wire   step, a_out, s_out, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n13,
         n14, SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8,
         SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10,
         SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12,
         SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14,
         SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16,
         SYNOPSYS_UNCONNECTED_17, SYNOPSYS_UNCONNECTED_18,
         SYNOPSYS_UNCONNECTED_19, SYNOPSYS_UNCONNECTED_20,
         SYNOPSYS_UNCONNECTED_21, SYNOPSYS_UNCONNECTED_22,
         SYNOPSYS_UNCONNECTED_23, SYNOPSYS_UNCONNECTED_24,
         SYNOPSYS_UNCONNECTED_25, SYNOPSYS_UNCONNECTED_26,
         SYNOPSYS_UNCONNECTED_27, SYNOPSYS_UNCONNECTED_28,
         SYNOPSYS_UNCONNECTED_29, SYNOPSYS_UNCONNECTED_30,
         SYNOPSYS_UNCONNECTED_31, SYNOPSYS_UNCONNECTED_32;

  DFFQ_X0P5M_A12TR keyed_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n13), .CK(clk), .Q(keyed) );
  DFFQ_X0P5M_A12TR ks_bit_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n11), .CK(clk), .Q(ks_bit) );
  DFFQ_X0P5M_A12TR ks_ready_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n10), .CK(clk), .Q(n14) );
  INV_X0P5B_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(key_load), .Y(n2) );
  OAI21_X0P5M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n14), .A1(ks_consume), .B0(n2), .Y(n4) );
  NOR2_X1M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(clr), .B(n4), .Y(step) );
  NOR2_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .B(ks_consume), .Y(n3) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .Y(n5) );
  NOR2_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(clr), .B(n5), .Y(n9) );
  AND3_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(step), .C(s_out), .Y(n8) );
  AOI31_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n3), .A1(n9), .A2(n2), .B0(n8), .Y(n10) );
  INV_X0P5B_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n4), .Y(n6) );
  AOI211_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n6), .A1(s_out), .B0(clr), .C0(n5), .Y(n7) );
  AO22_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(a_out), .A1(n8), .B0(ks_bit), .B1(n7), .Y(n11) );
  INV_X0P5B_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n14), .Y(ks_ready) );
  OA21_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(key_load), .A1(keyed), .B0(n9), .Y(n13) );
  lfsr_17_12000_1c94b_0 A ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(clr), .load_en(
        key_load), .load_bit(key_in), .step(step), .out(a_out), .state({
        SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, 
        SYNOPSYS_UNCONNECTED_4, SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6, 
        SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8, SYNOPSYS_UNCONNECTED_9, 
        SYNOPSYS_UNCONNECTED_10, SYNOPSYS_UNCONNECTED_11, 
        SYNOPSYS_UNCONNECTED_12, SYNOPSYS_UNCONNECTED_13, 
        SYNOPSYS_UNCONNECTED_14, SYNOPSYS_UNCONNECTED_15, 
        SYNOPSYS_UNCONNECTED_16, SYNOPSYS_UNCONNECTED_17}) );
  lfsr_15_6000_70ae_0 S ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(clr), .load_en(
        key_load), .load_bit(a_out), .step(step), .out(s_out), .state({
        SYNOPSYS_UNCONNECTED_18, SYNOPSYS_UNCONNECTED_19, 
        SYNOPSYS_UNCONNECTED_20, SYNOPSYS_UNCONNECTED_21, 
        SYNOPSYS_UNCONNECTED_22, SYNOPSYS_UNCONNECTED_23, 
        SYNOPSYS_UNCONNECTED_24, SYNOPSYS_UNCONNECTED_25, 
        SYNOPSYS_UNCONNECTED_26, SYNOPSYS_UNCONNECTED_27, 
        SYNOPSYS_UNCONNECTED_28, SYNOPSYS_UNCONNECTED_29, 
        SYNOPSYS_UNCONNECTED_30, SYNOPSYS_UNCONNECTED_31, 
        SYNOPSYS_UNCONNECTED_32}) );
endmodule


module lfsr_8_b8_a3_test_1 ( VDD, VSS, clk, rst_n, clr, load_en, load_bit, step, out, 
        state, test_si, test_se );
  inout VDD, VSS;
  output [7:0] state;
  input clk, rst_n, clr, load_en, load_bit, step, test_si, test_se;
  output out;
  wire   n33, n25, n26, n27, n28, n29, n30, n31, n32, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n18, n19, n23;

  SDFFQ_X1M_A12TR state_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n31), .SI(state[0]), .SE(test_se), .CK(clk), .Q(state[1]) );
  SDFFQ_X1M_A12TR state_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n30), .SI(state[1]), .SE(test_se), .CK(clk), .Q(state[2]) );
  SDFFQ_X1M_A12TR state_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n29), .SI(state[2]), .SE(test_se), .CK(clk), .Q(state[3]) );
  SDFFQ_X1M_A12TR state_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n28), .SI(state[3]), .SE(test_se), .CK(clk), .Q(state[4]) );
  SDFFQ_X1M_A12TR state_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n27), .SI(state[4]), .SE(test_se), .CK(clk), .Q(state[5]) );
  SDFFQ_X0P5M_A12TR state_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n32), .SI(test_si), .SE(test_se), .CK(
        clk), .Q(state[0]) );
  SDFFQ_X0P5M_A12TR state_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n25), .SI(state[6]), .SE(test_se), .CK(
        clk), .Q(n33) );
  OAI211_X0P5M_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n7), .B0(n10), .C0(n6), .Y(n32) );
  OAI221_X0P5M_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n8), .B0(n9), .B1(n13), .C0(n10), .Y(
        n25) );
  OAI221_X0P5M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n11), .B0(n9), .B1(n7), .C0(n10), .Y(
        n31) );
  OAI221_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n14), .B0(n9), .B1(n19), .C0(n10), 
        .Y(n27) );
  INV_X0P5B_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .Y(n9) );
  BUF_X0P7B_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[7]), .Y(out) );
  INV_X0P5B_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[0]), .Y(n7) );
  NOR2XB_X0P7M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .BN(rst_n), .A(clr), .Y(n10) );
  INV_X0P5B_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[3]), .Y(n16) );
  INV_X0P5B_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[4]), .Y(n19) );
  AOI22_X0P5M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state[4]), .A1(state[3]), .B0(n16), .B1(n19), 
        .Y(n5) );
  INV_X0P5B_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[5]), .Y(n14) );
  INV_X0P5B_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[7]), .Y(n8) );
  AOI22_X0P5M_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(state[7]), .A1(state[5]), .B0(n14), .B1(n8), .Y(
        n4) );
  NAND2_X0P5M_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n5), .B(n4), .Y(n3) );
  OAI211_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n5), .A1(n4), .B0(step), .C0(n3), .Y(n6) );
  INV_X0P5B_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[1]), .Y(n11) );
  INV_X0P5B_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[6]), .Y(n13) );
  NAND2_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n10), .B(n9), .Y(n18) );
  INV_X0P5B_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state[2]), .Y(n12) );
  NAND2_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n10), .B(step), .Y(n15) );
  OAI22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n16), .A1(n18), .B0(n12), .B1(n15), .Y(n29) );
  OAI22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n18), .A1(n12), .B0(n15), .B1(n11), .Y(n30) );
  OAI22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n14), .A1(n15), .B0(n18), .B1(n13), .Y(n26) );
  OAI22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n19), .A1(n18), .B0(n16), .B1(n15), .Y(n28) );
  INV_X0P5B_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n33), .Y(n23) );
  INV_X0P5B_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n23), .Y(state[7]) );
  SDFFQ_X0P5M_A12TR state_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n26), .SI(state[5]), .SE(test_se), .CK(
        clk), .Q(state[6]) );
endmodule


module bist_ctrl_51_51_test_1 ( VDD, VSS, clk, rst_n, bit_tick, tx_ready, rx_data, 
        rx_valid, rx_err, bist_start, bist_active, bist_clr, b_tx_data, 
        b_tx_valid, bist_done, bist_pass, test_si, test_so, test_se );
  inout VDD, VSS;
  input [7:0] rx_data;
  output [7:0] b_tx_data;
  input clk, rst_n, bit_tick, tx_ready, rx_valid, rx_err, bist_start, test_si,
         test_se;
  output bist_active, bist_clr, b_tx_valid, bist_done, bist_pass, test_so;
  wire   step, timeout_q_2_, timeout_q_1_, timeout_q_0_, fail_q, n74, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66;
  wire   [2:0] state_q;
  wire   [7:0] MISR_q;

  SDFFQ_X1M_A12TR state_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n103), .SI(state_q[0]), .SE(test_se), 
        .CK(clk), .Q(state_q[1]) );
  SDFFQ_X1M_A12TR timeout_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n100), .SI(state_q[2]), .SE(test_se), 
        .CK(clk), .Q(timeout_q_0_) );
  SDFFQ_X1M_A12TR timeout_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n98), .SI(timeout_q_1_), .SE(test_se), 
        .CK(clk), .Q(timeout_q_2_) );
  SDFFQ_X1M_A12TR timeout_q_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n101), .SI(timeout_q_2_), .SE(test_se), 
        .CK(clk), .Q(test_so) );
  SDFFQ_X1M_A12TR state_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n104), .SI(state_q[1]), .SE(test_se), 
        .CK(clk), .Q(state_q[2]) );
  SDFFQ_X1M_A12TR MISR_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n90), .SI(test_si), .SE(test_se), .CK(clk), .Q(MISR_q[0]) );
  SDFFQ_X1M_A12TR MISR_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n91), .SI(MISR_q[0]), .SE(test_se), .CK(
        clk), .Q(MISR_q[1]) );
  SDFFQ_X1M_A12TR MISR_q_reg_2_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n92), .SI(MISR_q[1]), .SE(test_se), .CK(
        clk), .Q(MISR_q[2]) );
  SDFFQ_X1M_A12TR MISR_q_reg_3_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n93), .SI(MISR_q[2]), .SE(test_se), .CK(
        clk), .Q(MISR_q[3]) );
  SDFFQ_X1M_A12TR MISR_q_reg_4_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n94), .SI(MISR_q[3]), .SE(test_se), .CK(
        clk), .Q(MISR_q[4]) );
  SDFFQ_X1M_A12TR MISR_q_reg_5_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n95), .SI(MISR_q[4]), .SE(test_se), .CK(
        clk), .Q(MISR_q[5]) );
  SDFFQ_X1M_A12TR MISR_q_reg_6_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n96), .SI(MISR_q[5]), .SE(test_se), .CK(
        clk), .Q(MISR_q[6]) );
  SDFFQ_X0P5M_A12TR timeout_q_reg_1_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n99), .SI(timeout_q_0_), .SE(test_se), .CK(clk), .Q(timeout_q_1_) );
  SDFFQ_X0P5M_A12TR fail_q_reg ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n105), .SI(MISR_q[7]), .SE(test_se), .CK(
        clk), .Q(fail_q) );
  NAND2_X1A_A12TR U4 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n15), .B(n5), .Y(bist_active) );
  INV_X0P6M_A12TR U5 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[2]), .Y(n24) );
  INV_X0P5M_A12TR U7 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[0]), .Y(n5) );
  OAI22_X0P5M_A12TR U8 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n65), .B0(n64), .B1(n63), .Y(n93) );
  OAI22_X0P5M_A12TR U9 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n62), .B0(n61), .B1(n63), .Y(n95) );
  OAI22_X0P5M_A12TR U10 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n53), .B0(n52), .B1(n63), .Y(n92) );
  TIELO_X1M_A12TR U11 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .Y(n74) );
  NAND2_X0P5M_A12TR U12 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[1]), .B(n24), .Y(n6) );
  NAND2B_X0P5M_A12TR U13 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(n6), .B(state_q[0]), .Y(n1) );
  NOR2B_X1M_A12TR U14 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(rx_valid), .B(n1), .Y(step) );
  NAND2B_X0P5M_A12TR U15 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(n1), .B(rst_n), .Y(n54) );
  NOR2_X0P5M_A12TR U16 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n54), .B(rx_valid), .Y(n36) );
  INV_X0P5B_A12TR U17 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n36), .Y(n22) );
  INV_X0P5B_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(timeout_q_1_), .Y(n32) );
  INV_X0P5B_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(timeout_q_2_), .Y(n33) );
  NOR2_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n32), .B(n33), .Y(n55) );
  AOI31_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n55), .A1(timeout_q_0_), .A2(test_so), .B0(
        rx_err), .Y(n23) );
  INV_X0P5B_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(fail_q), .Y(n25) );
  NAND2_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[0]), .B(n24), .Y(n37) );
  OAI21_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n37), .B0(rst_n), .Y(n2) );
  OAI222_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n22), .A1(n23), .B0(n22), .B1(n25), .C0(n25), 
        .C1(n2), .Y(n105) );
  NOR2_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[1]), .B(n37), .Y(bist_clr) );
  NOR2_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[0]), .B(n6), .Y(b_tx_valid) );
  NOR2_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bist_start), .B(bist_active), .Y(n3) );
  AOI22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(rst_n), .A1(n3), .B0(n36), .B1(n23), .Y(n9) );
  NAND3B_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(tx_ready), .B(b_tx_valid), .C(rst_n), .Y(n8) );
  OAI211_X0P5M_A12TR U31 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_start), .A1(bist_active), .B0(rst_n), .C0(
        n8), .Y(n13) );
  INV_X0P5B_A12TR U32 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n13), .Y(n19) );
  OAI211_X0P5M_A12TR U33 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n15), .A1(n24), .B0(n19), .C0(n5), .Y(n4) );
  OAI21_X0P5M_A12TR U34 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n9), .A1(n5), .B0(n4), .Y(n102) );
  NAND2_X0P5M_A12TR U35 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rst_n), .B(n6), .Y(n7) );
  OAI211_X0P5M_A12TR U36 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bit_tick), .A1(n54), .B0(n8), .C0(n7), .Y(n30)
         );
  INV_X0P5B_A12TR U37 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(timeout_q_0_), .Y(n29) );
  INV_X0P5B_A12TR U38 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n54), .Y(n38) );
  AOI21_X0P5M_A12TR U39 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n38), .A1(n29), .B0(n30), .Y(n60) );
  AOI21_X0P5M_A12TR U40 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n30), .A1(n29), .B0(n60), .Y(n100) );
  NAND2_X0P5M_A12TR U41 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n9), .B(n8), .Y(n17) );
  INV_X0P5B_A12TR U42 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n17), .Y(n16) );
  NAND4B_X0P5M_A12TR U43 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(b_tx_data[3]), .B(b_tx_data[6]), .C(
        b_tx_data[0]), .D(b_tx_data[4]), .Y(n10) );
  OR3_X0P5M_A12TR U44 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(b_tx_data[5]), .B(b_tx_data[7]), .C(n10), .Y(n11)
         );
  NOR3_X0P5A_A12TR U45 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(b_tx_data[1]), .B(b_tx_data[2]), .C(n11), .Y(n18)
         );
  INV_X0P5B_A12TR U46 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n18), .Y(n12) );
  AOI211_X0P5M_A12TR U47 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(step), .A1(n12), .B0(b_tx_valid), .C0(bist_clr), 
        .Y(n14) );
  OAI22_X0P5M_A12TR U48 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n16), .A1(n15), .B0(n14), .B1(n13), .Y(n103) );
  NAND2_X0P5M_A12TR U49 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[2]), .B(n17), .Y(n21) );
  NAND3_X0P5A_A12TR U50 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(step), .B(n19), .C(n18), .Y(n20) );
  OAI211_X0P5M_A12TR U51 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n23), .A1(n22), .B0(n21), .C0(n20), .Y(n104) );
  INV_X0P5B_A12TR U52 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[7]), .Y(n40) );
  INV_X0P5B_A12TR U53 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[3]), .Y(n65) );
  NAND3_X0P5A_A12TR U54 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n25), .B(n40), .C(n65), .Y(n28) );
  INV_X0P5B_A12TR U55 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[5]), .Y(n62) );
  INV_X0P5B_A12TR U56 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[1]), .Y(n45) );
  NAND4_X0P5M_A12TR U57 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[4]), .B(MISR_q[0]), .C(n62), .D(n45), .Y(
        n27) );
  INV_X0P5B_A12TR U58 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[2]), .Y(n53) );
  NAND3_X0P5A_A12TR U59 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[6]), .B(bist_done), .C(n53), .Y(n26) );
  NOR3_X0P5A_A12TR U60 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n28), .B(n27), .C(n26), .Y(bist_pass) );
  NOR3_X0P5M_A12TR U61 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n54), .B(n30), .C(n29), .Y(n56) );
  INV_X0P5B_A12TR U62 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n56), .Y(n31) );
  AOI22_X0P5M_A12TR U63 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(timeout_q_1_), .A1(n60), .B0(n31), .B1(n32), .Y(
        n99) );
  NAND2_X0P5M_A12TR U64 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n38), .B(n32), .Y(n35) );
  NAND2_X0P5M_A12TR U65 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(timeout_q_1_), .B(n56), .Y(n34) );
  AOI32_X0P5M_A12TR U66 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n60), .A1(timeout_q_2_), .A2(n35), .B0(n34), 
        .B1(n33), .Y(n98) );
  AOI21_X1M_A12TR U67 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(rst_n), .A1(n37), .B0(n36), .Y(n66) );
  XNOR2_X0P5M_A12TR U68 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[6]), .B(rx_data[7]), .Y(n39) );
  NAND2_X0P5A_A12TR U69 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n38), .B(n66), .Y(n63) );
  OAI22_X0P5M_A12TR U70 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n40), .B0(n39), .B1(n63), .Y(n97) );
  INV_X0P5B_A12TR U71 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[4]), .Y(n46) );
  XNOR2_X0P5M_A12TR U72 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[3]), .B(rx_data[4]), .Y(n41) );
  OAI22_X0P5M_A12TR U73 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n46), .B0(n41), .B1(n63), .Y(n94) );
  INV_X0P5B_A12TR U74 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[6]), .Y(n43) );
  XNOR2_X0P5M_A12TR U75 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[5]), .B(rx_data[6]), .Y(n42) );
  OAI22_X0P5M_A12TR U76 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n43), .B0(n42), .B1(n63), .Y(n96) );
  XNOR2_X0P5M_A12TR U77 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[0]), .B(rx_data[1]), .Y(n44) );
  OAI22_X0P5M_A12TR U78 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n45), .B0(n44), .B1(n63), .Y(n91) );
  INV_X0P5B_A12TR U79 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[0]), .Y(n51) );
  XNOR2_X0P5M_A12TR U80 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[3]), .B(rx_data[0]), .Y(n48) );
  AOI22_X0P5M_A12TR U81 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(MISR_q[5]), .A1(MISR_q[4]), .B0(n46), .B1(n62), 
        .Y(n47) );
  XNOR2_X0P5M_A12TR U82 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n48), .B(n47), .Y(n49) );
  XNOR2_X0P5M_A12TR U83 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[7]), .B(n49), .Y(n50) );
  OAI22_X0P5M_A12TR U84 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n66), .A1(n51), .B0(n50), .B1(n63), .Y(n90) );
  XNOR2_X0P5M_A12TR U85 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[1]), .B(rx_data[2]), .Y(n52) );
  OR2_X0P5M_A12TR U86 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n55), .B(n54), .Y(n59) );
  NAND3_X0P5A_A12TR U87 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(timeout_q_1_), .B(timeout_q_2_), .C(n56), .Y(n58)
         );
  INV_X0P5B_A12TR U88 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(test_so), .Y(n57) );
  AOI32_X0P5M_A12TR U89 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(n60), .A1(test_so), .A2(n59), .B0(n58), .B1(n57), 
        .Y(n101) );
  XNOR2_X0P5M_A12TR U90 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[4]), .B(rx_data[5]), .Y(n61) );
  XNOR2_X0P5M_A12TR U91 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(MISR_q[2]), .B(rx_data[3]), .Y(n64) );
  SDFFQ_X0P5M_A12TR state_q_reg_0_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n102), .SI(b_tx_data[7]), .SE(test_se), 
        .CK(clk), .Q(state_q[0]) );
  SDFFQ_X0P5M_A12TR MISR_q_reg_7_ ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .D(n97), .SI(MISR_q[6]), .SE(test_se), 
        .CK(clk), .Q(MISR_q[7]) );
  INV_X0P5B_A12TR U3 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(state_q[1]), .Y(n15) );
  NOR2_X0P5M_A12TR U6 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(n24), .B(bist_active), .Y(bist_done) );
  lfsr_8_b8_a3_test_1 p_gen ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(bist_clr), 
        .load_en(n74), .load_bit(n74), .step(step), .state(b_tx_data), 
        .test_si(fail_q), .test_se(test_se) );
endmodule


module top ( VDD, VSS, clk, rst_n, tx_valid, tx_data, tx_ready, uart_txd, uart_rxd, 
        rx_data, rx_valid, rx_err, key_in, key_load, key_sel, scan_en, 
        bist_start, bist_done, bist_pass, scan_in, scan_out );
  inout VDD, VSS;
  input [7:0] tx_data;
  output [7:0] rx_data;
  input clk, rst_n, tx_valid, uart_rxd, key_in, key_load, key_sel, scan_en,
         bist_start, scan_in;
  output tx_ready, uart_txd, rx_valid, rx_err, bist_done, bist_pass, scan_out;
  wire   bit_tick, tx_valid_w, tx_ks_bit, tx_keyed_w, tx_ready_w,
         tx_ks_consume, txd_w, rxd_raw, rxd_s, rx_ks_bit, rx_valid_w, rx_err_w,
         rx_ks_consume, bist_clr, tx_key_load, rx_key_load, key_bit, sec_clr,
         tx_keyed, bist_active, b_tx_valid, n2, n3, n4, n5, n6;
  wire   [7:0] tx_data_w;
  wire   [7:0] b_tx_data;

  INV_X0P7B_A12TR U18 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(bist_active), .Y(n2) );
  AO22_X0P5M_A12TR U19 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(txd_w), .B0(n2), .B1(uart_rxd), 
        .Y(rxd_raw) );
  NAND2B_X0P5M_A12TR U20 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .AN(txd_w), .B(n2), .Y(uart_txd) );
  AND2_X0P5M_A12TR U21 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(tx_ready_w), .B(n2), .Y(tx_ready) );
  AND2_X0P5M_A12TR U22 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rx_err_w), .B(n2), .Y(rx_err) );
  AO22_X0P5M_A12TR U23 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[7]), .B0(n2), .B1(
        tx_data[7]), .Y(tx_data_w[7]) );
  AND2_X0P5M_A12TR U24 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rx_valid_w), .B(n2), .Y(rx_valid) );
  AO22_X0P5M_A12TR U25 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[3]), .B0(n2), .B1(
        tx_data[3]), .Y(tx_data_w[3]) );
  AO22_X0P5M_A12TR U26 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[1]), .B0(n2), .B1(
        tx_data[1]), .Y(tx_data_w[1]) );
  AO22_X0P5M_A12TR U27 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[6]), .B0(n2), .B1(
        tx_data[6]), .Y(tx_data_w[6]) );
  AO22_X0P5M_A12TR U28 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[0]), .B0(n2), .B1(
        tx_data[0]), .Y(tx_data_w[0]) );
  AO22_X0P5M_A12TR U29 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[4]), .B0(n2), .B1(
        tx_data[4]), .Y(tx_data_w[4]) );
  AO22_X0P5M_A12TR U30 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[5]), .B0(n2), .B1(
        tx_data[5]), .Y(tx_data_w[5]) );
  AO22_X0P5M_A12TR U31 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_data[2]), .B0(n2), .B1(
        tx_data[2]), .Y(tx_data_w[2]) );
  AO22_X0P5M_A12TR U32 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A0(bist_active), .A1(b_tx_valid), .B0(n2), .B1(
        tx_valid), .Y(tx_valid_w) );
  OR2_X0P5M_A12TR U33 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(tx_keyed), .B(bist_active), .Y(tx_keyed_w) );
  BUF_X0P7B_A12TR U34 ( .VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS),  .A(rx_data[7]), .Y(scan_out) );
  baud_gen_test_1 baud ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .bit_tick(bit_tick), 
        .test_si(scan_in), .test_so(n6), .test_se(scan_en) );
  uart_tx_test_1 tx ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .tx_valid(tx_valid_w), 
        .tx_data(tx_data_w), .bit_tick(bit_tick), .ks_bit(tx_ks_bit), 
        .tx_keyed(tx_keyed_w), .tx_ready(tx_ready_w), .ks_consume(
        tx_ks_consume), .txd(txd_w), .test_si(n3), .test_se(scan_en) );
  sync_2ff_test_1 sync ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .d(rxd_raw), .q(rxd_s), 
        .test_si(n4), .test_so(n3), .test_se(scan_en) );
  uart_rx_test_1 rx ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .rx_in(rxd_s), .ks_bit(
        rx_ks_bit), .rx_data(rx_data), .rx_valid(rx_valid_w), .rx_err(rx_err_w), .ks_consume(rx_ks_consume), .test_si2(txd_w), .test_si1(n5), .test_so1(n4), 
        .test_se(scan_en) );
  sec_ctrl sec ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .key_in(key_in), .key_load(key_load), .key_sel(key_sel), .scan_en(scan_en), .bist_clr(bist_clr), .tx_key_load(
        tx_key_load), .rx_key_load(rx_key_load), .key_bit(key_bit), .sec_clr(
        sec_clr) );
  sg_cipher_1 tx_cipher ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(sec_clr), .key_load(
        tx_key_load), .key_in(key_bit), .ks_consume(tx_ks_consume), .ks_bit(
        tx_ks_bit), .keyed(tx_keyed) );
  sg_cipher_0 rx_cipher ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .clr(sec_clr), .key_load(
        rx_key_load), .key_in(key_bit), .ks_consume(rx_ks_consume), .ks_bit(
        rx_ks_bit) );
  bist_ctrl_51_51_test_1 bist ( .VDD(VDD), .VSS(VSS),  .clk(clk), .rst_n(rst_n), .bit_tick(bit_tick), 
        .tx_ready(tx_ready_w), .rx_data(rx_data), .rx_valid(rx_valid_w), 
        .rx_err(rx_err_w), .bist_start(bist_start), .bist_active(bist_active), 
        .bist_clr(bist_clr), .b_tx_data(b_tx_data), .b_tx_valid(b_tx_valid), 
        .bist_done(bist_done), .bist_pass(bist_pass), .test_si(n6), .test_so(
        n5), .test_se(scan_en) );
endmodule

