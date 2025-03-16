`timescale 1ns/1ps
module sram_w16_out (CLK,
                 D,
                 Q,
                 CEN,
                 WEN,
                 A);
    
    parameter sram_bit = 160;
    parameter sram_fold = sram_bit/4;
    parameter sram_addr = 16*4;
    input  CLK;
    input  WEN;//active low
    input  CEN;
    input  [sram_bit-1:0] D;
    input  [3:0] A;
    output reg [sram_bit-1:0] Q;
    
    // Rearranged to 40 (width) x 64 (height)
    reg [sram_fold-1:0] memory [0:sram_addr-1]; // 64 memory units, each 40 bits wide

    
    always @ (posedge CLK) begin
        if (!CEN && WEN) begin // read operation
            // Combine four 40-bit blocks into a 160-bit output
            Q <= {memory[{A, 2'b11}],memory[{A, 2'b10}],memory[{A, 2'b01}],memory[{A, 2'b00}]};
        end
        else if (!CEN && !WEN) begin // write operation
            // Split the 160-bit input into four 40-bit blocks and write to memory
            memory[{A, 2'b00}] <= D[sram_fold-1:0];
            memory[{A, 2'b01}] <= D[sram_fold*2-1:sram_fold*1];
            memory[{A, 2'b10}] <= D[sram_fold*3-1:sram_fold*2];
            memory[{A, 2'b11}] <= D[sram_fold*4-1:sram_fold*3];
        end
            end
            
            endmodule
