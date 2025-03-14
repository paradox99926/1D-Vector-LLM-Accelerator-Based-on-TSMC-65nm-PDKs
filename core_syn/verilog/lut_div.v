`timescale 1ns/1ps
module lut_div (
    input [7:0] dividend,    // 8-bit dividend
    input [3:0] divisor,     // 4-bit divisor
    output reg [7:0] quotient // 8-bit quotient
);

    // Lookup table for quotient: lut[divisor][dividend]
    (*rom_style = "block" *) reg [7:0] quotient_lut [15:0][255:0];

    // Initialize lookup table
    integer i, j;
    initial begin
        // Precompute quotients for all valid divisors (1-15)
        for (i = 1; i < 16; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                quotient_lut[i][j] = j / i;
            end
        end

        // Handle division by zero (set quotient to max value)
        for (j = 0; j < 256; j = j + 1) begin
            quotient_lut[0][j] = 8'hFF;
        end
    end

    // Directly lookup quotient from LUT
    always @(*) begin
        quotient = quotient_lut[divisor][dividend];
    end

endmodule