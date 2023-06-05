
module and_gate(out ,a,b);
input a,b;
output out;
and (out ,a,b);
endmodule 
module and_gate_test;
reg a,b;
wire out;
and_gate uunt (out,a,b);
initial 
begin
#100  a = 1; b = 0;
#100 a = 0; b = 1;
#100  a = 1; b = 0;
#100 a = 0; b = 1;
#100  a = 1; b = 0;
#100 a = 0; b = 1; 
end
endmodule
