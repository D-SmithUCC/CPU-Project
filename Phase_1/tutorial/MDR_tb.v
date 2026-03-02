`timescale 1ns/1ps

module MDR_tb;

    // ============================================================
    // Testbench Signals
    // ============================================================
    reg         clock;
    reg         clear;
    reg         Read;      // 0 = BusMuxOut, 1 = Mdatain
    reg         MDRin;     // Load enable
    reg  [31:0] BusMuxOut; // Input from Bus
    reg  [31:0] Mdatain;   // Input from Memory

    wire [31:0] q;         // Output

    // ============================================================
    // DUT Instantiation
    // ============================================================
    MDR dut (
        .BusMuxOut(BusMuxOut),
        .Mdatain(Mdatain),
        .Read(Read),
        .clear(clear),
        .clock(clock),
        .MDRin(MDRin),
        .q(q)
    );

    // ============================================================
    // Clock Generation (10ns period)
    // ============================================================
    // Clock Generation (10ns period)
    initial begin
        clock = 0;
        // Run for a finite number of cycles (e.g., 1000) like Mul32
        repeat (1000) #5 clock = ~clock; 
    end

    // ============================================================
    // Test Sequence
    // ============================================================
    initial begin
        // 1. Initialize Inputs
        clear     = 1;
        Read      = 0;
        MDRin     = 0;
        BusMuxOut = 32'h0;
        Mdatain   = 32'h0;

        // Wait for reset
        #15;
        clear = 0;
        
        // --------------------------------------------------------
        // Test Case 1: Load from BUS (Read = 0)
        // --------------------------------------------------------
        // Target value: 0xAAAA5555
        @(negedge clock);
        BusMuxOut = 32'hAAAA5555;
        Mdatain   = 32'hDEADBEEF; // Should be ignored
        Read      = 0;            // Select Bus
        MDRin     = 1;            // Enable Load
        
        @(posedge clock); // Latch occurs here
        #2; // Wait a bit for propagation
        
        if (q === 32'hAAAA5555) $display("PASS: Load from BUS successful. Q = %h", q);
        else                    $display("FAIL: Load from BUS failed. Expected AAAA5555, got %h", q);

        // --------------------------------------------------------
        // Test Case 2: Hold Value (MDRin = 0)
        // --------------------------------------------------------
        // Change inputs but disable load. Q should not change.
        @(negedge clock);
        MDRin     = 0;            // Disable Load
        BusMuxOut = 32'hFFFFFFFF; // Change Bus Input
        
        @(posedge clock);
        #2;

        if (q === 32'hAAAA5555) $display("PASS: Hold value successful. Q = %h", q);
        else                    $display("FAIL: Hold value failed. Expected AAAA5555, got %h", q);

        // --------------------------------------------------------
        // Test Case 3: Load from MEMORY (Read = 1)
        // --------------------------------------------------------
        // Target value: 0x12345678
        @(negedge clock);
        BusMuxOut = 32'hFFFFFFFF; // Should be ignored
        Mdatain   = 32'h12345678;
        Read      = 1;            // Select Memory
        MDRin     = 1;            // Enable Load
        
        @(posedge clock);
        #2;

        if (q === 32'h12345678) $display("PASS: Load from MEMORY successful. Q = %h", q);
        else                    $display("FAIL: Load from MEMORY failed. Expected 12345678, got %h", q);

        // --------------------------------------------------------
        // Test Case 4: Clear
        // --------------------------------------------------------
        @(negedge clock);
        clear = 1;
        
        @(posedge clock);
        #2;

        if (q === 32'h00000000) $display("PASS: Clear successful. Q = %h", q);
        else                    $display("FAIL: Clear failed. Expected 00000000, got %h", q);

        $stop;
    end

endmodule