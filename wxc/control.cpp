//-----------------------------------------------------------------------------
// wxD - control.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - control.cxx
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/control.h>

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
void wxControl_Command(wxControl *self, wxCommandEvent *event)
{
	self->Command(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxControl_SetLabel(wxControl *self, dstr label)
{
	self->SetLabel(wxstr(label));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxControl_GetLabel(wxControl *self)
{
	return dstr_ret(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxControl_GetAlignment(wxControl* self)
{
	return self->GetAlignment();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxControl_SetFont(wxControl* self, wxFont* font)
{
	return self->SetFont(*font)?1:0;
}

