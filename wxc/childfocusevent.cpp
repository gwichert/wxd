//-----------------------------------------------------------------------------
// wx.NET - childfocusevent.cxx
// 
// The wxChildFocusEvent proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxChildFocusEvent* wxChildFocusEvent_ctor(wxWindow* win)
{
    return new wxChildFocusEvent(win);
}

extern "C" WXEXPORT
wxWindow* wxChildFocusEvent_GetWindow(wxChildFocusEvent* self)
{
	return self->GetWindow();
}
