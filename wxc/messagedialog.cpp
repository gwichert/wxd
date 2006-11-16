//-----------------------------------------------------------------------------
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
#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMsgBox(wxWindow* parent, const char* msg, const char* cap, int style, const wxPoint* pos)
{
	return wxMessageBox(wxString(msg, wxConvUTF8), wxString(cap, wxConvUTF8), style, parent, pos->x, pos->y);
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
wxMessageDialog* wxMessageDialog_ctor(wxWindow *parent, const char* message, const char* caption, int style, const wxPoint* pos)
{
    wxString cptn;
	if (caption == NULL)
        cptn = wxMessageBoxCaptionStr;
    else 
        cptn = wxString(caption, wxConvUTF8);

	if (pos == NULL)
		pos = &wxDefaultPosition;

	return new _MessageDialog(parent, wxString(message, wxConvUTF8), cptn, style, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMessageDialog_ShowModal(wxMessageDialog* self)
{
	return self->ShowModal();
}

//-----------------------------------------------------------------------------

