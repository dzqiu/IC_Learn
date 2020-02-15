module ram_tb;
parameter RAM_WIDTH     = 8;
parameter RAM_DEPTH     = 512;
parameter ADDR_WIDTH    = 9;
parameter DELAY         = 2; 

reg clk;
reg [RAM_WIDTH-1:0] wr_data;
wire [RAM_WIDTH-1:0] rd_data;
reg [ADDR_WIDTH-1:0] wr_addr,rd_addr; 
reg wr_en,rd_en;

always #2 clk = ~ clk;

initial begin
    clk = 0;
    wr_en = 0; rd_en = 0;

    #10;
    wr_addr = 'd100;wr_data = 'd 6; wr_en =1;
    #10;
    wr_en = 0;
    #20;
    rd_addr = 'd100;rd_en=1;
    #100;
    $finish


end


ram ram_u1(
    .wr_clk(clk),
    .rd_clk(clk),
    .wr_addr(wr_addr),
    .rd_addr(rd_addr),
    .wr_data(wr_data),
    .rd_data(rd_data),
    .wr_en(wr_en),
    .rd_en(rd_en)
);


endmodule