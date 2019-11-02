module DATAMEM(
    input reset_n,
    input clk,
    input read,
    input write,
    input [31:0] addr,
    input [31:0] in_data,
    output [31:0] data
);

reg [7:0] _data[511:0];

always @(posedge clk) begin
    if(!reset_n) begin
    end
    else begin
        if(write) begin
            _data[0] <= in_data[31:24];
            _data[1] <= in_data[23:16];
            _data[2] <= in_data[15:8];
            _data[3] <= in_data[7:0];
        end
    end
end

assign data = {
    _data[addr],
    _data[addr + 1],
    _data[addr + 2],
    _data[addr + 3]
};

endmodule
