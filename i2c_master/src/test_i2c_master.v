`timescale 1 ns/ 100 ps

module TEST_I2C_MASTER();

parameter CLK = 10;

reg clk;
reg reset_n;

wire scl;
wire sda;
reg _sda;
assign sda = _sda;
reg [2:0] scl_cnt;
reg enable;

always begin
    #CLK clk <= ~clk;
end

initial begin
    $dumpvars(0, TEST_I2C_MASTER);
    #0
        clk <= 0;
        reset_n <= 1;
        enable <= 0;
    #0;
    
    #(CLK + 1)
        _sda <= 1'bz;
    #(CLK + 1);
    
    #1 reset_n <= 0;
    #1 reset_n <= 1;
    #1 enable <= 1;
    #1 enable <= 1;
    
    #764 _sda <= 0;
    #60 _sda <= 1'bz;
    #700 _sda <= 0;
    #60 _sda <= 1'bz;
    
    #880 _sda <= 0;
    #60 _sda <= 1'bz;
    #80 _sda <= 1;
    
    #580 _sda <= 1'bz;
    
    #1000 $finish;
end

I2C_READ read(
    .clk(clk),
    .reset_n(reset_n),
    .sda(sda),
    .scl(scl),
    .slave_addr(7'h77),
    .register_addr(8'hda),
    .enable(enable)
);


endmodule
