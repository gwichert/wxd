//-----------------------------------------------------------------------------
// wx.NET - closeevent.cxx
// 
// The wxCloseEvent proxy interface.
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
wxCloseEvent* wxCloseEvent_ctor(wxEventType type)
{
    return new wxCloseEvent(type);
}

extern "C" WXEXPORT
void wxCloseEvent_SetLoggingOff(wxCloseEvent* self, bool logOff)
{
	self->SetLoggingOff(logOff);
}

extern "C" WXEXPORT
bool wxCloseEvent_GetLoggingOff(wxCloseEvent* self)
{
	return self->GetLoggingOff()?1:0;
}

extern "C" WXEXPORT
void wxCloseEvent_Veto(wxCloseEvent* self, bool veto)
{
	self->Veto(veto);
}

extern "C" WXEXPORT
void wxCloseEvent_SetCanVeto(wxCloseEvent* self, bool canVeto)
{
	self->SetCanVeto(canVeto);
}

extern "C" WXEXPORT
bool wxCloseEvent_CanVeto(wxCloseEvent* self)
{
	return self->CanVeto()?1:0;
}

extern "C" WXEXPORT
bool wxCloseEvent_GetVeto(wxCloseEvent* self)
{
	return self->GetVeto()?1:0;
}

