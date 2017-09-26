#ifndef LASERFINDER_H
#define LASERFINDER_H

#include "opencv2/opencv.hpp"

class LaserFinder
{
public:
    LaserFinder();
    virtual ~LaserFinder();

    // return a binary image which indicates pixels lit by the laser
    cv::Mat FindLaserMask(const cv::Mat &im);

protected:
private:
	const static uchar thresh = 30;
};

#endif