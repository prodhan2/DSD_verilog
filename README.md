Digital System Design with Verilog
Reference Books:
Verilog HDL - Samir Palnitkar
Digital Logic and Computer Design - M. Morris Mano
Contents (listed alphabetically)
Adder Subtractor
BCD to Excess3 Code Converter
Binary to Gray Code Converter
Carry Look Ahead Adder
Decoder (3-to-8 line)
Demultiplexer (1-to-4)
Encoder (8-to-3 line)
Excess3 to BCD Code Converter
Full Adder (using half adder)
Gray to Binary Code Converter
Half Adder
JK Flip Flop (master slave)
Magnitude Comparator (2-bit)
Mod-10 Asynchronous Counter
Mod-10 Synchronous Counter
Multiplexer (4-to-1)
Multiplier (2-bit by 2-bit)
Ripple Carry Counter (4-bit/Mod-16)
Synchronous Up Down Counter (3-bit)
Random Sequence (4-bit)
Adder Subtractor (4-bit)
adder_subtractor

Code
module adder_subtractor(s, cout, a, b, mode);
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
BCD to Excess-3 Code Converter
bcd_to_excess_3

Code
module bcd_to_excess_3(b, a);
	input [3:0] a;
	output [3:0] b;
	wire p, q;
	assign b[0] = ~a[0];
	xnor(b[1], a[1], a[0]);
	or(p, a[1], a[0]);
	xor(b[2], a[2], p);
	and(q, a[2], p);
	or(b[3], a[3], q);
endmodule

module bcd_stimulus;
	reg [3:0] a;
	wire [3:0] b;
	bcd_to_excess_3 bcd(b, a);
	initial
	begin
	    a = 4'b0000;
	#50 a = 4'b0001;
	#50 a = 4'b0010;
	#50 a = 4'b0011;
	#50 a = 4'b0100;
	#50 a = 4'b0101;
	#50 a = 4'b0110;
	#50 a = 4'b0111;
	#50 a = 4'b1000;
	#50 a = 4'b1001;
	#50 $finish;
	end
endmodule
Binary to Gray Code Converter
binary_to_gray

Code
module binary_to_gray(g, b);
	input [3:0] b;
	output [3:0] g;
	assign g[3] = b[3];
	xor(g[2], b[3], b[2]);
	xor(g[1], b[2], b[1]);
	xor(g[0], b[1], b[0]);
endmodule

module binary_stimulus;
    reg [3:0] b;
    wire [3:0] g;
    binary_to_gray b1(g, b);
    initial
    begin
        b = 4'b0000;
    #50 b = 4'b0001;
    #50 b = 4'b0010;
    #50 b = 4'b0011;
    #50 b = 4'b0100;
    #50 b = 4'b0101;
    #50 b = 4'b0110;
    #50 b = 4'b0111;
    #50 b = 4'b1000;
    #50 b = 4'b1001;
    #50 b = 4'b1010;
    #50 b = 4'b1011;
    #50 b = 4'b1100;
    #50 b = 4'b1101;
    #50 b = 4'b1110;
    #50 b = 4'b1111;
    #200 $finish;
    end
endmodule
Carry Look Ahead Adder
cla

Code
module carry_look_ahead_adder(s, cout, a, b, cin);
    input [3:0] a, b;
    input cin;
    output [3:0] s;
    output cout;
    wire [3:0] p, g, c;
    assign p = a ^ b;
    assign g = a & b;
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);
    assign s = p ^ c;
endmodule

module cla_stimulus;
	reg [3:0] a, b;
	reg cin;
	wire [3:0] s;
	wire cout;
	carry_look_ahead_adder cla1(s, cout, a, b, cin);
	initial
	begin
	    a = 4'b0000; b = 4'b0000; cin = 1'b0;
	#50 a = 4'b0001; b = 4'b0001;
	#50 a = 4'b0001; b = 4'b0001; cin = 1'b1;
	#50 a = 4'b1010; b = 4'b0101; cin = 1'b0;
	#50 a = 4'b0111; b = 4'b0101;
	#50 a = 4'b1000; b = 4'b1001;
	#50 a = 4'b0011; b = 4'b0011;
	#50 a = 4'b0011; b = 4'b0011; cin = 1'b1;
	#50 a = 4'b1010; b = 4'b0101;
	#200 $finish;
	end
