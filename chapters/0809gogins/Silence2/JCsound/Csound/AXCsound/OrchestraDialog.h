#ifndef __ORCHESTRADIALOG_H_
#define __ORCHESTRADIALOG_H_

#include "resource.h"       // main symbols
#include <atlhost.h>

class COrchestraDialog : 
	public CAxDialogImpl<COrchestraDialog>,
	public CDynamicChain
{
public:
	COrchestraDialog()
	{
	}
	~COrchestraDialog()
	{
	}
	enum { IDD = IDD_ORCHESTRADIALOG };
BEGIN_MSG_MAP(COrchestraDialog)
	MESSAGE_HANDLER(WM_INITDIALOG, OnInitDialog)
	COMMAND_ID_HANDLER(IDOK, OnOK)
	COMMAND_ID_HANDLER(IDCANCEL, OnCancel)
    CHAIN_MSG_MAP_DYNAMIC(3333)
END_MSG_MAP()
// Handler prototypes:
//  LRESULT MessageHandler(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
//  LRESULT CommandHandler(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
//  LRESULT NotifyHandler(int idCtrl, LPNMHDR pnmh, BOOL& bHandled);
	LRESULT OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
	{
		return 1;  // Let the system set the focus
	}
	LRESULT OnOK(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
	{
		EndDialog(wID);
		return 0;
	}
	LRESULT OnCancel(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
	{
		EndDialog(wID);
		return 0;
	}
};

#endif //__ORCHESTRADIALOG_H_
