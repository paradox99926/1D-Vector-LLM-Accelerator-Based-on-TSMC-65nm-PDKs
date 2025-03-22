`timescale 1ns/1ps
module sram_w16_in (CLK,
                 D,
                 Q,
                 CEN,
                 WEN,
                 A);

    parameter initial_addr = 16;    // original SRAM depth is 16
    parameter sram_bit = 64;        // original SRAM width is 64 (data width)
    parameter spliter = 2;
    parameter sram_fold = sram_bit/spliter;
    parameter sram_addr = initial_addr*spliter;

    input  CLK;
    input  WEN;
    input  CEN;
    input  [sram_bit-1:0] D;
    input  [3:0] A;
    output reg [sram_bit-1:0] Q;
    
    // Rearranged to 32 (width) x 32 (depth)
    reg [sram_fold-1:0] memory [0:sram_addr-1]; // 32 memory units, each 32 bits wide

    
    always @ (posedge CLK) begin
        if (!CEN && WEN) begin // read operation
            // Combine 2 32-bit blocks into a 64-bit output
            Q <= {memory[{A, 1'b1}],memory[{A, 1'b0}]};
        end
        else if (!CEN && !WEN) begin // write operation
            // Split the 64-bit input into 2 32-bit blocks and write to memory
            memory[{A, 1'b0}] <= D[sram_fold-1:0];
            memory[{A, 1'b1}] <= D[sram_fold*2-1:sram_fold*1];
        end
            end
            
            endmodule
