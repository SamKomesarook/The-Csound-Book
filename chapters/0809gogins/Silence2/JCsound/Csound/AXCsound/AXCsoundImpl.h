#ifndef __AXCsound_H_
#define __AXCsound_H_

#include "resource.h"       // main symbols
#include "CommandDialog.h"
#include "OrchestraDialog.h"
#include "ScoreDialog.h"
#include "CopyrightDialog.h"
#include <atlctl.h>
#include <commctrl.h>
#include <richedit.h>
#include <Csound.h>
#include <CsoundFile.h>
#include <string>

class WaitCursor
{
	HCURSOR oldCursor;
public:
	WaitCursor()
	{
		oldCursor = SetCursor(LoadCursor(0, IDC_WAIT));
	}
	~WaitCursor()
	{
		SetCursor(oldCursor);
	}
};

class ATL_NO_VTABLE CAXCsound : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CStockPropImpl<CAXCsound, IAXCsound, &IID_IAXCsound, &LIBID_AXCSOUNDLib>,
	public CComCompositeControl<CAXCsound>,
	public IPersistStreamInitImpl<CAXCsound>,
	public IOleControlImpl<CAXCsound>,
	public IOleObjectImpl<CAXCsound>,
	public IOleInPlaceActiveObjectImpl<CAXCsound>,
	public IViewObjectExImpl<CAXCsound>,
	public IOleInPlaceObjectWindowlessImpl<CAXCsound>,
	public IConnectionPointContainerImpl<CAXCsound>,
	public IPersistStorageImpl<CAXCsound>,
	public ISpecifyPropertyPagesImpl<CAXCsound>,
	public IQuickActivateImpl<CAXCsound>,
	public IDataObjectImpl<CAXCsound>,
	public IProvideClassInfo2Impl<&CLSID_AXCsound, &DIID__IAXCsoundEvents, &LIBID_AXCSOUNDLib>,
	public IPropertyNotifySinkCP<CAXCsound>,
	public CComCoClass<CAXCsound, &CLSID_AXCsound>
{
public:
	CAXCsound();
DECLARE_REGISTRY_RESOURCEID(IDR_AXCSOUND)
DECLARE_PROTECT_FINAL_CONSTRUCT()
BEGIN_COM_MAP(CAXCsound)
	COM_INTERFACE_ENTRY(IAXCsound)
	COM_INTERFACE_ENTRY(IDispatch)
	COM_INTERFACE_ENTRY(IViewObjectEx)
	COM_INTERFACE_ENTRY(IViewObject2)
	COM_INTERFACE_ENTRY(IViewObject)
	COM_INTERFACE_ENTRY(IOleInPlaceObjectWindowless)
	COM_INTERFACE_ENTRY(IOleInPlaceObject)
	COM_INTERFACE_ENTRY2(IOleWindow, IOleInPlaceObjectWindowless)
	COM_INTERFACE_ENTRY(IOleInPlaceActiveObject)
	COM_INTERFACE_ENTRY(IOleControl)
	COM_INTERFACE_ENTRY(IOleObject)
	COM_INTERFACE_ENTRY(IPersistStreamInit)
	COM_INTERFACE_ENTRY2(IPersist, IPersistStreamInit)
	COM_INTERFACE_ENTRY(IConnectionPointContainer)
	COM_INTERFACE_ENTRY(ISpecifyPropertyPages)
	COM_INTERFACE_ENTRY(IQuickActivate)
	COM_INTERFACE_ENTRY(IPersistStorage)
	COM_INTERFACE_ENTRY(IDataObject)
	COM_INTERFACE_ENTRY(IProvideClassInfo)
	COM_INTERFACE_ENTRY(IProvideClassInfo2)
END_COM_MAP()
BEGIN_PROP_MAP(CAXCsound)
	PROP_DATA_ENTRY("_cx", m_sizeExtent.cx, VT_UI4)
	PROP_DATA_ENTRY("_cy", m_sizeExtent.cy, VT_UI4)
	PROP_ENTRY("AutoSize", DISPID_AUTOSIZE, CLSID_NULL)
	PROP_ENTRY("Caption", DISPID_CAPTION, CLSID_NULL)
	// Example entries
	// PROP_ENTRY("Property Description", dispid, clsid)
	// PROP_PAGE(CLSID_StockColorPage)
END_PROP_MAP()
BEGIN_CONNECTION_POINT_MAP(CAXCsound)
	CONNECTION_POINT_ENTRY(IID_IPropertyNotifySink)
END_CONNECTION_POINT_MAP()
BEGIN_MSG_MAP(CAXCsound)
	CHAIN_MSG_MAP(CComCompositeControl<CAXCsound>)
	MESSAGE_HANDLER(WM_INITDIALOG, OnInitDialog)
	NOTIFY_HANDLER(IDC_TABS, TCN_SELCHANGE, OnSelchangeTabs)
	MESSAGE_HANDLER(WM_PAINT, OnPaint)
	MESSAGE_HANDLER(WM_SETFOCUS, OnSetFocus)
	MESSAGE_HANDLER(WM_KILLFOCUS, OnKillFocus)
	MESSAGE_HANDLER(WM_MOUSEACTIVATE, OnMouseActivate)
ALT_MSG_MAP(1)
	COMMAND_HANDLER(IDOPEN, BN_CLICKED, OnOpen)
	COMMAND_HANDLER(IDSAVE, BN_CLICKED, OnSave)
    COMMAND_HANDLER(IDSAVEAS, BN_CLICKED, OnSaveAs)
	COMMAND_HANDLER(IDIMPORT, BN_CLICKED, OnImport)
	NOTIFY_HANDLER(IDC_MAIN_SPIN_PLAY, UDN_DELTAPOS, OnPlayOrStop)
	COMMAND_HANDLER(IDOPENSOUND, BN_CLICKED, OnOpenSound)
    COMMAND_HANDLER(IDC_EDIT_COMMAND, EN_CHANGE, OnChangeCommand)
    COMMAND_HANDLER(IDC_EDIT_COMMAND, EN_UPDATE, OnChangeCommand)
ALT_MSG_MAP(2)
	COMMAND_HANDLER(IDC_EDIT_ORCHESTRA, EN_UPDATE, OnChangeOrchestra)
	COMMAND_HANDLER(IDC_EDIT_ORCHESTRA, EN_CHANGE, OnChangeOrchestra)
ALT_MSG_MAP(3)
	COMMAND_HANDLER(IDC_CLEAR_SCORE, BN_CLICKED, OnClearScore)
	COMMAND_HANDLER(IDC_SCORE_EDIT, EN_CHANGE, OnChangeScore)
	COMMAND_HANDLER(IDC_SCORE_EDIT, EN_UPDATE, OnChangeScore)
	COMMAND_HANDLER(IDC_CLEAR_NOTES_ONLY, BN_CLICKED, OnClearNotesOnly)
	COMMAND_HANDLER(IDC_UPDATE, BN_CLICKED, OnUpdateScore)
END_MSG_MAP()
// Handler prototypes:
//  LRESULT MessageHandler(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
//  LRESULT CommandHandler(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
//  LRESULT NotifyHandler(int idCtrl, LPNMHDR pnmh, BOOL& bHandled);
BEGIN_SINK_MAP(CAXCsound)
	//Make sure the Event Handlers have __stdcall calling convention
END_SINK_MAP()
	STDMETHOD(OnAmbientPropertyChange)(DISPID dispid)
	{
		if (dispid == DISPID_AMBIENT_BACKCOLOR)
		{
			SetBackgroundColorFromAmbient();
			FireViewChange();
		}
		return IOleControlImpl<CAXCsound>::OnAmbientPropertyChange(dispid);
	}
	STDMETHOD(get_OutputSoundfileName)(BSTR *pValue);
	STDMETHOD(Play)(void);
	STDMETHOD(Pause)(void);
	STDMETHOD(Resume)(void);
	STDMETHOD(Stop)(void);
	STDMETHOD(Open)(BSTR Filename);
	STDMETHOD(Import)(BSTR Filename);
	STDMETHOD(Save)(BSTR Filename);
	STDMETHOD(Export)(BSTR Filename);
	STDMETHOD(OpenSound)(void);
	STDMETHOD(get_Filename)(BSTR *pValue);
	STDMETHOD(put_Filename)(BSTR Value);
	STDMETHOD(get_Command)(BSTR *pValue);
	STDMETHOD(put_Command)(BSTR Value);
	STDMETHOD(get_OrcFilename)(BSTR *pValue);
	STDMETHOD(get_ScoFilename)(BSTR *pValue);
	STDMETHOD(get_MidiFilename)(BSTR *pValue);
	STDMETHOD(get_Score)(BSTR *pValue);
	STDMETHOD(put_Score)(BSTR Value);
	STDMETHOD(get_ScoreLine)(long Index, BSTR *pValue);
	STDMETHOD(put_ScoreLine)(long Index, BSTR Value);
	STDMETHOD(AddScoreLine)(BSTR Value);
	STDMETHOD(AddNote10)(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9, double p10);
	STDMETHOD(AddNote9)(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9);
	STDMETHOD(AddNote8)(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8);
	STDMETHOD(AddNote7)(double p1, double p2, double p3, double p4, double p5, double p6, double p7);
	STDMETHOD(AddNote6)(double p1, double p2, double p3, double p4, double p5, double p6);
	STDMETHOD(AddNote5)(double p1, double p2, double p3, double p4, double p5);
	STDMETHOD(AddNote4)(double p1, double p2, double p3, double p4);
	STDMETHOD(AddNote3)(double p1, double p2, double p3);
	STDMETHOD(get_ScoreLineCount)(long *pValue);
	STDMETHOD(put_ScoreLineCount)(long NewValue);
	STDMETHOD(get_Orchestra)(BSTR *pValue);
	STDMETHOD(put_Orchestra)(BSTR Value);
	STDMETHOD(RemoveAll)(void);
	STDMETHOD(RemoveCommand)(void);
	STDMETHOD(RemoveOrchestra)(void);
	STDMETHOD(RemoveScore)(void);
	STDMETHOD(RemoveScoreExceptFunctions)(void);
	STDMETHOD(InitNew)();
	STDMETHOD(IsDirty)();
	STDMETHOD(GetSizeMax)(ULARGE_INTEGER FAR* pcbSize);
	STDMETHOD(Load)(LPSTREAM pStream);
	STDMETHOD(Save)(LPSTREAM pStream, BOOL fClearDirty);
	STDMETHOD(InitFromData)(IDataObject *pDataObject, BOOL fCreation, DWORD dwReserved); 
	STDMETHOD(Help)(LPCOLESTR pszHelpDir);
	STDMETHOD(SetObjectRects)(LPCRECT prcPos,LPCRECT prcClip);
	STDMETHOD(GetViewStatus)(DWORD* pdwStatus);
	STDMETHOD(TranslateAccelerator)(MSG *pMsg);
	STDMETHOD(UpdateView)();
	LRESULT OnMouseActivate(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL &bHandled);
	LRESULT OnOpen(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled);
	LRESULT OnSave(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled);
	LRESULT OnSaveAs(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnImport(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled);
	LRESULT OnProperties(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled);
	LRESULT OnPlayOrStop(int idCtrl, LPNMHDR pnmh, BOOL& bHandled);
	LRESULT OnOpenSound(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL &bHandled);
	LRESULT OnSelchangeTabs(int idCtrl, LPNMHDR pnmh, BOOL& bHandled);
	LRESULT OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
	LRESULT OnChangeCommand(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnChangeOrchestra(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnClearScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnClearNotesOnly(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnChangeScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
	LRESULT OnUpdateScore(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled);
// IViewObjectEx
	DECLARE_VIEW_STATUS(0)
protected:
	HWND tabsWindow;
	unsigned int renderingThread;
	Csound csound;
	CsoundFile csoundFile;
	std::string helpFilename;
// IAXCsound
public:
	void updateModel();
	void updateView();
	enum
	{
		COMMAND_TAB = 0,
		ORCHESTRA_TAB,
		SCORE_TAB,
		COPYRIGHT_TAB,
	};
	CCopyrightDialog copyrightDialog;
	CScoreDialog scoreDialog;
	COrchestraDialog orchestraDialog;
	CCommandDialog commandDialog;
	CComBSTR m_bstrCaption;
	enum 
	{ 
		IDD = IDD_AXCSOUND 
	};
};

#endif //__AXCsound_H_
