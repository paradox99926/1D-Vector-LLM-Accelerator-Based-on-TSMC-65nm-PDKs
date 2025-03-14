`include "adder4.v"
module adder16 (
    input  wire [15:0]  a   , // Input data, 16-bit two's complement
    input  wire [15:0]  b   , // Input data, 16-bit two's complement
    input  wire         cin , // Carry input from the lower bit
    output wire [15:0]  out , // Output sum a + b, 16-bit two's complement (excluding the highest carry bit)
    output wire         cout // Carry output of a + b
);

    // Level 1: Generate P and G for every 4 bits
    wire [15:0] p1 = a | b; // Propagate signal
    wire [15:0] g1 = a & b; // Generate signal
    wire [15:0] c;          // Carry output for each bit
    wire [3:0]  p2, g2;     // P and G for every 4 bits
    assign c[0] = cin;      // Carry input for the least significant bit

    genvar j;
    generate
        for (j = 0; j < 4; j = j + 1) begin
            adder4 u_adder4_l1 (
                .p(p1[(4*j+3)-:4]), // P for every 4 bits
                .g(g1[(4*j+3)-:4]), // G for every 4 bits
                .cin(c[j*4]),       // Carry input
                .P(p2[j]),          // P output for every 4 bits
                .G(g2[j]),          // G output for every 4 bits
                .cout(c[(4*j+3)-:3]) // Carry output for every 4 bits
            );
        end
    endgenerate

    // Level 2: Generate P and G for 16 bits
    wire [0:0] p3, g3; // P and G for 16 bits
    generate
        adder4 u_adder4_l2 (
            .p(p2),          // P for every 4 bits
            .g(g2),          // G for every 4 bits
            .cin(c[0]),     // Carry input for the least significant bit
            .P(p3[0]),       // P output for 16 bits
            .G(g3[0]),       // G output for 16 bits
            .cout({c[12], c[8], c[4]}) // Carry output for every 4 bits
        );
    endgenerate

    // Level 3: Compute the carry for the most significant bit
    // assign c[16] = g3[0] | (p3[0] & c[0]);

    // Compute the final sum
    assign out = a ^ b ^ c; // 16-bit addition result
    assign cout = (a[15] & b[15]) | (a[15] & c[15]) | (b[15] & c[15]); // Carry of the most significant bit

endmodule
