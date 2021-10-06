// DlgProxy.h : header file
//

#if !defined(AFX_DLGPROXY_H__018CD137_20DE_11D2_917D_00A0CC30C276__INCLUDED_)
#define AFX_DLGPROXY_H__018CD137_20DE_11D2_917D_00A0CC30C276__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CAXCsoundExeDlg;

/////////////////////////////////////////////////////////////////////////////
// CAXCsoundExeDlgAutoProxy command target

class CAXCsoundExeDlgAutoProxy : public CCmdTarget
{
	DECLARE_DYNCREATE(CAXCsoundExeDlgAutoProxy)

	CAXCsoundExeDlgAutoProxy();           // protected constructor used by dynamic creation

// Attributes
public:
	CAXCsoundExeDlg* m_pDialog;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAXCsoundExeDlgAutoProxy)
	public:
	virtual void OnFinalRelease();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~CAXCsoundExeDlgAutoProxy();

	// Generated message map functions
	//{{AFX_MSG(CAXCsoundExeDlgAutoProxy)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
	DECLARE_OLECREATE(CAXCsoundExeDlgAutoProxy)

	// Generated OLE dispatch map functions
	//{{AFX_DISPATCH(CAXCsoundExeDlgAutoProxy)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_DISPATCH
	DECLARE_DISPATCH_MAP()
	DECLARE_INTERFACE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGPROXY_H__018CD137_20DE_11D2_917D_00A0CC30C276__INCLUDED_)
