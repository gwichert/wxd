//-----------------------------------------------------------------------------
// wxD - radiobutton.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
dbit wxRadioButton_Create(wxRadioButton* self, wxWindow* parent, int id,
                       dstr label, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (val == NULL)
		val = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("radioButton");

	return self->Create(parent, id, wxString(label.data, wxConvUTF8, label.length), *pos, *size, style,
	                    *val, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxRadioButton_GetValue(wxRadioButton* self)
{
	return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioButton_SetValue(wxRadioButton* self, dbit state)
{
	self->SetValue(state);
}

//-----------------------------------------------------------------------------
