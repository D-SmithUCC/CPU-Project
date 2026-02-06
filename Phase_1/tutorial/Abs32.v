module Abs32(
    input  wire [31:0] x,
    output wire [31:0] y,
    output wire        is_neg
);
    assign is_neg = x[31];

    wire [31:0] x_neg;
    Neg32 NEG(.x(x), .y(x_neg));

    // y = is_neg ? x_neg : x
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : GEN_MUX
            wire selx, nsel, selneg, out_or;

            NotGate #(.WIDTH(1)) NSEL (.a(is_neg), .y(nsel));

            AndGate #(.WIDTH(1)) A0 (.a(x[i]),     .b(nsel),   .y(selx));
            AndGate #(.WIDTH(1)) A1 (.a(x_neg[i]), .b(is_neg), .y(selneg));
            OrGate  #(.WIDTH(1)) O0 (.a(selx),     .b(selneg), .y(y[i]));
        end
    endgenerate
endmodule
