module masterSlaveff(q,qb,j,k,clr,clk);
input j,k,clr,clk;
output q,qb;
wire a,b,y,z,c,d,cb;

nand(a,qb,j,clk,clr);
nand(b,q,k,clk);
nand(y,a,z);
nand(z,b,y,clr);

not(cb,clk);

nand(c,y,cb);
nand(d,cb,z);
nand(q,c,qb);
nand(qb,q,d,clr);

endmodule


module sequestialCouunterLab(q,clr,clk);
input clr,clk;
output [3:0]q;
wire [3:0]qb;

masterSlaveff jk1(q[0],qb[0],q[1],qb[1],clr,clk);

masterSlaveff jk2(q[1],qb[1],q[2],qb[2],clr,clk);

masterSlaveff jk3(q[2],qb[2],q[3],qb[3],clr,clk);

masterSlaveff jk4(q[3],qb[3],qb[0],q[0],clr,clk);

endmodule
