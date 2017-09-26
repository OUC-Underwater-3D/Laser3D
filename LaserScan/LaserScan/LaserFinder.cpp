#include "LaserFinder.h"
#include <iostream>
#include <fstream>

using namespace std;
using namespace cv;

LaserFinder::LaserFinder()
{

}

LaserFinder::~LaserFinder()
{

}

Mat LaserFinder::FindLaserMask(const Mat &im)
{
	Mat mask = Mat::zeros(im.rows, im.cols, CV_8U);//8位无符号整型单通道矩阵
	int max, a;         //存每行或列的最大值
	int idrows, idcols;

	for (int j = 0; j < im.cols; j++)//cols列
	{
		vector<int> row_id;
		max = im.at<uchar>(0, j);
		if (im.at<uchar>(0, j) > thresh)
		{
			row_id.push_back(0);
		}
		for (int i = 1; i < im.rows; i++)//该循环找最大值
		{
			if (im.at<uchar>(i, j) > thresh)
			{
				if (im.at<uchar>(i, j) > max)
				{
					max = im.at<uchar>(i, j);
					row_id.clear();
					row_id.push_back(i);
					//in << "第" << i << "列最大值为：" << max << endl;
					//先找到该列最大值
					//in.close();
				}
				else if (im.at<uchar>(i, j) == max)
				{
					row_id.push_back(i);
				}
			}
		}
		for (int k = 0; k < row_id.size(); ++k)
		{
			mask.at<uchar>(row_id[k], j) = 255;
		}
		//in << "第" << i << "列第" << count << "个最大值为：" << max << " 坐标为：(" << idrows << "," << idcols << ")" << endl;
		//in.close();
	}
	/*
	for (int j = 0; j < im.cols; j++)
	{
	max = im.at<uchar>(0, j);
	for (int i = 1; i < im.rows; i++)//该循环找最大值
	{
	if (im.at<uchar>(i, j) > max)
	{
	max = im.at<uchar>(i, j);

	}
	}
	if (max > 30)
	{
	for (int i = 0; i < im.rows; i++)
	{
	if (im.at<uchar>(i, j) ==max)
	{
	idrows = i;
	idcols = j;
	mask.at<uchar>(idrows, idcols) = 255;
	}
	}
	}
	}
	*/

	return mask;
}