/******************************************************************************
* 
* File   : Camera.h
* Version: 1.0
* Author : Shengke Wang
* Date   : 2012.10.25
* History£º 
* 
******************************************************************************/
#ifndef CAMERA_H_
#define CAMERA_H_

#include "opencv2/opencv.hpp"

class Camera
{
public:
    // Open camera.  
	virtual void OpenCamera() = 0;
    // Close camera.
	virtual void CloseCamera() = 0;
	// Get current frame of camera.
	virtual void GetFrame(cv::Mat &color_frame) = 0; 
   // Get the height of video frame.
	virtual int get_frame_height() = 0;
   // Get the width of video frame.
	virtual int get_frame_width() = 0;
};

#endif //#ifndef CAMERA_H_