`timescale 1ps/1ps
module seq_tb;
reg clk,in,reset;
wire out_sfm,out_reg;
wire[2:0] state_sfm,state_reg;

always #5 clk = ~clk;

initial begin
    clk = 0 ;
    reset = 0;
    in = 0;
    #20 reset = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #2000 $finish;
end
seq_sfm seq_u1(
        .clk(clk),
        .in(in),
        .reset(reset),
        .out(out_sfm),
        .state(state_sfm)
);
seq_reg seq_u2(
        .clk(clk),
        .in(in),
        .reset(reset),
        .out(out_reg),
        .state(state_reg)
);





endmodule;

