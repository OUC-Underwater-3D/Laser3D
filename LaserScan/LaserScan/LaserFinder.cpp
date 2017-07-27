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
	Mat mask = Mat::zeros(im.rows, im.cols, CV_8UC1);//8位无符号整型单通道矩阵
	int model = 1;
	int idrows, idcols;//记录数组下标
	int count = 0;//标记每一行或者每一列的最大值的个数
	uchar max;         //存每行或列的最大值
	//ofstream in;
	//in.open("./data.txt", ios::out);
	//in << "hhh";//测试是否写入data.txt

	// The laser line is horizontal. Process each column
	/*if (model == 1)  //model=1每一行最大值
	{
		for (int i = 0; i < im.rows; i++)
		{
			max = im.at<uchar>(i,0);
			for (int j = 0; j < im.cols; j++)//该循环找最大值
			{
				if (im.at<uchar>(i,j) >=max)
				{
					max = im.at<uchar>(i,j);
					//输出每一行最大值
					idrows = i;
					idcols = j;
					//cout << "第" << i << "行最大值为：" << max << endl;
					in<< "第" << i << "行最大值为：" << max <<endl;
					//先找到该行最大值
					in.close();
				}

			}
			for (int j = 0; j < im.cols; j++)//该循环标记出和最大值相等的最大值
			{
				if (im.at<uchar>(i, j) == max)
				{
					count = count + 1;
					idrows = i;
					idcols = j;
					in << "第" << i << "行第"<<count<<"个最大值为：" << max << " 坐标为：(" << idrows << "," << idcols << ")" << endl;
					in.close();
				}
			}
			mask.at<uchar>(idrows,idcols) == 255;
		}
	}
	*/


	for (int j = 0; j < im.cols; j++)
	{
		count = 0;
		vector<int> row_id;
		max = im.at<uchar>(0, j);
		row_id.push_back(0);
		for (int i = 1; i < im.rows; i++)//该循环找最大值
		{
			if (im.at<uchar>(i, j) > max)
			{
				max = im.at<uchar>(i, j);
				row_id.clear();
				row_id.push_back(i);

				//输出每一列最大值
				//idrows = i;
				//idcols = j;
				//cout << "第" << j << "列最大值为：" << max << endl;
				//in << "第" << i << "列最大值为：" << max << endl;
				//先找到该列最大值
				//in.close();
			}
			else if (im.at<uchar>(i, j) == max)
			{
				row_id.push_back(i);
			}
		}
		for (int k = 0; k < row_id.size(); ++k)
		{
			mask.at<uchar>(row_id[k], j) == 255;
		}
		/*
		for (int i = 0; i < im.rows; i++)//该循环找最大值
		{
			if (im.at<uchar>(i, j) == max)
			{
				count = count + 1;
				idrows = i;
				idcols = j;
				in << "第" << i << "列第" << count << "个最大值为：" << max << " 坐标为：(" << idrows << "," << idcols << ")" << endl;
				in.close();
			}
		}
		*/
		
	}

	return mask;
}