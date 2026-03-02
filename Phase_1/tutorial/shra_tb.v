`timescale 1ns/1ps

module shra_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    SHRA uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        A = 32'h0;
        B = 32'h0;

        #20;

        // Test 1: Positive number shift (should behave like SHR)
        // A = 0x0000000F, Shift 2
        A = 32'h0000000F; B = 32'd2;
        #20;
        $display("Test 1: A=%h, B=%d, Result=%h (Expected: 00000003)", A, B, Result);

        // Test 2: Negative number shift (Sign Extension check)
        // A = 0x80000000 (MSB is 1), Shift 1
        A = 32'h80000000; B = 32'd1;
        #20;
        $display("Test 2: A=%h, B=%d, Result=%h (Expected: C0000000)", A, B, Result);

        // Test 3: Large Negative number shift
        // A = 0xFFFFFFF0 (-16), Shift 4
        A = 32'hFFFFFFF0; B = 32'd4;
        #20;
        $display("Test 3: A=%h, B=%d, Result=%h (Expected: FFFFFFFF)", A, B, Result);

        // Test 4: Maximum shift on negative number
        // A = 0x80000000, Shift 31
        A = 32'h80000000; B = 32'd31;
        #20;
        $display("Test 4: A=%h, B=%d, Result=%h (Expected: FFFFFFFF)", A, B, Result);

        // Test 5: Shift by 0
        A = 32'h12345678; B = 32'd0;
        #20;
        $display("Test 5: A=%h, B=%d, Result=%h (Expected: 12345678)", A, B, Result);

        #20;
        $stop;
    end
endmodule