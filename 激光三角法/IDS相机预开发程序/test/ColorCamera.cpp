/******************************************************************************
* 
* File   : ColorCamera.cpp
* Version: 1.0
* Author : Xiaoying Sha
* Date   : 2012.10.26
* History£º
*          2012.11.26, ql. Change the return type of OpenCamera() to void.
*                        
******************************************************************************/
#include "stdafx.h"
#include "ColorCamera.h"

using namespace cv;
using namespace std;

const wchar_t *ColorCamera::kParamFile = L".\\Camera_4002871717.ini";

/*-----------------------------------------------------------------------------
Description: Constructor of ColorCamera class.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
ColorCamera::ColorCamera()
{
	cam_handle_ = (HIDS)0;
	ret_        = IS_SUCCESS;
	size_x_     = 0;
	size_y_     = 0;
	pos_x_      = 0;
	pos_y_      = 0;
    image_memory_ = NULL;
    reset_aoi_ = false;
}

/*-----------------------------------------------------------------------------
Description: Destructor of ColorCamera class.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
ColorCamera::~ColorCamera()
{
    CloseCamera();
}

/*-----------------------------------------------------------------------------
Description£ºGet serial NOs of all connected cameras..
Output : vector<string> sno -- all serial NOs.
Return : bool -- if there is a camera connected, return true; else return false.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
bool ColorCamera::GetAllSerialNo(vector<string> &sno)
{
    if (!sno.empty())
    {
        sno.clear();
    }

	bool cam_exist = false;
	
	// Get numbers of camera.
	int cam_count;
	is_GetNumberOfCameras(&cam_count);
	if(cam_count >= 1) 
	{
		cam_exist = true;
		// Create new list with suitable size.
		UEYE_CAMERA_LIST *pucl = (UEYE_CAMERA_LIST *)new BYTE[sizeof(DWORD) 
            + cam_count*sizeof(UEYE_CAMERA_INFO)];
		pucl->dwCount = cam_count;

		// Retrieve camera info.
		is_GetCameraList(pucl);
		for (int i = 0; i < cam_count; i++)
		{
			sno.push_back(pucl->uci[i].SerNo);
		}
		delete []pucl;
	}

	return cam_exist;
}

/*-----------------------------------------------------------------------------
Description£ºJudge if the current camera is in use.
Author  : Xiaoying.Sha 		 Date: 2013-07-02
-----------------------------------------------------------------------------*/
bool ColorCamera::IsCameraInUse()
{
	bool cam_avaliable = false;
	// Get camera count.
	int cam_count;
	is_GetNumberOfCameras(&cam_count);
	if(cam_count >= 1) 
	{
		// Create new list with suitable size.
		UEYE_CAMERA_LIST *pucl = (UEYE_CAMERA_LIST *)new BYTE[sizeof(DWORD)
            + cam_count * sizeof(UEYE_CAMERA_INFO)];
		pucl->dwCount = cam_count;

		// Retrieve camera info.
		is_GetCameraList(pucl);
		for (int i = 0; i < cam_count; i++)
		{
			if(strcmp(pucl->uci[i].SerNo, serial_no_.c_str()) == 0)  
			{
				if(pucl->uci[i].dwInUse && cam_handle_ != 0)
                {
                    cam_avaliable = true;
				}
			}
		}
		delete []pucl;
	}

    return cam_avaliable;
}

