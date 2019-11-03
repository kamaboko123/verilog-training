module SIGNEXTEND_16_32(
    input [15:0] a,
    output [31:0] x
);

assign x = {
    {16{a[15]}},
    a
};

endmodule
