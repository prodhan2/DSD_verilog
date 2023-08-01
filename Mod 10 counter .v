module JKFF(q,qb,j,k,clr,clk);
input clr,clk,j,k;
output q,qb;
wire a,b,c,d,e,f,cb;

nand(a,qb,clk,j,clr);
nand(b,clk,k,q);
nand(c,a,d);
nand(d,c,b,clr);

not(cb,clk);

nand(e,cb,c);
nand(f,d,cb);
nand(q,e,qb);
nand(qb,f,q,clr);
endmodule

module MOD__10(q,qb,clr,clk);
input clr,clk;
output [3:0]q,qb;
//initial
//q=4'b 0000;
wire clr;
//reg j=1;
  nand(clr,q[1],q[3]);

  JKFF jk0(q[0],qb[0],1,1,clr,clk);
  JKFF jk1(q[1],qb[1],1,1,clr,q[0]);
  JKFF jk2(q[2],qb[2],1,1,clr,q[1]);
  JKFF jk3(q[3],qb[3],1,1,clr,q[2]);
endmodule
