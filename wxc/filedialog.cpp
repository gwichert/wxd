//-----------------------------------------------------------------------------
// wxD - filedialog.cpp
// (C) 2005 bero <berobero@users.sourceforge.net>
// (C) 2005 afb <afb@users.sourceforge.net>
// based on
// wx.NET - filedialog.cxx
//
// The wxFileDialog proxy interface.
//
// Written by Achim Breunig (Achim.Breunig@web.de)
// (C) 2003 by Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/filedlg.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _FileDialog : public wxFileDialog
{
public:
        _FileDialog(wxWindow* parent, const wxString message, 
            const wxString& defaultDir, const wxString& defaultFile, 
            const wxString& wildcard, long style, const wxPoint& pos)
        : wxFileDialog(parent, message, defaultDir, defaultFile, wildcard, style, pos)
    {
    }

    DECLARE_OBJECTDELETED(_FileDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFileDialog* wxFileDialog_ctor(wxWindow* parent, dstr message, 
            dstr defaultDir, dstr defaultFile, 
            dstr wildcard, long style, const wxPoint* pos)
{
    return new _FileDialog(parent, wxstr(message), 
                           wxstr(defaultDir), 
                           wxstr(defaultFile), 
                           wxstr(wildcard), style, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDialog_dtor(wxFileDialog* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFileDialog_ShowModal(wxFileDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFileDialog_GetDirectory(wxFileDialog* self)
{
    return dstr_ret(self->GetDirectory());
}

extern "C" WXEXPORT
void wxFileDialog_SetDirectory(wxFileDialog* self, dstr dir)
{
    self->SetDirectory(wxstr(dir));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFileDialog_GetFilename(wxFileDialog* self)
{
    return dstr_ret(self->GetFilename());
}

extern "C" WXEXPORT
void wxFileDialog_SetFilename(wxFileDialog* self, dstr filename)
{
    self->SetFilename(wxstr(filename));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFileDialog_GetPath(wxFileDialog* self)
{
    return dstr_ret(self->GetPath());
}

extern "C" WXEXPORT
void wxFileDialog_SetPath(wxFileDialog* self, dstr path)
{
    self->SetPath(wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDialog_SetFilterIndex(wxFileDialog *self, int filterindex)
{
    self->SetFilterIndex(filterindex);
}

extern "C" WXEXPORT
int wxFileDialog_GetFilterIndex(wxFileDialog *self)
{
    return self->GetFilterIndex();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDialog_SetMessage(wxFileDialog *self, dstr message)
{
    self->SetMessage(wxstr(message));
}

extern "C" WXEXPORT
dstrret wxFileDialog_GetMessage(wxFileDialog *self)
{
    return dstr_ret(self->GetMessage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFileDialog_GetWildcard(wxFileDialog* self)
{
    return dstr_ret(self->GetWildcard());
}

extern "C" WXEXPORT
void wxFileDialog_SetWildcard(wxFileDialog* self, dstr wildcard)
{
    self->SetWildcard(wxstr(wildcard));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDialog_SetStyle(wxFileDialog *self, int style)
{
#if wxABI_VERSION < 20700
    self->SetStyle(style);
#endif
}

extern "C" WXEXPORT
int wxFileDialog_GetStyle(wxFileDialog *self)
{
#if wxABI_VERSION < 20700
    return self->GetStyle();
#else
    return wxDEFAULT_DIALOG_STYLE;
#endif
}

//-----------------------------------------------------------------------------
extern "C" WXEXPORT
wxArrayString* wxFileDialog_GetPaths(wxFileDialog* self)
{
	wxArrayString* wai = new wxArrayString();
	self->GetPaths(*wai);
	return wai;
}

//-----------------------------------------------------------------------------
extern "C" WXEXPORT
wxArrayString* wxFileDialog_GetFilenames(wxFileDialog* self)
{
    wxArrayString* wai = new wxArrayString();
    self->GetFilenames(*wai);
    return wai;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFileSelector_func(dstr message,
               dstr default_path,
               dstr default_filename,
               dstr default_extension,
               dstr wildcard,
               int flags,
               wxWindow *parent,
               int x, int y)
{
	wxString wxmessage, wxwildcard;
	if (message.data==NULL)
		wxmessage = wxString(wxFileSelectorPromptStr);
	else
		wxmessage = wxstr(message);
	if (wildcard.data==NULL)
		wxwildcard = wxString(wxFileSelectorDefaultWildcardStr);
	else
		wxwildcard = wxstr(wildcard);
	return dstr_ret(wxFileSelector(wxmessage,
	    wxstr(default_path),
	    wxstr(default_filename),
	    wxstr(default_extension),
	    wxwildcard,
	    flags, parent, x, y));
}

extern "C" WXEXPORT
dstrret wxFileSelectorEx_func(dstr message,
               dstr default_path,
               dstr default_filename,
               int *indexDefaultExtension,
               dstr wildcard,
               int flags,
               wxWindow *parent,
               int x, int y)
{
	wxString wxmessage, wxwildcard;
	if (message.data==NULL)
		wxmessage = wxString(wxFileSelectorPromptStr);
	else
		wxmessage = wxstr(message);
	if (wildcard.data==NULL)
		wxwildcard = wxString(wxFileSelectorDefaultWildcardStr);
	else
		wxwildcard = wxstr(wildcard);
	return dstr_ret(wxFileSelectorEx(wxmessage,
	    wxstr(default_path),
	    wxstr(default_filename),
	    indexDefaultExtension,
	    wxwildcard,
	    flags, parent, x, y));
}
	
	
// Ask for filename to load
extern "C" WXEXPORT
dstrret wxLoadFileSelector_func(dstr what,
                   dstr extension,
                   dstr default_name,
                   wxWindow *parent)
{
	return dstr_ret(wxLoadFileSelector(wxstr(what),
	    wxstr(extension),
	    wxstr(default_name),
	    parent));
}

// Ask for filename to save
extern "C" WXEXPORT
dstrret wxSaveFileSelector_func(dstr what,
                   dstr extension,
                   dstr default_name,
                   wxWindow *parent)
{
	return dstr_ret(wxSaveFileSelector(wxstr(what),
	    wxstr(extension),
	    wxstr(default_name),
	    parent));
}
