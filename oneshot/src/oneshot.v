module ONESHOT(
    input clk, reset_n,
    input in,
    output reg enable
);

reg [1:0] cnt;
reg state;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        enable <= 1'b0;
        state <= 0;
        cnt <= 0;
    end
    if(in) begin
        state <= 1;
    end
    if(cnt == 2'b11) begin
        enable <= 0;
        state <= 0;
        cnt <= 0;
    end
    else begin
        if(state) begin
            enable <= 1;
            cnt = cnt + 1;
        end
    end
end

endmodule
