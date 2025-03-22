module sram_w16 (CLK, D, Q, CEN, WEN, A);

  parameter sram_bit = 128;
  input  CLK;
  input  WEN;
  input  CEN;
  input  [sram_bit-1:0] D;
  input  [3:0] A;
  output reg [sram_bit-1:0] Q;

  reg [sram_bit-1:0] memory0;
  reg [sram_bit-1:0] memory1;
  reg [sram_bit-1:0] memory2;
  reg [sram_bit-1:0] memory3;
  reg [sram_bit-1:0] memory4;
  reg [sram_bit-1:0] memory5;
  reg [sram_bit-1:0] memory6;
  reg [sram_bit-1:0] memory7;
  reg [sram_bit-1:0] memory8;
  reg [sram_bit-1:0] memory9;
  reg [sram_bit-1:0] memory10;
  reg [sram_bit-1:0] memory11;
  reg [sram_bit-1:0] memory12;
  reg [sram_bit-1:0] memory13;
  reg [sram_bit-1:0] memory14;
  reg [sram_bit-1:0] memory15;

/*
  assign Q = (add_q == 0)  ? memory0 : (
             (add_q == 1)  ? memory1 : (
             (add_q == 2)  ? memory2 : (
             (add_q == 3)  ? memory3 : (
             (add_q == 4)  ? memory4 : (
             (add_q == 5)  ? memory5 : (
             (add_q == 6)  ? memory6 : (
             (add_q == 7)  ? memory7 : (
             (add_q == 8)  ? memory8 : (
             (add_q == 9)  ? memory9 : (
             (add_q == 10) ? memory10 : (
             (add_q == 11) ? memory11 : (
             (add_q == 12) ? memory12 : (
             (add_q == 13) ? memory13 : (
             (add_q == 14) ? memory14 : memory15))))))))))))));
*/

  always @ (posedge CLK) begin

   if (!CEN && WEN) begin // read 
     case (A)
      4'b0000: Q <= memory0; 
      4'b0001: Q <= memory1; 
      4'b0010: Q <= memory2; 
      4'b0011: Q <= memory3; 
      4'b0100: Q <= memory4; 
      4'b0101: Q <= memory5; 
      4'b0110: Q <= memory6; 
      4'b0111: Q <= memory7; 
      4'b1000: Q <= memory8; 
      4'b1001: Q <= memory9; 
      4'b1010: Q <= memory10; 
      4'b1011: Q <= memory11; 
      4'b1100: Q <= memory12; 
      4'b1101: Q <= memory13; 
      4'b1110: Q <= memory14; 
      4'b1111: Q <= memory15; 
    endcase
   end

   else if (!CEN && !WEN) begin // write
     case (A)
      4'b0000: memory0  <= D; 
      4'b0001: memory1  <= D; 
      4'b0010: memory2  <= D; 
      4'b0011: memory3  <= D; 
      4'b0100: memory4  <= D; 
      4'b0101: memory5  <= D; 
      4'b0110: memory6  <= D; 
      4'b0111: memory7  <= D; 
      4'b1000: memory8  <= D; 
      4'b1001: memory9  <= D; 
      4'b1010: memory10 <= D; 
      4'b1011: memory11 <= D; 
      4'b1100: memory12 <= D; 
      4'b1101: memory13 <= D; 
      4'b1110: memory14 <= D; 
      4'b1111: memory15 <= D; 
    endcase
  end
end

endmodule
