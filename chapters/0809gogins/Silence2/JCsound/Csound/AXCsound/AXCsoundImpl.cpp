#include "stdafx.h"
#include "AXCsound.h"
#include "AXCsoundImpl.h"
#include <process.h>
CAXCsound *This = 0;

extern "C" void AXCsoundLogCallback(const char *message)
{
	WPARAM returnValue = This->commandDialog.SendDlgItemMessage(IDC_LOG_LIST, LB_ADDSTRING, 0, (LPARAM) (LPCTSTR) message);
	if(returnValue == LB_ERRSPACE)
	{
		This->commandDialog.SendDlgItemMessage(IDC_LOG_LIST, LB_RESETCONTENT, 0, 0);	
		returnValue = This->commandDialog.SendDlgItemMessage(IDC_LOG_LIST, LB_ADDSTRING, 0, (LPARAM) (LPCTSTR) message);
	}
	This->commandDialog.SendDlgItemMessage(IDC_LOG_LIST, LB_SETCURSEL, returnValue, 0);
}

static void renderingThreadRoutine(void *data)
{
	Csound *csound = (Csound *)data;
	csound->play();
}

STDMETHODIMP CAXCsound::Play(void)
{
	if(m_hWnd)
	{
		SendDlgItemMessage(IDC_LOG_LIST, LB_RESETCONTENT, 0, 0);
	}
	renderingThread = _beginthread(&renderingThreadRoutine, 0, &csound);
	SetThreadPriority((void *)renderingThread, 11);
	return S_OK;
}

STDMETHODIMP CAXCsound::Pause(void)
{
	WaitForSingleObject((void *)renderingThread, INFINITE);
	return S_OK;
}

STDMETHODIMP CAXCsound::Resume(void)
{
	SetEvent((void *)renderingThread);
	return S_OK;
}

STDMETHODIMP CAXCsound::Stop(void)
{
	csound.stop();
	return S_OK;
}


STDMETHODIMP CAXCsound::Open(BSTR Filename)
{
	USES_CONVERSION;
	WaitCursor wait;
	std::string buffer = OLE2T(Filename);
	csoundFile.removeAll();
	csoundFile.setFilename(buffer);
	if(csoundFile.load(buffer))
	{
		if(m_hWnd)
		{
			updateView();
		}
		return S_OK;
	}
	return E_FAIL;
	return S_OK;
}

STDMETHODIMP CAXCsound::Import(BSTR Filename)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(Filename);
	if(csoundFile.import(buffer))
	{
		return S_OK;
	}
	return E_FAIL;
}

STDMETHODIMP CAXCsound::Save(BSTR Filename)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(Filename);
	if(csoundFile.save(buffer))
	{
		return S_OK;
	}
	return E_FAIL;
}

STDMETHODIMP CAXCsound::Export(BSTR Filename)
{
	return Save(Filename);
}

STDMETHODIMP CAXCsound::OpenSound(void)
{
	ATLTRACE(_T("CAXCsound::OnOpenSound\n"));
	std::string filename = csoundFile.getOutputSoundfileName();
	HINSTANCE returnValue = ShellExecute(0,
		"open",
		filename.c_str(),
		0,
		0,
		SW_SHOWNORMAL);
	return S_OK;
}

STDMETHODIMP CAXCsound::get_Command(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getCommand();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::put_Command(BSTR newVal)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(newVal);
	csoundFile.setCommand(buffer);
	csound.command(buffer.c_str());
	return S_OK;
}

STDMETHODIMP CAXCsound::get_OrcFilename(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getOrcFilename();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}