/*-----------------------------------------------------------------------------
Description£ºOpen one HD camera.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
void ColorCamera::OpenCamera()
{
	// Get numbers of camera.
	int cam_count;
	is_GetNumberOfCameras(&cam_count);
	if(cam_count >= 1) 
	{
		// Create new list with suitable size.
		UEYE_CAMERA_LIST *pucl = (UEYE_CAMERA_LIST*)new BYTE[sizeof(DWORD) 
            + cam_count * sizeof(UEYE_CAMERA_INFO)];
		pucl->dwCount = cam_count;

		// Retrieve camera info.
		if (is_GetCameraList(pucl) == IS_SUCCESS) 
		{
			for (int i = 0; i < cam_count; i++)
			{
				if(pucl->uci[i].dwInUse)
				{
					i++;
				}
				else
				{
					cam_handle_ = (HIDS)pucl->uci[i].dwDeviceID | IS_USE_DEVICE_ID;
					break;
				}
			}
		}
		delete []pucl;

        INT nRet = is_InitCamera (&cam_handle_, NULL); 
        if (nRet != IS_SUCCESS)
        {
             //Check if GigE uEye SE needs a new starter firmware
             if (nRet == IS_STARTER_FW_UPLOAD_NEEDED)
             { 
                //Upload new starter firmware during initialization
                cam_handle_ =  cam_handle_ | IS_ALLOW_STARTER_FW_UPLOAD;
                nRet = is_InitCamera (&cam_handle_, NULL);
                /*if (nRet != IS_SUCCESS)
                {
                    THROW_EXCEPTION(UeyeException, "Camera is unavailable", 0);
                }*/
             }
        }
	}

	// Get board info.
	CAMINFO CameraInfo;
	is_GetCameraInfo(cam_handle_, &CameraInfo);
    // Save serial NO.
	serial_no_ = CameraInfo.SerNo;
    // Get default parameters of current camera.
    GetOriginSize();
    // Load parameters for current camera.
	LoadParameters(true, kParamFile);
}

/*-----------------------------------------------------------------------------
Description£ºOpen a camera with specified serial NO and set its parameter file.
Input   : char *serial_no     -- the serial NO.
          wchar_t *param_file -- parameter file
          bool show_aoi       -- if show AOI or not
Author  : Xiaoying.Sha 		 Date: 2012-11-26
Revision: Xiaoying.Sha, 2012.11.9, add parameter file.
-----------------------------------------------------------------------------*/
void ColorCamera::OpenCamera(const char *serial_no, bool show_aoi
    , const wchar_t *param_file)
{
	bool cam_exist = false;
	// Get camera count.
	int cam_count;
	is_GetNumberOfCameras(&cam_count);
	if(cam_count >= 1) 
	{
		// Create new list with suitable size.
		UEYE_CAMERA_LIST *pucl = (UEYE_CAMERA_LIST *)new BYTE[sizeof(DWORD)
            + cam_count * sizeof(UEYE_CAMERA_INFO)];
		pucl->dwCount = cam_count;

		// Retrieve camera info.
		is_GetCameraList(pucl);
		for (int i = 0; i < cam_count; i++)
		{
			if(strcmp(pucl->uci[i].SerNo, serial_no) == 0)  
			{
				cam_exist = true;
				if(pucl->uci[i].dwInUse)
				{
					CloseCamera();
				}
				else
				{
					cam_handle_ = (HIDS)pucl->uci[i].dwDeviceID | IS_USE_DEVICE_ID;
					serial_no_ = serial_no;
				}
				break;
			}
		}
		delete []pucl;
	}

	/*if (!cam_exist)
	{
		THROW_EXCEPTION(UeyeException, "Camera is not connected", 0);
        return;
	}*/

    INT nRet = is_InitCamera (&cam_handle_, NULL); 
    if (nRet != IS_SUCCESS)
    {
        //Check if GigE uEye SE needs a new starter firmware
        if (nRet == IS_STARTER_FW_UPLOAD_NEEDED)
        {
            //Calculate time needed for updating the starter firmware
            //INT nTime;
            //is_GetDuration (cam_handle_, IS_STARTER_FW_UPLOAD, &nTime);
 
            //Upload new starter firmware during initialization
            cam_handle_ =  cam_handle_ | IS_ALLOW_STARTER_FW_UPLOAD;
            nRet = is_InitCamera (&cam_handle_, NULL);
            /*if (nRet != IS_SUCCESS)
            {
                THROW_EXCEPTION(UeyeException, "Camera is unavailable", 0);
            }*/
        }
    }

    // Get default parameters of current camera.
    GetOriginSize();
    // Load parameters for current camera.
	LoadParameters(show_aoi, param_file);
}

