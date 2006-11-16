//-----------------------------------------------------------------------------
// wx.NET - togglebutton.cxx
//
// The wxToggleButton proxy interface.
//
// Written by Florian Fankhauser (f.fankhauser@gmx.at)
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/tglbtn.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ToggleButton : public wxToggleButton
{
public:
    DECLARE_OBJECTDELETED(_ToggleButton)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToggleButton* wxToggleButton_ctor()
{
	return new _ToggleButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxToggleButton_Create(wxToggleButton *self, wxWindow* parent, wxWindowID id, const char* label, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name == NULL)
		name = "check";

	return self->Create(parent, id, wxString(label, wxConvUTF8), *pos, *size, style, *validator, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxToggleButton_GetValue(wxToggleButton* self)
{
	return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToggleButton_SetValue(wxToggleButton* self, const bool state)
{
	self->SetValue(state);
}

