//===========================================================================//
//                                                                           //
//  Copyright (C) 2004 - 2017                                                //
//  IDS Imaging GmbH                                                         //
//  Dimbacherstr. 6-8                                                        //
//  D-74182 Obersulm-Willsbach                                               //
//                                                                           //
//  The information in this document is subject to change without            //
//  notice and should not be construed as a commitment by IDS Imaging GmbH.  //
//  IDS Imaging GmbH does not assume any responsibility for any errors       //
//  that may appear in this document.                                        //
//                                                                           //
//  This document, or source code, is provided solely as an example          //
//  of how to utilize IDS software libraries in a sample application.        //
//  IDS Imaging GmbH does not assume any responsibility for the use or       //
//  reliability of any portion of this document or the described software.   //
//                                                                           //
//  General permission to copy or modify, but not for profit, is hereby      //
//  granted,  provided that the above copyright notice is included and       //
//  reference made to the fact that reproduction privileges were granted	 //
//	by IDS Imaging GmbH.				                                     //
//                                                                           //
//  IDS cannot assume any responsibility for the use or misuse of any        //
//  portion of this software for other than its intended diagnostic purpose	 //
//  in calibrating and testing IDS manufactured cameras and software.		 //
//                                                                           //
//===========================================================================//

#if !defined(AFX_UEYESIMPLETRIGGERDLG_H__00EFA87C_7A28_4501_8760_D28D4F306A00__INCLUDED_)
#define AFX_UEYESIMPLETRIGGERDLG_H__00EFA87C_7A28_4501_8760_D28D4F306A00__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "uEye.h"
#include "afxwin.h"
#include "opencv2/opencv.hpp"
/*zyl*/
#include "afxcmn.h"
#include "afxext.h"
#include "Mstcpip.h"
#define WM_RECVDATA WM_USER+1
#define MAXSIZE 1024
/*zyl*/


using namespace cv;
using namespace std;




/////////////////////////////////////////////////////////////////////////////
class CuEyeSimpleTriggerDlg : public CDialog
{
 private:
	virtual void DoDataExchange(CDataExchange* pDX);
	HICON	m_hIcon;
	// uEye variables
	HIDS	    m_hCam;				// handle to camera
	HWND	    m_hWndDisplay;		// handle to diplay window
	INT		    m_nColorMode;		// Y8/RGB16/RGB24/REG32
	INT		    m_nBitsPerPixel;	// number of bits needed store one pixel 
	INT		    m_nSizeX;			// width of image
	INT		    m_nSizeY;			// height of image
	INT		    m_nPosX;			// left offset of image
	INT		    m_nPosY;			// right offset of image
    INT         m_nTriggerMode;     // trigger mode
    INT         m_nFrameEvents;     // counter for the frame events
    INT         m_nTriggerEvents;   // counter for the trigger events
    BOOL        m_bLive;            	
	// Memory needed for live display while using DIB
	INT		    m_lMemoryId;		// camera memory - buffer ID 
	char*	    m_pcImageMemory;	// camera memory - pointer to buffer 
	SENSORINFO  m_sInfo;			// sensor information struct
    INT         m_nRenderMode;		// render  mode
    INT         m_nFlipHor;			// horizontal flip flag
    INT         m_nFlipVert;		// vertical flip flag
	int    ret_;                        // return value of uEye SDK functions

	/*
	设置文件路径测试
	*/
	string img_name_temp;


	POINT	Old;
	void resize();
	void GetFrame(Mat &color_frame);
	void setPath();
    INT InitCamera (HIDS *hCam, HWND hWnd);
	bool OpenCamera();
    void ExitCamera();
    int  InitDisplayMode();
    void LoadParameters();
    void GetMaxImageSize(INT *pnSizeX, INT *pnSizeY);
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonStart();
	afx_msg void OnButtonStop();
	afx_msg void OnBnClickedButtonLoadParameter();
	afx_msg void OnButtonExit();
	LRESULT OnUEyeMessage(WPARAM wParam, LPARAM lParam);
	DECLARE_MESSAGE_MAP()
	/*zyl*/
	DWORD m_numberIP;
	bool m_ConnectSign;
	/*zyl*/
 public:
    CuEyeSimpleTriggerDlg(CWnd* pParent = NULL);
	enum { IDD = IDD_UEYESIMPLETRIGGER_DIALOG };
    afx_msg void OnClose();
    afx_msg void OnBnClickedRadioTrigger();
    afx_msg void OnBnClickedButtonResetCounters();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnBnClickedButton1();
	/*zyl*/
	int m_Radio;
	SOCKET m_serverSocket;
	SOCKET m_clientSocket;
	afx_msg void OnBnClickedButtonConnect();
	afx_msg void OnBnClickedButtonSend();
	afx_msg void OnBnClickedButtonEmptyrecv();
	afx_msg void OnBnClickedButtonEmptysend();
	afx_msg LRESULT OnRecvData(WPARAM wParam, LPARAM lParam);
	static DWORD WINAPI ServerRecvProc(LPVOID lpParam);
	static DWORD WINAPI MonitorThread(LPVOID lpParam);
	CEdit m_EditClient;
	CEdit m_EditServer;
	CIPAddressCtrl m_IPAddress;
	int ShowIpAddress(void);
	CButton m_connect;
	int serverSign;
	int Init(void);
	CEdit m_EditSend;
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//afx_msg void OnIpnFieldchangedIpaddress(NMHDR *pNMHDR, LRESULT *pResult);
	/*zyl*/
	afx_msg void OnStnClickedStaticTriggerEvents3();
	afx_msg void OnStnClickedStaticTriggerEvents();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedButtonSingleshot();
	afx_msg void OnBnClickedButton4();
};
/*zyl*/
struct RECVPARAM
{
	HWND hwnd;
	CuEyeSimpleTriggerDlg *pDlg;
};
/*zyl*/
#endif // !defined(AFX_UEYESIMPLETRIGGERDLG_H__00EFA87C_7A28_4501_8760_D28D4F306A00__INCLUDED_)