STDMETHODIMP CAXCsound::get_ScoFilename(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getScoFilename();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::get_Score(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getScore();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::put_Score(BSTR newVal)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(newVal);
	csoundFile.setScore(buffer);
	return S_OK;
}

STDMETHODIMP CAXCsound::get_ScoreLine(long index, BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getScoreLine(index);
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::put_ScoreLine(long index, BSTR newVal)
{
	USES_CONVERSION;
	if(index < 0 || index >= csoundFile.getScoreLineCount())
	{
		return E_INVALIDARG;
	}
	std::string buffer = OLE2T(newVal);
	csoundFile.setScoreLine(index, buffer);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddScoreLine(BSTR Note)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(Note);
	csoundFile.addScoreLine(buffer);	
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote10(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9, double p10)
{
	csoundFile.addNote(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote9(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9)
{
	csoundFile.addNote(p1, p2, p3, p4, p5, p6, p7, p8, p9);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote8(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8)
{
	csoundFile.addNote(p1, p2, p3, p4, p5, p6, p7, p8);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote7(double p1, double p2, double p3, double p4, double p5, double p6, double p7)
{
	csoundFile.addNote(p1, p2, p3, p4, p5, p6, p7);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote6(double p1, double p2, double p3, double p4, double p5, double p6)
{
	csoundFile.addNote(p1, p2, p3, p4, p5, p6);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote5(double p1, double p2, double p3, double p4, double p5)
{
	csoundFile.addNote(p1, p2, p3, p4, p5);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote4(double p1, double p2, double p3, double p4)
{
	csoundFile.addNote(p1, p2, p3, p4);
	return S_OK;
}

STDMETHODIMP CAXCsound::AddNote3(double p1, double p2, double p3)
{
	csoundFile.addNote(p1, p2, p3);
	return S_OK;
}

STDMETHODIMP CAXCsound::get_ScoreLineCount(long *pVal)
{
	*pVal = csoundFile.getScoreLineCount();
	return S_OK;
}

STDMETHODIMP CAXCsound::put_ScoreLineCount(long newVal)
{
	csoundFile.setScoreLineCount(newVal);
	return S_OK;
}

STDMETHODIMP CAXCsound::get_Orchestra(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getOrchestra();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::put_Orchestra(BSTR newVal)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(newVal);
	csoundFile.setOrchestra(buffer);
	return S_OK;
}

STDMETHODIMP CAXCsound::RemoveOrchestra(void)
{
	csoundFile.removeOrchestra();
	return S_OK;
}

STDMETHODIMP CAXCsound::RemoveAll(void)
{
	InitNew();
	updateView();
	return S_OK;
}

STDMETHODIMP CAXCsound::RemoveScoreExceptFunctions(void)
{
	csoundFile.removeScoreExceptFunctions();
	updateView();
	return S_OK;
}

STDMETHODIMP CAXCsound::RemoveScore(void)
{
	csoundFile.setScoreLineCount(0);
	updateView();
	return S_OK;
}

STDMETHODIMP CAXCsound::get_Filename(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getFilename();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::get_MidiFilename(BSTR *pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getMidiFilename();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::put_Filename(BSTR newVal)
{
	USES_CONVERSION;
	std::string buffer = OLE2T(newVal);
	csoundFile.setFilename(buffer);
	return S_OK;
}

STDMETHODIMP CAXCsound::RemoveCommand()
{
	csoundFile.removeCommand();
	updateView();
	return S_OK;
}

STDMETHODIMP CAXCsound::get_OutputSoundfileName(BSTR * pVal)
{
	USES_CONVERSION;
	std::string buffer = csoundFile.getOutputSoundfileName();
	*pVal = ::SysAllocString(T2OLE(buffer.c_str()));
	return S_OK;
}

STDMETHODIMP CAXCsound::InitFromData(IDataObject *pDataObject, BOOL fCreation, DWORD dwReserved)
{
	ATLTRACE(_T("CAXCsound::InitFromData().\n"));
	return E_NOTIMPL;
}

STDMETHODIMP CAXCsound::Help(LPCOLESTR pszHelpDir)
{
	TCHAR path[_MAX_PATH];
	TCHAR drive[_MAX_PATH];
	TCHAR dir[_MAX_PATH];
	TCHAR fname[_MAX_PATH];
	TCHAR ext[_MAX_PATH];
	long returnValue = ::GetModuleFileName(_Module.m_hInst, path, _MAX_PATH);
	if(!returnValue)
	{
		return E_INVALIDARG;
	}
	_splitpath(path, drive, dir, fname, ext);
	std::string helpFilename;
	helpFilename += drive;
	helpFilename += dir;
	helpFilename += "AXCsound.htm";
	returnValue = (long) ShellExecute(0,
		"open",
		helpFilename.c_str(),
		0,
		0,
		SW_SHOWNORMAL);
	return S_OK;
}

STDMETHODIMP CAXCsound::IsDirty()
{
	ATLTRACE(_T("CAXCsound::IsDirty().\n"));
	return true;
}

STDMETHODIMP CAXCsound::UpdateView()
{
	ATLTRACE(_T("CAXCsound::UpdateView().\n"));
	updateView();
	return true;
}

STDMETHODIMP CAXCsound::InitNew()
{
	ATLTRACE(_T("AXCSound::InitNew().\n"));
	csoundFile.removeAll();
	return S_OK;
}

STDMETHODIMP CAXCsound::GetSizeMax(ULARGE_INTEGER FAR* pcbSize)
{
	ATLTRACE(_T("CAXCsound::GetSizeMax().\n"));
	std::ostringstream stringStream;
	if(!csoundFile.save(stringStream))
	{
		return E_FAIL;
	}
	const char *buffer = stringStream.str().c_str();
	if(buffer)
	{
		pcbSize->LowPart = strlen(buffer);
		return S_OK;
	}
	return E_FAIL;
}

STDMETHODIMP CAXCsound::Load(LPSTREAM stream)
{
	ATLTRACE(_T("CAXCsound::Load().\n"));
	HRESULT returnValue = E_FAIL;
	if(stream)
	{
		STATSTG statstg;
		HRESULT hResult = stream->Stat(&statstg, STATFLAG_DEFAULT);
		if(!SUCCEEDED(hResult))
		{
			return S_OK;
		}
		char charBuffer = 0;
		ULONG charBufferSize = sizeof(charBuffer);
		ULONG sizeRead = 0;
		std::string buffer;
		for(;;)
		{
			returnValue = stream->Read(&charBuffer,
				charBufferSize,
				&sizeRead);
			if(returnValue != S_OK || sizeRead != charBufferSize)
			{
				break;
			}
			else
			{
				buffer.append(1, charBuffer);
			}
		}
		if(buffer.size() > 0)
		{
			std::istringstream stringStream(buffer);
			return csoundFile.load(stringStream);
			if(m_hWnd)
			{
				updateView();
			}
			return S_OK;
		}
	}
	updateView();
	return returnValue;
}

STDMETHODIMP CAXCsound::Save(LPSTREAM stream, BOOL fClearDirty)
{
	ATLTRACE(_T("CAXCsound::Save().\n"));
	HRESULT returnValue = E_FAIL;
	if(stream)
	{
		std::ostringstream stringStream;
		if(!csoundFile.save(stringStream))
		{
			return E_FAIL;
		}
		std::string &buffer = stringStream.str();
		if(buffer.size() > 0)
		{
			ULONG sizeWritten = 0;
			returnValue = stream->Write(buffer.c_str(),
				buffer.size() + 1,
				&sizeWritten);  
		}
	}
	return returnValue;
}

LRESULT CAXCsound::OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnInitDialog().\n"));
	RECT rc;
	GetWindowRect(&rc);
	rc.right -= rc.left;
	rc.bottom -= rc.top;
	rc.top = 0;
	rc.left = 0;
	tabsWindow = GetDlgItem(IDC_TABS);
	TC_ITEM tcItem;
	memset(&tcItem, 0, sizeof(tcItem));
	tcItem.mask = TCIF_TEXT;
	tcItem.pszText = "Command";
	TabCtrl_InsertItem(tabsWindow, COMMAND_TAB, &tcItem);
	tcItem.pszText = "Orchestra";
	TabCtrl_InsertItem(tabsWindow, ORCHESTRA_TAB, &tcItem);
	tcItem.pszText = "Score";
	TabCtrl_InsertItem(tabsWindow, SCORE_TAB, &tcItem);
	tcItem.pszText = "Copyright";
	TabCtrl_InsertItem(tabsWindow, COPYRIGHT_TAB, &tcItem);
	commandDialog.Create(m_hWnd);
	orchestraDialog.Create(m_hWnd);
	scoreDialog.Create(m_hWnd);
	copyrightDialog.Create(m_hWnd);
	commandDialog.SetChainEntry(3333, this, 1);
	orchestraDialog.SetChainEntry(3333, this, 2);
	scoreDialog.SetChainEntry(3333, this, 3);
	commandDialog.ShowWindow(SW_SHOW);
	updateView();
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnSelchangeTabs(int idCtrl, LPNMHDR pnmh, BOOL& bHandled)
{
	commandDialog.ShowWindow(SW_HIDE);
	orchestraDialog.ShowWindow(SW_HIDE);
	scoreDialog.ShowWindow(SW_HIDE);
	copyrightDialog.ShowWindow(SW_HIDE);
	int index = TabCtrl_GetCurSel(tabsWindow);
	switch(index)	
	{
	case COMMAND_TAB:
		commandDialog.ShowWindow(SW_SHOW);
		break;
	case ORCHESTRA_TAB:
		orchestraDialog.ShowWindow(SW_SHOW);
		break;
	case SCORE_TAB:
		scoreDialog.ShowWindow(SW_SHOW);
		break;
	case COPYRIGHT_TAB:
		copyrightDialog.ShowWindow(SW_SHOW);
		break;
	}
	bHandled = true;
	return 0;
}

STDMETHODIMP CAXCsound::SetObjectRects(LPCRECT prcPos,LPCRECT prcClip)
{
	if(!m_hWnd)
	{
		return S_OK;
	}
	IOleInPlaceObjectWindowlessImpl<CAXCsound>::SetObjectRects(prcPos, prcClip);
	int cx;
	int cy;
	cx = prcPos->right - prcPos->left;
	cy = prcPos->bottom - prcPos->top;
	::SetWindowPos(tabsWindow, NULL, 0, 0, cx, cy, SWP_NOZORDER | SWP_NOACTIVATE);
	int tabLeft = 5;
	int tabTop = 30;
	int tabBottom = 5;
	int tabWidth = cx - 2 * tabLeft;
	int tabHeight = cy - tabTop - tabBottom;
	::SetWindowPos(commandDialog.m_hWnd, NULL, tabLeft, tabTop, tabWidth, tabHeight, SWP_NOZORDER | SWP_NOACTIVATE);
	::SetWindowPos(orchestraDialog.m_hWnd, NULL, tabLeft, tabTop, tabWidth, tabHeight, SWP_NOZORDER | SWP_NOACTIVATE);
	::SetWindowPos(scoreDialog.m_hWnd, NULL, tabLeft, tabTop, tabWidth, tabHeight, SWP_NOZORDER | SWP_NOACTIVATE);
	::SetWindowPos(copyrightDialog.m_hWnd, NULL, tabLeft, tabTop, tabWidth, tabHeight, SWP_NOZORDER | SWP_NOACTIVATE);
	return S_OK;
}

CAXCsound::CAXCsound() : 
	tabsWindow(0)
{
	::InitCommonControls();
	HINSTANCE library = ::LoadLibrary("RICHED32.DLL");
	SIZE pixelSize;
	pixelSize.cx = 515;
	pixelSize.cy = 410;
	AtlPixelToHiMetric(&pixelSize, &m_sizeNatural);
	m_sizeExtent = m_sizeNatural;
	m_bWindowOnly = TRUE; 
	m_bAutoSize = TRUE;
	m_bDrawFromNatural = TRUE;
	CalcExtent(m_sizeExtent);
	csound.setLogCallback(&AXCsoundLogCallback);
	renderingThread = 0;
	This = this;
}

STDMETHODIMP CAXCsound::GetViewStatus(DWORD* pdwStatus)
{
	ATLTRACE(_T("IViewObjectExImpl::GetViewStatus\n"));
	*pdwStatus = VIEWSTATUS_SOLIDBKGND | VIEWSTATUS_OPAQUE;
	return S_OK;
}

STDMETHODIMP CAXCsound::TranslateAccelerator(MSG *pMsg)
{
	ATLTRACE(_T("CAXCsound::TranslateAccelerator\n"));
	if(((pMsg->message < WM_KEYFIRST) || (pMsg->message > WM_KEYLAST)) && ((pMsg->message < WM_MOUSEFIRST) || (pMsg->message > WM_MOUSELAST)))
	{
		return S_FALSE;
	}
	return (IsDialogMessage(pMsg)) ? S_OK : S_FALSE;
}

LRESULT CAXCsound::OnOpenSound(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled)
{
	OpenSound();
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnPlayOrStop(int idCtrl, LPNMHDR pnmh, BOOL& bHandled)
{
	extern int keepPlayingFlag;
	bHandled = true;
	ATLTRACE(_T("CAXCsound::OnPlayOrStop\n"));
	if(((NM_UPDOWN *)pnmh)->iDelta < 0 && !csound.isPlaying())
	{
		updateModel();
		csound.read(csoundFile.getFilename().c_str());
		Play();
	}
	else if(((NM_UPDOWN *)pnmh)->iDelta > 0 && csound.isPlaying())
	{
		Stop();
	}
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnImport(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled)
{
	ATLTRACE(_T("CAXCsound::OnImport\n"));
	char szFile[260];		// buffer for filename
	memset(szFile, 0, sizeof(szFile));
	OPENFILENAME ofn;       // common dialog box structure
	memset(&ofn, 0, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = m_hWnd;
	ofn.lpstrFile = szFile;
	ofn.nMaxFile = sizeof(szFile);
	ofn.lpstrFilter = "Csound\0*.csd\0Orchestra\0*.orc\0Score\0*.sco\0Midi\0*.mid\0All\0*.*\0\0";
	ofn.nFilterIndex = 0;
	ofn.lpstrFileTitle = 0;
	ofn.nMaxFileTitle = 0;
	ofn.lpstrInitialDir = 0;
	ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
	ofn.lpstrDefExt = "*.csd";
	if(GetOpenFileName(&ofn))
	{
		WaitCursor wait;
		csoundFile.import(ofn.lpstrFile);
		updateView();
	}	
	else
	{
		long returnValue = CommDlgExtendedError();
	}
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnSave(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled)
{
	ATLTRACE(_T("CAXCsound::OnSave\n"));
	WaitCursor wait;
	updateModel();
	csoundFile.save(csoundFile.getFilename());
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnOpen(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled)
{
	ATLTRACE(_T("CAXCsound::OnOpen\n"));
	char szFile[260];		// buffer for filename
	memset(szFile, 0, sizeof(szFile));
	OPENFILENAME ofn;       // common dialog box structure
	memset(&ofn, 0, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = m_hWnd;
	ofn.lpstrFile = szFile;
	ofn.nMaxFile = sizeof(szFile);
	ofn.lpstrFilter = "Csound\0*.csd\0All\0*.*\0\0";
	ofn.nFilterIndex = 0;
	ofn.lpstrFileTitle = 0;
	ofn.nMaxFileTitle = 0;
	ofn.lpstrInitialDir = 0;
	ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
	ofn.lpstrDefExt = "csd";
	if(GetOpenFileName(&ofn))
	{
		WaitCursor wait;
		csoundFile.removeAll();
		csoundFile.setFilename(ofn.lpstrFile);
		csoundFile.load(csoundFile.getFilename());
		updateView();
	}	
	else
	{
		long returnValue = CommDlgExtendedError();
	}
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnMouseActivate(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL &bHandled)
{
	ATLTRACE(_T("CAXCsound::OnMouseActivate\n"));
	InPlaceActivate(OLEIVERB_UIACTIVATE);
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnChangeCommand(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	USES_CONVERSION;
	ATLTRACE(_T("CAXCsound::OnChangeEdit_command\n"));
	BSTR buffer = 0;
	if(commandDialog.GetDlgItemText(IDC_EDIT_COMMAND, buffer))
	{
		put_Command(buffer);
	}
	SetDirty(false);
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnSaveAs(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnSaveAs\n"));
	char szFile[260];		// buffer for filename
	memset(szFile, 0, sizeof(szFile));
	OPENFILENAME ofn;       // common dialog box structure
	memset(&ofn, 0, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = m_hWnd;
	ofn.lpstrFile = szFile;
	ofn.nMaxFile = sizeof(szFile);
	ofn.lpstrFilter = "Csound\0*.csd\0All\0*.*\0\0";
	ofn.nFilterIndex = 0;
	ofn.lpstrFileTitle = 0;
	ofn.nMaxFileTitle = 0;
	ofn.lpstrInitialDir = 0;
	ofn.Flags = OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT;
	ofn.lpstrDefExt = "*.csd";
	if(GetSaveFileName(&ofn))
	{
		WaitCursor wait;
		updateModel();
		csoundFile.setFilename(ofn.lpstrFile);
		csoundFile.save(csoundFile.getFilename());
		commandDialog.SetDlgItemText(IDC_EDIT_FILENAME, csoundFile.getFilename().c_str());
	}	
	else
	{
		long returnValue = CommDlgExtendedError();
	}
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnChangeScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnChangeScore\n"));
	BSTR buffer = 0;
	if(scoreDialog.GetDlgItemText(IDC_EDIT_ORCHESTRA, buffer))
	{
		put_Orchestra(buffer);
	}
	SetDirty(false);
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnChangeOrchestra(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnChangeOrchestra\n"));
	BSTR buffer = 0;
	if(orchestraDialog.GetDlgItemText(IDC_EDIT_ORCHESTRA, buffer))
	{
		put_Orchestra(buffer);
	}
	SetDirty(false);
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnClearScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnClearScore\n"));
	csoundFile.setScoreLineCount(0);
	scoreDialog.SetDlgItemText(IDC_SCORE_EDIT, csoundFile.getScore().c_str());
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnClearNotesOnly(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnClearNotesOnly\n"));
	csoundFile.removeScoreExceptFunctions();
	scoreDialog.SetDlgItemText(IDC_SCORE_EDIT, csoundFile.getScore().c_str());
	bHandled = true;
	return 0;
}

LRESULT CAXCsound::OnUpdateScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	ATLTRACE(_T("CAXCsound::OnUpdateScore\n"));
	updateModel();
	bHandled = true;
	return 0;
}

void CAXCsound::updateView()
{
	commandDialog.SetDlgItemText(IDC_EDIT_FILENAME, csoundFile.getFilename().c_str());
	commandDialog.SetDlgItemText(IDC_EDIT_COMMAND, csoundFile.getCommand().c_str());
	orchestraDialog.SetDlgItemText(IDC_EDIT_ORCHESTRA, csoundFile.getOrchestra().c_str());
	scoreDialog.SetDlgItemText(IDC_SCORE_EDIT, csoundFile.getScore().c_str());
	SetDirty(false);
}

void CAXCsound::updateModel()
{
	BSTR buffer = 0;
	if(commandDialog.GetDlgItemText(IDC_EDIT_COMMAND, buffer))
	{
		put_Command(buffer);
	}
	if(scoreDialog.GetDlgItemText(IDC_EDIT_ORCHESTRA, buffer))
	{
		put_Orchestra(buffer);
	}
	if(orchestraDialog.GetDlgItemText(IDC_EDIT_ORCHESTRA, buffer))
	{
		put_Orchestra(buffer);
	}
}
