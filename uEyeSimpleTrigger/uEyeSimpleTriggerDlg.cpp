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
//                                                                           //f
//  This document, or source code, is provided solely as an example          //
//  of how to utilize IDS software libraries in a sample application.        //
//  IDS Imaging GmbH does not assume any responsibility for the use or       //
//  reliability of any portion of this document or the described software.   //
//                                                                           //
//  General permission to copy or modify, but not for profit, is hereby      //
//  granted,  provided that the above copyright notice is included and       //
//  reference made to the fact that reproduction privileges were granted     //
//  by IDS Imaging GmbH.                                                     //
//                                                                           //
//  IDS cannot assume any responsibility for the use or misuse of any        //
//  portion of this software for other than its intended diagnostic purpose  //
//  in calibrating and testing IDS manufactured cameras and software.        //
//                                                                           //
//===========================================================================//

#include "StdAfx.h"
#include "uEyeSimpleTrigger.h"
#include "uEyeSimpleTriggerDlg.h"
#include ".\ueyesimpletriggerdlg.h"
#include "opencv2/opencv.hpp"
#include "version.h"
#include "uEye.h"



/*zyl*/
#include "afxdialogex.h"
/*yzl*/
using namespace cv;
using namespace std;


extern CuEyeSimpleTriggerApp theApp;

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif


class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	enum { IDD = IDD_ABOUTBOX };

private:

	virtual BOOL OnInitDialog();

	virtual void DoDataExchange(CDataExchange* pDX);

	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}


BOOL CAboutDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	CString Str;
	GetDlgItem(IDC_STATIC_COPYRIGHT)->GetWindowText(Str);
	Str.Append(_T(CURRENT_YEAR));
	GetDlgItem(IDC_STATIC_COPYRIGHT)->SetWindowText(Str);




	return TRUE;
}


void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
CuEyeSimpleTriggerDlg::CuEyeSimpleTriggerDlg(CWnd* pParent /*=NULL*/)
: CDialog(CuEyeSimpleTriggerDlg::IDD, pParent)
/*zyl*/
, m_Radio(0)
, m_numberIP(0)
, m_ConnectSign(false)
/*zyl*/
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}


void CuEyeSimpleTriggerDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Radio(pDX, IDC_RADIO_OFF, m_nTriggerMode);
	DDX_Text(pDX, IDC_EDIT_FRAME_EVENTS, m_nFrameEvents);
	DDX_Text(pDX, IDC_EDIT_TRIGGER_EVENTS, m_nTriggerEvents);
	/*zyl*/
	DDX_Control(pDX, IDC_EDIT_SERVERPORT, m_EditServer);
	DDX_Control(pDX, IDC_IPADDRESS, m_IPAddress);
	DDX_Control(pDX, IDC_BUTTON_CONNECT, m_connect);
	DDX_Control(pDX, IDC_EDIT_SEND, m_EditSend);
	/*zyl*/
}


