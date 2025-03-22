module fifo_depth16 (rd_clk, wr_clk, in, out, rd, wr, o_full, o_empty, reset);

  parameter bw = 4;
  parameter simd = 1;

  input  rd_clk;
  input  wr_clk;
  input  rd;
  input  wr;
  input  reset;
  output o_full;
  output o_empty;
  input  [simd*bw-1:0] in;
  output [simd*bw-1:0] out;

  wire full, empty;

  reg [4:0] rd_ptr;
  reg [4:0] wr_ptr;

  reg [simd*bw-1:0] q0;
  reg [simd*bw-1:0] q1;
  reg [simd*bw-1:0] q2;
  reg [simd*bw-1:0] q3;
  reg [simd*bw-1:0] q4;
  reg [simd*bw-1:0] q5;
  reg [simd*bw-1:0] q6;
  reg [simd*bw-1:0] q7;
  reg [simd*bw-1:0] q8;
  reg [simd*bw-1:0] q9;
  reg [simd*bw-1:0] q10;
  reg [simd*bw-1:0] q11;
  reg [simd*bw-1:0] q12;
  reg [simd*bw-1:0] q13;
  reg [simd*bw-1:0] q14;
  reg [simd*bw-1:0] q15;


 assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0 ;
 assign full  = ((wr_ptr[3:0] == rd_ptr[3:0]) && (wr_ptr[4] != rd_ptr[4])) ? 1'b1 : 1'b0;

 assign o_full  = full;
 assign o_empty = empty;


  fifo_mux_16_1 #(.bw(bw), .simd(simd)) fifo_mux_16_1a (.in0(q0), .in1(q1), .in2(q2), .in3(q3), .in4(q4), .in5(q5), .in6(q6), .in7(q7),
                                 .in8(q8), .in9(q9), .in10(q10), .in11(q11), .in12(q12), .in13(q13), .in14(q14), .in15(q15),
	                         .sel(rd_ptr[3:0]), .out(out));


 always @ (posedge rd_clk or posedge reset) begin
   if (reset) begin
      rd_ptr <= 5'b00000;
   end
   else if ((rd == 1) && (empty == 0)) begin
      rd_ptr <= rd_ptr + 1;
   end
 end


 always @ (posedge wr_clk or posedge reset) begin
   if (reset) begin
      wr_ptr <= 5'b00000;
   end
   else begin 
      if ((wr == 1) && (full == 0)) begin
        wr_ptr <= wr_ptr + 1;
      end

      if (wr == 1) begin
        case (wr_ptr[3:0])
         4'b0000   :    q0  <= in ;
         4'b0001   :    q1  <= in ;
         4'b0010   :    q2  <= in ;
         4'b0011   :    q3  <= in ;
         4'b0100   :    q4  <= in ;
         4'b0101   :    q5  <= in ;
         4'b0110   :    q6  <= in ;
         4'b0111   :    q7  <= in ;
         4'b1000   :    q8  <= in ;
         4'b1001   :    q9  <= in ;
         4'b1010   :    q10 <= in ;
         4'b1011   :    q11 <= in ;
         4'b1100   :    q12 <= in ;
         4'b1101   :    q13 <= in ;
         4'b1110   :    q14 <= in ;
         4'b1111   :    q15 <= in ;
        endcase
      end
   end

 end


endmodule
