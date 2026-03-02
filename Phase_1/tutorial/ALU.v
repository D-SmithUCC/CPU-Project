module ALU (
    input  wire        clock,
    input  wire        clear,
    input  wire [31:0] A,          
    input  wire [31:0] B,          
    input  wire [12:0] ctrl,       
    output reg  [63:0] Result,     
    output wire        done        
);

    wire [31:0] sum, diff, and_res, or_res, not_res, neg_res;
    wire [31:0] shr_res, shra_res, shl_res, ror_res, rol_res;
    wire [31:0] mul_res, div_q, div_r;
    wire        mul_done, div_done;

    // Sub-module Instantiations
    RCA32_Cout adder (.A(A), .B(B), .Cin(1'b0), .Sum(sum), .Cout());
    Sub32      sub   (.A(A), .B(B), .Result(diff));
    
    // MUL and DIV receive the specific start bit from the one-hot ctrl vector
    Mul32      mul   (.clock(clock), .clear(clear), .start(ctrl[2]), .A(A), .B(B), .done(mul_done), .Result(mul_res));
    Div32_Signed_NonRestoring div (.clock(clock), .clear(clear), .start(ctrl[3]), .dividend(A), .divisor(B), .done(div_done), .div0(), .quotient(div_q), .remainder(div_r));
    
    AndGate #(.WIDTH(32)) and_u  (.a(A), .b(B), .y(and_res));
    OrGate  #(.WIDTH(32)) or_u   (.a(A), .b(B), .y(or_res));
    NotGate #(.WIDTH(32)) not_u  (.a(B),        .y(not_res)); 
    Neg32                 neg_u  (.x(B),        .y(neg_res)); 

    SHR  shr_u  (.A(A), .B(B), .Result(shr_res));
    SHRA shra_u (.A(A), .B(B), .Result(shra_res));
    SHL  shl_u  (.A(A), .B(B), .Result(shl_res));
    ROR  ror_u  (.A(A), .B(B), .Result(ror_res));
    ROL  rol_u  (.A(A), .B(B), .Result(rol_res));

    assign done = (ctrl[2]) ? mul_done : (ctrl[3]) ? div_done : 1'b1;

    always @(*) begin
        Result = 64'b0;
        case (1'b1)
            ctrl[0]:  Result[31:0]  = sum;
            ctrl[1]:  Result[31:0]  = diff;
            ctrl[2]:  Result[31:0]  = mul_res;
            ctrl[3]:  begin Result[31:0] = div_q; Result[63:32] = div_r; end
            ctrl[4]:  Result[31:0]  = and_res;
            ctrl[5]:  Result[31:0]  = or_res;
            ctrl[6]:  Result[31:0]  = not_res;
            ctrl[7]:  Result[31:0]  = neg_res;
            ctrl[8]:  Result[31:0]  = shr_res;
            ctrl[9]:  Result[31:0]  = shra_res;
            ctrl[10]: Result[31:0]  = shl_res;
            ctrl[11]: Result[31:0]  = ror_res;
            ctrl[12]: Result[31:0]  = rol_res;
            default:  Result        = 64'b0;
        endcase
    end
endmodule