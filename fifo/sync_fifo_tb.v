`timescale 10ns/1ns
module sync_fifo_tb;
parameter FIFO_WIDTH = 8;
parameter FIFO_DEPTH = 16;
reg clk, n_rst;
reg [FIFO_WIDTH-1:0] data_in;
wire [FIFO_WIDTH-1:0] data_out;
reg wr_en,rd_en;
wire empty,full;


always #5 clk = ~clk;

initial begin
    clk   = 0;
    n_rst = 0;
    wr_en = 0;
    rd_en = 0;
end


initial begin
    #10;
    n_rst = 1;
    wr_en = 1;
    data_in = 10;
    @(full==1)
    wr_en =0;
    rd_en =1;
    @(empty);
    wr_en =1;
    data_in = 20;
    #20;

end

sync_fifo u1(
    .clk(clk),
    .n_rst(n_rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .empty(empty),
    .full(full)
);






endmodule