endmodule
Decoder (3-to-8 line)
decoder_3_to_8

Code
module decoder_3_to_8(d, a, en);
    input [2:0] a;
    input en; //To enable circuit
    output [7:0] d;
    and(d[0], ~a[0], ~a[1], ~a[2], en);
    and(d[1], a[0], ~a[1], ~a[2], en);
    and(d[2], ~a[0], a[1], ~a[2], en);
    and(d[3], a[0], a[1], ~a[2], en);
    and(d[4], ~a[0], ~a[1], a[2], en);
    and(d[5], a[0], ~a[1], a[2], en);
    and(d[6], ~a[0], a[1], a[2], en);
    and(d[7], a[0], a[1], a[2], en);
endmodule

module decoder_stimulus;
    reg en;
    reg [2:0] a;
    wire [7:0] d;
    decoder_3_to_8 d1(d, a, en);
    initial
    begin
    a = 3'b110; en = 1'b0;
    #50 a = 3'b000; en = 1'b1;
    #50 a = 3'b001;
    #50 a = 3'b010;
    #50 a = 3'b011;
    #50 a = 3'b100;
    #50 a = 3'b101;
    #50 a = 3'b110;
    #50 a = 3'b111;
    #50 a = 3'b111; en = 1'b0;
    #200 $finish;
    end
endmodule
Demultiplexer (1-to-4)
demux_1_to_4

Code
module demux_1_to_4(d, x, s);
    input x;
    input [1:0] s;
    output [3:0] d;
    and(d[0], x, ~s[0], ~s[1]);
    and(d[1], x, ~s[1], s[0]);
    and(d[2], x, s[1], ~s[0]);
    and(d[3], x, s[1], s[0]);
endmodule

module demux_stimulus;
    reg x;
    reg [1:0] s;
    wire [3:0] d
    demux_1_to_4 d1(d, x, s);
    initial
    begin
    x = 1'b0;
    #50 x = 1'b1; s = 2'b00;
    #50 s = 2'b01;
    #50 s = 2'b10;
    #50 s = 2'b11;
    #200 $finish;
    end
endmodule
Encoder (8-to-3 line)
encoder

Code
module encoder(y, x);
    input [7:0] x;
    output [2:0] y;
    or(y[0], x[1], x[3], x[5], x[7]);
    or(y[1], x[2], x[3], x[6], x[7]);
    or(y[2], x[4], x[5], x[6], x[7]);
endmodule

module encoder_stimulus;
    reg [7:0] x;
    wire [2:0] y;
    encoder en1(y, x);
    initial
    begin
         x = 8'b00000001;
    #100 x = 8'b00000010;
    #100 x = 8'b00000100;
    #100 x = 8'b00001000;
    #100 x = 8'b00010000;
    #100 x = 8'b00100000;
    #100 x = 8'b01000000;
    #100 x = 8'b10000000;
    #200 $finish;
    end
endmodule
Excess-3 to BCD Code Converter
excess3_to_bcd

Code
module excess_3_to_bcd(b, a);
	input [3:0] a;
	output [3:0] b;
	assign b[0] = ~a[0];
	xor(b[1], a[1], a[0]);
	xor(b[2], a[2], (~a[1] | ~a[0]));
	and(b[3], a[3], (a[2] | (a[1] & a[0])));
endmodule

module excess3_stimulus;
	reg [3:0] a;
	wire [3:0] b;
	excess_3_to_bcd excess(b, a);
	initial
	begin
	    a = 4'b0011;
	#50 a = 4'b0100;
	#50 a = 4'b0101;
	#50 a = 4'b0110;
	#50 a = 4'b0111;
	#50 a = 4'b1000;
	#50 a = 4'b1001;
	#50 a = 4'b1010;
	#50 a = 4'b1011;
	#50 a = 4'b1100;
	#50 $finish;
	end
