// Ripple Carry Adder (32-bit)
// Structural: uses And / Or / Xor modules for all internal logic.
// Interface kept the same as your current file: RCA(A, B, Result)

module RCA(A, B, Result);

    input  wire [31:0] A, B;
    output wire [31:0] Result;

    wire [32:0] carry;
    assign carry[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : GEN_FA
            // Sum: A ^ B ^ carry
            wire axb;
            Xor #(.WIDTH(1)) XOR1 (.a(A[i]),   .b(B[i]),     .y(axb));
            Xor #(.WIDTH(1)) XOR2 (.a(axb),    .b(carry[i]), .y(Result[i]));

            // Carry-out: (A&B) | (A&carry) | (B&carry)
            wire ab, ac, bc;
            wire ab_or_ac;

            And #(.WIDTH(1)) AND1 (.a(A[i]),     .b(B[i]),     .y(ab));
            And #(.WIDTH(1)) AND2 (.a(A[i]),     .b(carry[i]), .y(ac));
            And #(.WIDTH(1)) AND3 (.a(B[i]),     .b(carry[i]), .y(bc));

            Or  #(.WIDTH(1)) OR1  (.a(ab),       .b(ac),       .y(ab_or_ac));
            Or  #(.WIDTH(1)) OR2  (.a(ab_or_ac), .b(bc),       .y(carry[i+1]));
        end
    endgenerate

endmodule
