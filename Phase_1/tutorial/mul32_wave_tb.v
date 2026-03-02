`timescale 1ns/1ps

module mul32_wave_tb;

    reg clock;
    reg clear;
    reg start;

    reg  [31:0] A;
    reg  [31:0] B;

    wire done;
    wire [63:0] PROD;

    reg  [63:0] RESULT_REG;


	Mul32 dut (
        .clock(clock),
        .clear(clear),
        .start(start),
        .A(A),
        .B(B),
        .done(done),
        .Result(PROD)  // Connects 64-bit output to 64-bit wire
    );

    // Bounded clock: 1000 toggles = 500 full cycles
    initial begin
        clock = 1'b0;
        repeat (2000) begin
            #5 clock = ~clock;
        end
        $stop;
    end

    initial begin
        // init
        clear = 1'b1;
        start = 1'b0;
        A = 32'b0;
        B = 32'b0;
        RESULT_REG = 32'b0;

        // Release reset
        repeat (2) @(posedge clock);
        clear = 1'b0;

        // -------------------------
        // Test 1: 3 * 7 = 21
        // -------------------------
        A = 32'd3; B = 32'd7;
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        
        // Wait for done signal instead of hardcoded delay
        @(posedge done); 
        RESULT_REG = PROD;
        $display("Test 1 (3 * 7): Expected 21, Got %d", $signed(PROD));

        // -------------------------
        // Test 2: 12 * 12 = 144
        // -------------------------
        @(posedge clock); // spacing
        A = 32'd12; B = 32'd12;
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        
        @(posedge done);
        RESULT_REG = PROD;
        $display("Test 2 (12 * 12): Expected 144, Got %d", $signed(PROD));

        // -------------------------
        // Test 3: -1 * 2 = -2 (Using hex FFFFFFFF for -1)
        // -------------------------
        @(posedge clock);
        A = -32'd1; B = 32'd2; // Verilog handles the hex conversion for -1
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        
        @(posedge done);
        RESULT_REG = PROD;
        $display("Test 3 (-1 * 2): Expected -2, Got %d", $signed(PROD));

        $stop;
    end

endmodule
