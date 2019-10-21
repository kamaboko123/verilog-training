module I2C_READ(
    input clk,
    input reset_n,
    input [7:0] slave_addr,
    input [6:0] register_addr,
    inout sda,
    output scl,
    output busy,
    output [7:0] recv_buf,
    input enable,
    output reg error
);

parameter STATE_SETUP = 0;
parameter STATE_READY = 1;
parameter STATE_SEND_ADDR_START = 2;
parameter STATE_SEND_ADDR_WAIT = 3;
parameter STATE_RECV_DATA_START = 4;
parameter STATE_RECV_DATA_WAIT = 5;
parameter STATE_FINISH = 6;

parameter I2C_MODE_WRITE = 0;
parameter I2C_MODE_READ = 1;

wire _i2c_busy;
reg _i2c_enable;
reg _i2c_mode;
wire _i2c_error;
reg [6:0] _i2c_slave_addr;
reg [7:0] _i2c_data;
reg [3:0] _state;

I2C_MASTER master(
    .clk(clk),
    .reset_n(reset_n),
    .enable(_i2c_enable),
    .mode(_i2c_mode),
    .slave_addr(_i2c_slave_addr),
    .data(_i2c_data),
    .sda(sda),
    .scl(scl),
    .busy(_i2c_busy),
    .recv_buf(recv_buf),
    .error(_i2c_error)
);

assign busy = !((_state == STATE_READY) || (_state == STATE_FINISH));

always @(posedge clk or reset_n) begin
    if(!reset_n) begin
        _i2c_enable <= 0;
        _state <= STATE_SETUP;
        error <= 0;
    end
    else begin
        case(_state)
            STATE_SETUP: begin
                _i2c_mode <= I2C_MODE_WRITE;
                _i2c_slave_addr <= slave_addr;
                _i2c_data <= register_addr;
                _state <= STATE_READY;
            end
            STATE_READY: begin
                if(enable) begin
                    _state <= STATE_SEND_ADDR_START;
                end
            end
            STATE_SEND_ADDR_START: begin
                if(_i2c_busy == 0) begin
                    _i2c_enable <= 1;
                    _state <= STATE_SEND_ADDR_WAIT;
                end
            end
            STATE_SEND_ADDR_WAIT: begin
                _i2c_enable <= 0;
                if(_i2c_busy == 0) begin
                    if(_i2c_error) begin
                        error <= 1;
                        _state <= STATE_FINISH;
                    end
                    else begin
                        _i2c_mode <= I2C_MODE_READ;
                        _state <= STATE_RECV_DATA_START;
                    end
                end
            end
            STATE_RECV_DATA_START: begin
                if(_i2c_busy == 0) begin
                    _i2c_enable <= 1;
                    _state <= STATE_RECV_DATA_WAIT;
                end
            end
            STATE_RECV_DATA_WAIT: begin
                _i2c_enable <= 0;
                if(_i2c_busy == 0) begin
                    error <= _i2c_error;
                    _state <= STATE_FINISH;
                end
            end
            
        endcase
    end
end

endmodule
