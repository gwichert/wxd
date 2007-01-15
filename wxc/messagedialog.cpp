//-----------------------------------------------------------------------------
// wxD - messagedialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - messagedialog.cxx
//
// The wxMessageDialog proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMessageBox_func(wxc_string msg, wxc_string cap, int style, wxWindow* parent,int x, int y)
{
	return wxMessageBox(wxstr(msg), wxstr(cap), style, parent, x, y);
}

//-----------------------------------------------------------------------------

class _MessageDialog : public wxMessageDialog
{
public:
    _MessageDialog(wxWindow* parent, const wxString& message, const wxString& caption, int style, const wxPoint& pos)
        : wxMessageDialog(parent, message, caption, style, pos)
    {
    }

    DECLARE_OBJECTDELETED(_MessageDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMessageDialog* wxMessageDialog_ctor(wxWindow *parent, wxc_string message, wxc_string caption, int style, const wxPoint* pos)
{
    wxString cptn;
	if (caption.data==NULL)
        cptn = wxMessageBoxCaptionStr;
    else 
        cptn = wxstr(caption);

	if (pos == NULL)
		pos = &wxDefaultPosition;

	return new _MessageDialog(parent, wxstr(message), cptn, style, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMessageDialog_ShowModal(wxMessageDialog* self)
{
	return self->ShowModal();
}

//-----------------------------------------------------------------------------

