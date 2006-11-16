//-----------------------------------------------------------------------------
// wx.NET - textdialog.cxx
//
// The wxTextEntryDialog proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/textdlg.h>
#include "local_events.h"

class _TextEntryDialog : public wxTextEntryDialog
{
    public:
        _TextEntryDialog(wxWindow* parent, const wxString message,
                const wxString& caption, const wxString& value,
                long style, const wxPoint& pos)
            : wxTextEntryDialog(parent, message, caption, value, style, pos)
        {
        }

        DECLARE_OBJECTDELETED(_TextEntryDialog)
};


//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextEntryDialog* wxTextEntryDialog_ctor(wxWindow* parent, char* message,
        char* caption, char* value, int style, wxPoint* pos)
{
    return new _TextEntryDialog(parent, wxString(message, wxConvUTF8),
            wxString(caption, wxConvUTF8),
            wxString(value, wxConvUTF8), style, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextEntryDialog_dtor(wxTextEntryDialog* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextEntryDialog_ShowModal(wxTextEntryDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextEntryDialog_SetValue(wxTextEntryDialog* self, char* val)
{
    self->SetValue(wxString(val, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxTextEntryDialog_GetValue(wxTextEntryDialog* self)
{
    return new wxString(self->GetValue());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGetPasswordFromUser_func(char* message, char* caption,
                                     char* defaultValue, wxWindow* parent)
{
    return new wxString(wxGetPasswordFromUser(wxString(message, wxConvUTF8),
                        wxString(caption, wxConvUTF8),
                        wxString(defaultValue, wxConvUTF8),
                        parent));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGetTextFromUser_func(char* message, char* caption,
                                 char* defaultValue, wxWindow* parent,
                                 int x, int y, bool centre)
{
    return new wxString(wxGetTextFromUser(wxString(message, wxConvUTF8),
                        wxString(caption, wxConvUTF8),
                        wxString(defaultValue, wxConvUTF8),
                        parent, x, y, centre));
}



