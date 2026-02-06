`timescale 1ns/1ps

module div_signed_nonrestoring_tb;

    reg clock;
    reg clear;
    reg start;

    reg  [31:0] dividend;
    reg  [31:0] divisor;

    wire done;
    wire div0;
    wire [31:0] quotient;
    wire [31:0] remainder;

    // Wave-friendly capture regs (what you inspect)
    reg [31:0] Q_REG;
    reg [31:0] R_REG;
    reg        DIV0_REG;

    // DUT
    Div32_Signed_NonRestoring dut (
        .clock(clock),
        .clear(clear),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        .done(done),
        .div0(div0),
        .quotient(quotient),
        .remainder(remainder)
    );

    // -----------------------------
    // BOUNDED CLOCK (Quartus-safe)
    // 10ns period (toggle every 5ns)
    // -----------------------------
    initial begin
        clock = 1'b0;
        repeat (2000) begin     // plenty of toggles => plenty of cycles
            #5 clock = ~clock;
        end
    end

    // -----------------------------
    // Helper task: pulse start for 1 cycle
    // -----------------------------
    task pulse_start;
    begin
        @(posedge clock);
        start = 1'b1;
        @(posedge clock);
        start = 1'b0;
    end
    endtask

    // -----------------------------
    // Helper task: run one test case
    // Wait fixed cycles (no @(posedge done))
    // Divider is 32 cycles; we wait 40 for margin.
    // -----------------------------
    task run_case;
        input [31:0] a;
        input [31:0] b;
    begin
        dividend = a;
        divisor  = b;

        pulse_start();

        // fixed wait (Quartus-safe)
        repeat (45) @(posedge clock);

        // capture outputs for easy waveform checking
        Q_REG    = quotient;
        R_REG    = remainder;
        DIV0_REG = div0;

        // small gap so you can see capture edge
        repeat (3) @(posedge clock);
    end
    endtask

    // -----------------------------
    // Stimulus
    // -----------------------------
    initial begin
        clear    = 1'b1;
        start    = 1'b0;
        dividend = 32'b0;
        divisor  = 32'b0;

        Q_REG = 32'b0;
        R_REG = 32'b0;
        DIV0_REG = 1'b0;

        // reset for 2 cycles
        repeat (2) @(posedge clock);
        clear = 1'b0;

        // ----------------------------------------------------
        // Test 1:  21 / 7 = 3, rem 0
        // ----------------------------------------------------
        run_case(32'd21, 32'd7);

        // ----------------------------------------------------
        // Test 2: -21 / 7 = -3, rem 0
        // -21 = 0xFFFFFFEB
        // ----------------------------------------------------
        run_case(32'hFFFFFFEB, 32'd7);

        // ----------------------------------------------------
        // Test 3:  22 / 7 = 3, rem 1
        // ----------------------------------------------------
        run_case(32'd22, 32'd7);

        // ----------------------------------------------------
        // Test 4:  22 / -7 = -3, rem 1  (remainder sign matches dividend)
        // -7 = 0xFFFFFFF9
        // ----------------------------------------------------
        run_case(32'd22, 32'hFFFFFFF9);

        // ----------------------------------------------------
        // Test 5: -22 / 7 = -3, rem -1  (remainder sign matches dividend)
        // -22 = 0xFFFFFFEA
        // ----------------------------------------------------
        run_case(32'hFFFFFFEA, 32'd7);

        // ----------------------------------------------------
        // Test 6: divide by zero -> div0 should go 1, outputs likely 0
        // ----------------------------------------------------
        run_case(32'd123, 32'd0);

        // done
        repeat (10) @(posedge clock);
        $stop;
    end

endmodule
