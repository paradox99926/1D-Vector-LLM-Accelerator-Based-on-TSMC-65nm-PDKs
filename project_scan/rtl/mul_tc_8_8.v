`include "booth_decoder_4.v" // 8-bit Booth decoder, generates 4 partial products
// `include "adder16.v"       // 16-bit adder

module mul_tc_8_8 (
    input wire [7:0]  a         , // Input data, 8-bit two's complement
    input wire [7:0]  b         , // Input data, 8-bit two's complement
    output wire [15:0] product   // Output product a*b, 16-bit two's complement
);

    // Booth decoder generates 4 partial products
    wire [3:0] cout_t; // Carry output from Booth decoder, indicates if partial product needs "add one"
    wire [15:0] xout_t[3:0]; // 4 partial products, extended to 16 bits


    booth_decoder_4 u_booth_decoder_4 (
        .xin  (a        ), // 8-bit input
        .yin  (b        ), // 8-bit input
        .cout (cout_t   ), // 4-bit carry output
        .xout0(xout_t[0]), // Partial product 0
        .xout1(xout_t[1]), // Partial product 1
        .xout2(xout_t[2]), // Partial product 2
        .xout3(xout_t[3])  // Partial product 3
    );

assign product = xout_t[0] + xout_t[1] + xout_t[2] + xout_t[3] + cout_t[0]+ cout_t[1]+ cout_t[2]+ cout_t[3];


    // // Use 16-bit adder chain to sum 4 partial products
    // wire [15:0] sum_0, sum_1, sum_2;

    // // First adder: Partial product 0 + Partial product 1
    // adder16 u_adder16_0 (
    //     .a    (xout_t[0]), // Partial product 0
    //     .b    (xout_t[1]), // Partial product 1
    //     .cin  (cout_t[0]), // Carry input
    //     .out  (sum_0    ), // Sum of partial product 0 + 1
    //     .cout (         )  // Carry output (unused)
    // );

    // // Second adder: sum_0 + Partial product 2
    // adder16 u_adder16_1 (
    //     .a    (sum_0    ), // Sum of partial product 0 + 1
    //     .b    (xout_t[2]), // Partial product 2
    //     .cin  (cout_t[1]), // Carry input
    //     .out  (sum_1    ), // Sum of partial product 0 + 1 + 2
    //     .cout (         )  // Carry output (unused)
    // );

    // // Third adder: sum_1 + Partial product 3
    // adder16 u_adder16_2 (
    //     .a    (sum_1    ), // Sum of partial product 0 + 1 + 2
    //     .b    (xout_t[3]), // Partial product 3
    //     .cin  (cout_t[2]), // Carry input
    //     .out  (sum_2    ), // Final product
    //     .cout ( )          // Carry output (unused)
    // );

    // assign product = sum_2 + cout_t[3];

    // // Fourth adder: sum_1 + Partial product 4 (commented out)
    // adder16 u_adder16_3 (
    //     .a    (sum_2    ), // Sum of partial product 0 + 1 + 2
    //     .b    (16'b0    ), // Partial product 3
    //     .cin  (cout_t[3]),
    //     .out  (product  ), // Final product
    //     .cout ( )          // Carry output (unused)
    // );
    
endmodule