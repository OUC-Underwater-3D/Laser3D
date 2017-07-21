#include "../include/opencv2/opencv.hpp"

using namespace cv;

int main()
{
    Mat im = imread("../c_rect1.BMP");
    imshow("test", im);
    waitKey(0);
    return 0;
}