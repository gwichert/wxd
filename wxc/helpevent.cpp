//-----------------------------------------------------------------------------
// wxD - helpevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - helpevent.cxx
// 
// The wxHelpEvent proxy interface.
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
wxHelpEvent* wxHelpEvent_ctor(wxEventType type, int winid , wxPoint *pos)
{
    return new wxHelpEvent(type,winid,*pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_GetPosition(wxHelpEvent* self, wxPoint* inp)
{
	*inp = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_SetPosition(wxHelpEvent* self, wxPoint* pos)
{
	self->SetPosition(*pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHelpEvent_GetLink(wxHelpEvent* self)
{
	return dstr_ret(self->GetLink());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_SetLink(wxHelpEvent* self, wxc_string link)
{
	self->SetLink(wxstr(link));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHelpEvent_GetTarget(wxHelpEvent* self)
{
	return dstr_ret(self->GetTarget());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_SetTarget(wxHelpEvent* self, wxc_string target)
{
	self->SetTarget(wxstr(target));
}

