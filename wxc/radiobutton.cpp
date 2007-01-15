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
wxc_bool wxRadioButton_Create(wxRadioButton* self, wxWindow* parent, int id,
                       wxc_string label, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (val == NULL)
		val = &wxDefaultValidator;

	if (name.data==NULL)
		name = wxc_string("radioButton");

	return self->Create(parent, id, wxstr(label), *pos, *size, style,
	                    *val, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxRadioButton_GetValue(wxRadioButton* self)
{
	return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioButton_SetValue(wxRadioButton* self, wxc_bool state)
{
	self->SetValue(state);
}

//-----------------------------------------------------------------------------
