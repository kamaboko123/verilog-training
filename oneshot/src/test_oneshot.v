`timescale 1 ns/ 100 ps

module TEST_ONESHOT();

reg clk;
reg reset_n;
reg signal;
wire enable;

always begin
    #1 clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_ONESHOT);
    #0
        clk <= 0;
        signal <= 0;
        reset_n <= 1;
    #0;
    #5 reset_n <= 0;
    #1 reset_n <= 1;
    
    #5 signal <= 1;
    #1 signal <= 0;
    
    #10 signal <= 1;
    #2 signal <= 0;
    
    #10 signal <= 1;
    #3 signal <= 0;
    
    #10 signal <= 1;
    #10 signal <= 0;
    
    #10 signal <= 1;
    #1 signal <= 0;
    
    #50 $finish;
end


ONESHOT o(
    .clk(clk),
    .reset_n(reset_n),
    .in(signal),
    .enable(enable)
);

endmodule
