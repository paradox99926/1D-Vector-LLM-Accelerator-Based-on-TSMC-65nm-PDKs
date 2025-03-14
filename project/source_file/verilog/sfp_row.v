`ifndef FIFO_DEPTH16_V

`include "fifo_depth16.v"

`endif

`include "lut_div.v"
`timescale 1ns/1ps
module sfp_row (clk,
                clk_o,
                acc,
                div,
                fifo_ext_rd,
                reset,
                sum_in,
                sum_out,
                sfp_in,
                sfp_out,
                div_ready);
    
    parameter col     = 8;
    parameter bw      = 8;
    parameter bw_psum = 2*bw+4;
    
    
    input  clk, clk_o, div, acc, fifo_ext_rd, reset;
    input  [bw_psum+3:0] sum_in;
    input  [col*bw_psum-1:0] sfp_in;
    wire  [col*bw_psum-1:0] abs;
    output [col*bw_psum-1:0] sfp_out;
    output [bw_psum+3:0] sum_out;
    output div_ready;
    wire [bw_psum+3:0] sum_this_core;
    wire signed [bw_psum+3:0] sum_2core;
    wire signed [bw_psum-1:0] sfp_in_unsign [col-1:0];
    wire signed [bw_psum-1:0] sfp_out_unsign [col-1:0];
    reg signed [bw_psum-1:0] sfp_in_temp [col-1:0];
    reg [bw_psum+3:0] sum_q;
    reg [bw_psum+1:0] sum_2core_temp;
    reg fifo_wr;
    reg div_q;
    reg div_2q;
    
    genvar i;
    generate
    for(i = 0; i<col;i = i+1) begin
        assign sfp_in_unsign[i]                     = (sfp_in[bw_psum*(i+1)-1])?(~sfp_in[bw_psum*(i+1)-1:bw_psum*i] + 1):sfp_in[bw_psum*(i+1)-1 : bw_psum*i];
        assign sfp_out[bw_psum*(i+1)-1 : bw_psum*i] = {10'b0,sfp_out_unsign[i][7:0],2'b0};
        assign abs[bw_psum*(i+1)-1 : bw_psum*i]     = (sfp_in[bw_psum*(i+1)-1])?(~sfp_in[bw_psum*(i+1)-1:bw_psum*i] + 1):sfp_in[bw_psum*(i+1)-1 : bw_psum*i];
    end
    endgenerate
    
    assign sum_2core = sum_this_core + sum_in;
    assign div_ready = div_q;
    
    fifo_depth16 #(.WIDTH(bw_psum+4)) fifo_inst_int (
    .rd_clk(clk),
    .wr_clk(clk),
    .in(sum_q),
    .out(sum_this_core),
    .rd(div_q),
    .wr(fifo_wr),
    .reset(reset)
    );
    
    fifo_depth16 #(.WIDTH(bw_psum+4)) fifo_inst_ext (
    .rd_clk(clk),
    .wr_clk(clk_o),
    .in(sum_q),
    .out(sum_out),
    .rd(fifo_ext_rd),
    .wr(fifo_wr),
    .reset(reset)
    );
    
    integer k;
    
    always @ (posedge clk) begin
        if (reset) begin
            fifo_wr <= 0;
            div_q <= 0;
            div_2q <= 0;
            sum_2core_temp <= 0;
        end
        else begin
            div_q          <= div ;
            div_2q         <= div_q;
            sum_2core_temp <= sum_2core[bw_psum+3:5];
            if (acc) begin
                sum_q <= 
                {4'b0, abs[bw_psum*1-1 : bw_psum*0]} +
                {4'b0, abs[bw_psum*2-1 : bw_psum*1]} +
                {4'b0, abs[bw_psum*3-1 : bw_psum*2]} +
                {4'b0, abs[bw_psum*4-1 : bw_psum*3]} +
                {4'b0, abs[bw_psum*5-1 : bw_psum*4]} +
                {4'b0, abs[bw_psum*6-1 : bw_psum*5]} +
                {4'b0, abs[bw_psum*7-1 : bw_psum*6]} +
                {4'b0, abs[bw_psum*8-1 : bw_psum*7]} ;
                fifo_wr <= 1;
            end
            else begin
                fifo_wr <= 0;
                
                if (div_2q) begin
                    for (k = 0; k<col; k = k+1) begin
                        sfp_in_temp[k] <= sfp_in_unsign[k];
                    end
                end
            end
        end
    end
    
    genvar j;
    
    generate
    for(j = 0; j<col; j = j+1) begin : lut_dividor
    lut_div lut_div_instance (
    .dividend(sfp_in_temp[j][7:0]),   // Dividend
    .divisor(sum_2core_temp[3:0]),   // Divisor
    .quotient(sfp_out_unsign[j][7:0])      // Quotient
    );
    end
    endgenerate
    
endmodule
    
