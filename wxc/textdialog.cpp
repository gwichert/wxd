//-----------------------------------------------------------------------------
// wxD - textdialog.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
wxTextEntryDialog* wxTextEntryDialog_ctor(wxWindow* parent, dstr message,
        dstr caption, dstr value, int style, wxPoint* pos)
{
    return new _TextEntryDialog(parent, wxString(message.data, wxConvUTF8, message.length),
            wxString(caption.data, wxConvUTF8, caption.length),
            wxString(value.data, wxConvUTF8, value.length), style, *pos);
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
void wxTextEntryDialog_SetValue(wxTextEntryDialog* self, dstr val)
{
    self->SetValue(wxString(val.data, wxConvUTF8, val.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxTextEntryDialog_GetValue(wxTextEntryDialog* self)
{
    return dstr(self->GetValue());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxGetPasswordFromUser_func(dstr message, dstr caption,
                                     dstr defaultValue, wxWindow* parent)
{
    return dstr(wxGetPasswordFromUser(wxString(message.data, wxConvUTF8, message.length),
                        wxString(caption.data, wxConvUTF8, caption.length),
                        wxString(defaultValue.data, wxConvUTF8, defaultValue.length),
                        parent));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxGetTextFromUser_func(dstr message, dstr caption,
                                 dstr defaultValue, wxWindow* parent,
                                 int x, int y, bool centre)
{
    return dstr(wxGetTextFromUser(wxString(message.data, wxConvUTF8, message.length),
                        wxString(caption.data, wxConvUTF8, caption.length),
                        wxString(defaultValue.data, wxConvUTF8, defaultValue.length),
                        parent, x, y, centre));
}



