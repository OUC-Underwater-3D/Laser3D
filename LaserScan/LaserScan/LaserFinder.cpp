#include "LaserFinder.h"

LaserFinder::LaserFinder()
{

}

LaserFinder::~LaserFinder()
{

}

cv::Mat LaserFinder::FindLaserMask(const cv::Mat &im)
{
    cv::Mat mask = cv::Mat::zeros(im.rows, im.cols, CV_8UC1);
    for (int i = 0; i < im.rows; i++)     
    {
        for (int j = 0; j < im.cols; j++)
        {

        }
    }
    return mask;
}