`timescale 1ns/1ps

module alu_tb;
    reg clock, clear;
    reg [31:0] A, B;
    reg [12:0] ctrl;
    wire [63:0] Result;
    wire done;

    // Control vector index for DIV
    localparam DIV = 3;

    // Instantiate the ALU
    ALU uut (
        .clock(clock), 
        .clear(clear), 
        .A(A), 
        .B(B), 
        .ctrl(ctrl), 
        .Result(Result), 
        .done(done)
    );

    // Clock Generation: 10ns period. 
    // This will run for 50 cycles total (500ns).
    initial begin
        clock = 0;
        repeat (100) #5 clock = ~clock;
    end

    initial begin
        // 1. Reset (0ns - 20ns)
        clear = 1; ctrl = 13'b0; A = 32'b0; B = 32'b0;
        #20 clear = 0;

        // 2. Setup Division (25 / 4)
        A = 32'd25; 
        B = 32'd4;  
        
        // 3. Start Command
        @(posedge clock); 
        ctrl[DIV] = 1;      // Pulse DIV bit high
        
        @(posedge clock); 
        // Some ALUs need the ctrl bit to stay high, some don't.
        // We wait for the 'done' signal from the Non-Restoring Divider.
        
        // 4. Wait for the 32-cycle process to finish
        wait(done == 1'b1);
        
        // 5. Output Results
        #1; 
        $display("DIV: %d / %d", A, B);
        $display("Quotient: %d, Remainder: %d", Result[31:0], Result[63:32]);

        // 6. Cleanup
        @(posedge clock);
        ctrl[DIV] = 0;

        // Ensure simulation reaches the 500ns mark
        #50 $stop;
    end
endmodule