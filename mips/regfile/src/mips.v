module MIPS(
    input reset_n,
    input clk
);

parameter ALU_CODE_ADD = 3'b010;

wire [2:0] alu_code;
wire [31:0] alu_result;

wire [4:0] reg_read_sel0;
wire [4:0] reg_read_sel1;
wire [4:0] reg_write_sel0;
wire [31:0] reg_write_data0;
wire [31:0] reg_data0;
wire [31:0] reg_data1;

wire [31:0] ins_data;
wire [31:0] ins_imm;

wire [31:0] alu_in_b;

wire [31:0] pc_data;
wire [31:0] pc_next;
wire [31:0] jmp_to;
wire [31:0] pc_branch_candidate0;
wire [31:0] pc_branch_candidate1;

wire [31:0] mem_data;

// decoder flag(out)
wire reg_write;
wire reg_dst;
wire alu_src;
wire [1:0] alu_op;
wire mem_read;
wire mem_write;
wire mem_to_reg;
wire branch;
wire jmp;

//decoder flag(in)
wire alu_zero;

DECODER dec(
    .ins_op(ins_data[31:26]),
    .reg_write(reg_write),
    .reg_dst(reg_dst),
    .alu_src(alu_src),
    .alu_op(alu_op),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .branch(branch),
    .jmp(jmp)
);

DATAMEM datamem(
    .reset_n(reset_n),
    .clk(clk),
    .read(mem_read),
    .write(mem_write),
    .addr(alu_result),
    .in_data(reg_data1),
    .data(mem_data)
);

assign reg_write_data0 = (mem_to_reg == 0) ? (alu_result) : (mem_data);

INSMEM insmem(
    .reset_n(reset_n),
    .addr(pc_data),
    .data(ins_data)
);

assign reg_write_sel0 = (reg_dst == 0) ? (ins_data[20:16]) : (ins_data[15:11]);
assign alu_in_b = (alu_src == 0) ? (reg_data1) : (ins_imm);

SIGNEXTEND_16_32 signextend1(
    .a(ins_data[15:0]),
    .x(ins_imm)
);

REGFILE regfile(
    .reset_n(reset_n),
    .clk(clk),
    .reg_write(reg_write),
    .r_reg0(ins_data[25:21]),
    .r_reg1(ins_data[20:16]),
    .w_reg0(reg_write_sel0),
    .w_data(reg_write_data0),
    .reg0(reg_data0),
    .reg1(reg_data1)
);

ALUCTRL aluctrl(
    .alu_op(alu_op),
    .func(ins_data[5:0]),
    .alu_code(alu_code)
);

ALU alu(
    .op(alu_code),
    .a(reg_data0),
    .b(alu_in_b),
    .x(alu_result),
    .zero(alu_zero)
);

REGISTER_32 pc(
    .reset_n(reset_n),
    .clk(clk),
    .write(1'b1),
    .in_data(pc_next),
    .data(pc_data)
);

ALU pc_inc(
    .op(ALU_CODE_ADD),
    .a(pc_data),
    .b(32'h4),
    .x(pc_branch_candidate0)
);

ALU pc_branch(
    .op(ALU_CODE_ADD),
    .a(pc_branch_candidate0),
    .b({ins_imm[29:0], 2'b00}),
    .x(pc_branch_candidate1)
);

wire pc_src;
wire [31:0] branch_to;
assign pc_src = (branch & alu_zero);
assign branch_to = (pc_src == 0) ? (pc_branch_candidate0) : (pc_branch_candidate1);
assign jmp_to = {pc_branch_candidate0[31:28], {ins_imm[25:0], 2'b00}};
assign pc_next = (jmp == 0) ? (branch_to) : (jmp_to);

endmodule
