//-----------------------------------------------------------------------------
// wxD - filedialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// (C) 2005 afb <afb.sourceforge.net>
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
    return new _FileDialog(parent, wxString(message.data, wxConvUTF8, message.length), 
                           wxString(defaultDir.data, wxConvUTF8, defaultDir.length), 
                           wxString(defaultFile.data, wxConvUTF8, defaultFile.length), 
                           wxString(wildcard.data, wxConvUTF8, wildcard.length), style, *pos);
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
    self->SetDirectory(wxString(dir.data, wxConvUTF8, dir.length));
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
    self->SetFilename(wxString(filename.data, wxConvUTF8, filename.length));
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
    self->SetPath(wxString(path.data, wxConvUTF8, path.length));
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
    self->SetMessage(wxString(message.data, wxConvUTF8, message.length));
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
    self->SetWildcard(wxString(wildcard.data, wxConvUTF8, wildcard.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDialog_SetStyle(wxFileDialog *self, int style)
{
    self->SetStyle(style);
}

extern "C" WXEXPORT
int wxFileDialog_GetStyle(wxFileDialog *self)
{
    return self->GetStyle();
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
		wxmessage = wxString(message.data, wxConvUTF8, message.length);
	if (wildcard.data==NULL)
		wxwildcard = wxString(wxFileSelectorDefaultWildcardStr);
	else
		wxwildcard = wxString(wildcard.data, wxConvUTF8, wildcard.length);
	return dstr_ret(wxFileSelector(wxmessage,
	    wxString(default_path.data, wxConvUTF8, default_path.length),
	    wxString(default_filename.data, wxConvUTF8, default_filename.length),
	    wxString(default_extension.data, wxConvUTF8, default_extension.length),
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
		wxmessage = wxString(message.data, wxConvUTF8, message.length);
	if (wildcard.data==NULL)
		wxwildcard = wxString(wxFileSelectorDefaultWildcardStr);
	else
		wxwildcard = wxString(wildcard.data, wxConvUTF8, wildcard.length);
	return dstr_ret(wxFileSelectorEx(wxmessage,
	    wxString(default_path.data, wxConvUTF8, default_path.length),
	    wxString(default_filename.data, wxConvUTF8, default_filename.length),
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
	return dstr_ret(wxLoadFileSelector(wxString(what.data, wxConvUTF8, what.length),
	    wxString(extension.data, wxConvUTF8, extension.length),
	    wxString(default_name.data, wxConvUTF8, default_name.length),
	    parent));
}

// Ask for filename to save
extern "C" WXEXPORT
dstrret wxSaveFileSelector_func(dstr what,
                   dstr extension,
                   dstr default_name,
                   wxWindow *parent)
{
	return dstr_ret(wxSaveFileSelector(wxString(what.data, wxConvUTF8, what.length),
	    wxString(extension.data, wxConvUTF8, extension.length),
	    wxString(default_name.data, wxConvUTF8, default_name.length),
	    parent));
}
