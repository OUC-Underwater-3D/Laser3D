
#include "StdAfx.h"
#include "uEyeSimpleTrigger.h"
#include "uEyeSimpleTriggerDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
BEGIN_MESSAGE_MAP(CuEyeSimpleTriggerApp, CWinApp)
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
CuEyeSimpleTriggerApp::CuEyeSimpleTriggerApp()
{
	/*zyl*/
	// ֧����������������
	m_dwRestartManagerSupportFlags = AFX_RESTART_MANAGER_SUPPORT_RESTART;
	/*zyl*/
}

/////////////////////////////////////////////////////////////////////////////
CuEyeSimpleTriggerApp theApp;

/////////////////////////////////////////////////////////////////////////////
BOOL CuEyeSimpleTriggerApp::InitInstance()
{   

	/*zyl*/
	if (!AfxSocketInit())
	{
		AfxMessageBox("�����׽��ֿ�ʧ��");
		return FALSE;
	}
	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);
	CWinApp::InitInstance();
	CShellManager *pShellManager = new CShellManager;
	/*zyl*/
	InitCommonControls();
	AfxEnableControlContainer();

	SetRegistryKey(_T("IDS\\uEye"));
    WriteProfileString(_T("MRU"), _T(""), theApp.m_pszAppName);

	CuEyeSimpleTriggerDlg dlg;
	m_pMainWnd = &dlg;
	INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
	}
	else if (nResponse == IDCANCEL)
	{
	}
	/*zyl*/
	// ɾ�����洴���� shell ��������
	if (pShellManager != NULL)
	{
		delete pShellManager;
	}
	/*zyl*/
	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}


