module gray_to_binary(
  input [3:0] g,
  output [3:0] b
);
  assign b[0] = g[0];
  assign b[1] = g[0] ^ g[1];
  assign b[2] = g[1] ^ g[2];
  assign b[3] = g[2] ^ g[3];
endmodule

module gray_to_binary_test;
  reg [3:0] gray;
  wire [3:0] binary;

  gray_to_binary xx (.b(binary), .g(gray));

  initial begin
    #100 gray = 4'b0000;
    #100 gray = 4'b0001;
    #100 gray = 4'b0011;
    #100 gray = 4'b0111;
    #100 gray = 4'b1111;
    #100 gray = 4'b0110;
    $finish;
  end
endmodule
