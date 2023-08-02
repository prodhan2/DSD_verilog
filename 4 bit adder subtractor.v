module bcd_adder (sum,cout,a,b);

input [3:0]a,b;
output [3:0]sum;
wire w;
wire [3:0]z;
output cout;
assign {w,z} = a+b;

wire c,and_z2_z3,and_z1_z3;

and(and_z1_z3,z[1],z[3]);
and(and_z2_z3,z[2],z[3]);

or(c,w,and_z2_z3,and_z1_z3);

wire [3:0]m;
wire [3:0]n;

assign {m} = z; 
assign n[0] = 0;
assign n[3] = 0;
assign n[1] = c;
assign n[2] = c;

assign {cout,sum} = m+n;
    
endmodule

module bcd_adder_tester;
reg [3:0]a,b;
wire [3:0]sum;
wire cout;
bcd_adder bcd(sum,cout,a,b);

initial 
begin
#0      a = 4'b1000; b = 4'b 0001;
#100    a = 4'b1000; b = 4'b 0010;
#100    a = 4'b1000; b = 4'b 0011;
#100    a = 4'b1000; b = 4'b 0100;
#100    a = 4'b1000; b = 4'b 0101;
#100    a = 4'b1000; b = 4'b 0110;
#100    a = 4'b1000; b = 4'b 0111;
#100    a = 4'b1000; b = 4'b 1000;
#100    a = 4'b1000; b = 4'b 1001;
#100    a = 4'b1000; b = 4'b 1010;
#100    a = 4'b1000; b = 4'b 1011;
#100    a = 4'b1000; b = 4'b 1100;
#100    a = 4'b1000; b = 4'b 1101;


end
endmodule
