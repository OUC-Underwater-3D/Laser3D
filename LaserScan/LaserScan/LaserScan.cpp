#include <fstream>
#include "../include/opencv2/opencv.hpp"
#include "LaserFinder.h"

using namespace std;
using namespace cv;

int main()
{
	//fstream testFile;
	//testFile.open("./data.txt", std::fstream::in | std::fstream::out | std::fstream::app);
	//testFile << "hhh";
	//testFile.close();


    Mat im = imread("../w1_rect.BMP");
    imshow("test", im);
    waitKey(0);

	LaserFinder laser;
	Mat laserMask = laser.FindLaserMask(im);

	imshow("LaserMask", laserMask);
	waitKey(0);

	imwrite("../LaserMask.bmp", laserMask);

    return 0;
}