`include "mac_array.v"
`include "ofifo.v"
// `include "sram_w16_in.v"
// `include "sram_w16_out.v"
`include "sfp_row.v"
`include "mux2X1.v"
`timescale 1ns/1ps
module core (clk,
             clk_o,
             sum_out,
             sum_in,
             mem_in,
             out,
             inst,
             reset,
             fifo_ext_rd,
             div_ready,
             test_mode,
             clk_scan,
             reset_scan,
             SI,
             SE,
             SO);
    
    parameter col     = 8;
    parameter bw      = 8;
    parameter bw_psum = 2*bw+4;
    parameter pr      = 8;
    
    output [bw_psum+3:0] sum_out;
    output [bw_psum*col-1:0] out;
    output div_ready;
    input  [bw_psum+3:0] sum_in;
    input  [pr*bw-1:0] mem_in;
    input  clk,clk_o;
    input  [20:0] inst;
    input  reset;
    input fifo_ext_rd;
    
    input  test_mode;//0: data; 1: scan
    input  clk_scan;
    input  reset_scan;
    input  wire   SE;
    input  wire [23:0] SI;
    output wire [23:0] SO;
    
    wire  [bw_psum*col-1:0] pmem_out;
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
    wire fifo_valid;
    
    wire  qmem_rd;
    wire  qmem_wr;
    wire  kmem_rd;
    wire  kmem_wr;
    wire  pmem_rd;
    wire  pmem_wr;
    
    wire acc;
    wire div;
    wire sfp_sel;
    wire sfp_wr2pmem;
    wire [bw_psum+3:0] sum_in;
    wire [bw_psum+3:0] sum_out;
    
    wire clk_scan_data;
    wire clk_o_scan_data;
    wire reset_scan_data;
    
    assign sfp_sel     = inst[20];
    assign div         = inst[19];
    assign acc         = inst[18];
    assign sfp_wr2pmem = inst[17];
    assign ofifo_rd    = inst[16];
    assign qkmem_add   = inst[15:12];
    assign pmem_add    = inst[11:8];
    
    assign qmem_rd = inst[5];
    assign qmem_wr = inst[4];
    assign kmem_rd = inst[3];
    assign kmem_wr = inst[2];
    assign pmem_rd = inst[1];
    assign pmem_wr = inst[0];
    
    assign mac_in  = inst[6] ? kmem_out : qmem_out;
    assign pmem_in = (sfp_wr2pmem & sfp_sel) ? sfp_out : fifo_out;
    assign out     = pmem_out;
    
    // DFT by pass
    wire qmem_rd_sel;
    wire qmem_wr_sel;
    wire kmem_rd_sel;
    wire kmem_wr_sel;
    wire pmem_rd_sel;
    wire pmem_wr_sel;
    wire [3:0] qkmem_add_sel;
    wire [3:0] pmem_add_sel;
    wire [pr*bw-1:0] mem_in_sel;
    wire [bw_psum*col-1:0] pmem_in_sel;
    wire [bw_psum*col-1:0] pmem_out_sel;
    wire [pr*bw-1:0] kmem_out_sel;
    wire [pr*bw-1:0] qmem_out_sel;
    
    assign qmem_rd_sel   = test_mode ? 0 : qmem_rd;
    assign qmem_wr_sel   = test_mode ? 0 : qmem_wr;
    assign kmem_rd_sel   = test_mode ? 0 : kmem_rd;
    assign kmem_wr_sel   = test_mode ? 0 : kmem_wr;
    assign pmem_rd_sel   = test_mode ? 0 : pmem_rd;
    assign pmem_wr_sel   = test_mode ? 0 : pmem_wr;
    assign qkmem_add_sel = test_mode ? 0 : qkmem_add;
    assign pmem_add_sel  = test_mode ? 0 : pmem_add;
    assign mem_in_sel    = test_mode ? 0 : mem_in;
    assign pmem_in_sel   = test_mode ? 0 : pmem_in;
    assign qmem_out      = test_mode ? mem_in  : qmem_out_sel;
    assign kmem_out      = test_mode ? mem_in  : kmem_out_sel;
    assign pmem_out      = test_mode ? pmem_in : pmem_out_sel;
    
    
    mux2X1 mux2X1_instance0(
    .IN_0(clk),
    .IN_1(clk_scan),
    .SEL(test_mode),
    .OUT(clk_scan_data)
    );
    
    mux2X1 mux2X1_instance1(
    .IN_0(clk_o),
    .IN_1(clk_scan),
    .SEL(test_mode),
    .OUT(clk_o_scan_data)
    );
    
    mux2X1 mux2X1_instance2(
    .IN_0(reset),
    .IN_1(reset_scan),
    .SEL(test_mode),
    .OUT(reset_scan_data)
    );
    
    mac_array #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) mac_array_instance (
    .in(mac_in),
    .clk(clk_scan_data),
    .reset(reset_scan_data),
    .inst(inst[7:6]),
    .fifo_wr(fifo_wr),
    .out(array_out)
    );
    
    ofifo #(.bw(bw_psum), .col(col))  ofifo_inst (
    .reset(reset_scan_data),
    .clk(clk_scan_data),
    .in(array_out),
    .wr(fifo_wr),
    .rd(ofifo_rd),
    .o_valid(fifo_valid),
    .out(fifo_out)
    );
    
    
    sram_w16_in #(.sram_bit(pr*bw)) qmem_instance (
    .CLK(clk_scan_data),
    .D(mem_in_sel),
    .Q(qmem_out_sel),
    .CEN(!(qmem_rd_sel||qmem_wr_sel)),
    .WEN(!qmem_wr_sel),
    .A(qkmem_add_sel)
    );
    
    sram_w16_in #(.sram_bit(pr*bw)) kmem_instance (
    .CLK(clk_scan_data),
    .D(mem_in_sel),
    .Q(kmem_out_sel),
    .CEN(!(kmem_rd_sel||kmem_wr_sel)),
    .WEN(!kmem_wr_sel),
    .A(qkmem_add_sel)
    );
    
    sram_w16_out #(.sram_bit(col*bw_psum)) psum_mem_instance (
    .CLK(clk_scan_data),
    .D(pmem_in_sel),
    .Q(pmem_out_sel),
    .CEN(!(pmem_rd_sel||pmem_wr_sel)),
    .WEN(!pmem_wr_sel),
    .A(pmem_add_sel)
    );
    
    sfp_row #(.bw(bw), .bw_psum(bw_psum), .col(col)) sfp_row_instance(
    .clk(clk_scan_data),
    .clk_o(clk_o_scan_data),
    .acc(acc),
    .div(div),
    .fifo_ext_rd(fifo_ext_rd),
    .reset(reset_scan_data),
    .sum_in(sum_in),
    .sum_out(sum_out),
    .sfp_in(pmem_out),
    .sfp_out(sfp_out),
    .div_ready(div_ready)
    );
    
    // assign out = sfp_sel? sfp_out : pmem_out;
    
    // always @(*) begin
    //     if (~clk) begin
    //         q_clk_fifo <= clk_en_fifo;
    //         q_clk_mac  <= clk_en_mac;
    //         q_clk_sfp  <= clk_en_sfp&sfp_sel;
    //     end
    // end
    
    // assign clk_fifo = clk&q_clk_fifo;
    // assign clk_mac  = clk&q_clk_mac;
    // assign clk_sfp  = clk&q_clk_sfp;
    
endmodule
