`timescale 1 ns/ 100 ps

module TEST_ALU();

reg [2:0] op;
reg [31:0] a;
reg [31:0] b;
wire [31:0] x;
wire zero;

parameter OP_AND = 3'b000;
parameter OP_OR = 3'b001;
parameter OP_ADD = 3'b010;
parameter OP_SUB = 3'b110;
parameter OP_SLT = 3'b111;

initial begin
    $dumpvars(0, TEST_ALU);
    
    #10
        op <= OP_AND;
        a <= 32'b1001;
        b <= 32'b1000;
    #10;
    
    #10
        op <= OP_AND;
        a <= 32'b0000;
        b <= 32'b1000;
    #10;
    
    #10
        op <= OP_OR;
        a <= 32'b1011;
        b <= 32'b1100;
    #10;
    
    #10
        op <= OP_ADD;
        a <= 32'b0011;
        b <= 32'b0001;
    #10;
    
    #10
        op <= OP_SUB;
        a <= 32'b0100;
        b <= 32'b0001;
    #10;
    
    #10
        op <= OP_SUB;
        a <= 32'b0100;
        b <= 32'b0100;
    #10;
    
    #10
        op <= OP_SLT;
        a <= 32'b0100;
        b <= 32'b0001;
    #10;
    
    #10
        op <= OP_SLT;
        a <= 32'b0001;
        b <= 32'b0100;
    #10;
    
    #10 $finish;
end

ALU alu(
    .op(op),
    .a(a),
    .b(b),
    .x(x),
    .zero(zero)
);

endmodule
