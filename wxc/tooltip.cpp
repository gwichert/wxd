//-----------------------------------------------------------------------------
// wx.NET - tooltip.cxx
//
// The wxToolTip proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/tooltip.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolTip_Enable(bool flag)
{
	wxToolTip::Enable(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolTip_SetDelay(long msecs)
{
	wxToolTip::SetDelay(msecs);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolTip* wxToolTip_ctor(const char* tip)
{
	return new wxToolTip(wxString(tip, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolTip_SetTip(wxToolTip* self, const char* tip)
{
	self->SetTip(wxString(tip, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxToolTip_GetTip(wxToolTip* self)
{
	return new wxString(self->GetTip());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxToolTip_GetWindow(wxToolTip* self)
{
	return self->GetWindow();
}

//-----------------------------------------------------------------------------
