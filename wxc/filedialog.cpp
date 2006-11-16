//-----------------------------------------------------------------------------
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
wxFileDialog* wxFileDialog_ctor(wxWindow* parent, const char* message, 
            const char* defaultDir, const char* defaultFile, 
            const char* wildcard, long style, const wxPoint* pos)
{
    return new _FileDialog(parent, wxString(message, wxConvUTF8), 
                           wxString(defaultDir, wxConvUTF8), 
                           wxString(defaultFile, wxConvUTF8), 
                           wxString(wildcard, wxConvUTF8), style, *pos);
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
wxString* wxFileDialog_GetDirectory(wxFileDialog* self)
{
    return new wxString(self->GetDirectory());
}

extern "C" WXEXPORT
void wxFileDialog_SetDirectory(wxFileDialog* self, const char* dir)
{
    self->SetDirectory(wxString(dir, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFileDialog_GetFilename(wxFileDialog* self)
{
    return new wxString(self->GetFilename());
}

extern "C" WXEXPORT
void wxFileDialog_SetFilename(wxFileDialog* self, const char* filename)
{
    self->SetFilename(wxString(filename, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFileDialog_GetPath(wxFileDialog* self)
{
    return new wxString(self->GetPath());
}

extern "C" WXEXPORT
void wxFileDialog_SetPath(wxFileDialog* self, const char* path)
{
    self->SetPath(wxString(path, wxConvUTF8));
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
void wxFileDialog_SetMessage(wxFileDialog *self, char* message)
{
    self->SetMessage(wxString(message, wxConvUTF8));
}

extern "C" WXEXPORT
wxString* wxFileDialog_GetMessage(wxFileDialog *self)
{
    return new wxString(self->GetMessage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFileDialog_GetWildcard(wxFileDialog* self)
{
    return new wxString(self->GetWildcard());
}

extern "C" WXEXPORT
void wxFileDialog_SetWildcard(wxFileDialog* self, const char* wildcard)
{
    self->SetWildcard(wxString(wildcard, wxConvUTF8));
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


