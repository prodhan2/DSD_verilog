module RippleCarryAdder(input [3:0] A, input [3:0] B,input Cin,output [3:0] Sum,output Cout);
  
   wire [3:0] carry;
  
  // Generate the carry chain
  assign carry[0] = Cin;
  assign carry[1] = A[0] & B[0] | (A[0] ^ B[0]) & carry[0];
  assign carry[2] = A[1] & B[1] | (A[1] ^ B[1]) & carry[1];
  assign carry[3] = A[2] & B[2] | (A[2] ^ B[2]) & carry[2];
  
   // Calculate the sum bits
  assign Sum[0] = A[0] ^ B[0] ^ Cin;
  assign Sum[1] = A[1] ^ B[1] ^ carry[1];
  assign Sum[2] = A[2] ^ B[2] ^ carry[2];
  assign Sum[3] = A[3] ^ B[3] ^ carry[3];
  
  // Calculate the final carry out
  assign Cout = B[3] & A[3] | carry[3] & (B[3] | A[3]);
endmodule



module RippleCarryAdder_tb;
  // Inputs
  reg [3:0] A;
  reg [3:0] B;
  reg Cin;
  
  // Outputs
  wire [3:0] Sum;
  wire Cout;
  
  // Instantiate the RippleCarryAdder module
  RippleCarryAdder uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
  );
  
  initial begin
    // Initialize inputs
    A = 4'b0000;
    B = 4'b0000;
    Cin = 0;
    
    // Wait for a few time units
    #10;
    
    // Test case 1
    A = 4'b0101;
    B = 4'b0011;
    Cin = 0;
    #10;
  
    // Test case 2
    A = 4'b1111;
    B = 4'b1111;
    Cin = 1;
    #10;
       // Add more test cases here if needed
    
    // Finish simulation
    $finish;
  end
endmodule
