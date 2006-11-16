//-----------------------------------------------------------------------------
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
bool wxButton_Create(wxButton *self, wxWindow* parent, wxWindowID id, const char* label, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name == NULL)
		name = "button";

	return self->Create(parent, id, wxString(label, wxConvUTF8), *pos, *size, style, *validator, wxString(name, wxConvUTF8))?1:0;
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
void wxButton_SetLabel(wxButton* self, const char* label)
{
	self->SetLabel(wxString(label, wxConvUTF8));
}


