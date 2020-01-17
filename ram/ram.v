module ram(wr_clk,rd_clk,wr_addr,rd_addr,wr_data,rd_data,wr_en,rd_en);
parameter RAM_WIDTH     = 8;
parameter RAM_DEPTH     = 512;
parameter ADDR_WIDTH    = 9;
parameter DELAY         = 2; 

input wr_clk,rd_clk;
input [ADDR_WIDTH-1:0] wr_addr,rd_addr;
input [RAM_WIDTH-1:0] wr_data;
output reg [RAM_WIDTH-1:0] rd_data;
input rd_en,wr_en;

reg [RAM_WIDTH-1:0] MEN[RAM_DEPTH-1:0];

always @(posedge wr_clk) begin
    if(wr_en)
        MEN[wr_addr] <= #DELAY wr_data;
end

always @(posedge rd_clk) begin
    if(rd_en)
        rd_data <= #DELAY MEN[rd_addr];
end

endmodule