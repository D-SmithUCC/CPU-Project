module Neg32(
    input  wire [31:0] x,
    output wire [31:0] y
);
    wire [31:0] x_not;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : GEN_NOT
            NotGate #(.WIDTH(1)) N1 (.a(x[i]), .y(x_not[i]));
        end
    endgenerate

    // y = x_not + 1
    wire cout_unused;
    RCA32_Cout ADD1 (
        .A(x_not),
        .B(32'd0),
        .Cin(1'b1),
        .Sum(y),
        .Cout(cout_unused)
    );
endmodule
