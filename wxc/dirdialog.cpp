//-----------------------------------------------------------------------------
// wxD - dirdialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
wxDirDialog* wxDirDialog_ctor(wxWindow* parent,  dstr message, 
                              dstr defaultPath, int style, wxPoint* pos, 
                              wxSize* size, dstr name)
{
    return new _DirDialog(parent, wxString(message.data, wxConvUTF8, message.length), 
                          wxString(defaultPath.data, wxConvUTF8, defaultPath.length), style, *pos, 
                          *size, wxString(name.data, wxConvUTF8, name.length));
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
void wxDirDialog_SetMessage(wxDirDialog* self, dstr message)
{
    self->SetMessage(wxString(message.data, wxConvUTF8, message.length));
}

extern "C" WXEXPORT
dstrret wxDirDialog_GetMessage(wxDirDialog* self)
{
    return dstr_ret(self->GetMessage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDirDialog_ShowModal(wxDirDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDirDialog_SetPath(wxDirDialog* self, dstr path)
{
    self->SetPath(wxString(path.data, wxConvUTF8, path.length));
}

extern "C" WXEXPORT
dstrret wxDirDialog_GetPath(wxDirDialog* self)
{
    return dstr_ret(self->GetPath());
}

extern "C" WXEXPORT
dstrret wxDirSelector_func(dstr message,
              dstr defaultPath,
              long style,
              wxPoint* pos,
              wxWindow *parent)
{
	return dstr_ret(wxDirSelector(
		message.length?wxString(message.data, wxConvUTF8, message.length):wxString(wxDirSelectorPromptStr),
		wxString(defaultPath.data, wxConvUTF8, defaultPath.length),
		style, 
		pos?*pos:wxDefaultPosition, 
		parent
	));
}
