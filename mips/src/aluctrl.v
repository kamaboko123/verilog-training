module ALUCTRL(
    input [2:0] alu_op, //ALUの処理種別
    input [5:0] func, //R形式命令下位6bit(func code)
    output reg [2:0] alu_code //ALU制御信号
);

parameter ALU_OP_MEM = 3'b000; // lw, sw
parameter ALU_OP_BEQ = 3'b001; // beq
parameter ALU_OP_ARITHMETIC = 3'b010; //算術演算
parameter ALU_OP_SLTI = 3'b011; // slt imm
parameter ALU_OP_BNE = 3'b100; // bne

parameter ALU_CODE_AND = 3'b000;
parameter ALU_CODE_OR = 3'b001;
parameter ALU_CODE_ADD = 3'b010;
parameter ALU_CODE_SUB = 3'b110;
parameter ALU_CODE_SUB_N = 3'b101; //bne
parameter ALU_CODE_SLT = 3'b111;

parameter FUNC_AND = 6'b100100;
parameter FUNC_OR =  6'b100101;
parameter FUNC_ADD = 6'b100000;
parameter FUNC_ADDU = 6'b100001; //tmp
parameter FUNC_JR = 6'b001000; //tmp (for jr inst)
parameter FUNC_SUB = 6'b100010;
parameter FUNC_SLT = 6'b101010;

always @* begin
    case(alu_op)
        ALU_OP_MEM: alu_code = ALU_CODE_ADD;
        ALU_OP_BEQ: alu_code = ALU_CODE_SUB;
        ALU_OP_SLTI: alu_code = ALU_CODE_SLT;
        ALU_OP_BNE: alu_code = ALU_CODE_SUB_N;
        ALU_OP_ARITHMETIC: begin
            case(func)
                FUNC_AND: alu_code = ALU_CODE_AND;
                FUNC_OR:  alu_code = ALU_CODE_OR;
                FUNC_ADD: alu_code = ALU_CODE_ADD;
                FUNC_ADDU: alu_code = ALU_CODE_ADD; //tmp
                FUNC_JR: alu_code = ALU_CODE_ADD; //tmp
                FUNC_SUB: alu_code = ALU_CODE_SUB;
                FUNC_SLT: alu_code = ALU_CODE_SLT;
                default : alu_code = 2'bx;
            endcase
        end
        default: alu_code = 2'bx;
    endcase
    
end

endmodule
