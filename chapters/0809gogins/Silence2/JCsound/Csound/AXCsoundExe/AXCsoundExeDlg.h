// AXCsoundExeDlg.h : header file
//
//{{AFX_INCLUDES()
#include "axcsoundproxy.h"
//}}AFX_INCLUDES

#if !defined(AFX_AXCSOUNDEXEDLG_H__018CD135_20DE_11D2_917D_00A0CC30C276__INCLUDED_)
#define AFX_AXCSOUNDEXEDLG_H__018CD135_20DE_11D2_917D_00A0CC30C276__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CAXCsoundExeDlgAutoProxy;

/////////////////////////////////////////////////////////////////////////////
// CAXCsoundExeDlg dialog

class CAXCsoundExeDlg : public CDialog
{
	DECLARE_DYNAMIC(CAXCsoundExeDlg);
	friend class CAXCsoundExeDlgAutoProxy;

// Construction
public:
	CAXCsoundExeDlg(CWnd* pParent = NULL);	// standard constructor
	virtual ~CAXCsoundExeDlg();

// Dialog Data
	//{{AFX_DATA(CAXCsoundExeDlg)
	enum { IDD = IDD_AXCSOUNDEXE_DIALOG };
	CAXCsoundProxy	m_Csound;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAXCsoundExeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CAXCsoundExeDlgAutoProxy* m_pAutoProxy;
	HICON m_hIcon;

	BOOL CanExit();

	// Generated message map functions
	//{{AFX_MSG(CAXCsoundExeDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnClose();
	virtual void OnOK();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_AXCSOUNDEXEDLG_H__018CD135_20DE_11D2_917D_00A0CC30C276__INCLUDED_)
