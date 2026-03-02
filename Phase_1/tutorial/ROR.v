// ============================================================
// ROR (Rotate Right)
// ------------------------------------------------------------
// Performs: Result = (A >> B[4:0]) | (A << (32 - B[4:0]))
// - Bits shifted out of LSB wrap around to MSB.
// - B[4:0] allows for rotations of 0 to 31 bits.
// ============================================================

module ROR (
    input  wire [31:0] A,      // Value to be rotated
    input  wire [31:0] B,      // Rotate amount (only [4:0] used)
    output wire [31:0] Result  // Rotated result
);

    wire [4:0] shift_amt;
    assign shift_amt = B[4:0];

    // Concatenate A with itself to easily grab a 32-bit window
    // Alternatively, use the standard rotation logic:
    assign Result = (A >> shift_amt) | (A << (32 - shift_amt));

endmodule