//-----------------------------------------------------------------------------
// wx.NET - radiobutton.cxx
//
// The wxRadioButton proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/radiobut.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _RadioButton : public wxRadioButton
{
public:
    DECLARE_OBJECTDELETED(_RadioButton)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRadioButton* wxRadioButton_ctor()
{
	return new _RadioButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRadioButton_Create(wxRadioButton* self, wxWindow* parent, int id,
                       const char* label, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (val == NULL)
		val = &wxDefaultValidator;

	if (name == NULL)
		name = "radioButton";

	return self->Create(parent, id, wxString(label, wxConvUTF8), *pos, *size, style,
	                    *val, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRadioButton_GetValue(wxRadioButton* self)
{
	return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioButton_SetValue(wxRadioButton* self, bool state)
{
	self->SetValue(state);
}

//-----------------------------------------------------------------------------
