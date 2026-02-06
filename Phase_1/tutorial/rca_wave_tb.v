`timescale 1ns/1ps

module rca_wave_tb;

    // Inputs to RCA
    reg  [31:0] A;
    reg  [31:0] B;

    // RCA output
    wire [31:0] SUM;

    // Register to capture result (what you inspect in waves)
    reg  [31:0] RESULT_REG;

    // Instantiate RCA
    RCA dut (
        .A(A),
        .B(B),
        .Result(SUM)
    );

    initial begin
        // Initialize
        A = 32'b0;
        B = 32'b0;
        RESULT_REG = 32'b0;

        #10;

        // Test 1: 1 + 2 = 3
        A = 32'd1;
        B = 32'd2;
        #10;
        RESULT_REG = SUM;

        #20;

        // Test 2: 5 + 7 = 12
        A = 32'd5;
        B = 32'd7;
        #10;
        RESULT_REG = SUM;

        #20;

        // Test 3: carry chain (FFFFFFFF + 1 = 0)
        A = 32'hFFFFFFFF;
        B = 32'd1;
        #10;
        RESULT_REG = SUM;

        #20;

        $stop;
    end

endmodule
