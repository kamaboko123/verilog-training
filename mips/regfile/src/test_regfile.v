`timescale 1 ns/ 100 ps

module TEST_REGFILE();

parameter CLK = 10;

reg clk;
reg reset;
reg [31:0] data;
reg write;
reg [4:0] sel;
reg [4:0] r0;
reg [4:0] r1;

integer i;

always begin
    #CLK clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_REGFILE);
    
    #0
        clk <= 0;
        reset <= 1;
    #0;
    
    #(CLK/2) reset <= 0;
    
    #CLK reset <= 1;
    #(CLK*2);
    #(CLK*2);
    
    for(i = 0; i < 32; i = i + 1) begin
        sel <= i;
        data <= i*2;
        r0 <= i;
        r1 <= i;
        #(CLK*2);
    end
    
    #1000 $finish;
end

REGFILE rf(
    .clk(clk),
    .reset_n(reset),
    .reg_write(1),
    .w_reg0(sel),
    .w_data(data),
    .r_reg0(r0),
    .r_reg1(r1)
);

endmodule
