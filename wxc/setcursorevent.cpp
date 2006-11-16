//-----------------------------------------------------------------------------
// wxD - setcursorevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - setcursorevent.cxx
// 
// The wxSetCursorEvent proxy interface.
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
wxSetCursorEvent* wxSetCursorEvent_ctor(wxEventType type)
{
    return new wxSetCursorEvent(type);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSetCursorEvent_GetX(wxSetCursorEvent* self)
{
	return self->GetX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSetCursorEvent_GetY(wxSetCursorEvent* self)
{
	return self->GetY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSetCursorEvent_SetCursor(wxSetCursorEvent* self, wxCursor* cursor)
{
	self->SetCursor(*cursor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCursor* wxSetCursorEvent_GetCursor(wxSetCursorEvent* self)
{
	return new wxCursor(self->GetCursor());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxSetCursorEvent_HasCursor(wxSetCursorEvent* self)
{
	return self->HasCursor()?1:0;
}

