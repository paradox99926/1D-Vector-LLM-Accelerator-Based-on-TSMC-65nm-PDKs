`include "mul_tc_8_8.v"
`timescale 1ns/1ps
module mac_top (out,
                a,
                b);
    
    parameter bw      = 8;
    parameter bw_psum = 16;
    
    output  [bw_psum-1:0] out;
    input [bw-1:0] a;   // activation
    input  [bw-1:0]  b;   // weight
    
    wire [bw-1:0] a_p;   // activation
    wire  [bw-1:0]  b_p;   // weight
    wire [bw_psum-1:0] p_p;
    
    // wire [bw-1:0] a_ap;   // activation
    // wire  [bw-1:0]  b_ap;   // weight
    // wire  [bw_psum-1:0] p_ap;
    
    // assign a_p  = (a&b == = 0)? 0 : approximation? 0 : a;
    // assign b_p  = (a&b == = 0)? 0 : approximation? 0 : b;
    // assign a_ap = (a&b ==  = 0)? 0 : (~approximation)? 0 : a;
    // assign b_ap = (a&b ==  = 0)? 0 : (~approximation)? 0 : b;
    // assign out  = (a&b == = 0)? 0 : approximation? p_ap : p_p;
    
    assign a_p = (a&b == 0)? 0 : a;
    assign b_p = (a&b == 0)? 0 : b;
    assign out = (a&b == 0)? 0 : p_p;
    
    mul_tc_8_8 u_mul_tc_8_8 (
    .a(a_p),
    .b(b_p),
    .product(p_p)
    );
    
    // mul_Mitchell u_mul_Mitchell_8_8 (
    // .a(a_ap),
    // .b(b_ap),
    // .out(p_ap)
    // );
    
    
    
endmodule
