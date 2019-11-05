module ALU(
    input [2:0] op,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] x, //result
    output reg zero //flg for conditional branch
);

parameter ALU_CODE_AND = 3'b000;
parameter ALU_CODE_OR = 3'b001;
parameter ALU_CODE_ADD = 3'b010;
parameter ALU_CODE_SUB = 3'b110;
parameter ALU_CODE_SUB_N = 3'b101; //bne
parameter ALU_CODE_SLT = 3'b111;

always @* begin
    case(op)
        ALU_CODE_AND: begin
            x = a & b;
            zero = 1'bx;
        end
        ALU_CODE_OR: begin
            x = a | b;
            zero = 1'bx;
        end
        ALU_CODE_ADD: begin
            x = a + b;
            zero = 1'bx;
        end
        ALU_CODE_SUB: begin
            x = a - b;
            zero = (a == b);
        end
        ALU_CODE_SUB_N: begin
            x = a - b;
            zero = !(a == b);
        end
       
        ALU_CODE_SLT: begin
            zero = 1'bx;
            if(a < b) begin
                x = 31'b1;
            end
            else begin
                x = 31'b0;
            end
        end
        default: begin
            x = 3'bx;
            zero = 1'bx;
        end
    endcase
end

endmodule
