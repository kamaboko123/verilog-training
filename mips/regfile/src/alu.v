module ALU(
    input [2:0] op,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] x, //result
    output reg zero //flg for conditional branch
);

parameter OP_AND = 3'b000;
parameter OP_OR = 3'b001;
parameter OP_ADD = 3'b010;
parameter OP_SUB = 3'b110;
parameter OP_SLT = 3'b111;

always @* begin
    case(op)
        OP_AND: begin
            x = a & b;
            zero = 1'bx;
        end
        OP_OR: begin
            x = a | b;
            zero = 1'bx;
        end
        OP_ADD: begin
            x = a + b;
            zero = 1'bx;
        end
        OP_SUB: begin
            x = a - b;
            zero = (a == b);
        end
        OP_SLT: begin
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
