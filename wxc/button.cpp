//-----------------------------------------------------------------------------
// wxD - button.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - button.cxx
//
// The wxButton proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/button.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Button : public wxButton
{
public:
    DECLARE_OBJECTDELETED(_Button)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxButton* wxButton_ctor()
{
	return new _Button();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxButton_Create(wxButton *self, wxWindow* parent, wxWindowID id, dstr label, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("button");

	return self->Create(parent, id, wxString(label.data, wxConvUTF8, label.length), *pos, *size, style, *validator, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxButton_SetDefault(wxButton* self)
{
	self->SetDefault();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxButton_GetDefaultSize(wxSize* size)
{
	*size = wxButton::GetDefaultSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxButton_SetImageLabel(wxButton* self, wxBitmap* bitmap)
{
	self->SetImageLabel(*bitmap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxButton_SetImageMargins(wxButton* self, wxCoord x, wxCoord y)
{
	self->SetImageMargins(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxButton_SetLabel(wxButton* self, dstr label)
{
	self->SetLabel(wxString(label.data, wxConvUTF8, label.length));
}


