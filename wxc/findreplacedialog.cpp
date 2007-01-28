//-----------------------------------------------------------------------------
// wxD - findreplacedialog.cpp
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
wxc_bool wxFindReplaceDialog_Create(wxFindReplaceDialog* self, wxWindow* parent, wxFindReplaceData* data, wxc_string title, int style)
{
    return self->Create(parent, data, wxstr(title), style);
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
wxString* wxFindDialogEvent_GetFindString(wxFindDialogEvent* self)
{
    return new wxString(self->GetFindString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFindDialogEvent_GetReplaceString(wxFindDialogEvent* self)
{
    return new wxString(self->GetReplaceString());
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
void wxFindDialogEvent_SetFindString(wxFindDialogEvent* self, wxc_string str)
{
    self->SetFindString(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindDialogEvent_SetReplaceString(wxFindDialogEvent* self, wxc_string str)
{
    self->SetReplaceString(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFindReplaceData* wxFindReplaceData_ctor()
{
    return new wxFindReplaceData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFindReplaceData_GetFindString(wxFindReplaceData* self)
{
    return new wxString(self->GetFindString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFindReplaceData_GetReplaceString(wxFindReplaceData* self)
{
    return new wxString(self->GetReplaceString());
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
void wxFindReplaceData_SetFindString(wxFindReplaceData* self, wxc_string str)
{
    self->SetFindString(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFindReplaceData_SetReplaceString(wxFindReplaceData* self, wxc_string str)
{
    self->SetReplaceString(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_FIND()                  { return wxEVT_COMMAND_FIND; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_FIND_NEXT()             { return wxEVT_COMMAND_FIND_NEXT; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_FIND_REPLACE()          { return wxEVT_COMMAND_FIND_REPLACE; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_FIND_REPLACE_ALL()      { return wxEVT_COMMAND_FIND_REPLACE_ALL; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_FIND_CLOSE()            { return wxEVT_COMMAND_FIND_CLOSE; }

