#ifndef __COPYRIGHTDIALOG_H_
#define __COPYRIGHTDIALOG_H_

#include "resource.h"       // main symbols
#include <atlhost.h>

class CCopyrightDialog : 
	public CAxDialogImpl<CCopyrightDialog>
{
public:
	CCopyrightDialog();
	~CCopyrightDialog();
	enum 
	{ 
		IDD = IDD_COPYRIGHTDIALOG 
	};
BEGIN_MSG_MAP(CCopyrightDialog)
	MESSAGE_HANDLER(WM_INITDIALOG, OnInitDialog)
	COMMAND_ID_HANDLER(IDOK, OnOK)
	COMMAND_ID_HANDLER(IDCANCEL, OnCancel)
END_MSG_MAP()
// Handler prototypes:
//  LRESULT MessageHandler(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
//  LRESULT CommandHandler(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
//  LRESULT NotifyHandler(int idCtrl, LPNMHDR pnmh, BOOL& bHandled);
	LRESULT OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
	LRESULT OnOK(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnCancel(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
};

#endif //__COPYRIGHTDIALOG_H_
