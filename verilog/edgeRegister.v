// ============================================================
// edgeRegister
// ------------------------------------------------------------
// Generic edge-triggered register
// - Stores DATA_WIDTH bits
// - Loads input when enable = 1 on rising clock edge
// - Clears to 0 when clear = 1
// ============================================================

module edgeRegister #(
    parameter DATA_WIDTH = 32,     // width of register
    parameter INIT = 32'h0          // initial value (simulation)
)(
    input  wire                  clear,   // synchronous clear
    input  wire                  clock,   // clock
    input  wire                  enable,  // load enable
    input  wire [DATA_WIDTH-1:0] d,       // data input
    output wire [DATA_WIDTH-1:0] q_out    // register output
);

    // Actual storage (flip-flops)
    reg [DATA_WIDTH-1:0] q;

    // Initialize register (simulation / FPGA-supported)
    initial
        q = INIT;

    // Register behavior
    always @(posedge clock) begin
        if (clear)
            q <= {DATA_WIDTH{1'b0}};
        else if (enable)
            q <= d;
    end

    // Continuous output of stored value
    assign q_out = q;

endmodule
