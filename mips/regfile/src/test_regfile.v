`timescale 1 ns/ 100 ps

module TEST_REGFILE();

parameter CLK = 10;
parameter DLY = (CLK*2);

reg clk;
reg reset;
reg [31:0] data;
reg write;
reg [4:0] sel;
reg [4:0] r0;
reg [4:0] r1;

reg start;

integer i;

always begin
    #(CLK) clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_REGFILE);
    
    #0
        clk <= 0;
        reset <= 1;
        start <= 0;
        i <= 0;
    #0;
    
    #(DLY) reset <= 0;
    #(DLY)
        start <= 1;
        reset <= 1;
    #(DLY);
    
    #1000 $finish;
end

always @(negedge clk) begin
    if(start) begin
        sel <= i;
        data <= i << 2;
        
        #DLY;
        if(i == 0)
        i = i + 1;
    end
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
