//-----------------------------------------------------------------------------
// wxD - updateuievent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - updateuievent.cxx
//
// The wxUpdateUIEvent proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxUpdateUIEvent* wxUpdateUIEvent_ctor(wxWindowID commandId)
{
	return new wxUpdateUIEvent(commandId);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_CanUpdate(wxWindow* window)
{
	return wxUpdateUIEvent::CanUpdate(window)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdUIEvt_Enable(wxUpdateUIEvent* self, dbit enable)
{
	self->Enable(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdUIEvt_Check(wxUpdateUIEvent* self, dbit check)
{
	self->Check(check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_GetChecked(wxUpdateUIEvent* self)
{
	return self->GetChecked()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_GetEnabled(wxUpdateUIEvent* self)
{
	return self->GetEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_GetSetChecked(wxUpdateUIEvent* self)
{
	return self->GetSetChecked()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_GetSetEnabled(wxUpdateUIEvent* self)
{
	return self->GetSetEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxUpdateUIEvent_GetSetText(wxUpdateUIEvent* self)
{
	return self->GetSetText()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxUpdateUIEvent_GetText(wxUpdateUIEvent* self)
{
	return dstr_ret(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxUpdateUIMode wxUpdateUIEvent_GetMode()
{
	return wxUpdateUIEvent::GetMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxUpdateUIEvent_GetUpdateInterval()
{
	return wxUpdateUIEvent::GetUpdateInterval();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdateUIEvent_ResetUpdateTime()
{
	wxUpdateUIEvent::ResetUpdateTime();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdateUIEvent_SetMode(wxUpdateUIMode mode)
{
	wxUpdateUIEvent::SetMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdateUIEvent_SetText(wxUpdateUIEvent* self, dstr text)
{
	self->SetText(wxstr(text));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxUpdateUIEvent_SetUpdateInterval(long updateInterval)
{
	wxUpdateUIEvent::SetUpdateInterval(updateInterval);
}


