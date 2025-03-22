/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06-SP2
// Date      : Sat Mar 22 00:04:43 2025
/////////////////////////////////////////////////////////////


module fullchip ( clk, mem_in, inst, reset, out, test_mode, clk_scan, 
        reset_scan, SI, SE, SO );
  input [127:0] mem_in;
  input [20:0] inst;
  output [319:0] out;
  input clk, reset, test_mode, clk_scan, reset_scan, SI, SE;
  output SO;

  tri   clk;
  tri   [127:0] mem_in;
  tri   [20:0] inst;
  tri   reset;
  tri   [319:0] out;
  tri   test_mode;
  tri   clk_scan;
  tri   reset_scan;
  tri   SI;
  tri   SE;
  tri   SO;
  tri   [23:0] sum_core0;
  tri   [23:0] sum_core1;
  tri   div_ready1;
  tri   div_ready0;

  core core_instance0 ( .reset(reset), .clk(clk), .clk_o(clk), .mem_in(
        mem_in[63:0]), .inst(inst), .sum_out(sum_core0), .out(out[159:0]), 
        .sum_in(sum_core1), .fifo_ext_rd(div_ready1), .div_ready(div_ready0), 
        .test_mode(test_mode), .clk_scan(clk_scan), .reset_scan(reset_scan), 
        .SI(SI), .SE(SE), .SO(SO) );
  core core_instance1 ( .reset(reset), .clk(clk), .clk_o(clk), .mem_in(
        mem_in[127:64]), .inst(inst), .sum_out(sum_core1), .out(out[319:160]), 
        .sum_in(sum_core0), .fifo_ext_rd(div_ready0), .div_ready(div_ready1), 
        .test_mode(test_mode), .clk_scan(clk_scan), .reset_scan(reset_scan), 
        .SI(SI), .SE(SE), .SO(SO) );
endmodule

