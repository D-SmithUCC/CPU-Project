`timescale 1ns/1ps

module Phase1_DataPath_tb;
    reg clock, clear;
    reg [12:0] alu_ctrl;
    reg [31:0] inport_val, c_val;
    reg r0_oe, r1_oe, r2_oe, r3_oe, r4_oe, r5_oe, r6_oe, r7_oe, r8_oe, r9_oe, r10_oe, r11_oe, r12_oe, r13_oe, r14_oe, r15_oe;
    reg hi_oe, lo_oe, zhi_oe, zlo_oe, pc_oe, mdr_oe, inport_oe, c_oe;
    reg r0_ld, r1_ld, r2_ld, r3_ld, r4_ld, r5_ld, r6_ld, r7_ld, r8_ld, r9_ld, r10_ld, r11_ld, r12_ld, r13_ld, r14_ld, r15_ld;
    reg hi_ld, lo_ld, y_ld, zhi_ld, zlo_ld, pc_ld, mdr_ld;

    wire alu_done;
    wire [31:0] bus_check; 

    DataPath DUT (
        .clock(clock), .clear(clear), .alu_ctrl(alu_ctrl), .alu_done(alu_done),
        .inport_val(inport_val), .c_val(c_val),
        .r0_oe(r0_oe), .r1_oe(r1_oe), .r2_oe(r2_oe), .r3_oe(r3_oe), .r4_oe(r4_oe), .r5_oe(r5_oe), .r6_oe(r6_oe), .r7_oe(r7_oe),
        .r8_oe(r8_oe), .r9_oe(r9_oe), .r10_oe(r10_oe), .r11_oe(r11_oe), .r12_oe(r12_oe), .r13_oe(r13_oe), .r14_oe(r14_oe), .r15_oe(r15_oe),
        .hi_oe(hi_oe), .lo_oe(lo_oe), .zhi_oe(zhi_oe), .zlo_oe(zlo_oe), .pc_oe(pc_oe), .mdr_oe(mdr_oe), .inport_oe(inport_oe), .c_oe(c_oe),
        .r0_ld(r0_ld), .r1_ld(r1_ld), .r2_ld(r2_ld), .r3_ld(r3_ld), .r4_ld(r4_ld), .r5_ld(r5_ld), .r6_ld(r6_ld), .r7_ld(r7_ld),
        .r8_ld(r8_ld), .r9_ld(r9_ld), .r10_ld(r10_ld), .r11_ld(r11_ld), .r12_ld(r12_ld), .r13_ld(r13_ld), .r14_ld(r14_ld), .r15_ld(r15_ld),
        .hi_ld(hi_ld), .lo_ld(lo_ld), .y_ld(y_ld), .zhi_ld(zhi_ld), .zlo_ld(zlo_ld), .pc_ld(pc_ld), .mdr_ld(mdr_ld),
        .bus_contents(bus_check) 
    );

    initial begin clock = 0; repeat (1000) #5 clock = ~clock; end

    initial begin
        // Reset
        {r0_oe, r1_oe, r2_oe, r3_oe, r4_oe, r5_oe, r6_oe, r7_oe, r8_oe, r9_oe, r10_oe, r11_oe, r12_oe, r13_oe, r14_oe, r15_oe} = 16'b0;
        {hi_oe, lo_oe, zhi_oe, zlo_oe, pc_oe, mdr_oe, inport_oe, c_oe} = 8'b0;
        {r0_ld, r1_ld, r2_ld, r3_ld, r4_ld, r5_ld, r6_ld, r7_ld, r8_ld, r9_ld, r10_ld, r11_ld, r12_ld, r13_ld, r14_ld, r15_ld} = 16'b0;
        {hi_ld, lo_ld, y_ld, zhi_ld, zlo_ld, pc_ld, mdr_ld} = 7'b0;
        alu_ctrl = 13'b0; inport_val = 0; c_val = 0;
        clear = 1; #20 clear = 0;
        @(posedge clock);

        // PRE-LOAD: R1=25, R2=4, R3=2
        c_val = -32'd25; c_oe = 1; r1_ld = 1; @(posedge clock); r1_ld = 0; c_oe = 0;
        c_val = 32'd4;  c_oe = 1; r2_ld = 1; @(posedge clock); r2_ld = 0; c_oe = 0;
        c_val = 32'd2;  c_oe = 1; r3_ld = 1; @(posedge clock); r3_ld = 0; c_oe = 0;

        // 1. ADD R2,R5,R6
         c_val = 32'h34; c_oe = 1; r5_ld = 1;
			@(posedge clock);
			r5_ld = 0; c_oe = 0;
			c_val = 32'h45; c_oe = 1; r6_ld = 1;
			@(posedge clock);
			r6_ld = 0; c_oe = 0;
			r5_oe = 1; y_ld = 1;
			@(posedge clock);
			y_ld = 0; r5_oe = 0;
			r6_oe   = 1;
			alu_ctrl = 13'h0001;
			zlo_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			r6_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; #1;
			$display("ADD: 0x34 + 0x45 = %h (expected 00000079)", bus_check);
			#1;
			r2_ld = 1;
			@(posedge clock);
			r2_ld = 0;
			zlo_oe = 0;

        // 2. SUB R2,R5,R6
        c_val = 32'h34; c_oe = 1; r5_ld = 1;
			@(posedge clock);
			r5_ld = 0; c_oe = 0;
			c_val = 32'h45; c_oe = 1; r6_ld = 1;
			@(posedge clock);
			r6_ld = 0; c_oe = 0;
			r5_oe = 1; y_ld = 1;
			@(posedge clock);
			y_ld = 0; r5_oe = 0;
			r6_oe   = 1;
			alu_ctrl = 13'h0002;
			zlo_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			r6_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; #1;
			$display("SUB: 0x34 - 0x45 = %h (expected FFFFFEF)", bus_check);
			#1;
			r2_ld = 1;
			@(posedge clock);
			r2_ld = 0;
			zlo_oe = 0;

        // 3. MUL R3,R1
			c_val = 32'h2; c_oe = 1; r1_ld = 1;
			@(posedge clock); r1_ld = 0; c_oe = 0;
			c_val = 32'h3; c_oe = 1; r3_ld = 1;
			@(posedge clock); r3_ld = 0; c_oe = 0;
			r1_oe = 1; y_ld = 1;
			@(posedge clock); y_ld = 0; r1_oe = 0;
			r3_oe   = 1;
			alu_ctrl = 13'h0004;
			zlo_ld  = 1;
			zhi_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			zhi_ld  = 0;
			r3_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; lo_ld = 1;
			@(posedge clock);
			lo_ld = 0; zlo_oe = 0;
			zhi_oe = 1; hi_ld = 1;
			@(posedge clock);
			hi_ld = 0; zhi_oe = 0;
			lo_oe = 1; #1;
			$display("MUL LO: %h (expected 00000006)", bus_check);
			#1; lo_oe = 0;
			hi_oe = 1; #1;
			$display("MUL HI: %h (expected 00000000)", bus_check);
			#1; hi_oe = 0;

        // 4. DIV R3,R1
        c_val = 32'h9; c_oe = 1; r1_ld = 1;
			@(posedge clock);
			r1_ld = 0; c_oe = 0;
			c_val = 32'h2; c_oe = 1; r3_ld = 1;
			@(posedge clock);
			r3_ld = 0; c_oe = 0;
			r1_oe = 1; y_ld = 1;
			@(posedge clock);
			y_ld = 0; r1_oe = 0;
			r3_oe   = 1;
			alu_ctrl = 13'h0008;
			zlo_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			r3_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; #1;
			$display("DIV: 0x9 / 0x2 = %h (expected 4R1)", bus_check);
			#1; zlo_oe = 0;

        // 5. AND R2,R5,R6
			c_val = 32'h34; c_oe = 1; r5_ld = 1;
			@(posedge clock);
			r5_ld = 0; c_oe = 0;
			c_val = 32'h45; c_oe = 1; r6_ld = 1;
			@(posedge clock);
			r6_ld = 0; c_oe = 0;
			c_val = 32'h67; c_oe = 1; r2_ld = 1;
			@(posedge clock);
			r2_ld = 0; c_oe = 0;
			r5_oe = 1; y_ld = 1;
			@(posedge clock);
			y_ld = 0; r5_oe = 0;
			r6_oe   = 1;
			alu_ctrl = 13'h0010;
			zlo_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			r6_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; #1;
			$display("AND: 0x34 & 0x45 = %h (expected 00000004)", bus_check);
			#1; 
			r2_ld = 1;
			@(posedge clock);
			r2_ld = 0;
			zlo_oe = 0;



        // 6. OR R2,R5,R6
         c_val = 32'h34; c_oe = 1; r5_ld = 1;
			@(posedge clock);
			r5_ld = 0; c_oe = 0;
			c_val = 32'h45; c_oe = 1; r6_ld = 1;
			@(posedge clock);
			r6_ld = 0; c_oe = 0;
			r5_oe = 1; y_ld = 1;
			@(posedge clock);
			y_ld = 0; r5_oe = 0;
			r6_oe   = 1;
			alu_ctrl = 13'h0020;
			zlo_ld  = 1;
			@(posedge clock);
			zlo_ld  = 0;
			r6_oe   = 0;
			alu_ctrl = 0;
			zlo_oe = 1; #1;
			$display("OR: 0x34 | 0x45 = %h (expected 00000075)", bus_check);
			#1;
			r2_ld = 1;
			@(posedge clock);
			r2_ld = 0;
			zlo_oe = 0;

        // 7. NOT
        r2_oe = 1; alu_ctrl = 13'h0040; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r2_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("NOT: ~4 = %b", bus_check); #1; zlo_oe = 0;

        // 8. NEG
        r2_oe = 1; alu_ctrl = 13'h0080; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r2_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("NEG: -4 = %b", bus_check); #1; zlo_oe = 0;

        // 9. SHR
        r1_oe = 1; y_ld = 1; @(posedge clock); y_ld = 0; r1_oe = 0;
        r3_oe = 1; alu_ctrl = 13'h0100; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r3_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("SHR: 25 >> 2 = %b", bus_check); #1; zlo_oe = 0;

        // 10. SHRA
        r1_oe = 1; y_ld = 1; @(posedge clock); y_ld = 0; r1_oe = 0;
        r3_oe = 1; alu_ctrl = 13'h0200; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r3_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("SHRA: 25 >>> 2 = %b", bus_check); #1; zlo_oe = 0;

        // 11. SHL
        r1_oe = 1; y_ld = 1; @(posedge clock); y_ld = 0; r1_oe = 0;
        r3_oe = 1; alu_ctrl = 13'h0400; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r3_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("SHL: 25 << 2 = %b", bus_check); #1; zlo_oe = 0;

        // 12. ROR
        r1_oe = 1; y_ld = 1; @(posedge clock); y_ld = 0; r1_oe = 0;
        r3_oe = 1; alu_ctrl = 13'h0800; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r3_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("ROR: 25 rot-right 2 = %b", bus_check); #1; zlo_oe = 0;

        // 13. ROL
        r1_oe = 1; y_ld = 1; @(posedge clock); y_ld = 0; r1_oe = 0;
        r3_oe = 1; alu_ctrl = 13'h1000; @(posedge clock);
        zlo_ld = 1; @(posedge clock); zlo_ld = 0;
        r3_oe = 0; alu_ctrl = 0; @(posedge clock);
        zlo_oe = 1; #1; $display("ROL: 25 rot-left 2 = %b", bus_check); #1; zlo_oe = 0;

        #100 $stop;
    end
endmodule