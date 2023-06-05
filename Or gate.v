module or_gate(out,a,b);
input a,b;
output out;
or(y,a,b);
endmodule

module or_gate_test;
reg a,b;
wire out;
or_gate xx(out,a,b);
initial 
begin
#100 a=1;b=0;
#100 a=0;b=0;
#100 a=1;b=1;
#100 a=0;b=1;
end
endmodule
