#source 
SV_FILE = img_tb.sv
TOP_NAME = img_tb
SRC = cvFunction.c
DPI_OBJ = svdpi
#Too;l
MODELSIM_HOME = /home/dzqiu/Modelsim10.2c/modeltech
VLIB = vlib
VLOG = vlog
VSIM = vsim

CC = g++
OBJ = $(SRC:%.c=%.o)

# definitions needed for OpenCV:
CV_COPTS=`pkg-config --cflags opencv`
CV_LOPTS=`pkg-config --libs opencv`

run : vlib vlog vsim

vlib:
	$(VLIB) work

vlog:
	$(VLOG) -sv -dpiheader dpiheader.h $(SV_FILE) +acc

vsim: $(DPI_OBJ).so
	$(VSIM) -64  -sv_lib $(DPI_OBJ) $(TOP_NAME)   -do "add wave -position insertpoint sim:/img_tb/clk sim:/img_tb/pixel_r sim:/img_tb/pixel_g sim:/img_tb/pixel_b;run -all"

.c.o:
	$(CC) -c -fpic -m64 -I$(MODELSIM_HOME)/include $(CV_COPTS) $<

$(DPI_OBJ).so :$(OBJ)
	$(CC) -shared -m64 $(OBJ) -o $(DPI_OBJ).so $(CV_COPTS) $(CV_LOPTS)

qv:
	LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$(LIBRARY_PATH) qverilog $(SV_FILE) $(SRC)

clean:
	rm -rf work dpi.so $(DPI_OBJ).so $(OBJ)  transcript *.wlf dpiheader.h