// ============================================================
// SHRA (Arithmetic Shift Right)
// ------------------------------------------------------------
// Performs: Result = A >>> B[4:0]
// - Vacated bits are filled with the sign bit (A[31]).
// - B[4:0] allows for shifts of 0 to 31 bits.
// ============================================================

module SHRA (
    input  wire [31:0] A,      // Value to be shifted
    input  wire [31:0] B,      // Shift amount (only [4:0] used)
    output wire [31:0] Result  // Shifted result
);

    // Using the arithmetic shift operator (>>>) 
    // We cast A to signed to ensure Verilog performs sign-extension.
    assign Result = $signed(A) >>> B[4:0];

endmodule