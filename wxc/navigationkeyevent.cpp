//-----------------------------------------------------------------------------
// wxD - navigationkeyevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - navigationkeyevent.cxx
// 
// The wxNavigationKeyEvent proxy interface.
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
wxNavigationKeyEvent* wxNavigationKeyEvent_ctor()
{
    return new wxNavigationKeyEvent();
}

extern "C" WXEXPORT
wxc_bool wxNavigationKeyEvent_GetDirection(wxNavigationKeyEvent* self)
{
	return self->GetDirection()?1:0;
}

extern "C" WXEXPORT
void wxNavigationKeyEvent_SetDirection(wxNavigationKeyEvent* self, wxc_bool bForward)
{
	self->SetDirection(bForward);
}

extern "C" WXEXPORT
wxc_bool wxNavigationKeyEvent_IsWindowChange(wxNavigationKeyEvent* self)
{
	return self->IsWindowChange()?1:0;
}

extern "C" WXEXPORT
void wxNavigationKeyEvent_SetWindowChange(wxNavigationKeyEvent* self, wxc_bool bIs)
{
	self->SetWindowChange(bIs);
}

extern "C" WXEXPORT
wxWindow* wxNavigationKeyEvent_GetCurrentFocus(wxNavigationKeyEvent* self)
{
	return self->GetCurrentFocus();
}

extern "C" WXEXPORT
void wxNavigationKeyEvent_SetCurrentFocus(wxNavigationKeyEvent* self, wxWindow* win)
{
	self->SetCurrentFocus(win);
}

extern "C" WXEXPORT
void wxNavigationKeyEvent_SetFlags(wxNavigationKeyEvent* self, long flags)
{
	self->SetFlags(flags);
}

