module fullchip (clk, mem_in, inst, reset, out);

parameter col = 8;
parameter bw = 8;
parameter bw_psum = 2*bw+4;
parameter pr = 8;
parameter core = 2;

input  clk; 
input  [pr*bw*core-1:0] mem_in; 
input  [19:0] inst; 
input  reset;
output [bw_psum*col*core-1:0] out;

wire [bw_psum*col-1:0] out_core0;
wire [bw_psum*col-1:0] out_core1;
assign out = {out_core1, out_core0};
wire [bw_psum+3:0] sum_core0;
wire [bw_psum+3:0] sum_core1;
wire div_ready0, div_ready1;
wire  clk_o;
assign clk_o = clk;

core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance0 (
      .reset(reset), 
      .clk(clk), 
      .clk_o(clk_o),
      .mem_in(mem_in[pr*bw*core-1:pr*bw]), 
      .inst(inst),
      .out(out_core0),
      .sum_out(sum_core0),
      .sum_in(sum_core1),
      .fifo_ext_rd(div_ready1),
      .div_ready(div_ready0)
);

core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance1 (
      .reset(reset), 
      .clk(clk_o), 
      .clk_o(clk),
      .mem_in(mem_in[pr*bw-1:0]), 
      .inst(inst),
      .out(out_core1),
      .sum_out(sum_core1),
      .sum_in(sum_core0),
      .fifo_ext_rd(div_ready0),
      .div_ready(div_ready1)
);

endmodule
