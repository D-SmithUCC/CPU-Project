

module Mul32(
    input  wire         clock,
    input  wire         clear,
    input  wire         start,
    input  wire [31:0]  A,      // Multiplicand (M)
    input  wire [31:0]  B,      // Multiplier (Q)
    output reg          done,
    output wire [63:0]  Result  // Full 64-bit Result
);

    // ----------------------------------------------------------------
    // 1. Registers & Wires
    // ----------------------------------------------------------------
    reg  [31:0] M_reg;
    reg  [64:0] PQ_reg; // [64:33]=UpperProduct, [32:1]=LowerProduct(Q), [0]=Implicit Bit
    reg  [4:0]  count;
    reg         busy;

    // Structural Logic Wires
    wire [31:0] M_2x;           // M shifted left by 1
    
    // 33-bit extended values for arithmetic
    wire [32:0] M_33;
    wire [32:0] M_2x_33;
    wire [32:0] M_neg_33;
    wire [32:0] M_2x_neg_33;

    wire [32:0] P_33;           // Current Product extended
    reg  [32:0] booth_term;     // Value selected to add
    wire [32:0] sum_temp;       // Output of Adder

    // Wires for the Shifting Step
    wire [31:0] P_shifted_arith; 
    wire [31:0] Q_shifted_logic; 
    wire [1:0]  bits_P_to_Q;   
    wire [31:0] Q_combined_structural;

    // ----------------------------------------------------------------
    // 2. Structural Instantiations
    // ----------------------------------------------------------------

    // A. Generate "2M" using SHL
    SHL shl_2m (
        .A(M_reg), 
        .B(32'd1), 
        .Result(M_2x)
    );

    // B. Prepare 33-bit inputs for Neg33
    assign M_33    = {M_reg[31], M_reg};
    assign M_2x_33 = {M_2x[31], M_2x};

    // C. Generate Negative versions using Neg33
    Neg33 neg_m_inst (.x(M_33), .y(M_neg_33));
    Neg33 neg_2m_inst (.x(M_2x_33), .y(M_2x_neg_33));

    // D. Main Adder (Accumulator + Booth Term)
    assign P_33 = {PQ_reg[64], PQ_reg[64:33]};

    Add33 adder_inst (
        .A(P_33), 
        .B(booth_term), 
        .Cin(1'b0), 
        .Sum(sum_temp)
    );

    // ----------------------------------------------------------------
    // 3. Structural Shifting
    // ----------------------------------------------------------------
    // Shift Right by 2:
    // [31] = sum[32] (Sign Copy 1)
    // [30] = sum[32] (Sign Copy 2)
    // [29:0] = sum[31:2]
    assign P_shifted_arith = { sum_temp[32], sum_temp[32:2] };

    // Shift Q using SHR (Logical - fills with 0)
    SHR shr_q (
        .A(PQ_reg[32:1]), 
        .B(32'd2), 
        .Result(Q_shifted_logic) 
    );
	 
    // Structural Handoff: Merge shifted Q with bits from P
    OrGate #(.WIDTH(32)) or_fix_q (
        .a(Q_shifted_logic),           // The Q register shifted right (zeros at top)
        .b({bits_P_to_Q, 30'd0}),      // The 2 bits falling off P (placed at top)
        .y(Q_combined_structural)      // The result
    );

    // Capture the bits falling off P to move them to Q
    assign bits_P_to_Q = sum_temp[1:0];

    // ----------------------------------------------------------------
    // 4. Output Logic & State Machine
    // ----------------------------------------------------------------
    
    assign Result = PQ_reg[64:1];

    always @(*) begin
        case (PQ_reg[2:0])
            3'b001, 3'b010: booth_term = M_33;          // +M
            3'b011:         booth_term = M_2x_33;       // +2M
            3'b100:         booth_term = M_2x_neg_33;   // -2M
            3'b101, 3'b110: booth_term = M_neg_33;      // -M
            default:        booth_term = 33'd0;         // 0
        endcase
    end

    always @(posedge clock) begin
        if (clear) begin
            PQ_reg  <= 65'd0;
            M_reg   <= 32'd0;
            count   <= 5'd0;
            busy    <= 1'b0;
            done    <= 1'b0;
        end else begin
            done <= 1'b0; 

            // Priority 1: Start
            if (start && !busy) begin
                M_reg   <= A;
                PQ_reg  <= {32'd0, B, 1'b0}; 
                count   <= 5'd0;
                busy    <= 1'b1;
            end 
            // Priority 2: Run
            else if (busy) begin
                if (count < 16) begin
                    // Register Update
                    PQ_reg <= { 
                        P_shifted_arith[31:0],                     
                        Q_combined_structural,  
                        PQ_reg[2] // <--- FIX: Use bit [2] for overlap
                    };
                    
                    count <= count + 5'd1;
                end else begin
                    busy <= 1'b0;
                    done <= 1'b1;
                end
            end
        end
    end

endmodule