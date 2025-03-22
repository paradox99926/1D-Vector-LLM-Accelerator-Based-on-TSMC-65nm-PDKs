module core (clk, clk_o, sum_out, mem_in, out, inst, reset, div_ready, fifo_ext_rd, sum_in);

parameter col = 8;
parameter bw = 8;
parameter bw_psum = 2*bw+4;
parameter pr = 8;

output [bw_psum+3:0] sum_out;
output [bw_psum*col-1:0] out;
output div_ready;
wire   [bw_psum*col-1:0] pmem_out;
input  [pr*bw-1:0] mem_in;
input  clk;
input  clk_o;
input  [19:0] inst; 
input  reset;
input fifo_ext_rd;
input [bw_psum+3:0] sum_in;

wire  [pr*bw-1:0] mac_in;
wire  [pr*bw-1:0] kmem_out;
wire  [pr*bw-1:0] qmem_out;
wire  [bw_psum*col-1:0] pmem_in;
wire  [bw_psum*col-1:0] fifo_out;
wire  [bw_psum*col-1:0] sfp_out;
wire  [bw_psum*col-1:0] array_out;
wire  [col-1:0] fifo_wr;
wire  ofifo_rd;
wire [3:0] qkmem_add;
wire [3:0] pmem_add;

wire  qmem_rd;
wire  qmem_wr; 
wire  kmem_rd;
wire  kmem_wr; 
wire  pmem_rd;
wire  pmem_wr; 

assign ofifo_rd = inst[16];
assign qkmem_add = inst[15:12];
assign pmem_add = inst[11:8];

assign sfp_wr2pmem = inst[19];
assign sfp_div = inst[18];
assign sfp_acc = inst[17];

assign qmem_rd = inst[5];
assign qmem_wr = inst[4];
assign kmem_rd = inst[3];
assign kmem_wr = inst[2];
assign pmem_rd = inst[1];
assign pmem_wr = inst[0];

assign mac_in  = inst[6] ? kmem_out : qmem_out;
assign pmem_in = (sfp_wr2pmem == 1)? sfp_out : fifo_out;
assign out = pmem_out;

mac_array #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) mac_array_instance (
        .in(mac_in), 
        .clk(clk), 
        .reset(reset), 
        .inst(inst[7:6]),     
        .fifo_wr(fifo_wr),     
	.out(array_out)
);

ofifo #(.bw(bw_psum), .col(col))  ofifo_inst (
        .reset(reset),
        .clk(clk),
        .in(array_out),
        .wr(fifo_wr),
        .rd(ofifo_rd),
        .out(fifo_out)
);


sram_w16_in #(.sram_bit(pr*bw)) qmem_instance (
        .clk(clk),
        .D(mem_in),
        .Q(qmem_out),
        .CEN(!(qmem_rd||qmem_wr)),
        .WEN(!qmem_wr), 
        .A(qkmem_add)
);

sram_w16_in #(.sram_bit(pr*bw)) kmem_instance (
        .clk(clk),
        .D(mem_in),
        .Q(kmem_out),
        .CEN(!(kmem_rd||kmem_wr)),
        .WEN(!kmem_wr), 
        .A(qkmem_add)
);


sram_w16_out #(.sram_bit(col*bw_psum)) psum_mem_instance (
        .clk(clk),
        .D(pmem_in),
        .Q(pmem_out),
        .CEN(!(pmem_rd||pmem_wr)),
        .WEN(!pmem_wr), 
        .A(pmem_add)
);

sfp_row #(.bw(bw), .col(col)) sfp_instance (
        .clk(clk),
        .clk_o(clk_o),
        .reset(reset),
        .acc(sfp_acc),
        .div(sfp_div),
        .fifo_ext_rd(fifo_ext_rd),
        .sum_in(sum_in),
        .sum_out(sum_out),
        .sfp_in(pmem_out),
        .sfp_out(sfp_out),
        .div_ready(div_ready)
);

/*
  //////////// For printing purpose ////////////
  always @(posedge clk) begin
        //if(pmem_wr)
        //        $display("Memory write to PSUM mem add %x %x ", pmem_add, pmem_in); 
        //if(sfp_div)
        //        $display("SFP div result %x ", sfp_out);
  end
*/


endmodule
