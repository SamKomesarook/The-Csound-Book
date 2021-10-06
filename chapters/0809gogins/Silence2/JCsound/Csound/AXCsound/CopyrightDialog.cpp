#include "stdafx.h"
#include "CopyrightDialog.h"

/////////////////////////////////////////////////////////////////////////////
// CCopyrightDialog

CCopyrightDialog::CCopyrightDialog()
{
}

CCopyrightDialog::~CCopyrightDialog()
{
}

LRESULT CCopyrightDialog::OnInitDialog(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	SetDlgItemText(IDC_EDIT_COPYRIGHT,
		_T(
		"AXCsound ActiveX custom control for Csound is copyright (c) 1998 by Michael Gogins. "
		"All rights reserved. "
		"AXCsound is licensed under the terms of the GNU General Public License (see below).\r\n\r\n"
		"Csound is copyright 1986, 1992 by the Massachusetts Institute of Technology. "
		"All rights reserved\r\n\r\n"
		"Developed by Barry L. Vercoe at the Experimental Music Studio, Media Laboratory, "
		"M.I.T., Cambridge, Massachusetts, with partial support from the System Development Foundation "
		"and from National Science Foundation Grant # IRI-8704665.\r\n\r\n"
		"Permission to use, copy, or modify these programs and their documentation "
		"for educational and research purposes only and without fee is hereby granted, "
		"provided that this copyright and permission notice appear on all copies "
		"and supporting documentation. "
		"For any other uses of this software, in original or modified form, "
		"including but not limited to distribution in whole or in part, "
		"specific prior permission from M.I.T. must be obtained. "
		"M.I.T. makes no representations about the suitability of this software for any purpose. "
		"It is provided \"as is\" without express or implied warranty.\r\n\r\n"
		"Part of the Csound code was developed by an independent group of programmers, "
		"composers and scientists. Copyright to this code is held by the respective authors. "
		"The following people have contributed code to this version of Csound:\r\n\r\n"
		"John ffitch\r\n"
		"Paris Smaragdis\r\n"
		"Richard Karpen\r\n"
		"Gabriel Maldonado\r\n"
		"Greg Sullivan\r\n"
		"Michael Clark\r\n"
		"Allan Lee\r\n"
		"Michael Casey\r\n"
		"Marc Resibois\r\n"
		"Robin Whittle\r\n"
		"Matt Ingals\r\n "
		"Mike Berry\r\n"
		"Eli Breder\r\n"
		"David Macintyre\r\n"
		"Dan Ellis\r\n"
		"Richard Dobson\r\n\r\n"
		"Special thanks to Gabriel Maldonado for his MIDI and DirectSound code.\r\n\r\n"
		"This program is free software; you can redistribute it and/or \r\n"
		"modify it under the terms of the GNU General Public License \r\n"
		"as published by the Free Software Foundation; either version 2 \r\n"
		"of the License, or (at your option) any later version. \r\n"
		"This program is distributed in the hope that it will be useful, \r\n"
		"but WITHOUT ANY WARRANTY; without even the implied warranty of \r\n"
		"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the \r\n"
		"GNU General Public License for more details. \r\n"
		"You should have received a copy of the GNU General Public License \r\n"
		"along with this program; if not, write to the Free Software \r\n"
		"Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. \r\n"
		));
	return 1;  // Let the system set the focus
}

LRESULT CCopyrightDialog::OnOK(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	EndDialog(wID);
	return 0;
}

LRESULT CCopyrightDialog::OnCancel(WORD wNotifyCode, WORD wID, HWND hWndCtl, BOOL& bHandled)
{
	EndDialog(wID);
	return 0;
}

