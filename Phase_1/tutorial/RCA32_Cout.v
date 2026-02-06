module RCA32_Cout(
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire        Cin,
    output wire [31:0] Sum,
    output wire        Cout
);

    wire [32:0] carry;
    assign carry[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : GEN_FA
            wire axb;
            wire ab, ac, bc;
            wire ab_or_ac;

            // axb = A ^ B
            XorGate #(.WIDTH(1)) X1 (.a(A[i]), .b(B[i]), .y(axb));
            // Sum = axb ^ carry
            XorGate #(.WIDTH(1)) X2 (.a(axb), .b(carry[i]), .y(Sum[i]));

            // carry = (A&B) | (A&c) | (B&c)
            AndGate #(.WIDTH(1)) A1 (.a(A[i]), .b(B[i]), .y(ab));
            AndGate #(.WIDTH(1)) A2 (.a(A[i]), .b(carry[i]), .y(ac));
            AndGate #(.WIDTH(1)) A3 (.a(B[i]), .b(carry[i]), .y(bc));

            OrGate  #(.WIDTH(1)) O1 (.a(ab), .b(ac), .y(ab_or_ac));
            OrGate  #(.WIDTH(1)) O2 (.a(ab_or_ac), .b(bc), .y(carry[i+1]));
        end
    endgenerate

    assign Cout = carry[32];

endmodule
