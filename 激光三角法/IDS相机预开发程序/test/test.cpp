// test.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <string>
#include <iostream>
#include "ColorCamera.h"
//#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/ml/ml.hpp>
#pragma warning(disable:4996)
using namespace cv;
using namespace std;


int main()

{
	ColorCamera camera1, camera2;
	camera1.OpenCamera("4002871717", L"20160105.ini");
	camera2.OpenCamera("4102653410", L"20160105.ini");

	Mat frame1;
	Mat frame2;
	char img_name1[100];
	char img_name2[100];

	bool stop = false;
	int i = 1;
	while (!stop)
	{
		
		camera1.GetFrame(frame1);
		camera2.GetFrame(frame2);

		if (frame1.empty() && frame2.empty())
			return 0;
		resize(frame1,frame1,Size(640,480));
		resize(frame2, frame2, Size(640, 480));
		imshow("当前视频1", frame1);
		imshow("当前视频2", frame2);
		int c1 = waitKey(16);
		if ((char)c1 == 13)
		{
			
			sprintf(img_name1, "E:\\uEye\\test\\L%d.jpg", i);
			sprintf(img_name2, "E:\\uEye\\test\\R%d.jpg", i);
			imwrite(img_name1,frame1);
			imwrite(img_name2, frame2);
			printf("已经保存第  %d  对左右图像\n",i);
			i++;
		}
		int c2 = waitKey(16);
		if ((char)c2 == 27)
			stop = true;

	}

	return 0;

}

