module full_adder (
    input  wire  [2:0] cin ,
    output wire        Cout,
    output wire        S    
);
    assign S = (cin[0]&~cin[1]&~cin[2])|(~cin[0]&cin[1]&~cin[2])|(~cin[0]&~cin[1]&cin[2])|(cin[0]&cin[1]&cin[2]);
    assign Cout = cin[0]&cin[1]|cin[0]&cin[2]|cin[1]&cin[2];
endmodule