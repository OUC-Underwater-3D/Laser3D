/******************************************************************************
* 
* File   : ColorCamera.h
* Version: 1.0
* Author : Xiaoying Sha
* Date   : 2012.10.26
* History£º
*          2012.10.31, Shengke Wang. Reviewed.
*          2012.11.9, Xiaoying Sha. Add parameter file.
******************************************************************************/
#ifndef COLORCAMERA_H_
#define COLORCAMERA_H_

#include "uEye.h"
#include "Camera.h"
//#include "../modules/Presentation/Configure.h"
//#include "ExceptionBase.h"

//extern Configure g_configure;

class ColorCamera : public Camera
{
public:
	ColorCamera();
	~ColorCamera();

	virtual void OpenCamera();

	// Open camera with serial NO.
    void OpenCamera(const char *serial_no, bool show_aoi = true, 
        const wchar_t *param_file = kParamFile);
        
    virtual void CloseCamera();

    // Reset camera AOI to the original size.
    void ResetAOI();
    
	virtual void GetFrame(cv::Mat &color_frame);

	virtual int get_frame_height();

	virtual int get_frame_width();

    // Get serial NO of current camera.
    std::string get_serial_no(); 

    // Judge if the specified camera is in use.
    bool IsCameraInUse();

    // Get serial NOs of all connected cameras.
	bool GetAllSerialNo(std::vector<std::string> &sno);

    // Load parameters of current camera.
	void LoadParameters(bool show_aoi = true,
        const wchar_t *param_file = kParamFile);

    int    get_pos_x_step(){ return x_step_; }
    int    get_pos_y_step(){ return y_step_; }

    double get_exposure_min(){ return exposure_min_; }
    double get_exposure_max(){ return exposure_max_; }
    double get_exposure_inc(){ return exposure_inc_; }

    double GetExposureTime();
    void   SetExposureTime(double exposure);
    void   SetRedGain(int red_gain);
    void   SetGreenGain(int green_gain);
    void   SetBlueGain(int blue_gain);
        
private:
    void GetOriginSize();

	std::string serial_no_;             // serial NO of current camera
	static const wchar_t *kParamFile;   // parameter file for color camera		                                  
	HIDS   cam_handle_;                 // handle to camera
	int    ret_;                        // return value of uEye SDK functions
	int    size_x_;                     // width of video
	int    size_y_;                     // height of video
	int    pos_x_;			            // left offset of image
	int    pos_y_;			            // right offset of image
	int    max_width_;                  // max width of frame image
	int    max_height_;                 // max height of frame image
    int    width_step_;                 // step for width of image
    int    height_step_;                // step for height of image
    int    x_step_;                     // step for x orientation
    int    y_step_;                     // step for y orientation
	int    memory_id_;                  // grabber memory - buffer ID
	char   *image_memory_;              // grabber memory - pointer to buffer
    double exposure_min_;
    double exposure_max_;
    double exposure_inc_;
    bool   reset_aoi_;
};

#endif //#ifndef COLORCAMERA_H_