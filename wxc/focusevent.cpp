//-----------------------------------------------------------------------------
// wxD - focusevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - focusevent.cxx
// 
// The wxFocusEvent proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFocusEvent* wxFocusEvent_ctor(wxEventType type)
{
    return new wxFocusEvent(type);
}

extern "C" WXEXPORT
wxWindow* wxFocusEvent_GetWindow(wxFocusEvent* self)
{
	return self->GetWindow();
}

extern "C" WXEXPORT
void wxFocusEvent_SetWindow(wxFocusEvent* self, wxWindow* win)
{
	self->SetWindow(win);
}
