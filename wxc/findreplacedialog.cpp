//-----------------------------------------------------------------------------
// wxD - findreplacedialog.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - findreplacedialog.cxx
//
// The wxFindReplaceDialog proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/fdrepdlg.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _FindReplaceDialog : public wxFindReplaceDialog
{
public:
    DECLARE_OBJECTDELETED(_FindReplaceDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindReplaceDialog* wxFindReplaceDialog_ctor()
{
    return new _FindReplaceDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFindReplaceDialog_Create(wxFindReplaceDialog* self, wxWindow* parent, wxFindReplaceData* data, dstr title, int style)
{
    return self->Create(parent, data, wxString(title.data, wxConvUTF8, title.length), style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindReplaceData* wxFindReplaceDialog_GetData(wxFindReplaceDialog* self)
{
    return (wxFindReplaceData*)self->GetData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindReplaceDialog_SetData(wxFindReplaceDialog* self, wxFindReplaceData* data)
{
    self->SetData(data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindDialogEvent* wxFindDialogEvent_ctor(wxEventType commandType, int id)
{
    return new wxFindDialogEvent(commandType, id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFindDialogEvent_GetFlags(wxFindDialogEvent* self)
{
    return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFindDialogEvent_GetFindString(wxFindDialogEvent* self)
{
    return dstr(self->GetFindString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFindDialogEvent_GetReplaceString(wxFindDialogEvent* self)
{
    return dstr(self->GetReplaceString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindReplaceDialog* wxFindDialogEvent_GetDialog(wxFindDialogEvent* self)
{
    return self->GetDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindDialogEvent_SetFlags(wxFindDialogEvent* self, int flags)
{
    self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindDialogEvent_SetFindString(wxFindDialogEvent* self, dstr str)
{
    self->SetFindString(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindDialogEvent_SetReplaceString(wxFindDialogEvent* self, dstr str)
{
    self->SetReplaceString(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindReplaceData* wxFindReplaceData_ctor()
{
    return new wxFindReplaceData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFindReplaceData_GetFindString(wxFindReplaceData* self)
{
    return dstr(self->GetFindString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFindReplaceData_GetReplaceString(wxFindReplaceData* self)
{
    return dstr(self->GetReplaceString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFindReplaceData_GetFlags(wxFindReplaceData* self)
{
    return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindReplaceData_SetFlags(wxFindReplaceData* self, wxUint32 flags)
{
    self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindReplaceData_SetFindString(wxFindReplaceData* self, dstr str)
{
    self->SetFindString(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindReplaceData_SetReplaceString(wxFindReplaceData* self, dstr str)
{
    self->SetReplaceString(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