BEGIN_MESSAGE_MAP(CuEyeSimpleTriggerDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
	ON_BN_CLICKED(IDC_BUTTON_STOP, OnButtonStop)
	ON_BN_CLICKED(IDC_BUTTON_EXIT, OnButtonExit)
	ON_MESSAGE(IS_UEYE_MESSAGE, OnUEyeMessage)
	ON_BN_CLICKED(IDC_BUTTON_LOAD_PARAMETER, OnBnClickedButtonLoadParameter)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_RADIO_OFF, OnBnClickedRadioTrigger)
	ON_BN_CLICKED(IDC_RADIO_SOFTWARE, OnBnClickedRadioTrigger)
	ON_BN_CLICKED(IDC_RADIO_LO_HI, OnBnClickedRadioTrigger)
	ON_BN_CLICKED(IDC_RADIO_HI_LO, OnBnClickedRadioTrigger)
	ON_BN_CLICKED(IDC_BUTTON_RESET_COUNTERS, OnBnClickedButtonResetCounters)
	ON_WM_SIZE()
	/*zyl*/
	ON_MESSAGE(WM_RECVDATA, OnRecvData)
	ON_BN_CLICKED(IDC_BUTTON_CONNECT, &CuEyeSimpleTriggerDlg::OnBnClickedButtonConnect)
	ON_BN_CLICKED(IDC_BUTTON_SEND, &CuEyeSimpleTriggerDlg::OnBnClickedButtonSend)
	ON_BN_CLICKED(IDC_BUTTON_EMPTYRECV, &CuEyeSimpleTriggerDlg::OnBnClickedButtonEmptyrecv)
	ON_BN_CLICKED(IDC_BUTTON_EMPTYSEND, &CuEyeSimpleTriggerDlg::OnBnClickedButtonEmptysend)
	ON_WM_CTLCOLOR()
	/*zyl*/
	ON_BN_CLICKED(IDC_BUTTON_SingleShot, &CuEyeSimpleTriggerDlg::OnBnClickedButtonSingleshot)
	ON_BN_CLICKED(IDC_BUTTON4, &CuEyeSimpleTriggerDlg::OnBnClickedButton4)
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
BOOL CuEyeSimpleTriggerDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Will only be enabled if in stop mode
	GetDlgItem(IDC_BUTTON_LOAD_PARAMETER)->EnableWindow(FALSE);
	// Set the icon for this dialog.  The framework does this automatically
	// when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE); // Set big icon
	SetIcon(m_hIcon, FALSE); // Set small icon

	// Get handle to display window
	m_hWndDisplay = GetDlgItem(IDC_DISPLAY)->m_hWnd;

	m_pcImageMemory = NULL;
	m_lMemoryId = 0;
	m_hCam = 0;
	m_nRenderMode = IS_RENDER_FIT_TO_WINDOW;
	m_nPosX = 0;
	m_nPosY = 0;
	m_nFlipHor = 0;
	m_nFlipVert = 0;

	m_nTriggerMode = 0;
	m_nFrameEvents = 0;
	m_nTriggerEvents = 0;

	UpdateData(FALSE);

	// Open a camera
	OpenCamera();
	/*zyl*/
	Init();
	m_Radio = 2;
	SetDlgItemText(IDC_BUTTON_CONNECT, "开始监听");
	SetDlgItemText(IDC_STATIC1, "本机地址");
	m_EditClient.SetReadOnly(TRUE);
	m_EditServer.SetReadOnly(FALSE);
	m_IPAddress.SetAddress(m_numberIP);
	m_IPAddress.EnableWindow(FALSE);
	/*zyl*/

	// Deactivate button "Start"
	GetDlgItem(IDC_BUTTON_START)->EnableWindow(FALSE);

	GetDlgItem(IDC_RADIO_SOFTWARE)->EnableWindow(FALSE);
	GetDlgItem(IDC_RADIO_HI_LO)->EnableWindow(FALSE);
	GetDlgItem(IDC_RADIO_LO_HI)->EnableWindow(FALSE);

	// Check if trigger mode is supported
	INT nSupportedTriggerModes = is_SetExternalTrigger(m_hCam, IS_GET_SUPPORTED_TRIGGER_MODE);

	if ((nSupportedTriggerModes & IS_SET_TRIGGER_SOFTWARE) == IS_SET_TRIGGER_SOFTWARE)
	{
		GetDlgItem(IDC_RADIO_SOFTWARE)->EnableWindow(TRUE);
	}

	if ((nSupportedTriggerModes & IS_SET_TRIGGER_HI_LO) == IS_SET_TRIGGER_HI_LO)
	{
		GetDlgItem(IDC_RADIO_HI_LO)->EnableWindow(TRUE);
	}

	if ((nSupportedTriggerModes & IS_SET_TRIGGER_LO_HI) == IS_SET_TRIGGER_LO_HI)
	{
		GetDlgItem(IDC_RADIO_LO_HI)->EnableWindow(TRUE);
	}
	CRect rect;
	GetClientRect(&rect);     //取客户区大小  
	Old.x = rect.right - rect.left;
	Old.y = rect.bottom - rect.top;
	return true;
}

/*zyl*/
void CuEyeSimpleTriggerDlg::OnBnClickedButtonConnect()
{
	// TODO: 在此添加控件通知处理程序代码
	if (m_Radio == 2)
	{
		serverSign++;
		if (serverSign)
		{
			m_serverSocket = socket(AF_INET, SOCK_STREAM, 0);
			if (m_serverSocket == INVALID_SOCKET)
			{
				MessageBox("服务器: 创建套接字失败", "提示");
				return;
			}

			CString strPort;
			GetDlgItemText(IDC_EDIT_SERVERPORT, strPort);
			if (strPort.IsEmpty())
			{
				MessageBox("请设置本地端口");
				return;
			}

			u_short port = atoi(strPort);
			SOCKADDR_IN addrServer;
			addrServer.sin_family = AF_INET;
			addrServer.sin_addr.S_un.S_addr = htonl(m_numberIP);
			addrServer.sin_port = htons(port);
			int addrBind;
			addrBind = bind(m_serverSocket, (SOCKADDR *)&addrServer, sizeof(addrServer));
			if (addrBind == SOCKET_ERROR)
			{
				MessageBox("绑定地址失败", "提示");
				return;
			}
			int clientListen;
			clientListen = listen(m_serverSocket, 5);
			if (clientListen == SOCKET_ERROR)
			{
				MessageBox("监听失败", "提示");
				return;
			}
			RECVPARAM *pRecvParam = new RECVPARAM;
			pRecvParam->hwnd = m_hWnd;
			pRecvParam->pDlg = (CuEyeSimpleTriggerDlg *)AfxGetMainWnd();
			HANDLE hThread = CreateThread(NULL, 0, ServerRecvProc, (LPVOID)pRecvParam, 0, NULL);
			CloseHandle(hThread);
			SetDlgItemText(IDC_BUTTON_CONNECT, "停止监听");
			SetDlgItemText(IDC_STATIC_CONNECT, "正在监听");
			serverSign = -1;
			return;
		}
		else
		{
			closesocket(m_serverSocket);
			closesocket(m_clientSocket);
			SetDlgItemText(IDC_BUTTON_CONNECT, "开始监听");
			SetDlgItemText(IDC_STATIC_CONNECT, "未连接");
		}
	}
	else
	{
		MessageBox("请选择当前主机的通信对象", "提示");
		return;
	}
}

