//-----------------------------------------------------------------------------
// wxD - activateevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxActivateEvent* wxActivateEvent_ctor(wxEventType type, wxc_bool active, int Id)
{
    return new wxActivateEvent(type,active,Id);
}

extern "C" WXEXPORT
wxc_bool wxActivateEvent_GetActive(wxActivateEvent* self)
{
	return self->GetActive()?1:0;
}