/*-----------------------------------------------------------------------------
Description: Close camera.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
void ColorCamera::CloseCamera()
{
    if(cam_handle_ != 0)
    {
        // Free the allocated buffer.
        if(image_memory_ != NULL)
        {
            is_FreeImageMem(cam_handle_, image_memory_, memory_id_);
            image_memory_ = NULL;
        }
        // Close camera.
        is_ExitCamera(cam_handle_);
        cam_handle_ = NULL;
    }
}

/*-----------------------------------------------------------------------------
Description: Get frame from camera.
Output : Mat &colorFrame -- the frame from HD camera
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
void ColorCamera::GetFrame(Mat &color_frame)
{    
    if (!color_frame.empty())
    {
        color_frame.release();
    }

    ret_ = is_FreezeVideo(cam_handle_, IS_WAIT);
    if (ret_ == IS_NO_SUCCESS || ret_ == IS_TRANSFER_ERROR)
    {
        /*THROW_EXCEPTION(UeyeException, "Camera is not connected", ret_);*/
    }
    else
    {
        int line_step = 0;
        is_GetImageMemPitch(cam_handle_, &line_step);

        if (!reset_aoi_)
        {
            Mat img(size_y_, size_x_, CV_8UC3, image_memory_, line_step);	
            if (image_memory_)
            {
                color_frame = img.clone();
            }
        }
    }
}

/*-----------------------------------------------------------------------------
Description: Get the height of the frame.
Return : int -- the height of the frame
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
int ColorCamera::get_frame_height()
{
	return size_y_;
}

/*-----------------------------------------------------------------------------
Description: Get the width of the frame.
Return : int -- the width of the frame
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
int ColorCamera::get_frame_width()
{
	return size_x_;
}

/*-----------------------------------------------------------------------------
Description: Get serial NO of current camera.
Return : string -- the serial NO. of current HD camera.
Author : Xiaoying.Sha 		 Date: 2012-11-26
-----------------------------------------------------------------------------*/
string ColorCamera::get_serial_no()
{
	return serial_no_;
}

/*-----------------------------------------------------------------------------
Description: Load parameters of the camera.
Input   : wchar_t *param_file -- parameter file
          bool show_aoi       -- if show AOI or not
Author  : Xiaoying.Sha 		 Date: 2012-11-26
Revision: Xiaoying.Sha, 2012.11.9, add parameter file.
-----------------------------------------------------------------------------*/
void ColorCamera::LoadParameters(bool show_aoi, const wchar_t *param_file)
{ 	
	if(cam_handle_ == NULL || param_file == NULL)	
    {
        return;
    }

	if (cam_handle_ != 0)
	{   
		ret_ = is_ParameterSet(cam_handle_, IS_PARAMETERSET_CMD_LOAD_FILE, (void *)param_file, NULL);
        
        /* get exposure range */
        double dExpsoureRange[3];
        ret_ = is_Exposure(cam_handle_, IS_EXPOSURE_CMD_GET_EXPOSURE_RANGE, (void*)&dExpsoureRange, sizeof(dExpsoureRange));
        if (ret_ == IS_SUCCESS)
        {
            /* min, max, inc */
            exposure_min_ = dExpsoureRange[0];
            exposure_max_ = dExpsoureRange[1];
            exposure_inc_ = dExpsoureRange[2];
        }
		
		is_SetExternalTrigger(cam_handle_, IS_SET_TRIGGER_SOFTWARE);
		
		// Set the bitmapmode so we have access to the memory.
		int nRet = is_SetDisplayMode(cam_handle_, IS_SET_DM_DIB);

        // Returns the AOI position and size by using an object of the IS_RECT type.
        IS_RECT rectAOI;
        if (show_aoi)
        {
            is_AOI(cam_handle_, IS_AOI_IMAGE_GET_AOI, (void *)&rectAOI, sizeof(rectAOI));
            pos_x_  = rectAOI.s32X;
            pos_y_  = rectAOI.s32Y;
            size_x_ = rectAOI.s32Width;
            size_y_ = rectAOI.s32Height;
        }
        else
        {
            pos_x_ = 0;
            pos_y_ = 0;
            size_x_ = max_width_;
            size_y_ = max_height_;
        }

        // Set the position and size of the image by using an object of the IS_RECT type.
        is_AOI( cam_handle_, IS_AOI_IMAGE_SET_AOI, (void *)&rectAOI, sizeof(rectAOI));

        int bits_per_pixel = 24;  // number of bits needed to store one pixel
        // Memory initialization.
		ret_ = is_AllocImageMem( cam_handle_, size_x_, size_y_, bits_per_pixel, &image_memory_, &memory_id_);
        if(ret_ != IS_SUCCESS)
		{
			/*THROW_EXCEPTION(UeyeException, "Memory allocation failed", ret_);*/
		}
		else
		{
			// Set memory active.
			is_SetImageMem(cam_handle_, image_memory_, memory_id_ );
		}
		if (nRet == IS_SUCCESS)
		{
			is_SetColorMode(cam_handle_, IS_CM_BGR8_PACKED);
		}
	} 
}

