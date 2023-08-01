module bcd_to_excess3(e,b);
input [3:0] b;
output [3:0] e;
not(e[0],b[0]);
wire BO_B1;
or (BO_B1,b[0],b[1]);
not(e[1],BO_B1);
xor(e[2],BO_B1,b[2]);
wire B0_B1andb2;
and(B0_B1andb2,BO_B1,b[2]);
or(e[3],B0_B1andb2,b[3]);
endmodule

module BBtoEE_test;
reg[3:0] b;
wire [3:0] e;
bcd_to_excess3 XX(e,b);
 
initial begin 
#100 b = 4'b0000;
#100 b = 4'b0001;
#100 b = 4'b0010;
#100 b = 4'b0011;
#100 b = 4'b0101;
end
endmodule
