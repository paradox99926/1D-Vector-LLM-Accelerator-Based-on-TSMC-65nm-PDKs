`include "booth_decoder_1.v"
module booth_decoder_4 (
    input  wire [7:0]  xin       , // Multiplier x, 8-bit
    input  wire [7:0]  yin       , // Multiplier y, 8-bit
    output wire [3:0]  cout      , // Carry signal of partial products (whether to add one)
    output wire [15:0] xout0     , // Partial product 0
    output wire [15:0] xout1     , // Partial product 1
    output wire [15:0] xout2     , // Partial product 2
    output wire [15:0] xout3       // Partial product 3
);

    wire [15:0] xout[3:0]; // 4 partial products
    assign xout0 = xout[0];
    assign xout1 = xout[1];
    assign xout2 = xout[2];
    assign xout3 = xout[3];

    wire [8:0] yin_t = {yin, 1'b0}; // Extend yin by 1 bit for Booth encoding
    wire [8:0] xout_t[3:0]; // Partial products after Booth encoding

    genvar j;
    generate
        for (j = 0; j < 4; j = j + 1) begin : booth_decoder_loop
            booth_decoder_1 u_booth_decoder (
                .xin  (xin),                     // 8-bit multiplier x
                .yin  (yin_t[(j+1)*2-:3]),       // Extract 3 bits for Booth encoding
                .xout (xout_t[j]),               // Partial product after Booth encoding
                .cout (cout[j])                  // Carry signal
            );
            // Extend partial product to 16 bits
            assign xout[j] = {
                {(7-j*2){xout_t[j][8]}}, // Sign extension
                xout_t[j],                // Partial product after Booth encoding
                {(j*2){cout[j]}}          // Zero-padding or carry propagation at lower bits
            };
        end
    endgenerate


endmodule
