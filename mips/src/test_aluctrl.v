`timescale 1 ns/ 100 ps

module TEST_ALUCTRL();

reg [1:0] op;
reg [5:0] func;
wire [2:0] alu_code;

parameter ALU_OP_MEM = 2'b00; // lw, sw
parameter ALU_OP_BEQ = 2'b01; // beq
parameter ALU_OP_ARITHMETIC = 2'b10; //算術演算

parameter FUNC_AND = 6'b100100;
parameter FUNC_OR =  6'b100101;
parameter FUNC_ADD = 6'b100000;
parameter FUNC_SUB = 6'b100010;
parameter FUNC_SLT = 6'b101010;


initial begin
    $dumpvars(0, TEST_ALUCTRL);
    
    #10
        op <= ALU_OP_MEM;
        func <= 6'bx;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_BEQ;
        func <= 6'bx;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_ARITHMETIC;
        func <= FUNC_AND;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_ARITHMETIC;
        func <= FUNC_OR;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_ARITHMETIC;
        func <= FUNC_ADD;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_ARITHMETIC;
        func <= FUNC_SUB;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10
        op <= ALU_OP_ARITHMETIC;
        func <= FUNC_SLT;
    #10;
    #1 $display("%b, %b, %b", op, func, alu_code);
    
    #10 $finish;
end

ALUCTRL ctrl(
    .alu_op(op),
    .func(func),
    .alu_code(alu_code)
);

endmodule
