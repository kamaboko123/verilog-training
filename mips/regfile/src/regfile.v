module REGFILE(
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

wire [31:0] _write_sel;
wire [31:0] _r0_data;
wire [31:0] _r1_data;
wire [31:0] _r2_data;
wire [31:0] _r3_data;
wire [31:0] _r4_data;
wire [31:0] _r5_data;
wire [31:0] _r6_data;
wire [31:0] _r7_data;
wire [31:0] _r8_data;
wire [31:0] _r9_data;
wire [31:0] _r10_data;
wire [31:0] _r11_data;
wire [31:0] _r12_data;
wire [31:0] _r13_data;
wire [31:0] _r14_data;
wire [31:0] _r15_data;
wire [31:0] _r16_data;
wire [31:0] _r17_data;
wire [31:0] _r18_data;
wire [31:0] _r19_data;
wire [31:0] _r20_data;
wire [31:0] _r21_data;
wire [31:0] _r22_data;
wire [31:0] _r23_data;
wire [31:0] _r24_data;
wire [31:0] _r25_data;
wire [31:0] _r26_data;
wire [31:0] _r27_data;
wire [31:0] _r28_data;
wire [31:0] _r29_data;
wire [31:0] _r30_data;
wire [31:0] _r31_data;

REGISTER_32 r0(reset_n, clk, _write_sel[0], w_data, _r0_data);
REGISTER_32 r1(reset_n, clk, _write_sel[1], w_data, _r1_data);
REGISTER_32 r2(reset_n, clk, _write_sel[2], w_data, _r2_data);
REGISTER_32 r3(reset_n, clk, _write_sel[3], w_data, _r3_data);
REGISTER_32 r4(reset_n, clk, _write_sel[4], w_data, _r4_data);
REGISTER_32 r5(reset_n, clk, _write_sel[5], w_data, _r5_data);
REGISTER_32 r6(reset_n, clk, _write_sel[6], w_data, _r6_data);
REGISTER_32 r7(reset_n, clk, _write_sel[7], w_data, _r7_data);
REGISTER_32 r8(reset_n, clk, _write_sel[8], w_data, _r8_data);
REGISTER_32 r9(reset_n, clk, _write_sel[9], w_data, _r9_data);
REGISTER_32 r10(reset_n, clk, _write_sel[10], w_data, _r10_data);
REGISTER_32 r11(reset_n, clk, _write_sel[11], w_data, _r11_data);
REGISTER_32 r12(reset_n, clk, _write_sel[12], w_data, _r12_data);
REGISTER_32 r13(reset_n, clk, _write_sel[13], w_data, _r13_data);
REGISTER_32 r14(reset_n, clk, _write_sel[14], w_data, _r14_data);
REGISTER_32 r15(reset_n, clk, _write_sel[15], w_data, _r15_data);
REGISTER_32 r16(reset_n, clk, _write_sel[16], w_data, _r16_data);
REGISTER_32 r17(reset_n, clk, _write_sel[17], w_data, _r17_data);
REGISTER_32 r18(reset_n, clk, _write_sel[18], w_data, _r18_data);
REGISTER_32 r19(reset_n, clk, _write_sel[19], w_data, _r19_data);
REGISTER_32 r20(reset_n, clk, _write_sel[20], w_data, _r20_data);
REGISTER_32 r21(reset_n, clk, _write_sel[21], w_data, _r21_data);
REGISTER_32 r22(reset_n, clk, _write_sel[22], w_data, _r22_data);
REGISTER_32 r23(reset_n, clk, _write_sel[23], w_data, _r23_data);
REGISTER_32 r24(reset_n, clk, _write_sel[24], w_data, _r24_data);
REGISTER_32 r25(reset_n, clk, _write_sel[25], w_data, _r25_data);
REGISTER_32 r26(reset_n, clk, _write_sel[26], w_data, _r26_data);
REGISTER_32 r27(reset_n, clk, _write_sel[27], w_data, _r27_data);
REGISTER_32 r28(reset_n, clk, _write_sel[28], w_data, _r28_data);
REGISTER_32 r29(reset_n, clk, _write_sel[29], w_data, _r29_data);
REGISTER_32 r30(reset_n, clk, _write_sel[30], w_data, _r30_data);
REGISTER_32 r31(reset_n, clk, _write_sel[31], w_data, _r31_data);

endmodule

