
module adder_subtractor(s,cout,a,b,mode);
    input [3:0] a, b;
    input mode;
    output [3:0] s;
    output cout;
    wire c0, c1, c2;
    full_adder fa1(s[0], c0, a[0], (b[0]^mode), mode);
    full_adder fa2(s[1], c1, a[1], (b[1]^mode), c0);
    full_adder fa3(s[2], c2, a[2], (b[2]^mode), c1);
    full_adder fa4(s[3], cout, a[3], (b[3]^mode), c2);
endmodule

module full_adder(s, cout, a, b, cin);
    input a, b, cin;
    output s, cout;
    wire p, q, r;
    half_adder ha1(p, q, a, b);
    half_adder ha2(s, r, p, cin);
    or(cout, q, r);
endmodule

module half_adder(s, cout, a, b);
    input a, b;
    output s, cout;
    xor(s, a, b);
    and(cout, a, b);
endmodule
module FourAdder_subtractor_tester;

reg [3:0]a,b;
reg mode;
wire [3:0]s;
wire cout;

adder_subtractor four_a_s(s,cout,a,b,mode);
initial
begin

         #0  a = 4'b11;   b = 4'b1;    mode = 0; // 4
        #50 a = 4'b100;  b = 4'b10;   mode = 0; // 6
        #50 a = 4'b101;  b = 4'b110;  mode = 0; // 11
        #50 a = 4'b110;  b = 4'b111;  mode = 0; // 13
        #50 a = 4'b111;  b = 4'b1000; mode = 0; // 15
        #50 a = 4'b1001; b = 4'b1000; mode = 1; // 1
        #50 a = 4'b1001; b = 4'b11;   mode = 1; // 6
        #50 a = 4'b1100; b = 4'b1000; mode = 1; // 4
        #50 a = 4'b1100; b = 4'b11;   mode  = 1; // 9
end

endmodule
