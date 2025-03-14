`include "core.v"
`timescale 1ns/1ps
module fullchip (clk,
                 mem_in,
                 inst,
                 reset,
                 out);
    
    parameter col     = 8;
    parameter bw      = 8;
    parameter bw_psum = 2*bw+4;
    parameter pr      = 8;
    parameter cor     = 2;
    
    input  clk;
    input  [cor*pr*bw-1:0] mem_in;
    input  [23:0] inst;
    input  reset;
    output [bw_psum*col*cor-1:0] out;
    
    wire div_ready0, div_ready1;
    wire clk0, clk1;
    wire [bw_psum+3:0] sum_core0;
    wire [bw_psum+3:0] sum_core1;
    wire [bw_psum*col-1:0] out_core0;
    wire [bw_psum*col-1:0] out_core1;

    assign clk0 = clk;
    assign clk1 = clk;

    assign out = {out_core1, out_core0};
    
    core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance0 (
    .reset(reset),
    .clk(clk0),
    .clk_o(clk1),
    .mem_in(mem_in[pr*bw-1:0]),
    .inst(inst),
    .sum_out(sum_core0),
    .out(out_core0),
    .sum_in(sum_core1),
    .fifo_ext_rd(div_ready1),
    .div_ready(div_ready0)
    );
    
    core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance1 (
    .reset(reset),
    .clk(clk1),
    .clk_o(clk0),
    .mem_in(mem_in[cor*pr*bw-1:pr*bw]),
    .inst(inst),
    .sum_out(sum_core1),
    .out(out_core1),
    .sum_in(sum_core0),
    .fifo_ext_rd(div_ready0),
    .div_ready(div_ready1)
    );

    // sync #(.width(1)) sync_instance0(
    // .clk(clk),
    // .in(),
    // .out(),
    // .reset(reset)
    // );
    
endmodule
