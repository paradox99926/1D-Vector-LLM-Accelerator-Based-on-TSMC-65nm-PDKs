module adder4
(
input    wire          cin ,
input    wire [3:0]    p   ,
input    wire [3:0]    g   ,
output   wire          G   ,
output   wire          P   ,
output   wire [2:0]    cout 
);

assign P=&p;
assign G=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0]);
assign cout[0]=g[0]|(p[0]&cin);
assign cout[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&cin);
assign cout[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin);
endmodule