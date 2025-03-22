module fifo_mux_8_1 (out, sel, in0, in1, in2, in3, in4, in5, in6, in7 );

  parameter bw = 4;
  parameter simd = 8;

  input  [2:0 ] sel ;
  input  [simd*bw-1:0] in0;
  input  [simd*bw-1:0] in1;
  input  [simd*bw-1:0] in2;
  input  [simd*bw-1:0] in3;
  input  [simd*bw-1:0] in4;
  input  [simd*bw-1:0] in5;
  input  [simd*bw-1:0] in6;
  input  [simd*bw-1:0] in7;
  output [simd*bw-1:0] out;

  wire   [simd*bw-1:0] out_sub0_0, out_sub0_1, out_sub0_2, out_sub0_3 ;
  wire   [simd*bw-1:0] out_sub1_0, out_sub1_1 ;


 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1a (.in0(in0), .in1(in1), .sel(sel[0]), .out(out_sub0_0));
 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1b (.in0(in2), .in1(in3), .sel(sel[0]), .out(out_sub0_1));
 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1c (.in0(in4), .in1(in5), .sel(sel[0]), .out(out_sub0_2));
 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1d (.in0(in6), .in1(in7), .sel(sel[0]), .out(out_sub0_3));

 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1e (.in0(out_sub0_0), .in1(out_sub0_1), .sel(sel[1]), .out(out_sub1_0));
 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1f (.in0(out_sub0_2), .in1(out_sub0_3), .sel(sel[1]), .out(out_sub1_1));
 
 fifo_mux_2_1 #(.bw(bw), .simd(simd)) fifo_mux_2_1g (.in0(out_sub1_0), .in1(out_sub1_1), .sel(sel[2]), .out(out));


endmodule
