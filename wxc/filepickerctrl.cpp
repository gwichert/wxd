//-----------------------------------------------------------------------------
// wxD - filepickerctrl.cpp
//
// The wxFilePickerCtrl proxy interface.
//
// Written by Gerrit Wichert (gwichert@yahoo.com)
// (C) 2013 by Gerrit Wichert
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/filepicker.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _FilePickerCtrl : public wxFilePickerCtrl
{
public:
    DECLARE_OBJECTDELETED(_FilePickerCtrl);
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFilePickerCtrl* wxFilePickerCtrl_ctor()
{
	return new _FilePickerCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxFilePickerCtrl_Create(
  wxFilePickerCtrl* self, wxWindow *parent, wxWindowID id, wxc_string path, wxc_string message, wxc_string wildcard, const wxPoint *pos, const wxSize *size, long style, const wxValidator* validator, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	return self->Create(parent, id, wxstr(path), wxstr(message), wxstr(wildcard), *pos, *size, style, *validator, wxstr(name)) ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxFilePickerCtrl_GetPath( wxFilePickerCtrl* self)
{
    return new wxString( self->GetPath().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFilePickerCtrl_SetPath( wxFilePickerCtrl* self, wxc_string filename)
{
    self->SetPath(filename);
}





class _DirPickerCtrl : public wxDirPickerCtrl
{
public:
    DECLARE_OBJECTDELETED( _DirPickerCtrl );
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDirPickerCtrl* wxDirPickerCtrl_ctor()
{
	return new _DirPickerCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxDirPickerCtrl_Create(
  wxDirPickerCtrl* self, wxWindow *parent, wxWindowID id, wxc_string path, wxc_string message, const wxPoint *pos, const wxSize *size, long style, const wxValidator* validator, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	return self->Create(parent, id, wxstr(path), wxstr(message), *pos, *size, style, *validator, wxstr(name)) ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxDirPickerCtrl_GetPath( wxDirPickerCtrl* self)
{
    return new wxString( self->GetPath().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDirPickerCtrl_SetPath( wxDirPickerCtrl* self, wxc_string dirname)
{
    self->SetPath(dirname);
}

