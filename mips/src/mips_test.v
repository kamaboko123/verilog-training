`timescale 1 ns/ 100 ps

module TEST_MIPS();

parameter CLK = 10;
reg clk;
reg reset_n;

always begin
    #(CLK) clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_MIPS);
    
    #0
        clk <= 0;
        reset_n <= 1;
    #0;
    
    #(CLK * 2);
    #1 reset_n <= 0;
    #(CLK * 2) reset_n <= 1;
    
    #150 $finish;
end

MIPS mips(
    .reset_n(reset_n),
    .clk(clk)
);

endmodule
