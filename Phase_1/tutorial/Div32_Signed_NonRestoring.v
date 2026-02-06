// ============================================================
// Div32_Signed_NonRestoring (Verilog-2001, Quartus-friendly)
// ------------------------------------------------------------
// Signed (two's complement) non-restoring division
// - Uses ONLY your modules: AndGate/OrGate/XorGate/NotGate,
//   Abs32, Neg32, Add33, Neg33, RCA32_Cout
// - No built-in + - * & | ^ ~ used in this file
// - 32 iterations, start pulse begins, done pulses at end
// - quotient sign = sign(dividend) XOR sign(divisor)
// - remainder sign matches dividend
// ============================================================

module Div32_Signed_NonRestoring(
    input  wire        clock,
    input  wire        clear,
    input  wire        start,
    input  wire [31:0] dividend,
    input  wire [31:0] divisor,
    output reg         done,
    output reg         div0,
    output reg  [31:0] quotient,
    output reg  [31:0] remainder
);

    // -------------------------
    // Magnitudes + sign bits
    // -------------------------
    wire [31:0] dvd_mag;
    wire [31:0] dvs_mag;
    wire dvd_neg, dvs_neg;

    Abs32 ABS_DVD(.x(dividend), .y(dvd_mag), .is_neg(dvd_neg));
    Abs32 ABS_DVS(.x(divisor),  .y(dvs_mag), .is_neg(dvs_neg));

    // qneg = dvd_neg XOR dvs_neg
    wire qneg;
    XorGate #(.WIDTH(1)) XSGN(.a(dvd_neg), .b(dvs_neg), .y(qneg));

    // -------------------------
    // State regs
    // -------------------------
    reg  [31:0] Q;        // running quotient magnitude
    reg  [31:0] M;        // divisor magnitude
    reg  [32:0] Aacc;     // signed accumulator (33-bit)
    reg  [31:0] count;
    reg         busy;

    // -------------------------
    // Count increment via RCA32_Cout (count_next = count + 1)
    // -------------------------
    wire [31:0] count_next;
    wire count_cout_unused;
    RCA32_Cout INC_COUNT(
        .A(count),
        .B(32'd0),
        .Cin(1'b1),
        .Sum(count_next),
        .Cout(count_cout_unused)
    );

    // -------------------------
    // Useful wires
    // -------------------------
    // shiftedAQ = {Aacc[31:0], Q[31]}
    wire [32:0] shiftedAQ;
    assign shiftedAQ = {Aacc[31:0], Q[31]};

    // M33 = {0, M}
    wire [32:0] M33;
    assign M33 = {1'b0, M};

    // Compute A_plus_M and A_minus_M from shiftedAQ
    wire [32:0] A_plus_M;
    wire [32:0] A_minus_M;

    Add33 ADD_AM (
        .A(shiftedAQ),
        .B(M33),
        .Cin(1'b0),
        .Sum(A_plus_M)
    );

    wire [32:0] negM33;
    Neg33 NEG_M(.x(M33), .y(negM33));

    Add33 SUB_AM (
        .A(shiftedAQ),
        .B(negM33),
        .Cin(1'b0),
        .Sum(A_minus_M)
    );

    // -------------------------
    // A_next mux (NO ternary): if shiftedAQ >= 0 -> A_minus_M else A_plus_M
    // sign_shifted = shiftedAQ[32]
    // -------------------------
    wire sign_shifted;
    assign sign_shifted = shiftedAQ[32];

    wire nsign_shifted;
    NotGate #(.WIDTH(1)) N_S(.a(sign_shifted), .y(nsign_shifted));

    wire [32:0] A_next;
    genvar i;
    generate
        for (i = 0; i < 33; i = i + 1) begin : GEN_A_NEXT
            wire take_sub, take_add;
            AndGate #(.WIDTH(1)) A0(.a(A_minus_M[i]), .b(nsign_shifted), .y(take_sub));
            AndGate #(.WIDTH(1)) A1(.a(A_plus_M[i]),  .b(sign_shifted),  .y(take_add));
            OrGate  #(.WIDTH(1)) O0(.a(take_sub),     .b(take_add),      .y(A_next[i]));
        end
    endgenerate

    // qbit = 1 if A_next >= 0 else 0  => qbit = ~A_next[32]
    wire qbit;
    NotGate #(.WIDTH(1)) N_QBIT(.a(A_next[32]), .y(qbit));

    // Q_next = {Q[30:0], qbit}
    wire [31:0] Q_next;
    assign Q_next = {Q[30:0], qbit};

    // ------------------------------------------------------------
    // FINAL RESTORE should use A_next (final iteration value),
    // not Aacc (previous-cycle value).
    // If A_next < 0, restore: Afinal = A_next + M33 else Afinal = A_next
    // ------------------------------------------------------------
    wire [32:0] A_next_plus_M;
    Add33 REST_ADD(.A(A_next), .B(M33), .Cin(1'b0), .Sum(A_next_plus_M));

    wire [32:0] Afinal;
    genvar k;
    generate
        for (k = 0; k < 33; k = k + 1) begin : GEN_RESTORE
            wire nsel, keep_bit, add_bit;

            // nsel=1 when A_next>=0
            NotGate #(.WIDTH(1)) N0(.a(A_next[32]), .y(nsel));

            AndGate #(.WIDTH(1)) A0(.a(A_next[k]),         .b(nsel),       .y(keep_bit));
            AndGate #(.WIDTH(1)) A1(.a(A_next_plus_M[k]),  .b(A_next[32]), .y(add_bit));
            OrGate  #(.WIDTH(1)) O0(.a(keep_bit),          .b(add_bit),    .y(Afinal[k]));
        end
    endgenerate

    wire [31:0] Afinal_lo;
    assign Afinal_lo = Afinal[31:0];

    // Final quotient magnitude should use Q_next (final iteration value)
    wire [31:0] Q_final;
    assign Q_final = Q_next;

    // Negations for sign application
    wire [31:0] Q_neg;
    wire [31:0] R_neg;
    Neg32 NEGQ(.x(Q_final),   .y(Q_neg));
    Neg32 NEGR(.x(Afinal_lo), .y(R_neg));

    // Q_signed = qneg ? -Q_final : Q_final  (gate mux)
    wire [31:0] Q_signed;
    generate
        for (k = 0; k < 32; k = k + 1) begin : GEN_QSIGN
            wire nsel, keep_bit, neg_bit;
            NotGate #(.WIDTH(1)) N0(.a(qneg), .y(nsel));
            AndGate #(.WIDTH(1)) A0(.a(Q_final[k]), .b(nsel), .y(keep_bit));
            AndGate #(.WIDTH(1)) A1(.a(Q_neg[k]),   .b(qneg), .y(neg_bit));
            OrGate  #(.WIDTH(1)) O0(.a(keep_bit),   .b(neg_bit), .y(Q_signed[k]));
        end
    endgenerate

    // R_signed = dvd_neg ? -Afinal_lo : Afinal_lo  (gate mux)
    wire [31:0] R_signed;
    generate
        for (k = 0; k < 32; k = k + 1) begin : GEN_RSIGN
            wire nsel, keep_bit, neg_bit;
            NotGate #(.WIDTH(1)) N0(.a(dvd_neg), .y(nsel));
            AndGate #(.WIDTH(1)) A0(.a(Afinal_lo[k]), .b(nsel),    .y(keep_bit));
            AndGate #(.WIDTH(1)) A1(.a(R_neg[k]),     .b(dvd_neg), .y(neg_bit));
            OrGate  #(.WIDTH(1)) O0(.a(keep_bit),     .b(neg_bit), .y(R_signed[k]));
        end
    endgenerate

    // -------------------------
    // Sequential control
    // -------------------------
    always @(posedge clock) begin
        if (clear) begin
            done      <= 1'b0;
            div0      <= 1'b0;
            quotient  <= 32'b0;
            remainder <= 32'b0;

            Q     <= 32'b0;
            M     <= 32'b0;
            Aacc  <= 33'd0;

            count <= 32'd0;
            busy  <= 1'b0;

        end else begin
            done <= 1'b0;
            div0 <= 1'b0;

            if (start && !busy) begin
                if (divisor == 32'b0) begin
                    quotient  <= 32'b0;
                    remainder <= 32'b0;
                    div0      <= 1'b1;
                    done      <= 1'b1;
                    busy      <= 1'b0;
                end else begin
                    Q     <= dvd_mag;
                    M     <= dvs_mag;
                    Aacc  <= 33'd0;
                    count <= 32'd0;
                    busy  <= 1'b1;
                end
            end

            if (busy) begin
                // one iteration
                Aacc  <= A_next;
                Q     <= Q_next;
                count <= count_next;

                // stop after 32 iterations (count 0..31)
                if (count == 32'd31) begin
                    busy <= 1'b0;

                    // outputs based on FINAL iteration values (Q_final/Afinal)
                    quotient  <= Q_signed;
                    remainder <= R_signed;
                    done <= 1'b1;
                end
            end
        end
    end

endmodule
