module Neg33(
    input  wire [32:0] x,
    output wire [32:0] y
);
    wire [32:0] x_not;

    genvar i;
    generate
        for (i = 0; i < 33; i = i + 1) begin : GEN_NOT33
            NotGate #(.WIDTH(1)) N (.a(x[i]), .y(x_not[i]));
        end
    endgenerate

    // y = x_not + 1
    Add33 ADD1 (
        .A(x_not),
        .B(33'd0),
        .Cin(1'b1),
        .Sum(y)
    );
endmodule
