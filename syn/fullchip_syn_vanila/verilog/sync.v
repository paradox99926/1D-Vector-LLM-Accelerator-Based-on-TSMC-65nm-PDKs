module sync(clk, in, out);

input  in; 
input  clk;
output out;

reg    int1; 
reg    int2; 

assign out = int2;

always @ (posedge clk) begin
   int1 <= in;
   int2 <= int1;
end

endmodule
