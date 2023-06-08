module HalfAdder(a,b,sum,carry);
input a,b;
output sum,carry;
xor(sum,a,b);
and(carry,a,b);
endmodule


module TestModule;
// Inputs
reg a;
reg b;

// Outputs
wire sum;
wire carry;

// Instantiate the Unit Under Test (UUT)
HalfAdder uut (.a(a),.b(b),.sum(sum),.carry(carry));

initial begin
// Initialize Inputs
a = 0;
b = 0;
// Wait 100 ns for global reset to finish
#100
a = 1;
b = 0;
end
endmodule
