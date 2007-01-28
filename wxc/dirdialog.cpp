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
wxDirDialog* wxDirDialog_ctor(wxWindow* parent,  wxc_string message, 
                              wxc_string defaultPath, int style, wxPoint* pos, 
                              wxSize* size, wxc_string name)
{
    return new _DirDialog(parent, wxstr(message), 
                          wxstr(defaultPath), style, *pos, 
                          *size, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDirDialog_GetStyle(wxDirDialog* self)
{
#if wxABI_VERSION < 20700
    return self->GetStyle();
#else
    return wxDEFAULT_DIALOG_STYLE;
#endif
}

extern "C" WXEXPORT
void wxDirDialog_SetStyle(wxDirDialog* self, int style)
{
#if wxABI_VERSION < 20700
    self->SetStyle(style);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDirDialog_SetMessage(wxDirDialog* self, wxc_string message)
{
    self->SetMessage(wxstr(message));
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
void wxDirDialog_SetPath(wxDirDialog* self, wxc_string path)
{
    self->SetPath(wxstr(path));
}

extern "C" WXEXPORT
wxString* wxDirDialog_GetPath(wxDirDialog* self)
{
    return new wxString(self->GetPath());
}

extern "C" WXEXPORT
wxString* wxDirSelector_func(wxc_string message,
              wxc_string defaultPath,
              long style,
              wxPoint* pos,
              wxWindow *parent)
{
	return new wxString(wxDirSelector(
		message.length?wxstr(message):wxString(wxDirSelectorPromptStr),
		wxstr(defaultPath),
		style, 
		pos?*pos:wxDefaultPosition, 
		parent
	));
}
