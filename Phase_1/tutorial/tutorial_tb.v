`timescale 1ns/10ps
module tutorial_tb();

  reg clock, clear;

  reg [31:0] inport_val;
  reg [31:0] c_val;

  // bus output-enables
  reg r0_oe, r1_oe, r2_oe, r3_oe, r4_oe, r5_oe, r6_oe, r7_oe;
  reg r8_oe, r9_oe, r10_oe, r11_oe, r12_oe, r13_oe, r14_oe, r15_oe;
  reg hi_oe, lo_oe, zhi_oe, zlo_oe, pc_oe, mdr_oe, inport_oe, c_oe;

  // load-enables
  reg r0_ld, r1_ld, r2_ld, r3_ld, r4_ld, r5_ld, r6_ld, r7_ld;
  reg r8_ld, r9_ld, r10_ld, r11_ld, r12_ld, r13_ld, r14_ld, r15_ld;
  reg hi_ld, lo_ld, zhi_ld, zlo_ld, pc_ld, mdr_ld;

  reg [5:0] present_state;

  DataPath DP(
    .clock(clock), .clear(clear),
    .inport_val(inport_val), .c_val(c_val),

    .r0_oe(r0_oe), .r1_oe(r1_oe), .r2_oe(r2_oe), .r3_oe(r3_oe),
    .r4_oe(r4_oe), .r5_oe(r5_oe), .r6_oe(r6_oe), .r7_oe(r7_oe),
    .r8_oe(r8_oe), .r9_oe(r9_oe), .r10_oe(r10_oe), .r11_oe(r11_oe),
    .r12_oe(r12_oe), .r13_oe(r13_oe), .r14_oe(r14_oe), .r15_oe(r15_oe),
    .hi_oe(hi_oe), .lo_oe(lo_oe),
    .zhi_oe(zhi_oe), .zlo_oe(zlo_oe),
    .pc_oe(pc_oe), .mdr_oe(mdr_oe),
    .inport_oe(inport_oe),
    .c_oe(c_oe),

    .r0_ld(r0_ld), .r1_ld(r1_ld), .r2_ld(r2_ld), .r3_ld(r3_ld),
    .r4_ld(r4_ld), .r5_ld(r5_ld), .r6_ld(r6_ld), .r7_ld(r7_ld),
    .r8_ld(r8_ld), .r9_ld(r9_ld), .r10_ld(r10_ld), .r11_ld(r11_ld),
    .r12_ld(r12_ld), .r13_ld(r13_ld), .r14_ld(r14_ld), .r15_ld(r15_ld),
    .hi_ld(hi_ld), .lo_ld(lo_ld),
    .zhi_ld(zhi_ld), .zlo_ld(zlo_ld),
    .pc_ld(pc_ld), .mdr_ld(mdr_ld)
  );

  parameter INIT=5'd1, T0=5'd2, T1=5'd3, T2=5'd4, T3=5'd5;

  task clear_controls;
  begin
    r0_oe=0; r1_oe=0; r2_oe=0; r3_oe=0; r4_oe=0; r5_oe=0; r6_oe=0; r7_oe=0;
    r8_oe=0; r9_oe=0; r10_oe=0; r11_oe=0; r12_oe=0; r13_oe=0; r14_oe=0; r15_oe=0;
    hi_oe=0; lo_oe=0; zhi_oe=0; zlo_oe=0; pc_oe=0; mdr_oe=0; inport_oe=0; c_oe=0;

    r0_ld=0; r1_ld=0; r2_ld=0; r3_ld=0; r4_ld=0; r5_ld=0; r6_ld=0; r7_ld=0;
    r8_ld=0; r9_ld=0; r10_ld=0; r11_ld=0; r12_ld=0; r13_ld=0; r14_ld=0; r15_ld=0;
    hi_ld=0; lo_ld=0; zhi_ld=0; zlo_ld=0; pc_ld=0; mdr_ld=0;
  end
  endtask

  initial begin
    clock = 0;
    present_state = 0;
  end

  always #10 clock = ~clock;
  always @(negedge clock) present_state = present_state + 1;

  always @(present_state) begin
    case (present_state)

      INIT: begin
        clear <= 1;
        inport_val <= 32'h0;
        c_val <= 32'h0;
        clear_controls();
        #15 clear <= 0;
      end

      // ldi R1, 3
      T0: begin
        clear_controls();
        c_val <= 32'h0000_0003;
        c_oe  <= 1;
        r1_ld <= 1;
        #15 begin c_oe<=0; r1_ld<=0; c_val<=32'h0; end
      end

      // ldi R2, 4
      T1: begin
        clear_controls();
        c_val <= 32'h0000_0004;
        c_oe  <= 1;
        r2_ld <= 1;
        #15 begin c_oe<=0; r2_ld<=0; c_val<=32'h0; end
      end

      // mv R3, R1
      T2: begin
        clear_controls();
        r1_oe <= 1;
        r3_ld <= 1;
        #15 begin r1_oe<=0; r3_ld<=0; end
      end

      // mv R4, R2
      T3: begin
        clear_controls();
        r2_oe <= 1;
        r4_ld <= 1;
        #15 begin r2_oe<=0; r4_ld<=0; end
      end
		

    endcase
  end

endmodule
