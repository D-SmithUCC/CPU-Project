`timescale 1ns/1ps

module sub32_wave_tb;

    // Inputs to Sub32
    reg  [31:0] A;
    reg  [31:0] B;

    // Sub32 output
    wire [31:0] DIFF;

    // Register to capture result (what you inspect in waves)
    reg  [31:0] RESULT_REG;

    // Instantiate Sub32
    Sub32 dut (
        .A(A),
        .B(B),
        .Result(DIFF)
    );

    initial begin
        // Initialize
        A = 32'b0;
        B = 32'b0;
        RESULT_REG = 32'b0;

        #10;

        // Test 1: 5 - 3 = 2
        A = 32'd5;
        B = 32'd3;
        #10;
        RESULT_REG = DIFF;

        #20;

        // Test 2: 3 - 5 = -2 (two's complement: 0xFFFFFFFE)
        A = 32'd3;
        B = 32'd5;
        #10;
        RESULT_REG = DIFF;

        #20;

        // Test 3: 7 - 7 = 0
        A = 32'd7;
        B = 32'd7;
        #10;
        RESULT_REG = DIFF;

        #20;

        // Test 4: 0 - 1 = -1 (0xFFFFFFFF)
        A = 32'd0;
        B = 32'd1;
        #10;
        RESULT_REG = DIFF;

        #20;

        $stop;
    end

endmodule
