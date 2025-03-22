
module fifo_depth16 (rd_clk,
                     wr_clk,
                     rd,
                     wr,
                     reset,
                     o_full,
                     o_empty,
                     in,
                     out);

    parameter simd = 1;         // SIMD width
    parameter DEPTH = 16;         // FIFO depth
    parameter bw = 24;         // Data bw
    
    input          rd_clk;    // Read clock
    input          wr_clk;    // Write clock
    input          rd;        // Read enable
    input          wr;        // Write enable
    input          reset;     // Reset signal
    output         o_full;    // FIFO full signal
    output         o_empty;   // FIFO empty signal
    input   [bw-1:0] in;        // 16-bit input data
    output  [bw-1:0] out;       // 16-bit output data
    
    reg [bw-1:0] fifo_mem [0:DEPTH-1];  // FIFO memory
    reg [4:0] wr_ptr;          // Write pointer
    reg [4:0] rd_ptr;          // Read pointer
    
    wire [4:0] wr_ptr_gray;                // Gray code of write pointer
    wire [4:0] rd_ptr_gray;                // Gray code of read pointer
    reg  [4:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;  // Write pointer gray code synchronized to read clock domain
    reg  [4:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;  // Read pointer gray code synchronized to write clock domain
    
    wire full, empty;                      // FIFO full and empty signals
    
    // Function to convert binary to Gray code
    function [4:0] binary_to_gray(input [4:0] binary);
        binary_to_gray = (binary >> 1) ^ binary;
    endfunction
    
    // Generate Gray code pointers
    assign wr_ptr_gray = binary_to_gray(wr_ptr);
    assign rd_ptr_gray = binary_to_gray(rd_ptr);
    
    // Synchronize write pointer to read clock domain
    always @(posedge rd_clk or posedge reset) begin
        if (reset) begin
            wr_ptr_gray_sync1 <= 5'b00000;
            wr_ptr_gray_sync2 <= 5'b00000;
            end 
            else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end
    
    // Synchronize read pointer to write clock domain
    always @(posedge wr_clk or posedge reset) begin
        if (reset) begin
            rd_ptr_gray_sync1 <= 5'b00000;
            rd_ptr_gray_sync2 <= 5'b00000;
            end 
            else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end
    
    // Generate FIFO full signal
    assign full = (wr_ptr_gray == {~rd_ptr_gray_sync2[4:3], rd_ptr_gray_sync2[2:0]});
    
    // Generate FIFO empty signal
    assign empty = (wr_ptr_gray_sync2 == rd_ptr_gray);
    
    assign o_full  = full;
    assign o_empty = empty;
    
    // Write logic
    always @(posedge wr_clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 5'b00000;
            end else if (wr && !full) begin
            fifo_mem[wr_ptr[3:0]] <= in;  // Write data
            wr_ptr                <= wr_ptr + 1;         // Increment write pointer
        end
    end
    
    // Read logic
    always @(posedge rd_clk or posedge reset) begin
        if (reset) begin
            rd_ptr <= 5'b00000;
            end else if (rd && !empty) begin
            rd_ptr <= rd_ptr + 1;         // Increment read pointer
        end
    end
    
    // Output data
    assign out = fifo_mem[rd_ptr[3:0]];
    
endmodule
