module seq_reg(in,clk,reset,out,state);
parameter SEQ_LEN = 'd7, SEQ = 7'b1110010;
input in,clk,reset;
output out;
output[2:0] state;

reg [SEQ_LEN-1:0] cur_seq;

always @(posedge clk or negedge reset) begin
    if(!reset || out) begin
        if(SEQ[SEQ_LEN-1:SEQ_LEN-1]==1)
            cur_seq <= 7'b0000000;
        else 
            cur_seq <= 7'b1111111;
    end else begin
        cur_seq <= {cur_seq[SEQ_LEN-1:0],in};
    end
end

assign out = (cur_seq==SEQ)?1:0;
assign state = 3'b0;
endmodule