#include "stdafx.h"
#include "MainWindow.h"

AXCSOUNDLib::IAXCsoundPtr CMainWindow::csound;

CMainWindow::CMainWindow()
{
}

CMainWindow::~CMainWindow()
{
	csound->Release();
	csound = 0;
}

LRESULT CMainWindow::OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	IUnknown *pIUnknown = 0;
	HRESULT hresult = GetDlgControl(IDC_AXCSOUND, 
		__uuidof(AXCSOUNDLib::IAXCsound), 
		(void **)&pIUnknown);
	if(FAILED(hresult))
	{
		MessageBox("Failed to create AXCsound object.\nTry running \"regsvr32 AXCsound.dll\".", "AXCsound", MB_ICONEXCLAMATION);
	}
	else
	{
		csound = pIUnknown;
	}
	char *commandLine = ::GetCommandLine();
	{
		USES_CONVERSION;
		char *delimiters = " \t\n\r";
		char *token = strtok(commandLine, delimiters);
		while(token)
		{
			token = strtok(0, delimiters);
			if(token)
			{
				if(strcmp(token, "-deleteNotes") == 0)
				{
					csound->RemoveScoreExceptFunctions();
				}
				else if(strcmp(token, "-saveAs") == 0)
				{
					token = strtok(0, delimiters);
					csound->put_Filename(T2OLE(token));
					csound->Save(T2OLE(token));
				}
				else
				{
					csound->Import(T2OLE(token));
				}
			}
		}
		csound->UpdateView();
	}
	return 1;  // Let the system set the focus
}	

LRESULT CMainWindow::OnClose(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = true;
	::PostQuitMessage(0);
	return 0;
}

LRESULT CMainWindow::OnDestroy(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = true;
	::PostQuitMessage(0);
	return 0;
}

LRESULT CMainWindow::OnOK(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	bHandled = true;
	if(csound)
	{
		csound->Stop();
	}
	::PostQuitMessage(0);
	return 0;
}

LRESULT CMainWindow::OnCancel(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	bHandled = true;
	if(csound)
	{
		csound->Stop();
	}
	::PostQuitMessage(0);
	return 0;
}

