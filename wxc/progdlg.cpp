//-----------------------------------------------------------------------------
// wx.NET - progdlg.cxx
//
// The wxProgressDialog proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/progdlg.h>
#include "local_events.h"

class _ProgressDialog : public wxProgressDialog
{
    public:
        _ProgressDialog(const wxString title, const wxString& message,
			int maximum, wxWindow* parent, int style)
            : wxProgressDialog(title, message, maximum, parent, style)
        {
        }

        DECLARE_OBJECTDELETED(_ProgressDialog)
};


//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxProgressDialog* wxProgressDialog_ctor(const char* title, const char* message,
        int maximum, wxWindow* parent, int style)
{
    return new _ProgressDialog(wxString(title, wxConvUTF8), wxString(message, wxConvUTF8),
            maximum, parent, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxProgressDialog_dtor(wxProgressDialog* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxProgressDialog_Update(wxProgressDialog* self, int value, const char* newmsg)
{
    return self->Update(value, wxString(newmsg, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxProgressDialog_Resume(wxProgressDialog* self)
{
    self->Resume();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxProgressDialog_Show(wxProgressDialog* self, bool show)
{
	return self->Show(show)?1:0;
}


