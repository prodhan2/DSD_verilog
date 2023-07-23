module multiplier(s3, s2, s1, s0, a0, a1, b0, b1);
  input a0, a1, b0, b1;
  output s3, s2, s1, s0;
  wire y0, y1, y2;
  
  and gate1(s0, a0, b0);
  and gate2(y1, a1, b0);
  and gate3(y0, a0, b1);
  and gate4(y2, a1, b1);

  halfadder ha0(s1, c1, y0, y1);
  halfadder ha1(s2, s3, c1, y2);
endmodule

module halfadder(a, b, sum, carry);
  input a, b;
  output sum, carry;
  
  xor x1(sum, a, b);
  and a1(carry, a, b);
endmodule
