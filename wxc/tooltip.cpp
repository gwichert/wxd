//-----------------------------------------------------------------------------
// wxD - tooltip.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
wxToolTip* wxToolTip_ctor(dstr tip)
{
	return new wxToolTip(wxString(tip.data, wxConvUTF8, tip.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolTip_SetTip(wxToolTip* self, dstr tip)
{
	self->SetTip(wxString(tip.data, wxConvUTF8, tip.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolTip_GetTip(wxToolTip* self)
{
	return dstr_ret(self->GetTip());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxToolTip_GetWindow(wxToolTip* self)
{
	return self->GetWindow();
}

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
void wxToolTip_SetWindow(wxToolTip* self,wxWindow* win)
{
	return self->SetWindow(win);
}

//-----------------------------------------------------------------------------
