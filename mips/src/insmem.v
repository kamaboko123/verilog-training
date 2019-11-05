module INSMEM(
    input reset_n,
    input [31:0] addr,
    output [31:0] data
);

reg [7:0] _data[511:0];

initial $readmemh("test_c/memdata/test_for.mem", _data);

always @(negedge reset_n) begin
    if(!reset_n) begin
        /*
        {_data[0], _data[1], _data[2], _data[3]} <= 32'h20080020;
        {_data[4], _data[5], _data[6], _data[7]} <= 32'h21080020;
        {_data[8], _data[9], _data[10], _data[11]} <= 32'h20090020;
        {_data[12], _data[13], _data[14], _data[15]} <= 32'h01094022;
        {_data[16], _data[17], _data[18], _data[19]} <= 32'hac080008;
        {_data[20], _data[21], _data[22], _data[23]} <= 32'h8c0a0008;
        */
        /*
        {_data[0], _data[1], _data[2], _data[3]} <= 32'h20080001;
        {_data[4], _data[5], _data[6], _data[7]} <= 32'h20090010;
        {_data[8], _data[9], _data[10], _data[11]} <= 32'h200a0020;
        {_data[12], _data[13], _data[14], _data[15]} <= 32'h08000006;
        {_data[16], _data[17], _data[18], _data[19]} <= 32'h00000000;
        {_data[20], _data[21], _data[22], _data[23]} <= 32'h01095820;
        {_data[24], _data[25], _data[26], _data[27]} <= 32'h010a5820;
        {_data[28], _data[29], _data[30], _data[31]} <= 32'h08000007;
        */
    end
end

assign data = {
    _data[addr],
    _data[addr + 1],
    _data[addr + 2],
    _data[addr + 3]
};

endmodule
