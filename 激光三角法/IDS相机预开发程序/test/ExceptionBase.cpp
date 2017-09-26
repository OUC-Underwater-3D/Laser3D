/******************************************************************************
* Copyright 2012 RisingDigital. All rights reserved.
* 
* File   : ExceptionBase.cpp
* Version: 1.0
* Author : Xiaoying Sha
* Date   : 2012.11.5
* History£º
* 
******************************************************************************/
#include "stdafx.h"
#include <stdlib.h>
#include "opencv2/opencv.hpp"
#include "ExceptionBase.h"

using namespace cv;

//ExceptionBase::ExceptionBase(const String& msg, int code) : msg_(msg), code_(code), file_(""), func_(""), line_(-1)
//{
//}

ExceptionBase::~ExceptionBase() 
{
}

/*------------------------------------------ ----------------------------------
	Description: Concatenation of string.
	Output	   : string -- the exception message contain all informations;
	Author	   :				Date:
-----------------------------------------------------------------------------*/
const std::string& ExceptionBase::ToString() const
{
	if (what_.empty())
	{
		String sstr("");
		if (line_ > 0)
		{
			sstr = cv::format("%s(%s)", file_, line_);
		}
		if (!GetExMessage().empty())
		{
			sstr = cv::format("%s: %s", sstr, GetExMessage());
		}
		if (GetExErrorCode()!= 0) 
		{
			sstr = cv::format("%s with exit code %s.", sstr, GetExErrorCode());
		}
		what_ = sstr;
	}

	return what_;
}
