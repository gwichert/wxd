//-----------------------------------------------------------------------------
// wxD - filedialog.cxx
// (C) 2005 bero <berobero.sourceforge.net>
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
dstr wxFileDialog_GetDirectory(wxFileDialog* self)
{
    return dstr(self->GetDirectory());
}

extern "C" WXEXPORT
void wxFileDialog_SetDirectory(wxFileDialog* self, dstr dir)
{
    self->SetDirectory(wxString(dir.data, wxConvUTF8, dir.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFileDialog_GetFilename(wxFileDialog* self)
{
    return dstr(self->GetFilename());
}

extern "C" WXEXPORT
void wxFileDialog_SetFilename(wxFileDialog* self, dstr filename)
{
    self->SetFilename(wxString(filename.data, wxConvUTF8, filename.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFileDialog_GetPath(wxFileDialog* self)
{
    return dstr(self->GetPath());
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
dstr wxFileDialog_GetMessage(wxFileDialog *self)
{
    return dstr(self->GetMessage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxFileDialog_GetWildcard(wxFileDialog* self)
{
    return dstr(self->GetWildcard());
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
dstr wxFileSelector_func(const char *message,
               const char *default_path,
               const char *default_filename,
               const char *default_extension,
               const char *wildcard,
               int flags,
               wxWindow *parent,
               int x, int y)
{
	if (message ==NULL) message =wxFileSelectorPromptStr;
	if (wildcard==NULL) wildcard=wxFileSelectorDefaultWildcardStr;
	return dstr(wxFileSelector(message,default_path,default_filename,default_extension,wildcard,
			flags,parent,x,y));
}

extern "C" WXEXPORT
dstr wxFileSelectorEx_func(const char *message,
               const char *default_path,
               const char *default_filename,
               int *indexDefaultExtension,
               const char *wildcard,
               int flags,
               wxWindow *parent,
               int x, int y)
{
	if (message ==NULL) message  = wxFileSelectorPromptStr;
	if (wildcard==NULL) wildcard = wxFileSelectorDefaultWildcardStr;
	return dstr(wxFileSelectorEx(message,default_path,default_filename,indexDefaultExtension,wildcard,
			flags,parent,x,y));
}
	
	
// Ask for filename to load
extern "C" WXEXPORT
dstr wxLoadFileSelector_func(const char *what,
                   const char *extension,
                   const char *default_name,
                   wxWindow *parent)
{
	return dstr(wxLoadFileSelector(what,extension,default_name,parent));
}

// Ask for filename to save
extern "C" WXEXPORT
dstr wxSaveFileSelector_func(const char *what,
                   const char *extension,
                   const char *default_name,
                   wxWindow *parent)
{
	return dstr(wxSaveFileSelector(what,extension,default_name,parent));
}
