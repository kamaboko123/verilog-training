module I2C_MASTER(
    input clk, reset_n,
    input enable,
    input mode,
    input [6:0] slave_addr,
    input [7:0] data,
    input stop,
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
reg [2:0] _state_next;
reg [7:0] _slave_addr;
reg [7:0] _data;
reg [3:0] _step;
reg [2:0] _cnt;
reg _stop;

parameter MODE_WRITE = 1;
parameter MODE_READ = 0;
parameter STATE_READY = 0;
parameter STATE_START = 1;
parameter STATE_SEND_ADDR = 2;
parameter STATE_CHECK_ACK = 3;
parameter STATE_SEND_DATA = 4;
parameter STATE_STOP = 5;
parameter STATE_NONE = 6;
parameter STATE_ERROR = 7;

always @(posedge clk or negedge reset_n or posedge enable) begin
    
    if(!reset_n) begin
        _state <= STATE_READY;
        _scl <= 1;
        _sda <= 1;
        _step <= 0;
        _mode <= 1'bx;
        _enable <= 0;
        error <= 0;
    end
    
    if(enable) begin
        if(_state == STATE_READY)begin
            _enable <= 1;
            _mode <= mode;
            _slave_addr <= (slave_addr << 1) + mode;
            _data = data;
            _state <= STATE_START;
            _stop <= stop;
            error <= 0;
        end
    end
    else begin
        if(_enable) begin
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
                            if(_mode == MODE_WRITE) begin
                                _state_next <= STATE_SEND_DATA;
                            end
                            else begin
                                //_state_next <= STATE_RECV_DATA;
                            end
                        end
                        else begin
                            _step <= 1;
                        end
                    end
                endcase
            end
            
            if(_state == STATE_CHECK_ACK) begin
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
                        _step <= 0;
                        if(sda == 0) begin
                            _step <= 0;
                            _state <= _state_next;
                        end
                        else begin
                            _state <= STATE_ERROR;
                        end
                    end
                endcase
            end
            
            if(_state == STATE_SEND_DATA) begin
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
                        _sda <= (_data & 8'b10000000) ? 1'b1 : 1'b0;
                        _step <= 3;
                    end
                    3:begin
                        _data <= _data << 1;
                        _scl <= 1;
                        _step <= 4;
                    end
                    4:begin
                        _cnt <= _cnt - 1;
                        if(_cnt == 0) begin
                            _step <= 0;
                            _state <= STATE_CHECK_ACK;
                            _state_next <= STATE_STOP;
                        end
                        else begin
                            _step <= 1;
                        end
                    end
                endcase
            end
            
            if(_state == STATE_STOP) begin
                case(_step)
                    0:begin
                        _scl <= 0;
                        _step <= 1;
                    end
                    1:begin
                        _sda <= 0;
                        _step <= 2;
                    end
                    2:begin
                        _scl <= 1;
                        _step <= 3;
                    end
                    3:begin
                        _sda <= 1;
                        _step <= 4;
                    end
                    4:begin
                        _state <= STATE_READY;
                    end
                endcase
            end
            
            if(_state == STATE_ERROR) begin
                error <= 1;
                _step <= 0;
                _state <= STATE_STOP;
            end
            
        end
    end
end

endmodule
