module INSMEM(
    input reset_n,
    input [31:0] addr,
    output [31:0] data
);

reg [7:0] _data[511:0];

always @(negedge reset_n) begin
    if(!reset_n) begin
        {_data[0], _data[1], _data[2], _data[3]} <= 32'h0000ff00;
        {_data[4], _data[5], _data[6], _data[7]} <= 32'h0000ff10;
    end
end

assign data = {
    _data[addr],
    _data[addr + 1],
    _data[addr + 2],
    _data[addr + 3]
};

endmodule
