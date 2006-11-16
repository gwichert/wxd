//-----------------------------------------------------------------------------
// wx.NET - dirdialog.cxx
// 
// The wxDirDialog proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/dirdlg.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _DirDialog : public wxDirDialog
{
public:
    _DirDialog(wxWindow* parent, const wxString& message, 
            const wxString& defaultPath, int style, const wxPoint& pos,
            const wxSize& size, const wxString& name)
        : wxDirDialog(parent, message, defaultPath, style, pos, size, name)
    {
    }

    DECLARE_OBJECTDELETED(_DirDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDirDialog* wxDirDialog_ctor(wxWindow* parent,  char* message, 
                              char* defaultPath, int style, wxPoint* pos, 
                              wxSize* size, char* name)
{
    return new _DirDialog(parent, wxString(message, wxConvUTF8), 
                          wxString(defaultPath, wxConvUTF8), style, *pos, 
                          *size, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDirDialog_GetStyle(wxDirDialog* self)
{
    return self->GetStyle();
}

extern "C" WXEXPORT
void wxDirDialog_SetStyle(wxDirDialog* self, int style)
{
    self->SetStyle(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDirDialog_SetMessage(wxDirDialog* self, char* message)
{
    self->SetMessage(wxString(message, wxConvUTF8));
}

extern "C" WXEXPORT
wxString* wxDirDialog_GetMessage(wxDirDialog* self)
{
    return new wxString(self->GetMessage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDirDialog_ShowModal(wxDirDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDirDialog_SetPath(wxDirDialog* self, char* path)
{
    self->SetPath(wxString(path, wxConvUTF8));
}

extern "C" WXEXPORT
wxString* wxDirDialog_GetPath(wxDirDialog* self)
{
    return new wxString(self->GetPath());
}

