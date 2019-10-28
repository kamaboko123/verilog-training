module regfile(
    input reset_n,
    input clk,
    input reg_write, //write flg
    input [4:0] r_reg0, //read select
    input [4:0] r_reg1,
    input [4:0] w_reg0, //write select
    input [31:0] w_data, //write data
    output [31:0] reg0, //selected register data
    output [31:0] reg1
);

reg reg0[31:0];
reg reg1[31:0];
reg reg2[31:0];
reg reg3[31:0];
reg reg4[31:0];
reg reg5[31:0];
reg reg6[31:0];
reg reg7[31:0];
reg reg8[31:0];
reg reg9[31:0];
reg reg10[31:0];
reg reg11[31:0];
reg reg12[31:0];
reg reg13[31:0];
reg reg14[31:0];
reg reg15[31:0];
reg reg16[31:0];
reg reg17[31:0];
reg reg18[31:0];
reg reg19[31:0];
reg reg20[31:0];
reg reg21[31:0];
reg reg22[31:0];
reg reg23[31:0];
reg reg24[31:0];
reg reg25[31:0];
reg reg26[31:0];
reg reg27[31:0];
reg reg28[31:0];
reg reg29[31:0];
reg reg30[31:0];
reg reg31[31:0];


endmodule

