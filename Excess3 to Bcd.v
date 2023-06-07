
module excess3toBcd(b,e);
input[3:0]e;
output [3:0]b;
not (b[0],e[0]);
xor(b[1],e[1],e[0]);
wire e1ande0;
and(e1ande0,e[1],e[0]);
xnor(b[2],e[2],e1ande0);
wire e3e2and;
and (e3e2and,e[3],e[2]);
wire e3e1e0and;
and(e3e1e0and,e[3],e[1],e[0]);
or (b[3],e3e2and,e3e1e0and);
endmodule 

module excess3toBcd_test;
reg [3:0]excess3;
wire [3:0]bcd;
excess3toBcd xx(.b(bcd),.e(excess3));
initial 
begin
#100 excess3 = 4'b0000;
#100 excess3 = 4'b0001;
#100 excess3 = 4'b0010;
#100 excess3 = 4'b0011;
#100 excess3 = 4'b0100;
#100 excess3 = 4'b0101;
#100 excess3 = 4'b0111;
#100 excess3 = 4'b1000;
end
endmodule 