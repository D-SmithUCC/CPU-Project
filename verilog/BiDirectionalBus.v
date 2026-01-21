// ============================================================
// BiDirectionalBus
// ------------------------------------------------------------
// One-hot controlled bus multiplexer
// - Exactly ONE *_oe signal should be high at a time
// - Selected source drives the shared bus
// ============================================================

module BiDirectionalBus (

    // ===== Sources that can drive the bus =====
    input [31:0] r0_val,  r1_val,  r2_val,  r3_val,
    input [31:0] r4_val,  r5_val,  r6_val,  r7_val,
    input [31:0] r8_val,  r9_val,  r10_val, r11_val,
    input [31:0] r12_val, r13_val, r14_val, r15_val,
    input [31:0] hi_val,  lo_val,
    input [31:0] zhi_val, zlo_val,
    input [31:0] pc_val,  mdr_val,
    input [31:0] inport_val,
    input [31:0] c_val

    // ===== Output-enable control signals (one-hot) =====
    input r0_oe,  r1_oe,  r2_oe,  r3_oe,
    input r4_oe,  r5_oe,  r6_oe,  r7_oe,
    input r8_oe,  r9_oe,  r10_oe, r11_oe,
    input r12_oe, r13_oe, r14_oe, r15_oe,
    input hi_oe,  lo_oe,
    input zhi_oe, zlo_oe,
    input pc_oe,  mdr_oe,
    input inport_oe,
    input c_oe,

    // ===== Shared system bus =====
    output wire [31:0] bus
);

    reg [31:0] bus_reg;

    // Combinational bus selection
    always @(*) begin
        bus_reg = 32'b0;   // default prevents latch

        if      (r0_oe)     bus_reg = r0_val;
        else if (r1_oe)     bus_reg = r1_val;
        else if (r2_oe)     bus_reg = r2_val;
        else if (r3_oe)     bus_reg = r3_val;
        else if (r4_oe)     bus_reg = r4_val;
        else if (r5_oe)     bus_reg = r5_val;
        else if (r6_oe)     bus_reg = r6_val;
        else if (r7_oe)     bus_reg = r7_val;
        else if (r8_oe)     bus_reg = r8_val;
        else if (r9_oe)     bus_reg = r9_val;
        else if (r10_oe)    bus_reg = r10_val;
        else if (r11_oe)    bus_reg = r11_val;
        else if (r12_oe)    bus_reg = r12_val;
        else if (r13_oe)    bus_reg = r13_val;
        else if (r14_oe)    bus_reg = r14_val;
        else if (r15_oe)    bus_reg = r15_val;
        else if (hi_oe)     bus_reg = hi_val;
        else if (lo_oe)     bus_reg = lo_val;
        else if (zhi_oe)    bus_reg = zhi_val;
        else if (zlo_oe)    bus_reg = zlo_val;
        else if (pc_oe)     bus_reg = pc_val;
        else if (mdr_oe)    bus_reg = mdr_val;
        else if (inport_oe) bus_reg = inport_val;
        else if (c_oe)      bus_reg = c_val;
    end

    assign bus = bus_reg;

endmodule
