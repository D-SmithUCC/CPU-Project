module Add33(
    input  wire [32:0] A,
    input  wire [32:0] B,
    input  wire        Cin,
    output wire [32:0] Sum
);
    wire [31:0] sum_lo;
    wire cout_lo;

    RCA32_Cout ADDLO (
        .A(A[31:0]),
        .B(B[31:0]),
        .Cin(Cin),
        .Sum(sum_lo),
        .Cout(cout_lo)
    );

    // Sum[32] = A32 ^ B32 ^ cout_lo
    wire a_xor_b;
    XorGate #(.WIDTH(1)) X0 (.a(A[32]), .b(B[32]), .y(a_xor_b));
    XorGate #(.WIDTH(1)) X1 (.a(a_xor_b), .b(cout_lo), .y(Sum[32]));

    assign Sum[31:0] = sum_lo;
endmodule
