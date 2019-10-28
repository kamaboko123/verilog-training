`timescale 1 ns/ 100 ps

module TEST_REGFILE();

parameter CLK = 10;

reg clk;
reg reset;
reg [31:0] data;
reg write;

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
    
    #CLK
        data <= 32'hf1234567;
        write <= 1;
    #CLK;
    
    #1000 $finish;
end

REGISTER_32 reg_test(
    .clk(clk),
    .reset_n(reset),
    .write(write),
    .in_data(data)
);

endmodule