void ColorCamera::GetOriginSize()
{
    /* Receive aoi values */
    IS_SIZE_2D sizeMin;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_SIZE_MIN, (void*) &sizeMin, sizeof (sizeMin));

    IS_SIZE_2D sizeMax;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_SIZE_MAX, (void*) &sizeMax, sizeof (sizeMax));

    IS_POINT_2D pointMin;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_POS_MIN, (void*) &pointMin, sizeof (pointMin));

    IS_POINT_2D pointMax;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_POS_MAX, (void*) &pointMax, sizeof (pointMax));

    IS_SIZE_2D sizeInc;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_SIZE_INC, (void*) &sizeInc, sizeof (sizeInc));

    IS_POINT_2D pointInc;
    is_AOI(cam_handle_, IS_AOI_IMAGE_GET_POS_INC, (void*) &pointInc, sizeof (pointInc));

    /* Update step values */
    max_width_   = sizeMax.s32Width;
    max_height_  = sizeMax.s32Height;
    width_step_  = sizeInc.s32Width;
    height_step_ = sizeInc.s32Height;
    x_step_      = pointInc.s32X;
    y_step_      = pointInc.s32Y;
   // g_configure.set_camera_max_aoi(Rect(0, 0, max_width_, max_height_));
}

void ColorCamera::ResetAOI()
{      
    reset_aoi_ = true;
	int nRet = 0;
	
    // Returns the AOI position and size by using an object of the IS_RECT type.
    IS_RECT rectAOI;
	rectAOI.s32X = 0;;
	rectAOI.s32Y = 0;
	rectAOI.s32Width = max_width_;
	rectAOI.s32Height = max_height_;

    pos_x_ = 0;
    pos_y_ = 0;
    size_x_ = max_width_;
    size_y_ = max_height_;
    // Set the position and size of the image by using an object of the IS_RECT type.
    nRet = is_AOI( cam_handle_, IS_AOI_IMAGE_SET_AOI, (void *)&rectAOI, sizeof(rectAOI));
    // Free the allocated buffer.
    if(image_memory_ != NULL)
    {
        nRet = is_FreeImageMem(cam_handle_, image_memory_, memory_id_);
        image_memory_ = NULL;
    }
    
    int bits_per_pixel = 24;  // number of bits needed to store one pixel
    // Memory initialization.
    nRet = is_AllocImageMem( cam_handle_, size_x_, size_y_, bits_per_pixel, &image_memory_, &memory_id_);
    // Set memory active.
    nRet = is_SetImageMem(cam_handle_, image_memory_, memory_id_ );
    reset_aoi_ = false;
}

void ColorCamera::SetExposureTime( double exposure )
{
    is_Exposure(cam_handle_, IS_EXPOSURE_CMD_SET_EXPOSURE, (void*)&exposure, sizeof(exposure));
}

void ColorCamera::SetRedGain( int red_gain )
{
    is_SetHardwareGain(cam_handle_, IS_IGNORE_PARAMETER, red_gain, IS_IGNORE_PARAMETER, IS_IGNORE_PARAMETER);
}

void ColorCamera::SetGreenGain( int green_gain )
{
    is_SetHardwareGain(cam_handle_, IS_IGNORE_PARAMETER, IS_IGNORE_PARAMETER, green_gain, IS_IGNORE_PARAMETER);
}

void ColorCamera::SetBlueGain( int blue_gain )
{
    is_SetHardwareGain(cam_handle_, IS_IGNORE_PARAMETER, IS_IGNORE_PARAMETER, IS_IGNORE_PARAMETER, blue_gain);
}

double ColorCamera::GetExposureTime()
{
    double cur_exposure;
    is_Exposure(cam_handle_, IS_EXPOSURE_CMD_GET_EXPOSURE, (void*)&cur_exposure, sizeof(cur_exposure));
    return cur_exposure;
}
