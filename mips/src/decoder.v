module DECODER(
    input [5:0] ins_op,
    input [5:0] func_code,
    output reg reg_write,
    output reg reg_dst,
    output reg alu_src,
    output reg [2:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch,
    output reg jmp,
    output reg pc_to_reg,
    output reg pc_src_alu
);

always @* begin
    case(ins_op)
        0: begin //R-type
        if(func_code == 6'b001000) begin
                //これだと(pc << 2) + rsになるのでだめだけど、一旦これで
                reg_dst = 1'b1;
                alu_src = 1'b0;
                mem_to_reg = 1'b0;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                jmp = 1'b1;
                alu_op = 3'b001;
                pc_to_reg = 1'b0;
                pc_src_alu = 1'b1;
            end
            else begin
                reg_dst = 1'b1;
                alu_src = 1'b0;
                mem_to_reg = 1'b0;
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jmp = 1'b0;
                alu_op = 3'b010;
                pc_to_reg = 1'b0;
                pc_src_alu = 1'b0;
            end
        end
        2: begin //j (imm << 2)
            reg_dst = 1'b1;
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jmp = 1'b1;
            alu_op = 3'b001;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        3:begin //jal (ra = pc; pc += 4)
            reg_dst = 1'b1;
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jmp = 1'b1;
            alu_op = 3'b001;
            pc_to_reg = 1'b1;
            pc_src_alu = 1'b0;
        end
        4: begin //branch
            reg_dst = 1'bx;
            alu_src = 1'b0;
            mem_to_reg = 1'bx;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jmp = 1'b0;
            alu_op = 3'b001;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        5: begin //bne
            reg_dst = 1'bx;
            alu_src = 1'b0;
            mem_to_reg = 1'bx;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jmp = 1'b0;
            alu_op = 3'b100;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        8: begin //(add imm)
            reg_dst = 1'b0;
            alu_src = 1'b1;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 3'b000;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        9: begin //(add imm unsigned)
            reg_dst = 1'b0;
            alu_src = 1'b1;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 3'b000;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        10:begin //slti
            reg_dst = 1'b0;
            alu_src = 1'b1;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 3'b011;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        35: begin //load
            reg_dst = 1'b0;
            alu_src = 1'b1;
            mem_to_reg = 1'b1;
            reg_write = 1'b1;
            mem_read = 1'b1;
            mem_write = 1'b0;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 3'b000;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        43: begin //store
            reg_dst = 1'bx;
            alu_src = 1'b1;
            mem_to_reg = 1'bx;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 3'b000;
            pc_to_reg = 1'b0;
            pc_src_alu = 1'b0;
        end
        default: begin
            reg_dst = 1'bx;
            alu_src = 1'bx;
            mem_to_reg = 1'bx;
            reg_write = 1'bx;
            mem_read = 1'bx;
            mem_write = 1'bx;
            branch = 1'bx;
            jmp = 1'bx;
            alu_op = 3'bxxx;
            pc_to_reg = 1'bx;
            pc_src_alu = 1'b0;
        end
    endcase
end

endmodule