endmodule
Full Adder (using half adder)
full_adder

Code
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
Gray to Binary Code Converter
gray_to_binary

Code
module gray_to_binary(g, b);
	input [3:0] b;
	output [3:0] g;
	assign g[3] = b[3];
	xor(g[2], g[3], b[2]);
	xor(g[1], g[2], b[1]);
	xor(g[0], g[1], b[0]);
endmodule

module gray_stimulus;
    reg [3:0] b;
    wire [3:0] g;
    gray_to_binary b1(g, b);
    initial
    begin
        b = 4'b0000;
    #50 b = 4'b0001;
    #50 b = 4'b0011;
    #50 b = 4'b0010;
    #50 b = 4'b0110;
    #50 b = 4'b0111;
    #50 b = 4'b0101;
    #50 b = 4'b0100;
    #50 b = 4'b1100;
    #50 b = 4'b1101;
    #50 b = 4'b1111;
    #50 b = 4'b1110;
    #50 b = 4'b1010;
    #50 b = 4'b1011;
    #50 b = 4'b1001;
    #50 b = 4'b1000;
    #200 $finish;
    end
endmodule
Half Adder
half_adder

Code
module half_adder(s, c, a, b);
    input a, b;
    output s, c;
    xor(s, a, b);
    and(c, a, b);
endmodule

module half_adder_stimulus;
    reg a, b;
    wire s, c;
    half_adder ha1(s, c, a, b);
    initial
    begin
    a = 1'b0; b = 1'b0;
    #50 b = 1'b1;
    #50 a = 1'b1; b = 1'b0;
    #50 b = 1'b1;
    #200 $finish;
    end
endmodule
JK Flip Flop (master slave)
jk_flip_flop

Code
module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(y, a, y_bar);
	nand(y_bar, y, clear, b);
	not(c_bar, clk);
	nand(c, y, c_bar);
	nand(d, y_bar, c_bar);
	nand(q, c, q_bar);
	nand(q_bar, q, clear, d);
endmodule
Magnitude Comparator (2-bit)
magnitude_comparator

Code
module magnitude_comparator(g, e, s, a, b);
    input [1:0] a, b;
    output g, e, s; // g = (A>B), e = (A=B), s = (A<B)
    or(g, (a[1] & ~b[1]), (a[1] & a[0] & ~b[0]), (a[0] & ~b[1] & ~b[0]));
    and(e, ~(a[1] ^ b[1]), ~(a[0] ^ b[0]));
    or(s, (~a[1] & b[1]), (~a[1] & ~a[0] & b[0]), (~a[0] & b[1] & b[0]));
endmodule

module comparator_stimulus;
    reg [1:0] a, b;
    wire g, e, s;
    magnitude_comparator m1(g, e, s, a, b);
    initial
    begin
    a = 2'b00; b = 2'b00;
    #50 a = 2'b00; b = 2'b01;
    #50 a = 2'b00; b = 2'b10;
    #50 a = 2'b00; b = 2'b11;
    #50 a = 2'b01; b = 2'b00;
    #50 a = 2'b01; b = 2'b01;
    #50 a = 2'b01; b = 2'b10;
    #50 a = 2'b01; b = 2'b11;
    #50 a = 2'b10; b = 2'b00;
    #50 a = 2'b10; b = 2'b01;
    #50 a = 2'b10; b = 2'b10;
    #50 a = 2'b10; b = 2'b11;
    #50 a = 2'b11; b = 2'b00;
    #50 a = 2'b11; b = 2'b01;
    #50 a = 2'b11; b = 2'b10;
    #50 a = 2'b11; b = 2'b11;
    #200 $finish;
    end
endmodule
Mod-10 Asynchronous Counter
mod-10-async-counter

