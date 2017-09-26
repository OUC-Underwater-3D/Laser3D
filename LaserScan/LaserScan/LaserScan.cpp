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


	Mat im = imread("../w1_rect.bmp");
	namedWindow("test", 0);
	imshow("test", im);
	waitKey(0);
	cvtColor(im, im, COLOR_BGR2GRAY);//设置为单通道图

	LaserFinder laser;
	Mat laserMask = laser.FindLaserMask(im);
	namedWindow("LaserMask", 0);
	imshow("LaserMask", laserMask);
	waitKey(0);
	imwrite("../LaserMask.bmp", laserMask);

	return 0;
}