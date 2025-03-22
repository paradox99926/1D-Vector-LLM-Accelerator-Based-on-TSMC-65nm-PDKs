module mac_array (clk, reset, in, out, fifo_wr, inst);

parameter col = 8;
parameter bw = 8;
parameter bw_psum = 2*bw+6;
parameter pr = 8;

output [bw_psum*col-1:0] out;
input  [pr*bw-1:0] in;
input  clk, reset;
input  [1:0] inst; // [1]: execute, [0]: load 
output [col-1:0] fifo_wr;

wire   [col*bw_psum-1:0] psum;
wire   [2*(col+1)-1:0] inst_temp;
wire   [2*(col+1)*bw*pr-1:0] q_temp;

genvar i;

//for (i=0; i < col ; i=i+1) begin
//  assign fifo_wr[i] = inst_temp[2*i+1] ;
//end

assign inst_temp[1:0]    = inst;
assign q_temp[bw*pr-1:0] = in;

for (i=1; i < col+1 ; i=i+1) begin : col_idx
   mac_col #(.bw(bw), .bw_psum(bw_psum), .pr(pr), .col_id(i)) mac_col_inst (
        .q_in( q_temp[pr*bw*i-1    :pr*bw*(i-1)]), 
        .q_out(q_temp[pr*bw*(i+1)-1:pr*bw*i]), 
        .clk(clk), 
        .reset(reset), 
        .fifo_wr(fifo_wr[i-1]),
        .i_inst(inst_temp[2*i-1:2*(i-1)]),     
        .o_inst(inst_temp[2*(i+1)-1:2*(i)]),     
	.out(out[bw_psum*i-1 : bw_psum*(i-1)])
   );
end 

endmodule
