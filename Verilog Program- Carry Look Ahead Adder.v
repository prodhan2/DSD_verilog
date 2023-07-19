

module CLA_Adder(a,b,cin,sum,cout);
input[3:0] a,b;
input cin;
output [3:0] sum;
output cout;
wire p0,p1,p2,p3,g0,g1,g2,g3,c1,c2,c3,c4;
assign p0=(a[0]^b[0]),
p1=(a[1]^b[1]),
p2=(a[2]^b[2]),
p3=(a[3]^b[3]);
assign g0=(a[0]&b[0]),
g1=(a[1]&b[1]),
g2=(a[2]&b[2]),
g3=(a[3]&b[3]);
assign c0=cin,
c1=g0|(p0&cin),
c2=g1|(p1&g0)|(p1&p0&cin),
c3=g2|(p2&g1)|(p2&p1&g0)|(p1&p1&p0&cin),
c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&cin);
assign sum[0]=p0^c0,
sum[1]=p1^c1,
sum[2]=p2^c2,
sum[3]=p3^c3;
assign cout=c4;
endmodule



//Testbench Code- Carry Look Ahead Adder

module TestModule;
// Inputs
reg [3:0] a;
reg [3:0] b;
reg cin;

// Outputs
wire [3:0] sum;
wire cout;

// Instantiate the Unit Under Test (UUT)
CLA_Adder uut (
.a(a),
.b(b),
.cin(cin),
.sum(sum),
.cout(cout)
);
initial begin
// Initialize Inputs
a = 0;
b = 0;
cin = 0;
// Wait 100 ns for global reset to finish
#100;
a = 5;
b = 6;
cin = 1;
// Wait 100 ns for global reset to finish
#100;
end
endmodule
