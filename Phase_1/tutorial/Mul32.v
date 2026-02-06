// ============================================================
// Mul32 (Sequential Shift-and-Add)
// ------------------------------------------------------------
// Unsigned multiply: Result = (A * B) low 32 bits
// No '*' operator. Uses RCA for the addition step.
// start: pulse high for 1 cycle to begin
// done: goes high when finished (after 32 cycles)
// ============================================================

module Mul32(
    input  wire        clock,
    input  wire        clear,
    input  wire        start,
    input  wire [31:0] A,
    input  wire [31:0] B,
    output reg         done,
    output reg  [31:0] Result
);

    reg  [31:0] multiplicand;
    reg  [31:0] multiplier;
    reg  [5:0]  count;          // needs to count to 32
    reg         busy;

    wire [31:0] add_out;

    // RCA adds current Result + multiplicand (mod 2^32)
    RCA add_rca (
        .A(Result),
        .B(multiplicand),
        .Result(add_out)
    );

    always @(posedge clock) begin
        if (clear) begin
            Result       <= 32'b0;
            multiplicand <= 32'b0;
            multiplier   <= 32'b0;
            count        <= 6'd0;
            done         <= 1'b0;
            busy         <= 1'b0;
        end else begin
            done <= 1'b0; // default: only pulse when finishing

            // Start a new multiplication
            if (start && !busy) begin
                Result       <= 32'b0;
                multiplicand <= A;
                multiplier   <= B;
                count        <= 6'd0;
                busy         <= 1'b1;
            end

            // Run multiply while busy
            if (busy) begin
                // If LSB of multiplier is 1, add multiplicand into Result
                if (multiplier[0] == 1'b1) begin
                    Result <= add_out;
                end

                // Shift for next bit
                multiplicand <= multiplicand << 1;
                multiplier   <= multiplier >> 1;

                // Advance count
                count <= count + 6'd1;

                // Finish after 32 iterations
                if (count == 6'd31) begin
                    busy <= 1'b0;
                    done <= 1'b1;
                end
            end
        end
    end

endmodule
