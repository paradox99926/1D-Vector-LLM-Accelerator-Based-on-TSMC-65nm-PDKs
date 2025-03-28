module booth_decoder_1 (
    input  wire [7:0]  xin , // Multiplier x, 8-bit
    input  wire [2:0]  yin , // 3-bit control signal
    output wire        cout, // Indicates whether an increment is needed
    output wire [8:0]  xout  // Partial product after Booth encoding, 9-bit
);

    // Booth encoding control signals
    wire x_add1 = (~yin[2] & ~yin[1] & yin[0]) | (~yin[2] & yin[1] & ~yin[0]); // +x
    wire x_add2 = (~yin[2] & yin[1] & yin[0]);                                // +2x
    wire x_sub2 = (yin[2] & ~yin[1] & ~yin[0]);                               // -2x
    wire x_sub1 = (yin[2] & ~yin[1] & yin[0]) | (yin[2] & yin[1] & ~yin[0]);  // -x

    // Generate partial product
    assign xout = {9{x_add1}} & {xin[7], xin}           // +x
                | {9{x_add2}} & {xin[7:0], 1'b0}        // +2x
                | {9{x_sub1}} & {~xin[7], ~xin}        // -x
                | {9{x_sub2}} & {~xin[7:0], 1'b1}      // -2x
                ;

    // Determine whether an increment is needed
    assign cout = x_sub1 | x_sub2;

endmodule
