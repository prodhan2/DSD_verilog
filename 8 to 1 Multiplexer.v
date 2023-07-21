module Mulitplexer(d0,d1,d2,d3,d4,d5,d6,d7,sel,out);
input d0,d1,d2,d3,d4,d5,d6,d7;
input [2:0] sel;
output reg out;
always@(sel)
begin
case(sel)
3'b000:out=d0;
3'b001:out=d1;
3'b010:out=d2;
3'b011:out=d3;
3'b100:out=d4;
3'b101:out=d5;
3'b110:out=d6;
3'b111:out=d7;
endcase
end
endmodule


`timescale 1ns / 1ps

////////////////
module TestModule;
// Inputs
reg d0;
reg d1;
reg d2;
reg d3;
reg d4;
reg d5;
reg d6;
reg d7;
reg [2:0] sel;

// Outputs
wire out;

// Instantiate the Unit Under Test (UUT)
Mulitplexer uut (
.d0(d0),
.d1(d1),
.d2(d2),
.d3(d3),
.d4(d4),
.d5(d5),
.d6(d6),
.d7(d7),
.sel(sel),
.out(out)
);

initial begin
// Initialize Inputs
d0 = 0;
d1 = 0;
d2 = 0;
d3 = 0;
d4 = 0;
d5 = 0;
d6 = 0;
d7 = 0;
sel = 0;

// Wait 100 ns for global reset to finish
#100;

d0 = 0;
d1 = 0;
d2 = 0;
d3 = 0;
d4 = 1;
d5 = 1;
d6 = 0;
d7 = 1;
sel = 5;

// Wait 100 ns for global reset to finish
#100;

// Add stimulus here
end
endmodule
