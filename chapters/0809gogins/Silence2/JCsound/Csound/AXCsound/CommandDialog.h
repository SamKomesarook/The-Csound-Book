#ifndef __COMMANDDIALOG_H_
#define __COMMANDDIALOG_H_

#include "resource.h"       // main symbols
#include <atlhost.h>

class CCommandDialog : 
	public CAxDialogImpl<CCommandDialog>,
	public CDynamicChain,
	public IDispEventImpl<IDC_MEDIAPLAYER, CCommandDialog>
{
public:
	CCommandDialog()
	{
	}
	~CCommandDialog()
	{
	}
	enum { IDD = IDD_COMMANDDIALOG };
BEGIN_MSG_MAP(CCommandDialog)
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
public :

BEGIN_SINK_MAP(CCommandDialog)
	//Make sure the Event Handlers have __stdcall calling convention
END_SINK_MAP()

};

#endif //__COMMANDDIALOG_H_
