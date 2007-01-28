//-----------------------------------------------------------------------------
// wxD - radiobox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - radiobox.cxx
//
// The wxRadioBox proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

class _RadioBox : public wxRadioBox
{
public:
    DECLARE_OBJECTDELETED(_RadioBox)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxRadioBox* wxRadioBox_ctor()
{
	return new _RadioBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxRadioBox_Create(wxRadioBox* self, wxWindow* parent, int id, wxc_string label,
                       const wxPoint* pos, const wxSize* size, int n, wxc_string choices[],
                       int majorDimension, long style, const wxValidator* val, wxc_string name)
{
	int i;

	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (val == NULL)
		val = &wxDefaultValidator;

	if (name.data==NULL)
		name = wxc_string("radioBox");

	wxString* strings = new wxString[n];
	for (i = 0; i < n; ++i)
		strings[i] = wxstr(choices[i]);

	wxc_bool result = self->Create(parent, id, wxstr(label), *pos, *size, n,
		                       strings, majorDimension, style, *val, wxstr(name));

	delete[] strings;
	return result?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_SetSelection(wxRadioBox* self, int n)
{
	self->SetSelection(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxRadioBox_GetSelection(wxRadioBox* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxRadioBox_GetStringSelection(wxRadioBox* self)
{
	return new wxString(self->GetStringSelection().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxRadioBox_SetStringSelection(wxRadioBox* self, wxc_string s)
{
	return self->SetStringSelection(wxstr(s))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxRadioBox_GetCount(wxRadioBox* self)
{
	return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxRadioBox_FindString(wxRadioBox* self, wxc_string s)
{
	return self->FindString(wxstr(s));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxRadioBox_GetString(wxRadioBox* self, int n)
{
	return new wxString(self->GetString(n).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_SetString(wxRadioBox* self, int n, wxc_string label)
{
	self->SetString(n, wxstr(label));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_Enable(wxRadioBox* self, int n, wxc_bool enable)
{
	self->Enable(n, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_Show(wxRadioBox* self, int n, wxc_bool show)
{
	self->Show(n, show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxRadioBox_GetLabel(wxRadioBox* self)
{
	return new wxString(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_SetLabel(wxRadioBox* self, wxc_string label)
{
	self->SetLabel(wxstr(label));
}

