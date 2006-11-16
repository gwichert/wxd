//-----------------------------------------------------------------------------
// wxD - messagedialog.cxx
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
int wxMessageBox_func(dstr msg, dstr cap, int style, wxWindow* parent,int x, int y)
{
	return wxMessageBox(wxString(msg.data, wxConvUTF8, msg.length), wxString(cap.data, wxConvUTF8, cap.length), style, parent, x, y);
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
wxMessageDialog* wxMessageDialog_ctor(wxWindow *parent, dstr message, dstr caption, int style, const wxPoint* pos)
{
    wxString cptn;
	if (caption.data == NULL)
        cptn = wxMessageBoxCaptionStr;
    else 
        cptn = wxString(caption.data, wxConvUTF8, caption.length);

	if (pos == NULL)
		pos = &wxDefaultPosition;

	return new _MessageDialog(parent, wxString(message.data, wxConvUTF8, message.length), cptn, style, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMessageDialog_ShowModal(wxMessageDialog* self)
{
	return self->ShowModal();
}

//-----------------------------------------------------------------------------

