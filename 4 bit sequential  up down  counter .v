//for input 0000-1000-1100-1110-1111-0111-0011-0001-0000 sujan prodhan ru.cse-29

module masterslavejkff(q, qb, j, k, clr, clk);
   
    output q, qb; 
   input j, k, clr, clk;
    wire a, b, c, d, e, f;
    
    nand(a, j,clk, clr, qb);
    nand(b, k,clk,  q);
    nand(c, a, d);
    nand(d, c, b,clr);
    
    wire clkb;
    not (clkb ,clk); // Invert the clock signal
    
    nand(e, clkb, c);
    nand(f, clkb, d);
    nand(q, qb, e);
    nand(qb, q, clr, f);
endmodule


module sequentialUPdown(q,qb,clr,clk);

output [3:0]q,qb;
input clr,clk;


masterslavejkff f1(q[0],qb[0],q[1],qb[1],clr,clk);

masterslavejkff f2(q[1],qb[1],q[2],qb[2],clr,clk);

masterslavejkff f3(q[2],qb[2],q[3],qb[3],clr,clk);

masterslavejkff f4(q[3],qb[3],qb[0],q[0],clr,clk);

endmodule 
