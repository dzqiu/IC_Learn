
if [file exists work] {vdel -all}
vlib work

vlog ./async_fifo_tb.v 
vlog ./../design/*.v   

vsim -t ns -voptargs=+acc  work.async_fifo_tb

#添加波形
add wave -divider (tb)
add wave async_fifo_tb/*
add wave -divider (module)
add wave async_fifo_tb/u1/*
#运行仿真
run -all