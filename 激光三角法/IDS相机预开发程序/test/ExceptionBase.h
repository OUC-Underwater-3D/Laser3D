/******************************************************************************
* Copyright 2012 RisingDigital. All rights reserved.
* 
* File   : ExceptionBase.h
* Version: 1.0
* Author : Xiaoying Sha
* Date   : 2012.11.5
* History£º
* 
******************************************************************************/
#ifndef EXCEPTIONBASE_H_
#define EXCEPTIONBASE_H_

#include <exception>
#include <string>

#define THROW_EXCEPTION(ExClass, msg, code)                     \
	do                                                          \
	{                                                           \
	ExClass e(msg, code);                                       \
	e.Init(__FILE__, __FUNCTION__, __LINE__);                   \
	throw e;                                                    \
	}while (false);
 
#define DEFINE_EXCEPTION(ExClass, Base)                         \
	ExClass(const std::string& msg = "", int code = -1) throw() \
	: Base(msg, code) {}                                        \
	                                                            \
~ExClass() throw() {}											\
																\
std::string GetExClassName() const								\
{																\
return #ExClass;												\
}

/*---------------------------------------------------------------------------------------
 Description: Use to throw the identified exception.
 Author		:  Xiaoying.Sha			Date   : 2012.11.5			
 Revision	:
 Example:
	if(ret_ != IS_SUCCESS)
	{
	 THROW_EXCEPTION(VideoIOException, "Camera is not available", ret_);
	}
 
	try {...}
	catch (VideoIOException &e)
	{
		cout << e.what() << endl;
	}
---------------------------------------------------------------------------------------*/
class ExceptionBase : public std::exception
{
public:
	ExceptionBase(const std::string& msg = "", int code = -1) ;	
	virtual ~ExceptionBase();
	/*------------------------------------------ ----------------------------------------
	Description: Init all data.
	Input	   : file -- the file throw exception.
				 func -- the function throw exception.
				 line -- the line throw exception.
	Author		:				Date:
	-----------------------------------------------------------------------------------*/
	inline void Init(std::string file, std::string func, int line)
	{
		file_ = file;
		func_ = func;
		line_ = line;
	}

	inline virtual std::string GetExMessage() const	{ return msg_; }
	inline virtual int GetExErrorCode() const		{ return code_; }
	inline const char* what() const		   { return ToString().c_str(); }

	// Concatenation of string
	const std::string& ToString() const;

protected:
	std::string msg_;			// exception message
	std::string file_;			// exception file
	std::string func_;			// the function throw exception 
	int line_;					// the row number throw exception
	int code_;					// the exception code

private:
	mutable std::string what_;	// the exception message contain all informations
};

class VideoIOException : public ExceptionBase
{
public:
	DEFINE_EXCEPTION(VideoIOException, ExceptionBase);
};

class UeyeException : public VideoIOException
{
public:
	DEFINE_EXCEPTION(UeyeException, VideoIOException);
};

class PreProcessingException : public ExceptionBase
{
public:
	DEFINE_EXCEPTION(PreProcessingException, ExceptionBase);
};

class ForegroundException : public PreProcessingException
{
public:
    DEFINE_EXCEPTION(ForegroundException, PreProcessingException);
};

class VideoAnalysisException : public ExceptionBase
{
public:
	DEFINE_EXCEPTION(VideoAnalysisException, ExceptionBase);
};

class EventRecognitionException : public ExceptionBase
{
public:
	DEFINE_EXCEPTION(EventRecognitionException, ExceptionBase);
};

class PresentationException : public ExceptionBase
{
public:
	DEFINE_EXCEPTION(PresentationException, ExceptionBase);
};

#endif //#ifndef EXCEPTIONBASE_H_