LRESULT CuEyeSimpleTriggerDlg::OnRecvData(WPARAM wParam, LPARAM lParam)
{
	CString str = (char *)lParam;
	CString strTemp;
	GetDlgItemText(IDC_EDIT_RECV, strTemp);
	//str = strTemp + str;
	str += "\r\n";//增加一个换行
	str += strTemp;
	SetDlgItemText(IDC_EDIT_RECV, str);
	return 0;
}

void CuEyeSimpleTriggerDlg::OnBnClickedButtonSend()
{
	// TODO: 在此添加控件通知处理程序代码
	CString strSend;
	GetDlgItemText(IDC_EDIT_SEND, strSend);
	if (strSend == "")
	{
		MessageBox("没有输入数据，请重新输入", "提示");
		return;
	}
	//按字符发出的时候
	if (m_Radio == 2)
	{
		send(m_clientSocket, strSend.GetBuffer(0), strSend.GetLength(), 0);
	}
	return;
}

DWORD WINAPI CuEyeSimpleTriggerDlg::ServerRecvProc(LPVOID lpParam)
{
	HWND hwnd = ((RECVPARAM *)lpParam)->hwnd;
	CuEyeSimpleTriggerDlg *pDlg = ((RECVPARAM *)lpParam)->pDlg;
	SOCKADDR_IN addrClient;
	int len = sizeof(SOCKADDR);
	pDlg->m_clientSocket = accept(pDlg->m_serverSocket, (SOCKADDR *)&addrClient, &len);
	if (pDlg->m_clientSocket != INVALID_SOCKET)
	{
		CString ipConnect;
		ipConnect.Format("连接到 IP: %s  Port: %d", inet_ntoa(addrClient.sin_addr), ntohs(addrClient.sin_port));
		pDlg->SetDlgItemText(IDC_STATIC_CONNECT, ipConnect);
		HANDLE handle = CreateThread(NULL, 0, MonitorThread, (LPVOID)lpParam, 0, NULL);
		CloseHandle(handle);
	}
	else
	{
		return 0;
	}
	//初始化数组
	u_char recvBuf[MAXSIZE] = { 0 };
	CString displayBuf;
	int recvLength;
	while (TRUE)
	{
		recvLength = recv(pDlg->m_clientSocket, (char *)recvBuf, MAXSIZE, 0);
		if (recvLength == SOCKET_ERROR)
			break;
		recvBuf[recvLength] = '\0';
		displayBuf.Format("%s", recvBuf);
		::PostMessage(hwnd, WM_RECVDATA, 0, (LPARAM)displayBuf.GetBuffer(0));
	}
	return 0;
}

DWORD WINAPI CuEyeSimpleTriggerDlg::MonitorThread(LPVOID lpParam)
{
	CuEyeSimpleTriggerDlg *pDlg = ((RECVPARAM *)lpParam)->pDlg;
	HWND hwnd = ((RECVPARAM *)lpParam)->hwnd;

	while (1)
	{
		char szRecvBuf[10] = { 0 };
		if (pDlg->m_Radio != 3)
		{
			// 注意,最后一个参数必须是MSG_PEEK,否则会影响主线程接收信息
			int nRet = recv(pDlg->m_clientSocket, szRecvBuf, 1, MSG_PEEK);
			// 实际上,等于0表示服务端主动关闭通信socket
			if (nRet <= 0)
			{
				pDlg->SetDlgItemText(IDC_STATIC_CONNECT, "未连接");
				if (nRet == 0)
				{
					pDlg->OnBnClickedButtonConnect();
					pDlg->MessageBox("连接已断开", "提示");
				}
				break;
			}
		}
		Sleep(200);
	}
	//在断开后调用delete释放用new开辟出来的结构体资源
	closesocket(pDlg->m_serverSocket);
	closesocket(pDlg->m_clientSocket);
	delete lpParam;
	lpParam = NULL;
	return 0;
}

void CuEyeSimpleTriggerDlg::OnBnClickedButtonEmptyrecv()
{
	// TODO: 在此添加控件通知处理程序代码
	SetDlgItemText(IDC_EDIT_RECV, "");
}

void CuEyeSimpleTriggerDlg::OnBnClickedButtonEmptysend()
{
	// TODO: 在此添加控件通知处理程序代码
	SetDlgItemText(IDC_EDIT_SEND, "");
}

