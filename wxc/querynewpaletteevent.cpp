//-----------------------------------------------------------------------------
// wx.NET - querynewpaletteevent.cxx
// 
// The wxQueryNewPaletteEvent proxy interface.
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
wxQueryNewPaletteEvent* wxQueryNewPaletteEvent_ctor(wxEventType type)
{
    return new wxQueryNewPaletteEvent(type);
}

extern "C" WXEXPORT
bool wxQueryNewPaletteEvent_GetPaletteRealized(wxQueryNewPaletteEvent* self)
{
	return self->GetPaletteRealized()?1:0;
}

extern "C" WXEXPORT
void wxQueryNewPaletteEvent_SetPaletteRelized(wxQueryNewPaletteEvent* self, bool realized)
{
	self->SetPaletteRealized(realized);
}
