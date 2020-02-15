module async_fifo(n_rst,rd_clk,rd_en,dout,wr_clk,wr_en,din,empty,full);
parameter FIFO_WIDTH = 8;
parameter FIFO_DEPTH = 16;

input rd_clk,rd_en,wr_clk,wr_en,n_rst;
input  [FIFO_WIDTH-1:0] din;
output reg [FIFO_WIDTH-1:0] dout; 
output empty,full;

reg [FIFO_WIDTH-1:0] MEM[FIFO_DEPTH-1:0];

wire[4:0] wr_addr_gray,rd_addr_gray;
reg[4:0] wr_addr_b,wr_addr_gray1,wr_addr_gray2;
reg[4:0] rd_addr_b,rd_addr_gray1,rd_addr_gray2;

wire [3:0] wr_addr,rd_addr;
assign wr_addr = wr_addr_b[3:0];
assign rd_addr = rd_addr_b[3:0];

assign wr_addr_gray = (wr_addr_b>>1) ^ wr_addr_b;
assign rd_addr_gray = (rd_addr_b>>1) ^ rd_addr_b;


//读数据
always @(posedge rd_clk or negedge n_rst) begin
    if(!n_rst) begin
        rd_addr_b <= 'b0;
    end else if (rd_en && empty==0) begin
        dout <= MEM[rd_addr_b];
        rd_addr_b <= rd_addr_b + 'b1;
    end
end
//写数据
always @(posedge wr_clk or negedge n_rst) begin
    if(!n_rst) begin
        wr_addr_b <= 0;
    end else if(wr_en && full==0) begin
        MEM[wr_addr_b] <= din;
        wr_addr_b <= wr_addr_b + 'b1;
    end 
end

//将读地址同步到写时钟域,格雷码接两级D触发器级联，降低亚稳态出现概率
always @(posedge wr_clk or negedge n_rst) begin
    if(!n_rst)
        {rd_addr_gray2,rd_addr_gray1} <= 12'b0;
    else
        {rd_addr_gray2,rd_addr_gray1} <= {rd_addr_gray1,rd_addr_gray};
end
//将写地址同步到读时钟域,格雷码接两级D触发器级联，降低亚稳态出现概率
always @(posedge rd_clk or negedge n_rst) begin
    if(!n_rst)
        {wr_addr_gray2,wr_addr_gray1} <= 12'b0;
    else 
        {wr_addr_gray2,wr_addr_gray1} <= {wr_addr_gray1,wr_addr_gray};
end

assign empty = (rd_addr_gray == wr_addr_gray2)?1:0;
assign full  = (wr_addr_gray == {~rd_addr_gray2[4:3],rd_addr_gray2[2:0]});



endmodule