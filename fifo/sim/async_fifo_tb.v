`timescale 10ns/1ns

module async_fifo_tb;
parameter FIFO_WIDTH = 8;
    
reg n_rst,rd_clk,wr_clk,rd_en,wr_en;
reg[FIFO_WIDTH-1:0] din;
wire[FIFO_WIDTH-1:0] dout;
wire empty,full;

always #3 rd_clk = ~rd_clk;
always #4 wr_clk = ~wr_clk;

initial begin
    n_rst = 0;
    rd_clk = 0;
    wr_clk = 0;
    rd_en = 0;
    wr_en = 1;
    #30;
    n_rst =1;
    
end

initial begin
    $display("begin sim\n");
    #30;
    wr_en = 1; din = 4'd0;
    #8;din = 4'd1;
    #8;din = 4'd2;
    #8;din = 4'd3;
    #8;din = 4'd4;
    #8;din = 4'd5;
    #8;din = 4'd6;
    #8;din = 4'd7;
    #8;din = 4'd8;
    #8;din = 4'd9;
    #8;din = 4'd10;
    #8;din = 4'd11;
    #8;din = 4'd12;
    #8;din = 4'd13;
    #8;din = 4'd14;
    #8;din = 4'd15;
    #8;din = 4'd15;
    #8;din = 4'd15;
    #8;wr_en=0;
    rd_en =1;
    #100;
    $finish;


end


    
async_fifo u1(
    .n_rst(n_rst),
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .dout(dout),
    .wr_clk(wr_clk),
    .wr_en(wr_en),
    .din(din),
    .empty(empty),
    .full(full));



endmodule