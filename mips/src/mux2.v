module MUX2(
    input [31:0] a,
    input [31:0] b,
    output [31:0] x,
    input s
);

always @* begin
    if(s) begin
        x = a;
    end
    else begin
        x = b;
    end
end

endmodule
