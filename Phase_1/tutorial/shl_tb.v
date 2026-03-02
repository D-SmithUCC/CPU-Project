`timescale 1ns/1ps

module shl_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    SHL uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        A = 32'h0;
        B = 32'h0;

        #20;

        // Test 1: Shift by 0
        // Result should be identical to A
        A = 32'hABCD1234; B = 32'd0;
        #20;
        $display("Test 1: A=%h, B=%d, Result=%h (Expected: ABCD1234)", A, B, Result);

        // Test 2: Shift by 4 bits
        // Hex digit should shift one position left
        A = 32'h0000000F; B = 32'd4;
        #20;
        $display("Test 2: A=%h, B=%d, Result=%h (Expected: 000000F0)", A, B, Result);

        // Test 3: Shift by 1 bit (MSB loss check)
        // High bit 1 should be shifted out
        A = 32'h80000000; B = 32'd1;
        #20;
        $display("Test 3: A=%h, B=%d, Result=%h (Expected: 00000000)", A, B, Result);

        // Test 4: Maximum shift (31 bits)
        // LSB should move to MSB position
        A = 32'h00000001; B = 32'd31;
        #20;
        $display("Test 4: A=%h, B=%d, Result=%h (Expected: 80000000)", A, B, Result);

        // Test 5: Logical zero filling
        // Ensure zeros are pulled in from the right
        A = 32'hFFFFFFFF; B = 32'd8;
        #20;
        $display("Test 5: A=%h, B=%d, Result=%h (Expected: FFFFFF00)", A, B, Result);

        #20;
        $stop;
    end
endmodule