Code
module mod_10_asyn_counter(q, clear, clk);
    input clear, clk;
    output [3:0] q;
    wire a;
    nand(a, q[1], q[3]);
    jk_flip_flop jk0(q[0],,1,1,(clear && a), clk);
    jk_flip_flop jk1(q[1],,1,1,(clear && a), q[0]);
    jk_flip_flop jk2(q[2],,1,1,(clear && a), q[1]);
    jk_flip_flop jk3(q[3],,1,1,(clear && a), q[2]);
endmodule

module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(c, a, d);
	nand(d, c, clear, b);
	not(c_bar, clk);
	nand(y, c, c_bar);
	nand(y_bar, d, c_bar);
	nand(q, y, q_bar);
	nand(q_bar, q, clear, y_bar);
endmodule
Mod-10 Synchronous Counter
mod-10-sync-counter

Code
module mod_10_synchronous_counter(q, clear, clk);
    input clear, clk;
    output [3:0] q;
    wire a, b, c, d, e;
    jk_flip_flop jk1(q[0],,1,1,clear,clk);
    and(a, ~q[3], q[0]);
    jk_flip_flop jk2(q[1],,a,a,clear,clk);
    and(b, q[1], q[0]);
    jk_flip_flop jk3(q[2],,b,b,clear,clk);
    and(c, q[0], q[3]);
    and(d, q[2], b);
    or(e, c, d);
    jk_flip_flop jk4(q[3],,e,e,clear,clk);
endmodule

module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(y, a, y_bar);
	nand(y_bar, y, clear, b);
	not(c_bar, clk);
	nand(c, y, c_bar);
	nand(d, y_bar, c_bar);
	nand(q, c, q_bar);
	nand(q_bar, q, clear, d);
endmodule
Multiplexer (4-to-1 line)
mux_4_to_1

Code
module mux_4_to_1(f, i, s);
    input [3:0] i;
    input [1:0] s;
    output f;
    wire a, b, c, d;
    and(a, i[0], ~s[1], ~s[0]);
    and(b, i[1], ~s[1], s[0]);
    and(c, i[2], s[1], ~s[0]);
    and(d, i[3], s[1], s[0]);
    or(f, a, b, c, d);
endmodule

module mux_stimulus;
    reg [3:0] i;
    reg [1:0] s;
    wire f;
    mux_4_to_1 m1(f, i, s);
    initial
    begin
    i = 4'b1110; s = 2'b00;
    #50 i = 4'b1001;
    #50 i = 4'b0101; s = 2'b01;
    #50 i = 4'b0010;
    #50 i = 4'b1011; s = 2'b10;
    #50 i = 4'b0100;
    #50 i = 4'b0111; s = 2'b11;
    #50 i = 4'b1000;
    #200 $finish;
    end
endmodule
Multiplier (2-bit by 2-bit)
multiplier

Code
module multiplier_2x2(p, a, b);
	input [1:0] a, b; //b is multiplicand and a is multiplier
	output [3:0] p;
	wire c1;
	assign p[0] = a[0] & b[0];
	half_adder ha1(p[1], c1, a[0]&b[1], a[1]&b[0]);
	half_adder ha2(p[2], p[3], c1, a[1]&b[1]);
endmodule

module half_adder(s, c, a, b);
	input a, b;
	output s,c;
	assign s = a ^ b;
	assign c = a & b;
endmodule

module multiplier_stimulus;
    reg [1:0] a, b;
    wire [3:0] p;
    multiplier_2x2 m1(p, a, b);
    initial
    begin
        a = 2'b00; b = 2'b00;
    #50 a = 2'b00; b = 2'b01;
    #50 a = 2'b00; b = 2'b10;
    #50 a = 2'b00; b = 2'b11;
    #50 a = 2'b01; b = 2'b00;
    #50 a = 2'b01; b = 2'b01;
    #50 a = 2'b01; b = 2'b10;
    #50 a = 2'b01; b = 2'b11;
    #50 a = 2'b10; b = 2'b00;
    #50 a = 2'b10; b = 2'b01;
    #50 a = 2'b10; b = 2'b10;
    #50 a = 2'b10; b = 2'b11;
    #50 a = 2'b11; b = 2'b00;
    #50 a = 2'b11; b = 2'b01;
    #50 a = 2'b11; b = 2'b10;
    #50 a = 2'b11; b = 2'b11;
    #200 $finish;
    end
