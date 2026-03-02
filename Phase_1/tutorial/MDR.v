// ============================================================
// MDR (Memory Data Register)
// ------------------------------------------------------------
// As specified in Figure 4 of CPU Phase 1:
// - Contains a 2-to-1 Multiplexer (MDMux)
// - Contains a 32-bit Register
// - Selects between BusMuxOut (0) and Mdatain (1) based on Read
// ============================================================

module MDR (
    input  wire [31:0] BusMuxOut, // Data from the internal Bus
    input  wire [31:0] Mdatain,   // Data from the Memory Chip
    input  wire        Read,      // Control signal: 1 = Read from Memory, 0 = Read from Bus
    input  wire        clear,     // Async/Sync clear
    input  wire        clock,     // Clock
    input  wire        MDRin,     // Write enable (load) signal
    output wire [31:0] q          // Output to BusMuxIn-MDR and Memory Chip
);

    wire [31:0] mux_out;

    // --------------------------------------------------------
    // MDMux implementation
    // Selector: Read
    // 0: BusMuxOut
    // 1: Mdatain
    // --------------------------------------------------------
    assign mux_out = Read ? Mdatain : BusMuxOut;

    // --------------------------------------------------------
    // MDR Register implementation
    // Uses the generic edgeRegister module
    // --------------------------------------------------------
    edgeRegister #(.DATA_WIDTH(32)) MDR_Reg (
        .clear(clear),
        .clock(clock),
        .enable(MDRin),
        .d(mux_out),
        .q_out(q)
    );

endmodule