module NotGate #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] a,
    output wire [WIDTH-1:0] y
);
    assign y = ~a;
endmodule
