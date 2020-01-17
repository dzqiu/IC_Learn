module sync_fifo(clk,n_rst,wr_en,rd_en,data_in,data_out,empty,full);
parameter FIFO_WIDTH = 8;
parameter FIFO_DEPTH = 16;
input clk,n_rst,wr_en,rd_en;
output empty,full;

output reg [FIFO_WIDTH-1:0] data_out;
input [FIFO_WIDTH-1:0] data_in;

reg [FIFO_WIDTH-1:0] MEM[FIFO_DEPTH-1:0];

//FIFO读写地址，最高位用于判断FIFO是否为满
reg[4:0] wr_addr_a,rd_addr_a;
wire [3:0] wr_addr,rd_addr;
assign wr_addr = wr_addr_a[3:0];
assign rd_addr = rd_addr_a[3:0];


assign empty = (wr_addr_a==rd_addr_a)?1:0;
assign full  = (wr_addr_a[4]!=rd_addr_a[4] && rd_addr_a[3:0]==wr_addr_a[3:0])?1:0;

always @(posedge clk) begin
    if(!n_rst)
        wr_addr_a <= 0;
    else if(full==0 && wr_en) begin
        MEM[wr_addr] <= data_in;
        wr_addr_a  <= wr_addr_a + 'b1;
    end
end

always @(posedge clk) begin
    if(!n_rst)
        rd_addr_a <= 0;
    else if(empty==0 && rd_en) begin
        data_out <= MEM[rd_addr];
        rd_addr_a <= rd_addr_a + 'b1;
    end
end

endmodule