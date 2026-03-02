`timescale 1ns/1ps

module shr_tb;

    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Result;

    // Instantiate the Unit Under Test (UUT)
    SHR uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        A = 32'h0;
        B = 32'h0;

        // Wait for global reset
        #20;

        // Test 1: Shift by 0
        A = 32'hF0F0F0F0; B = 32'd0;
        #20;
        $display("Test 1: A=%h, B=%d, Result=%h (Expected: F0F0F0F0)", A, B, Result);

        // Test 2: Shift by 4
        A = 32'hF0000000; B = 32'd4;
        #20;
        $display("Test 2: A=%h, B=%d, Result=%h (Expected: 0F000000)", A, B, Result);

        // Test 3: Shift by 1 bit (LSB check)
        A = 32'h00000001; B = 32'd1;
        #20;
        $display("Test 3: A=%h, B=%d, Result=%h (Expected: 00000000)", A, B, Result);

        // Test 4: Shift by 31 bits (MSB to LSB)
        A = 32'h80000000; B = 32'd31;
        #20;
        $display("Test 4: A=%h, B=%d, Result=%h (Expected: 00000001)", A, B, Result);

        // Test 5: Logical property check (zero padding)
        A = 32'hFFFFFFFF; B = 32'd8;
        #20;
        $display("Test 5: A=%h, B=%d, Result=%h (Expected: 00FFFFFF)", A, B, Result);

        #20;
        $stop;
    end
endmodule