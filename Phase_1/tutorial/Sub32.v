module Sub32(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [31:0] Result
);

    wire [31:0] B_not;
    wire [31:0] B_twos;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : GEN_NOT
            NotGate #(.WIDTH(1)) NB (
                .a(B[i]),
                .y(B_not[i])
            );
        end
    endgenerate

    // B_twos = (~B) + 1
    RCA add_one (
        .A(B_not),
        .B(32'd1),
        .Result(B_twos)
    );

    // Result = A + B_twos
    RCA do_sub (
        .A(A),
        .B(B_twos),
        .Result(Result)
    );

endmodule
