`timescale 1ns/1ps

module mul32_wave_tb;

    reg clock;
    reg clear;
    reg start;

    reg  [31:0] A;
    reg  [31:0] B;

    wire done;
    wire [31:0] PROD;

    reg  [31:0] RESULT_REG;

    Mul32 dut (
        .clock(clock),
        .clear(clear),
        .start(start),
        .A(A),
        .B(B),
        .done(done),
        .Result(PROD)
    );

    // Bounded clock: 1000 toggles = 500 full cycles
    initial begin
        clock = 1'b0;
        repeat (1000) begin
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

        // release reset after 2 rising edges
        repeat (2) @(posedge clock);
        clear = 1'b0;

        // -------------------------
        // Test 1: 3 * 7 = 21
        // -------------------------
        A = 32'd3; B = 32'd7;
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        repeat (40) @(posedge clock);
        RESULT_REG = PROD;

        // -------------------------
        // Test 2: 12 * 12 = 144
        // -------------------------
        A = 32'd12; B = 32'd12;
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        repeat (40) @(posedge clock);
        RESULT_REG = PROD;

        // -------------------------
        // Test 3: FFFFFFFF * 2 => low32 = FFFFFFFE
        // -------------------------
        A = 32'hFFFFFFFF; B = 32'd2;
        @(posedge clock); start = 1'b1;
        @(posedge clock); start = 1'b0;
        repeat (40) @(posedge clock);
        RESULT_REG = PROD;

        // give 1 extra cycle so you clearly see the last update
        @(posedge clock);

        $stop;
    end

endmodule
