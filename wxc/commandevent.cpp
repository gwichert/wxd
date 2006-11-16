//-----------------------------------------------------------------------------
// wx.NET - commandevent.cxx
//
// The wxCommandEvent proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxCommandEvent_GetSelection(wxCommandEvent* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxString* wxCommandEvent_GetString(wxCommandEvent* self)
{
	return new wxString(self->GetString());
}

extern "C" WXEXPORT
void wxCommandEvent_SetString(wxCommandEvent* self, const char* s)
{
	self->SetString(wxString(s, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCommandEvent_IsChecked(wxCommandEvent* self)
{
	return self->IsChecked()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCommandEvent_IsSelection(wxCommandEvent* self)
{
	return self->IsSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxCommandEvent_GetInt(wxCommandEvent* self)
{
	return self->GetInt();
}

extern "C" WXEXPORT
void wxCommandEvent_SetInt(wxCommandEvent* self, int i)
{
	self->SetInt(i);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClientData* wxCommandEvent_GetClientObject(wxCommandEvent* self)
{
    return (wxClientData*)self->GetClientData();
}

extern "C" WXEXPORT
void wxCommandEvent_SetClientObject(wxCommandEvent* self, wxClientData* data)
{
    self->SetClientData(data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCommandEvent_SetExtraLong(wxCommandEvent* self, long extralong)
{
	self->SetExtraLong(extralong);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxCommandEvent_GetExtraLong(wxCommandEvent* self)
{
	return self->GetExtraLong();
}
