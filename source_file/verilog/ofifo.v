`ifndef FIFO_DEPTH16_V

`include "fifo_depth16.v"

`endif

`timescale 1ns/1ps
module ofifo (clk,
              in,
              out,
              rd,
              wr,
              o_valid,
              reset,
              o_full);
    
    parameter col  = 16;
    parameter simd = 1;
    parameter bw   = 24;
    
    input  clk;
    input  [col-1:0] wr;
    input  rd;
    input  reset;
    input  [simd*col*bw-1:0] in;
    output [simd*col*bw-1:0] out;
    output o_full;
    output o_valid;
    
    wire  [col-1:0] full;
    wire  [col-1:0] empty;
    
    assign o_full  = full[7];
    assign o_valid = !empty[0] && !empty[1] && !empty[2] && !empty[3] && !empty[4] && !empty[5] && !empty[6] && !empty[7];
    
    
    genvar i;
    
    for (i = 0; i < col ; i = i+1) begin : col_idx
    fifo_depth16 #(.WIDTH(bw), .DEPTH(col)) fifo_instance (
    .rd_clk(clk),
    .wr_clk(clk),
    .rd(rd),
    .wr(wr[i]),
    .in(in[bw*simd*(i+1)-1:bw*simd*i]),
    .out(out[bw*simd*(i+1)-1:bw*simd*i]),
    .o_full(full[i]),
    .o_empty(empty[i]),
    .reset(reset));
    end
    
    
    
    
endmodule
