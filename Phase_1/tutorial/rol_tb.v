`timescale 1ns/1ps

module rol_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    ROL uut (
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
        A = 32'h87654321; B = 32'd0;
        #20;
        $display("Test 1: A=%h, B=%d, Result=%h (Expected: 87654321)", A, B, Result);

        // Test 2: Rotate by 4 bits
        // The first hex digit (F) should move to the end
        A = 32'hF0000000; B = 32'd4;
        #20;
        $display("Test 2: A=%h, B=%d, Result=%h (Expected: 0000000F)", A, B, Result);

        // Test 3: Rotate by 1 bit
        // MSB (1 at bit 31) moves to LSB
        A = 32'h80000000; B = 32'd1;
        #20;
        $display("Test 3: A=%h, B=%d, Result=%h (Expected: 00000001)", A, B, Result);

        // Test 4: Rotate by 8 bits (Full byte wrap)
        A = 32'h12345678; B = 32'd8;
        #20;
        $display("Test 4: A=%h, B=%d, Result=%h (Expected: 34567812)", A, B, Result);

        // Test 5: Rotate by 31 bits
        // Effectively the same as Rotating Right by 1 bit
        A = 32'h00000001; B = 32'd31;
        #20;
        $display("Test 5: A=%h, B=%d, Result=%h (Expected: 00000002)", A, B, Result);

        #20;
        $stop;
    end
endmodule