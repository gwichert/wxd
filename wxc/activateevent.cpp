//-----------------------------------------------------------------------------
// wx.NET - activateevent.cxx
// 
// The wxActivateEvent proxy interface.
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
wxActivateEvent* wxActivateEvent_ctor(wxEventType type)
{
    return new wxActivateEvent(type);
}

extern "C" WXEXPORT
bool wxActivateEvent_GetActive(wxActivateEvent* self)
{
	return self->GetActive()?1:0;
}