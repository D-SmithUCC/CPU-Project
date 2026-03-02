// ============================================================
// ROL (Rotate Left)
// ------------------------------------------------------------
// Performs: Result = (A << B[4:0]) | (A >> (32 - B[4:0]))
// - Bits shifted out of MSB wrap around to LSB.
// - B[4:0] allows for rotations of 0 to 31 bits.
// ============================================================

module ROL (
    input  wire [31:0] A,      // Value to be rotated
    input  wire [31:0] B,      // Rotate amount (only [4:0] used)
    output wire [31:0] Result  // Rotated result
);

    wire [4:0] shift_amt;
    assign shift_amt = B[4:0];

    // Standard rotation logic for Left:
    // Shift left by 'n' OR shift right by '32-n'
    assign Result = (A << shift_amt) | (A >> (32 - shift_amt));

endmodule