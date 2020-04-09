#include "svdpi.h"
#include "stdio.h"
#include "stdlib.h"

#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"

using namespace cv;
static int WIDTH;
static int HEIGHT;
extern "C" void c_fun_printf(char * p_in)
{
    printf("c function print:%s\n",p_in);
}

extern "C" unsigned long long  allocFrame(int width,int height)
{
    Mat frame(height,width,CV_8UC3);
    void *frame_data = malloc(frame.total()*frame.elemSize());
    return (unsigned long long)frame_data;
}
extern "C" unsigned long long readframe(char * filename)
{
    Mat img = imread(filename,1);
    if(!img.data)
        printf("can not read image\n");
    printf("read image width:%d height:%d\n",img.cols,img.rows);
    HEIGHT = img.rows; WIDTH = img.cols;
    void *frame_data =(void *)allocFrame(img.cols,img.rows);
    Mat frame(img.cols,img.rows,CV_8UC3,(void *)frame_data);
    memcpy(frame.data,img.data,img.total()*img.elemSize());
    return (unsigned long long)frame.data;
}
extern "C"  int getChannel(unsigned long long pp,int i,int j,int c)
{
    Mat img(WIDTH,HEIGHT,CV_8UC3,(void*)pp);
    Vec3b intensity = img.at<Vec3b>(i,j);
    return intensity.val[c];
}
extern "C" int getWidth()
{
    return WIDTH;
}

extern "C" int getHeight()
{
    return HEIGHT;
}