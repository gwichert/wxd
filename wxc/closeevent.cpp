//-----------------------------------------------------------------------------
// wxD - closeevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCloseEvent* wxCloseEvent_ctor(wxEventType type, int winid)
{
    return new wxCloseEvent(type,winid);
}

extern "C" WXEXPORT
void wxCloseEvent_SetLoggingOff(wxCloseEvent* self, wxc_bool logOff)
{
	self->SetLoggingOff(logOff);
}

extern "C" WXEXPORT
wxc_bool wxCloseEvent_GetLoggingOff(wxCloseEvent* self)
{
	return self->GetLoggingOff()?1:0;
}

extern "C" WXEXPORT
void wxCloseEvent_Veto(wxCloseEvent* self, wxc_bool veto)
{
	self->Veto(veto);
}

extern "C" WXEXPORT
void wxCloseEvent_SetCanVeto(wxCloseEvent* self, wxc_bool canVeto)
{
	self->SetCanVeto(canVeto);
}

extern "C" WXEXPORT
wxc_bool wxCloseEvent_CanVeto(wxCloseEvent* self)
{
	return self->CanVeto()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxCloseEvent_GetVeto(wxCloseEvent* self)
{
	return self->GetVeto()?1:0;
}


