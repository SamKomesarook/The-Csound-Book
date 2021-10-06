// DlgProxy.cpp : implementation file
//

#include "stdafx.h"
#include "AXCsoundExe.h"
#include "DlgProxy.h"
#include "AXCsoundExeDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAXCsoundExeDlgAutoProxy

IMPLEMENT_DYNCREATE(CAXCsoundExeDlgAutoProxy, CCmdTarget)

CAXCsoundExeDlgAutoProxy::CAXCsoundExeDlgAutoProxy()
{
	EnableAutomation();
	
	// To keep the application running as long as an OLE automation 
	//	object is active, the constructor calls AfxOleLockApp.
	AfxOleLockApp();

	// Get access to the dialog through the application's
	//  main window pointer.  Set the proxy's internal pointer
	//  to point to the dialog, and set the dialog's back pointer to
	//  this proxy.
	ASSERT (AfxGetApp()->m_pMainWnd != NULL);
	ASSERT_VALID (AfxGetApp()->m_pMainWnd);
	ASSERT_KINDOF(CAXCsoundExeDlg, AfxGetApp()->m_pMainWnd);
	m_pDialog = (CAXCsoundExeDlg*) AfxGetApp()->m_pMainWnd;
	m_pDialog->m_pAutoProxy = this;
}

CAXCsoundExeDlgAutoProxy::~CAXCsoundExeDlgAutoProxy()
{
	// To terminate the application when all objects created with
	// 	with OLE automation, the destructor calls AfxOleUnlockApp.
	//  Among other things, this will destroy the main dialog
	AfxOleUnlockApp();
}

void CAXCsoundExeDlgAutoProxy::OnFinalRelease()
{
	// When the last reference for an automation object is released
	// OnFinalRelease is called.  The base class will automatically
	// deletes the object.  Add additional cleanup required for your
	// object before calling the base class.

	CCmdTarget::OnFinalRelease();
}

BEGIN_MESSAGE_MAP(CAXCsoundExeDlgAutoProxy, CCmdTarget)
	//{{AFX_MSG_MAP(CAXCsoundExeDlgAutoProxy)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BEGIN_DISPATCH_MAP(CAXCsoundExeDlgAutoProxy, CCmdTarget)
	//{{AFX_DISPATCH_MAP(CAXCsoundExeDlgAutoProxy)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_DISPATCH_MAP
END_DISPATCH_MAP()

// Note: we add support for IID_IAXCsoundExe to support typesafe binding
//  from VBA.  This IID must match the GUID that is attached to the 
//  dispinterface in the .ODL file.

// {018CD130-20DE-11D2-917D-00A0CC30C276}
static const IID IID_IAXCsoundExe =
{ 0x18cd130, 0x20de, 0x11d2, { 0x91, 0x7d, 0x0, 0xa0, 0xcc, 0x30, 0xc2, 0x76 } };

BEGIN_INTERFACE_MAP(CAXCsoundExeDlgAutoProxy, CCmdTarget)
	INTERFACE_PART(CAXCsoundExeDlgAutoProxy, IID_IAXCsoundExe, Dispatch)
END_INTERFACE_MAP()

// The IMPLEMENT_OLECREATE2 macro is defined in StdAfx.h of this project
// {018CD12E-20DE-11D2-917D-00A0CC30C276}
IMPLEMENT_OLECREATE2(CAXCsoundExeDlgAutoProxy, "AXCsoundExe.Application", 0x18cd12e, 0x20de, 0x11d2, 0x91, 0x7d, 0x0, 0xa0, 0xcc, 0x30, 0xc2, 0x76)

/////////////////////////////////////////////////////////////////////////////
// CAXCsoundExeDlgAutoProxy message handlers