endmodule
Ripple Carry Counter (4-bit)
ripple_carry_counter

Code
module ripple_carry_counter(q, clear, clk);
	input clk, clear;
	output [3:0] q;
	jk_flip_flop jk1(q[0], , 1, 1, clear, clk);
	jk_flip_flop jk2(q[1], , 1, 1, clear, q[0]);
	jk_flip_flop jk3(q[2], , 1, 1, clear, q[1]);
	jk_flip_flop jk4(q[3], , 1, 1, clear, q[2]);
endmodule

module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(y, a, y_bar);
	nand(y_bar, y, clear, b);
	not(c_bar, clk);
	nand(c, y, c_bar);
	nand(d, y_bar, c_bar);
	nand(q, c, q_bar);
	nand(q_bar, q, clear, d);
endmodule
Synchronous Up Down Counter (3-bit)
sync_up_down_counter

Code
module sync_up_down_counter(q, ud, clear, clk);
    input ud, clear, clk; //ud means up/down: 0=down, 1=up
    output [2:0] q;
    wire a, b, c, d;
    jk_flip_flop jk1(q[0],,1,1,clear,clk);
    xnor(a, ud, q[0]);
    jk_flip_flop jk2(q[1],,a,a,clear, clk);
    and(b, !q[1], !q[0], !ud);
    and(c, q[1], q[0], ud);
    or(d, b, c);
    jk_flip_flop jk3(q[2],,d,d,clear,clk);
endmodule

module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(y, a, y_bar);
	nand(y_bar, y, clear, b);
	not(c_bar, clk);
	nand(c, y, c_bar);
	nand(d, y_bar, c_bar);
	nand(q, c, q_bar);
	nand(q_bar, q, clear, d);
endmodule
Random Sequence by Synchronous Counter (4-bit)
0000->1101->1011->1001->0110->1100->0011->1111->0000
Circuit is too complicated. Verilog implementation from boolean function of inputs
Code
//0000->1101->1011->1001->0110->1100->0011->1111->0000
module random_sequence(q, clear, clk);
    input clear, clk;
    output [3:0] q;
    jk_flip_flop jk1(q[0],,(q[3]&q[2]&~q[1]|~q[3]&~q[2]&~q[1]),(~q[2]&~q[1]|~q[3]&q[2]|q[2]&q[1]),clear,clk);
    jk_flip_flop jk2(q[1],,(q[3]&q[2]|q[3]&q[0]),(q[3]|q[2]|~q[0]),clear,clk);
    jk_flip_flop jk3(q[2],,(q[3]&~q[1]&q[0]|~q[3]&~q[1]&~q[0]|~q[3]&q[1]&q[0]),(q[3]|~q[1]|q[0]),clear,clk);
    jk_flip_flop jk4(q[3],,(~q[2]&~q[1]&~q[0]|~q[2]&q[1]&q[0]|q[2]&q[1]&~q[0]), (~q[2]&~q[1]|~q[1]&~q[0]|q[1]&~q[0]|q[2]&q[1]),clear,clk);
endmodule

module jk_flip_flop(q, q_bar, j, k, clear, clk);
	input j, k, clear, clk;
	output q, q_bar;
	wire a, b, c, d, y, y_bar, c_bar;
	nand(a, q_bar, j, clk, clear);
	nand(b, k, clk, q);
	nand(y, a, y_bar);
	nand(y_bar, y, clear, b);
	not(c_bar, clk);
	nand(c, y, c_bar);
	nand(d, y_bar, c_bar);
	nand(q, c, q_bar);
	nand(q_bar, q, clear, d);
endmodule
