// ============================================================
// SHL (Logical Shift Left)
// ------------------------------------------------------------
// Performs: Result = A << B[4:0]
// - Vacated bits are filled with 0s.
// - B[4:0] allows for shifts of 0 to 31 bits.
// ============================================================

module SHL (
    input  wire [31:0] A,      // Value to be shifted
    input  wire [31:0] B,      // Shift amount (only [4:0] used)
    output wire [31:0] Result  // Shifted result
);

    // Using logical shift left operator
    assign Result = A << B[4:0];

endmodule