// ============================================================
// DataPath
// ------------------------------------------------------------
// Full datapath wiring:
// - Registers
// - ALU result registers (ZHI / ZLO)
// - Shared bus
// - ALU outputs are abstracted as alu_hi / alu_lo (ALU-agnostic)
// ============================================================

module DataPath (
    input wire clock,
    input wire clear,

    // External sources
    input wire [31:0] inport_val,
    input wire [31:0] c_val,

    // Bus output enables
    input r0_oe,  r1_oe,  r2_oe,  r3_oe,
    input r4_oe,  r5_oe,  r6_oe,  r7_oe,
    input r8_oe,  r9_oe,  r10_oe, r11_oe,
    input r12_oe, r13_oe, r14_oe, r15_oe,
    input hi_oe,  lo_oe,
    input zhi_oe, zlo_oe,
    input pc_oe,  mdr_oe,
    input inport_oe,
    input c_oe, 

    // Register load enables
    input r0_ld,  r1_ld,  r2_ld,  r3_ld,
    input r4_ld,  r5_ld,  r6_ld,  r7_ld,
    input r8_ld,  r9_ld,  r10_ld, r11_ld,
    input r12_ld, r13_ld, r14_ld, r15_ld,
    input hi_ld,  lo_ld,
    input zhi_ld, zlo_ld,
    input pc_ld,  mdr_ld
);

    // ===== Shared bus =====
    wire [31:0] bus;

    // ===== Register outputs =====
    wire [31:0] r0_val, r1_val, r2_val, r3_val;
    wire [31:0] r4_val, r5_val, r6_val, r7_val;
    wire [31:0] r8_val, r9_val, r10_val, r11_val;
    wire [31:0] r12_val, r13_val, r14_val, r15_val;
    wire [31:0] hi_val, lo_val, zhi_val, zlo_val;
    wire [31:0] pc_val, mdr_val;

    // =========================================================
    // ALU interface (GENERAL)
    // - Later you will implement an ALU module that drives these
    // - For now, keep them as placeholders so the datapath compiles
    // =========================================================
    wire [31:0] alu_hi;
    wire [31:0] alu_lo;

    // Placeholder behavior until ALU is implemented:
    // (You can change these to something else temporarily for testing,
    //  but the datapath itself should NOT hardcode "add".)
    assign alu_hi = 32'b0;
    assign alu_lo = 32'b0;

    // ===== Registers =====
    edgeRegister R0  (clear, clock, r0_ld,  bus, r0_val);
    edgeRegister R1  (clear, clock, r1_ld,  bus, r1_val);
    edgeRegister R2  (clear, clock, r2_ld,  bus, r2_val);
    edgeRegister R3  (clear, clock, r3_ld,  bus, r3_val);
    edgeRegister R4  (clear, clock, r4_ld,  bus, r4_val);
    edgeRegister R5  (clear, clock, r5_ld,  bus, r5_val);
    edgeRegister R6  (clear, clock, r6_ld,  bus, r6_val);
    edgeRegister R7  (clear, clock, r7_ld,  bus, r7_val);
    edgeRegister R8  (clear, clock, r8_ld,  bus, r8_val);
    edgeRegister R9  (clear, clock, r9_ld,  bus, r9_val);
    edgeRegister R10 (clear, clock, r10_ld, bus, r10_val);
    edgeRegister R11 (clear, clock, r11_ld, bus, r11_val);
    edgeRegister R12 (clear, clock, r12_ld, bus, r12_val);
    edgeRegister R13 (clear, clock, r13_ld, bus, r13_val);
    edgeRegister R14 (clear, clock, r14_ld, bus, r14_val);
    edgeRegister R15 (clear, clock, r15_ld, bus, r15_val);

    edgeRegister HI  (clear, clock, hi_ld,  bus, hi_val);
    edgeRegister LO  (clear, clock, lo_ld,  bus, lo_val);
    edgeRegister PC  (clear, clock, pc_ld,  bus, pc_val);
    edgeRegister MDR (clear, clock, mdr_ld, bus, mdr_val);
	 

    // Z registers capture ALU result (general)
    edgeRegister ZHI (clear, clock, zhi_ld, alu_hi, zhi_val);
    edgeRegister ZLO (clear, clock, zlo_ld, alu_lo, zlo_val);

    // ===== Bus =====
BiDirectionalBus bus_mux ( //These are all connections to busmux.
    .r0_val(r0_val),   .r1_val(r1_val),   .r2_val(r2_val),   .r3_val(r3_val),
    .r4_val(r4_val),   .r5_val(r5_val),   .r6_val(r6_val),   .r7_val(r7_val),
    .r8_val(r8_val),   .r9_val(r9_val),   .r10_val(r10_val), .r11_val(r11_val),
    .r12_val(r12_val), .r13_val(r13_val), .r14_val(r14_val), .r15_val(r15_val),
    .hi_val(hi_val),   .lo_val(lo_val),
    .zhi_val(zhi_val), .zlo_val(zlo_val),
    .pc_val(pc_val),   .mdr_val(mdr_val),
    .inport_val(inport_val),
    .c_val(c_val),

	 //These are all the connections to encoder
    .r0_oe(r0_oe),   .r1_oe(r1_oe),   .r2_oe(r2_oe),   .r3_oe(r3_oe),
    .r4_oe(r4_oe),   .r5_oe(r5_oe),   .r6_oe(r6_oe),   .r7_oe(r7_oe),
    .r8_oe(r8_oe),   .r9_oe(r9_oe),   .r10_oe(r10_oe), .r11_oe(r11_oe),
    .r12_oe(r12_oe), .r13_oe(r13_oe), .r14_oe(r14_oe), .r15_oe(r15_oe),
    .hi_oe(hi_oe),   .lo_oe(lo_oe),
    .zhi_oe(zhi_oe), .zlo_oe(zlo_oe),
    .pc_oe(pc_oe),   .mdr_oe(mdr_oe),
    .inport_oe(inport_oe),
    .c_oe(c_oe),

	 //This is bus mux out
    .bus(bus)
);

endmodule
