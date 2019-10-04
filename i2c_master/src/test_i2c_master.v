`timescale 1 ns/ 100 ps

module TEST_I2C_MASTER();

parameter CLK = 10;

reg clk;
reg reset_n;
reg signal;
wire enable;

reg i2c_mode;
reg [6:0] i2c_slave_addr;
reg [7:0] i2c_data;

wire sda;
reg _sda;
assign sda = _sda;

always begin
    #CLK clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_I2C_MASTER);
    #(CLK + 1)
        clk <= 0;
        signal <= 0;
        reset_n <= 1;
        i2c_mode <= 1;
        i2c_slave_addr <= 7'h77;
        i2c_data <= 8'hda;
        _sda <= 1'bz;
    #(CLK + 1);
    
    #1 reset_n <= 0;
    #1 reset_n <= 1;
    
    #5 signal <= 1;
    #1 signal <= 0;
    
    #750 _sda <= 0;
    #30 _sda <= 1'bz;
    #700 _sda <= 0;
    #30 _sda <= 1'bz;
    
    #2000 $finish;
end


ONESHOT o(
    .clk(clk),
    .reset_n(reset_n),
    .in(signal),
    .enable(enable)
);

I2C_MASTER master(
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .mode(i2c_mode),
    .slave_addr(i2c_slave_addr),
    .data(i2c_data),
    .sda(sda)
);


endmodule
