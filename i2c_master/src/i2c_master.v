module I2C_MASTER(
    input clk, reset_n,
    input enable,
    input mode,
    input [6:0] slave_addr,
    input [31:0] data,
    output scl,
    inout sda,
    output busy,
    output reg error
);

reg _enable;
reg _scl, _sda;
reg _mode;
assign scl = _scl;
assign sda = _sda;
assign busy = ~(_state == 3'd0);

reg [2:0] _state;
reg [7:0] _slave_addr;
reg [31:0] _data;
reg [3:0] _step;
reg [2:0] _cnt;

parameter STATE_READY = 0;
parameter STATE_START = 1;
parameter STATE_SEND_ADDR = 2;
parameter STATE_CHECK_ACK = 3;

always @(negedge reset_n) begin
    _state <= STATE_READY;
    _scl <= 1;
    _sda <= 1;
    _step <= 0;
    _mode <= 1'bx;
    _enable <= 0;
    error <= 0;
end

always @(posedge clk) begin
    if(enable) begin
        _enable <= 1;
        _mode <= mode;
        _slave_addr <= (slave_addr << 1) + mode;
        _state <= STATE_START;
        error <= 0;
    end
    else if(_enable) begin
        if(_state == STATE_START) begin
            _sda <= 0;
            _step <= 0;
            _state <= STATE_SEND_ADDR;
        end
        
        if(_state == STATE_SEND_ADDR) begin
            case (_step)
                0:begin
                    _cnt <= 3'd7;
                    _step <= 1;
                end
                1:begin
                    _scl <= 0;
                    _step <= 2;
                end
                2:begin
                    _sda <= (_slave_addr & 8'b10000000) ? 1'b1 : 1'b0;
                    _step <= 3;
                end
                3:begin
                    _slave_addr <= _slave_addr << 1;
                    _scl <= 1;
                    _step <= 4;
                end
                4:begin
                    _cnt <= _cnt -1;
                    if(_cnt == 0) begin
                        _step <= 0;
                        _state <= STATE_CHECK_ACK;
                    end
                    else begin
                        _step <= 1;
                    end
                end
            endcase
        end
        
        if (_state == STATE_CHECK_ACK) begin
            case(_step)
                0:begin
                    _scl <= 0;
                    _step <= 1;
                end
                1:begin
                    _sda <= 1'bz;
                    _step <= 2;
                end
                2:begin
                    if(sda == 0)begin
                    end
                    else begin
                        error <= 1;
                    end
                end
            endcase
        end
        
    end
end

endmodule
