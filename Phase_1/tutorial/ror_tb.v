`timescale 1ns/1ps

module ror_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    ROR uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        A = 32'h0;
        B = 32'h0;

        #20;

        // Test 1: Rotate by 0
        // Result should be identical to A
        A = 32'h12345678; B = 32'd0;
        #20;
        $display("Test 1: A=%h, B=%d, Result=%h (Expected: 12345678)", A, B, Result);

        // Test 2: Rotate by 4 bits
        // The last hex digit (F) should move to the front
        A = 32'h0000000F; B = 32'd4;
        #20;
        $display("Test 2: A=%h, B=%d, Result=%h (Expected: F0000000)", A, B, Result);

        // Test 3: Rotate by 1 bit
        // LSB (1) moves to MSB
        A = 32'h00000001; B = 32'd1;
        #20;
        $display("Test 3: A=%h, B=%d, Result=%h (Expected: 80000000)", A, B, Result);

        // Test 4: Rotate by 8 bits (Full byte wrap)
        A = 32'h12345678; B = 32'd8;
        #20;
        $display("Test 4: A=%h, B=%d, Result=%h (Expected: 78123456)", A, B, Result);

        // Test 5: Rotate by 31 bits
        // Effectively the same as Rotating Left by 1 bit
        A = 32'h80000000; B = 32'd31;
        #20;
        $display("Test 5: A=%h, B=%d, Result=%h (Expected: 00000001)", A, B, Result);

        #20;
        $stop;
    end
endmodule