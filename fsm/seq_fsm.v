//序列检测 1110010
module seq_sfm(in,out,state,clk,reset);
input in,clk,reset;
output out;
output[2:0] state;

reg[2:0] cur_state,next_state;
wire out;
wire[2:0] state;
parameter s0='d0,s1='d1,s2='d2,s3='d3,s4='d4,s5='d5,s6='d6,s7='d7;
// 三段式描述状态机
//第一段，描述状态转移 
always@(posedge clk or negedge reset) begin
    if(!reset) begin
        cur_state <= s0;
    end else begin
        cur_state <= next_state;
    end
end    
//第二段 组合逻辑
always@(*) begin
    case(cur_state)
        s0: begin 
            if(in==0) begin next_state <= s0; end
            else begin      next_state <= s1; end
            end
        s1: begin
            if(in==1) begin next_state <= s2; end
            else begin      next_state <= s0; end
            end
        s2: begin
            if(in==1) begin next_state <= s3; end
            else begin      next_state <= s0; end
            end
        s3: begin
            if(in==0) begin next_state <= s4; end
            else begin      next_state <= s3; end
            end
        s4: begin 
            if(in==0) begin next_state <= s5; end
            else begin      next_state <= s1; end
            end
        s5: begin
            if(in==1) begin next_state <= s6; end
            else begin      next_state <= s0; end
            end
        s6: begin
            if(in==0) begin next_state <= s7; end
            else begin      next_state <= s2; end
            end
        s7: begin
            if(in==1) begin next_state <= s1; end
            else begin      next_state <= s0; end
            end
        default: next_state <= s0; 
    endcase
end

//第三段 描述输出
assign state = cur_state;
assign out = (cur_state==s7)? 1:0 ;
endmodule;