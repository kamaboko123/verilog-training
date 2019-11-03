module DECODER(
    input [5:0] ins_op,
    output reg reg_write,
    output reg reg_dst,
    output reg alu_src,
    output reg [1:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch,
    output reg jmp
);

always @* begin
    case(ins_op)
        0: begin //R-type
            reg_dst = 1'b1;
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jmp = 1'b0;
            alu_op = 2'b10;
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
            alu_op = 2'b01;
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
            alu_op = 2'b00;
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
            alu_op = 2'b00;
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
            alu_op = 2'b00;
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
            alu_op = 2'b01;
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
            alu_op = 2'bxx;
        end
    endcase
end

endmodule
