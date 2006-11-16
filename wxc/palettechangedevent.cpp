//-----------------------------------------------------------------------------
// wxD - palettechangedevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - palettechangedevent.cxx
// 
// The wxPaletteChangedEvent proxy interface.
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
wxPaletteChangedEvent* wxPaletteChangedEvent_ctor(wxEventType type)
{
    return new wxPaletteChangedEvent(type);
}

extern "C" WXEXPORT
void wxPaletteChangedEvent_SetChangedWindow(wxPaletteChangedEvent* self, wxWindow* win)
{
	self->SetChangedWindow(win);
}

extern "C" WXEXPORT
wxWindow* wxPaletteChangedEvent_GetChangedWindow(wxPaletteChangedEvent* self)
{
	return self->GetChangedWindow();
}
