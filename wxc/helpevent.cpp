//-----------------------------------------------------------------------------
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

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHelpEvent* wxHelpEvent_ctor(wxEventType type)
{
    return new wxHelpEvent(type);
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
wxString* wxHelpEvent_GetLink(wxHelpEvent* self)
{
	return new wxString(self->GetLink());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_SetLink(wxHelpEvent* self, const char* link)
{
	self->SetLink(wxString(link, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHelpEvent_GetTarget(wxHelpEvent* self)
{
	return new wxString(self->GetTarget());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHelpEvent_SetTarget(wxHelpEvent* self, const char* target)
{
	self->SetTarget(wxString(target, wxConvUTF8));
}

