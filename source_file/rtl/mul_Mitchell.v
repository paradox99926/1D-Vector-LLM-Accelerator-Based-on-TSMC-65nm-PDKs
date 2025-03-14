`include "ECPETA.v"
module mul_Mitchell(input [7:0] a,
                    input [7:0] b,
                    output [15:0] out);
//reg define
reg  [2:0] n_0,n_1;
//wire define
wire [7:0] x_0 , x_1;
wire [15:0] n_x_0,n_x_1;  //n+x
wire [15:0] sum;          //n_x_0 + n_x_1
wire [7:0] sum_n;        //sum[15:8]
wire [15:0] sum_x;        //sum[7:0]
wire [7:0] p_c,q_c;
wire [15:0] c;

// complement signed numbers
complement complement_m0(
.in           (a),
.out          (p_c)
);
complement complement_m1(
.in           (b),
.out          (q_c)
);
complement #(
.WIDTH(16)
)
complement_m2(
.in           (c),
.out          (out)
);
always @(*)begin
    if (p_c[6]) n_0      = 'd6;
    else if (p_c[5]) n_0 = 'd5;
    else if (p_c[4]) n_0 = 'd4;
    else if (p_c[3]) n_0 = 'd3;
    else if (p_c[2]) n_0 = 'd2;
    else if (p_c[1]) n_0 = 'd1;
    else if (p_c[0]) n_0 = 'd0;
    else
    n_0 = 'd7;
end
always @(*)begin
    if (q_c[6]) n_1      = 'd6;
    else if (q_c[5]) n_1 = 'd5;
    else if (q_c[4]) n_1 = 'd4;
    else if (q_c[3]) n_1 = 'd3;
    else if (q_c[2]) n_1 = 'd2;
    else if (q_c[1]) n_1 = 'd1;
    else if (q_c[0]) n_1 = 'd0;
    else
    n_1 = 'd7;
end

assign x_0     = {1'b0,p_c[6:0]}<<(8-n_0);
assign x_1     = {1'b0,q_c[6:0]}<<(8-n_1);
assign n_x_0   = {n_0,x_0};
assign n_x_1   = {n_1,x_1};
// assign sum  = n_x_0 + n_x_1;
assign sum_n   = sum[15:8];
assign sum_x   = (sum_n>8)? {8'b0,sum[7:0]}<<(sum_n-8):{8'b0,sum[7:0]}>>(8-sum_n) ;
assign c[14:0] = ((&n_0) | (&n_1))? 'd0:(sum_x | (16'd1 << (sum_n)));
assign c[15]   = ((&n_0) | (&n_1))? 1'b0:p_c[7]^q_c[7];

ECPETA u_ECPETA16 (
.operand_a(n_x_0),  // First operand
.operand_b(n_x_1),  // Second operand
.sum_result(sum)  // Sum result
);

endmodule


module complement#(
    parameter WIDTH = 8
    )
    (
    input  [WIDTH-1:0] in,
    output [WIDTH-1:0] out
    );
    assign out[WIDTH-2:0] = (in[WIDTH-1])?((~in[WIDTH-2:0]) + 1'b1):in[WIDTH-2:0];
    assign out[WIDTH-1]   = in[WIDTH-1];
endmodule //complement
    
