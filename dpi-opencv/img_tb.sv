`include "cvFunction.svh"
module  img_tb();
reg [8:0] r,g,b;
reg clk;
longint unsigned img_ptr;
// string file_name = "/home/dzqiu/code/verilog_ws/sv_learn/dpi-opencv/test.png";
string file_name = "./test.png";
int width,heigth,pixel_r,pixel_g,pixel_b;
initial begin
    r = 8'h0;
    g = 8'h0;
    b = 8'h0;
    clk = 0;
end
always #5 clk =~clk;
initial begin
    $display("test....\n");
    img_ptr=readframe(file_name);
    width = getWidth();heigth= getHeight();
    for(int i=0;i<heigth;i++)
        for(int j=0;j<width;j++) begin
            @(posedge clk);
            pixel_b = getChannel(img_ptr,i,j,0);
            pixel_g = getChannel(img_ptr,i,j,1);
            pixel_r = getChannel(img_ptr,i,j,2);
        end
    $display("finish a picture.\n");
end
endmodule