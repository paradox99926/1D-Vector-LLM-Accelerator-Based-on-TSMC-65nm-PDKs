`include "mac_top.v"
`timescale 1ns/1ps
module mac_16in (out,
                 a,
                 b,
                 clk,
                 reset);
    
    parameter bw      = 8;
    parameter bw_psum = 2*bw+6;
    parameter pr      = 8; // parallel factor: number of inputs      = 64
    
    output [bw_psum-1:0] out;
    input  [pr*bw-1:0] a;
    input  [pr*bw-1:0] b;
    input  clk;
    input  reset;
    
    wire   [2*bw-1:0] product [pr-1:0];
    reg    [bw_psum-1:0] temp [pr-1:0];
    
    
    genvar i;
    generate
    for (i = 0; i<pr ; i = i+1) begin
        mac_top #(.bw(bw), .bw_psum(2*bw)) mac_instance(.out(product[i]),
        .a(a[bw*(i+1)-1:bw*i]),
        .b(b[bw*(i+1)-1:bw*i]));
    end
    endgenerate
    
    integer j;
    always @(posedge clk) begin
        if (reset) begin
            for (j = 0; j<pr ; j = j+1) begin
                temp[j] <= 0;
            end
        end
        else begin
            for (j = 0; j<pr ; j = j+1) begin
                temp[j] <= {{(4){product[j][2*bw-1]}},product[j]};
            end
        end
    end
    
    assign out = temp[0]+temp[1]+temp[2]+temp[3]
    +temp[4]+temp[5]+temp[6]+temp[7];

endmodule
