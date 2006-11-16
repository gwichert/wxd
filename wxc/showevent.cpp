//-----------------------------------------------------------------------------
// wx.NET - showevent.cxx
// 
// The wxShowEvent proxy interface.
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
wxShowEvent* wxShowEvent_ctor(wxEventType type)
{
    return new wxShowEvent(type);
}

extern "C" WXEXPORT
bool wxShowEvent_GetShow(wxShowEvent* self)
{
	return self->GetShow()?1:0;
}

extern "C" WXEXPORT
void wxShowEvent_SetShow(wxShowEvent* self, bool show)
{
	self->SetShow(show);
}