int CuEyeSimpleTriggerDlg::ShowIpAddress(void)
{
	/*  #define MAX_PATH 260   */
	char hostname[MAX_PATH] = { 0 };
	gethostname(hostname, MAX_PATH);
	hostent* ptent = gethostbyname(hostname);
	if (ptent != NULL)
	{
		char *ip = inet_ntoa(*(in_addr *)ptent->h_addr_list[0]);
		m_numberIP = ntohl(inet_addr(ip));
	}
	return 0;
}
int CuEyeSimpleTriggerDlg::Init(void)
{
	ShowIpAddress();
	m_ConnectSign = TRUE;
	serverSign = 0;
	CuEyeSimpleTriggerDlg *pDlg = (CuEyeSimpleTriggerDlg *)AfxGetMainWnd();
	return 0;
}

/*zyl*/

void CuEyeSimpleTriggerDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}


void CuEyeSimpleTriggerDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM)dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}


// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CuEyeSimpleTriggerDlg::OnQueryDragIcon()
{
	return (HCURSOR)m_hIcon;
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnButtonStart()
//
// DESCRIPTION: start capture and return immediately
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnButtonStart()
{
	if (m_hCam == 0)
	{
		OpenCamera();
	}

	if (m_hCam != 0)
	{
		// Capture video (live or trigger)
		is_CaptureVideo(m_hCam, IS_DONT_WAIT);

		// Disable button 'Load Parameters'
		GetDlgItem(IDC_BUTTON_LOAD_PARAMETER)->EnableWindow(FALSE);

		m_bLive = TRUE;

		// Deactivate button "Start"
		GetDlgItem(IDC_BUTTON_START)->EnableWindow(FALSE);

		// Activate button "Stop"
		GetDlgItem(IDC_BUTTON_STOP)->EnableWindow(TRUE);
	}
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnButtonStop()
//
// DESCRIPTION: stop capture and return immediately
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnButtonStop()
{
	// Stop immediately - force stop
	if (m_hCam != 0)
	{
		is_StopLiveVideo(m_hCam, IS_FORCE_VIDEO_STOP);

		m_bLive = FALSE;

		// Activate button "Start"
		GetDlgItem(IDC_BUTTON_START)->EnableWindow(TRUE);

		// Deactivate button "Stop"
		GetDlgItem(IDC_BUTTON_STOP)->EnableWindow(FALSE);
	}

	// Enable button 'Load Parameters'
	GetDlgItem(IDC_BUTTON_LOAD_PARAMETER)->EnableWindow(TRUE);
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnBnClickedButtonResetCounters()
//
// DESCRIPTION: reset the frame and trigger counters
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnBnClickedButtonResetCounters()
{
	// Reset the counters
	m_nFrameEvents = 0;
	m_nTriggerEvents = 0;
	UpdateData(FALSE);
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnBnClickedButtonLoadParameter()
//
// DESCRIPTION: - loads parameters from an ini file
//              - reallocates the memory
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnBnClickedButtonLoadParameter()
{

	if (m_hCam == 0)
		OpenCamera();

	if (m_hCam != 0)
	{
		if (is_ParameterSet(m_hCam, IS_PARAMETERSET_CMD_LOAD_FILE, NULL, NULL) == IS_SUCCESS && m_pcImageMemory != NULL)
		{
			// determine live capture
			BOOL bWasLive = (BOOL)(is_CaptureVideo(m_hCam, IS_GET_LIVE));
			if (bWasLive)
				is_StopLiveVideo(m_hCam, IS_FORCE_VIDEO_STOP);

			// realloc image mem with actual sizes and depth.
			is_FreeImageMem(m_hCam, m_pcImageMemory, m_lMemoryId);

			IS_SIZE_2D imageSize;
			is_AOI(m_hCam, IS_AOI_IMAGE_GET_SIZE, (void*)&imageSize, sizeof(imageSize));

			INT nAllocSizeX = 0;
			INT nAllocSizeY = 0;

			m_nSizeX = nAllocSizeX = imageSize.s32Width;
			m_nSizeY = nAllocSizeY = imageSize.s32Height;

			UINT nAbsPosX = 0;
			UINT nAbsPosY = 0;

			// absolute pos?
			is_AOI(m_hCam, IS_AOI_IMAGE_GET_POS_X_ABS, (void*)&nAbsPosX, sizeof(nAbsPosX));
			is_AOI(m_hCam, IS_AOI_IMAGE_GET_POS_Y_ABS, (void*)&nAbsPosY, sizeof(nAbsPosY));

			if (nAbsPosX)
			{
				nAllocSizeX = m_sInfo.nMaxWidth;
			}
			if (nAbsPosY)
			{
				nAllocSizeY = m_sInfo.nMaxHeight;
			}

			switch (is_SetColorMode(m_hCam, IS_GET_COLOR_MODE))
			{
			case IS_CM_RGBA12_UNPACKED:
			case IS_CM_BGRA12_UNPACKED:
				m_nBitsPerPixel = 64;
				break;
			case IS_CM_RGB12_UNPACKED:
			case IS_CM_BGR12_UNPACKED:
			case IS_CM_RGB10_UNPACKED:
			case IS_CM_BGR10_UNPACKED:
				m_nBitsPerPixel = 48;
				break;
			case IS_CM_RGBA8_PACKED:
			case IS_CM_BGRA8_PACKED:
			case IS_CM_RGB10_PACKED:
			case IS_CM_BGR10_PACKED:
			case IS_CM_RGBY8_PACKED:
			case IS_CM_BGRY8_PACKED:
				m_nBitsPerPixel = 32;
				break;
			case IS_CM_RGB8_PACKED:
			case IS_CM_BGR8_PACKED:
				m_nBitsPerPixel = 24;
				break;

			case IS_CM_BGR565_PACKED:
			case IS_CM_UYVY_PACKED:
			case IS_CM_CBYCRY_PACKED:
				m_nBitsPerPixel = 16;
				break;

			case IS_CM_BGR5_PACKED:
				m_nBitsPerPixel = 15;
				break;

			case IS_CM_MONO16:
			case IS_CM_SENSOR_RAW16:
			case IS_CM_MONO12:
			case IS_CM_SENSOR_RAW12:
			case IS_CM_MONO10:
			case IS_CM_SENSOR_RAW10:
				m_nBitsPerPixel = 16;
				break;

			case IS_CM_RGB8_PLANAR:
				m_nBitsPerPixel = 24;
				break;

			case IS_CM_MONO8:
			case IS_CM_SENSOR_RAW8:
			default:
				m_nBitsPerPixel = 8;
				break;
			}

			// memory initialization
			is_AllocImageMem(m_hCam, nAllocSizeX, nAllocSizeY, m_nBitsPerPixel, &m_pcImageMemory, &m_lMemoryId);

			// set memory active
			is_SetImageMem(m_hCam, m_pcImageMemory, m_lMemoryId);

			// display initialization
			imageSize.s32Width = m_nSizeX;
			imageSize.s32Height = m_nSizeY;

			// Set the AOI with the correct size
			is_AOI(m_hCam, IS_AOI_IMAGE_SET_SIZE, (void*)&imageSize, sizeof(imageSize));

			// run live image again
			if (bWasLive)
				is_CaptureVideo(m_hCam, IS_DONT_WAIT);
		}
	}
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnButtonExit()
//
// DESCRIPTION: - stop capture
//              - free used image memory
//              - exit the camera
//              - quit application
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnButtonExit()
{
	ExitCamera();
	PostQuitMessage(0);
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OpenCamera()
//
// DESCRIPTION: - Opens a handle to a connected camera
//
///////////////////////////////////////////////////////////////////////////////
bool CuEyeSimpleTriggerDlg::OpenCamera()
{
	INT nRet = IS_NO_SUCCESS;
	ExitCamera();

	// Init camera (open next available camera)
	m_hCam = (HIDS)0;
	nRet = InitCamera(&m_hCam, m_hWndDisplay);
	if (nRet == IS_SUCCESS)
	{
		// Retrieve original image size 
		is_GetSensorInfo(m_hCam, &m_sInfo);
		GetMaxImageSize(&m_nSizeX, &m_nSizeY);
		UpdateData(TRUE);
		nRet = InitDisplayMode();

		if (nRet == IS_SUCCESS)
		{
			// Enable Messages
			is_EnableMessage(m_hCam, IS_DEVICE_REMOVED, GetSafeHwnd());
			is_EnableMessage(m_hCam, IS_DEVICE_RECONNECTED, GetSafeHwnd());
			is_EnableMessage(m_hCam, IS_FRAME, GetSafeHwnd());
			is_EnableMessage(m_hCam, IS_TRIGGER, GetSafeHwnd());
			// Start capture
			if (is_CaptureVideo(m_hCam, IS_WAIT) == IS_SUCCESS)
			{
				m_bLive = TRUE;
			}
		}
		else
		{
			AfxMessageBox(TEXT("初始化显示模式失败"), MB_ICONWARNING);
		}

		return true;
	}
	else
	{
		AfxMessageBox(TEXT("相机未连接"), MB_ICONWARNING);
		return false;
	}
}


///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnUEyeMessage()
//
// DESCRIPTION: - handles the messages from the uEye camera
//              - messages must be enabled using is_EnableMessage()
//
///////////////////////////////////////////////////////////////////////////////
LRESULT CuEyeSimpleTriggerDlg::OnUEyeMessage(WPARAM wParam, LPARAM lParam)
{
	UpdateData(FALSE);

	switch (wParam)
	{
	case IS_DEVICE_REMOVED:
		Beep(400, 50);
		break;

	case IS_DEVICE_RECONNECTED:
		Beep(400, 50);
		break;

	case IS_FRAME:
		if (m_pcImageMemory != NULL)
		{
			m_nFrameEvents++;
			is_RenderBitmap(m_hCam, m_lMemoryId, m_hWndDisplay, m_nRenderMode);
		}
		break;

	case IS_TRIGGER:
		if (m_pcImageMemory != NULL)
		{
	/*		static int  i = 1;
			string img_name;
			char str[10];
			int line_step = 0;
			is_GetImageMemPitch(m_hCam, &line_step);
			Mat frame(m_nSizeY, m_nSizeX, CV_8UC3, m_pcImageMemory, line_step);
			sprintf(str, "%d.bmp", i++);
			img_name = img_name_temp + str ;
			imwrite(img_name, frame);
			/*待修改*/
			/*copyto函数*/
		/*	frame.release();
			m_nTriggerEvents++;*/

    
			static int  i = 1;
			string img_name;
			char str[10];
			Mat frame;

			GetFrame(frame);
			//resize(frame1, frame1, Size(640, 480));
			sprintf(str, "%d.bmp", i++);
			img_name = img_name_temp + str;
			imwrite(img_name, frame);
			m_nTriggerEvents++;




		}
		break;
	}
	return 0;
}




///////////////////////////////////////////////////////////////////////////////
//
// METHOD ExitCamera()
//
// DESCRIPTION: - exits the instance of the camera
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::ExitCamera()
{
	if (m_hCam != 0)
	{
		// Disable messages
		is_EnableMessage(m_hCam, IS_DEVICE_REMOVED, NULL);
		is_EnableMessage(m_hCam, IS_DEVICE_RECONNECTED, NULL);
		is_EnableMessage(m_hCam, IS_FRAME, NULL);
		is_EnableMessage(m_hCam, IS_TRIGGER, NULL);
		// Stop live video
		is_StopLiveVideo(m_hCam, IS_WAIT);
		// Free the allocated buffer
		if (m_pcImageMemory != NULL)
		{
			is_FreeImageMem(m_hCam, m_pcImageMemory, m_lMemoryId);
		}
		m_pcImageMemory = NULL;
		// Close camera
		is_ExitCamera(m_hCam);
		m_hCam = NULL;
	}
}

///////////////////////////////////////////////////////////////////////////////
//
// METHOD InitDisplayMode()
//
// DESCRIPTION: - initializes the display mode
//
///////////////////////////////////////////////////////////////////////////////
int CuEyeSimpleTriggerDlg::InitDisplayMode()
{
	INT nRet = IS_NO_SUCCESS;
	if (m_hCam == NULL)
	{
		return IS_NO_SUCCESS;
	}
	if (m_pcImageMemory != NULL)
	{
		is_FreeImageMem(m_hCam, m_pcImageMemory, m_lMemoryId);
	}
	m_pcImageMemory = NULL;
	// Set display mode to DIB
	nRet = is_SetDisplayMode(m_hCam, IS_SET_DM_DIB);
	if (m_sInfo.nColorMode == IS_COLORMODE_BAYER)
	{
		// Setup the color depth to the current windows setting 
		is_GetColorDepth(m_hCam, &m_nBitsPerPixel, &m_nColorMode);
	}
	else if (m_sInfo.nColorMode == IS_COLORMODE_CBYCRY)
	{
		// For CBYCRY camera models use RGB32 mode
		m_nColorMode = IS_CM_BGRA8_PACKED;
		m_nBitsPerPixel = 32;
	}
	else
	{
		// For monochrome camera models use Y8 mode
		m_nColorMode = IS_CM_MONO8;
		m_nBitsPerPixel = 8;
	}

	// Allocate an image memory.
	if (is_AllocImageMem(m_hCam, m_nSizeX, m_nSizeY, m_nBitsPerPixel, &m_pcImageMemory, &m_lMemoryId) != IS_SUCCESS)
	{
		AfxMessageBox(TEXT("内存分配失败"), MB_ICONWARNING);
	}
	else
	{
		is_SetImageMem(m_hCam, m_pcImageMemory, m_lMemoryId);
	}
	if (nRet == IS_SUCCESS)
	{
		// Set the desired color mode
		is_SetColorMode(m_hCam, m_nColorMode);
		// Set the image size to capture
		IS_SIZE_2D imageSize;
		imageSize.s32Width = m_nSizeX;
		imageSize.s32Height = m_nSizeY;
		is_AOI(m_hCam, IS_AOI_IMAGE_SET_SIZE, (void*)&imageSize, sizeof(imageSize));
	}
	return nRet;
}


void CuEyeSimpleTriggerDlg::OnClose()
{
	ExitCamera();
	CDialog::OnClose();
}


void CuEyeSimpleTriggerDlg::GetFrame(Mat &color_frame)
{

	if (!color_frame.empty())
	{
		color_frame.release();
	}
	int line_step = 0;
	is_GetImageMemPitch(m_hCam, &line_step);
	// they just initialize the matrix header that points to the specified data, which means that no data is copied.
	// This operation is very efficient and can be used to process external data using OpenCV functions.
	// The external data is not automatically deallocated, so you should take care of it.
	Mat img(m_nSizeY, m_nSizeX, CV_8UC3, m_pcImageMemory, line_step);
	if (m_pcImageMemory)
	{
		color_frame = img.clone();
	}

}





void CuEyeSimpleTriggerDlg::resize()
{
	float fsp[2];
	POINT Newp; //获取现在对话框的大小
	CRect recta;
	GetClientRect(&recta);     //取客户区大小  
	Newp.x = recta.right - recta.left;
	Newp.y = recta.bottom - recta.top;
	fsp[0] = (float)Newp.x / Old.x;
	fsp[1] = (float)Newp.y / Old.y;
	CRect Rect;
	int woc;
	CPoint OldTLPoint, TLPoint; //左上角
	CPoint OldBRPoint, BRPoint; //右下角
	HWND  hwndChild = ::GetWindow(m_hWnd, GW_CHILD);  //列出所有控件  
	while (hwndChild)
	{
		woc = ::GetDlgCtrlID(hwndChild);//取得ID
		GetDlgItem(woc)->GetWindowRect(Rect);
		ScreenToClient(Rect);
		OldTLPoint = Rect.TopLeft();
		TLPoint.x = long(OldTLPoint.x*fsp[0]);
		TLPoint.y = long(OldTLPoint.y*fsp[1]);
		OldBRPoint = Rect.BottomRight();
		BRPoint.x = long(OldBRPoint.x *fsp[0]);
		BRPoint.y = long(OldBRPoint.y *fsp[1]);
		Rect.SetRect(TLPoint, BRPoint);
		GetDlgItem(woc)->MoveWindow(Rect, TRUE);
		hwndChild = ::GetWindow(hwndChild, GW_HWNDNEXT);
	}
	Old = Newp;

}

///////////////////////////////////////////////////////////////////////////////
//
// METHOD OnBnClickedRadioTrigger()
//
// DESCRIPTION: - deactivates or changes the trigger mode
//
///////////////////////////////////////////////////////////////////////////////
void CuEyeSimpleTriggerDlg::OnBnClickedRadioTrigger()
{
	if (!UpdateData(TRUE))
	{
		return;
	}
	if (m_bLive == TRUE)
	{
		is_StopLiveVideo(m_hCam, IS_WAIT);
	}
	// Trigger off
	if (m_nTriggerMode == 0)
	{
		is_SetExternalTrigger(m_hCam, IS_SET_TRIGGER_OFF);
	}
	// Software trigger
	if (m_nTriggerMode == 1)
	{
		is_SetExternalTrigger(m_hCam, IS_SET_TRIGGER_SOFTWARE);
	}
	// Hardware trigger falling edge
	else if (m_nTriggerMode == 2)
	{
		is_SetExternalTrigger(m_hCam, IS_SET_TRIGGER_HI_LO);
	}
	// Hardware trigger rising edge
	else if (m_nTriggerMode == 3)
	{
		is_SetExternalTrigger(m_hCam, IS_SET_TRIGGER_LO_HI);
	}
	if (m_bLive == TRUE)
	{
		is_CaptureVideo(m_hCam, IS_DONT_WAIT);
	}
}
INT CuEyeSimpleTriggerDlg::InitCamera(HIDS *hCam, HWND hWnd)
{
	INT nRet = is_InitCamera(hCam, hWnd);
	/************************************************************************************************/
	/*                                                                                              */
	/*  If the camera returns with "IS_STARTER_FW_UPLOAD_NEEDED", an upload of a new firmware       */
	/*  is necessary. This upload can take several seconds. We recommend to check the required      */
	/*  time with the function is_GetDuration().                                                    */
	/*                                                                                              */
	/*  In this case, the camera can only be opened if the flag "IS_ALLOW_STARTER_FW_UPLOAD"        */
	/*  is "OR"-ed to m_hCam. This flag allows an automatic upload of the firmware.                 */
	/*                                                                                              */
	/************************************************************************************************/
	if (nRet == IS_STARTER_FW_UPLOAD_NEEDED)
	{
		// Time for the firmware upload = 25 seconds by default
		INT nUploadTime = 25000;
		is_GetDuration(*hCam, IS_STARTER_FW_UPLOAD, &nUploadTime);
		CString Str1, Str2, Str3;
		Str1 = "This camera requires a new firmware. The upload will take about";
		Str2 = "seconds. Please wait ...";
		//我只注释了这一句代码  // Str3.Format (L"%s %d %s", Str1, nUploadTime / 1000, Str2);
		AfxMessageBox(Str3, MB_ICONWARNING);
		// Set mouse to hourglass
		SetCursor(AfxGetApp()->LoadStandardCursor(IDC_WAIT));
		// Try again to open the camera. This time we allow the automatic upload of the firmware by
		// specifying "IS_ALLOW_STARTER_FIRMWARE_UPLOAD"
		*hCam = (HIDS)(((INT)*hCam) | IS_ALLOW_STARTER_FW_UPLOAD);
		nRet = is_InitCamera(hCam, hWnd);
	}
	return nRet;
}
void CuEyeSimpleTriggerDlg::GetMaxImageSize(INT *pnSizeX, INT *pnSizeY)
{
	// Check if the camera supports an arbitrary AOI
	// Only the ueye xs does not support an arbitrary AOI
	INT nAOISupported = 0;
	BOOL bAOISupported = TRUE;
	if (is_ImageFormat(m_hCam,
		IMGFRMT_CMD_GET_ARBITRARY_AOI_SUPPORTED,
		(void*)&nAOISupported,
		sizeof(nAOISupported)) == IS_SUCCESS)
	{
		bAOISupported = (nAOISupported != 0);
	}
	if (bAOISupported)
	{
		// All other sensors
		// Get maximum image size
		SENSORINFO sInfo;
		is_GetSensorInfo(m_hCam, &sInfo);
		*pnSizeX = sInfo.nMaxWidth;
		*pnSizeY = sInfo.nMaxHeight;
	}
	else
	{
		// Only ueye xs
		// Get image size of the current format
		IS_SIZE_2D imageSize;
		is_AOI(m_hCam, IS_AOI_IMAGE_GET_SIZE, (void*)&imageSize, sizeof(imageSize));
		*pnSizeX = imageSize.s32Width;
		*pnSizeY = imageSize.s32Height;
	}
}
void CuEyeSimpleTriggerDlg::OnSize(UINT nType, int cx, int cy)
{
	CDialog::OnSize(nType, cx, cy);
	// TODO:  在此处添加消息处理程序代码
	if (nType == SIZE_RESTORED || nType == SIZE_MAXIMIZED)
	{
		resize();
	}
}
/*zyl*/
HBRUSH CuEyeSimpleTriggerDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);

	// TODO:  在此更改 DC 的任何特性
	if (pWnd->GetDlgCtrlID() == IDC_EDIT_RECV || pWnd->GetDlgCtrlID() == IDC_EDIT_SEND)
	{
		pDC->SetTextColor(RGB(0, 134, 139));
	}
	if (pWnd->GetDlgCtrlID() == IDC_STATIC_GROUP || pWnd->GetDlgCtrlID() == IDC_STATIC_GROUP1)
	{
		pDC->SetTextColor(RGB(123, 104, 238));
	}
	// TODO:  如果默认的不是所需画笔，则返回另一个画笔
	return hbr;
}
/*zyl*/

void CuEyeSimpleTriggerDlg::OnBnClickedButtonSingleshot()
{

	Mat frame;
	//格式：过滤器描述符（显示作用）+ \0 + 文件扩展名称（过滤作用）
	//多个扩展名称之间用（;）分隔，两个过滤字符串之间以\0分隔
	//最后的过滤器需要以两个\0\0结尾
	char szFilters[] =
		"Bitmap(*.bmp)\0*.bmp\0"\
		"All Files(*.*)\0*.*\0" \
		"\0";
	//当过滤器或者默认构造参数赋值较少情况下，
	//使用构造函数修改对话框初始状态可能更好，这过滤器较多
	CFileDialog FileDlg(FALSE, "bmp", _T("image"));
	FileDlg.m_ofn.lpstrTitle = "Save File";
	FileDlg.m_ofn.lpstrFilter = szFilters;
	//通过以下两个参数修改对话框初始状态，程序奔溃，使用默认构造形式正常
	//环境：VS2008编译器+Wind7系统
	//FileDlg.m_ofn.lpstrDefExt = "txt";
	//FileDlg.m_ofn.lpstrFile = "test";
	if (IDOK == FileDlg.DoModal())
	{

	/*	string img_name(FileDlg.GetPathName());
		int line_step = 0;
		is_GetImageMemPitch(m_hCam, &line_step);
		Mat frame(m_nSizeY, m_nSizeX, CV_8UC3, m_pcImageMemory, line_step);
		imwrite(img_name, frame);
		frame.release();*/
		
		string img_name(FileDlg.GetPathName());
		GetFrame(frame);
		//resize(frame1, frame1, Size(640, 480));
		//sprintf(img_name, "F:\\Image\\L%d.bmp", i++);
		imwrite(img_name, frame);
	

	}
}


void CuEyeSimpleTriggerDlg::OnBnClickedButton4()
{	
	//格式：过滤器描述符（显示作用）+ \0 + 文件扩展名称（过滤作用）
	//多个扩展名称之间用（;）分隔，两个过滤字符串之间以\0分隔
	//最后的过滤器需要以两个\0\0结尾
	char szFilters[] =
		"Bitmap(*.bmp)\0*.bmp\0"\
		"All Files(*.*)\0*.*\0" \
		"\0";
	//当过滤器或者默认构造参数赋值较少情况下，
	//使用构造函数修改对话框初始状态可能更好，这过滤器较多
	CFileDialog FileDlg(FALSE, "bmp", _T("image"));
	FileDlg.m_ofn.lpstrTitle = "Save File";
	FileDlg.m_ofn.lpstrFilter = szFilters;
	//通过以下两个参数修改对话框初始状态，程序奔溃，使用默认构造形式正常
	//环境：VS2008编译器+Wind7系统
	//FileDlg.m_ofn.lpstrDefExt = "txt";
	//FileDlg.m_ofn.lpstrFile = "test";
	if (IDOK == FileDlg.DoModal())
	{
		string img_name(FileDlg.GetPathName());	
		int pos = img_name.find('.');
		int length = img_name.length();
		img_name_temp = img_name.substr(0, pos);
		//img_name_2 = img_name.substr(pos + 1, length - pos - 1);		

	}

}
