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
dbit wxRadioBox_Create(wxRadioBox* self, wxWindow* parent, int id, dstr label,
                       const wxPoint* pos, const wxSize* size, int n, dstr choices[],
                       int majorDimension, long style, const wxValidator* val, dstr name)
{
	int i;

	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (val == NULL)
		val = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("radioBox");

	wxString* strings = new wxString[n];
	for (i = 0; i < n; ++i)
		strings[i] = wxString(choices[i].data, wxConvUTF8, choices[i].length);

	dbit result = self->Create(parent, id, wxString(label.data, wxConvUTF8, label.length), *pos, *size, n,
		                       strings, majorDimension, style, *val, wxString(name.data, wxConvUTF8, name.length));

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
dstrret wxRadioBox_GetStringSelection(wxRadioBox* self)
{
	return dstr_ret(self->GetStringSelection().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxRadioBox_SetStringSelection(wxRadioBox* self, dstr s)
{
	return self->SetStringSelection(wxString(s.data, wxConvUTF8, s.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxRadioBox_GetCount(wxRadioBox* self)
{
	return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxRadioBox_FindString(wxRadioBox* self, dstr s)
{
	return self->FindString(wxString(s.data, wxConvUTF8, s.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxRadioBox_GetString(wxRadioBox* self, int n)
{
	return dstr_ret(self->GetString(n).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_SetString(wxRadioBox* self, int n, dstr label)
{
	self->SetString(n, wxString(label.data, wxConvUTF8, label.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_Enable(wxRadioBox* self, int n, dbit enable)
{
	self->Enable(n, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_Show(wxRadioBox* self, int n, dbit show)
{
	self->Show(n, show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxRadioBox_GetLabel(wxRadioBox* self)
{
	return dstr_ret(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRadioBox_SetLabel(wxRadioBox* self, dstr label)
{
	self->SetLabel(wxString(label.data, wxConvUTF8, label.length));
}

