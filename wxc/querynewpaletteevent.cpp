//-----------------------------------------------------------------------------
// wxD - querynewpaletteevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxQueryNewPaletteEvent* wxQueryNewPaletteEvent_ctor(wxWindowID winid)
{
    return new wxQueryNewPaletteEvent(winid);
}

extern "C" WXEXPORT
wxQueryNewPaletteEvent* wxQueryNewPaletteEvent_ctor2(wxEventType type)
{
    return new wxQueryNewPaletteEvent(type);
}

extern "C" WXEXPORT
dbit wxQueryNewPaletteEvent_GetPaletteRealized(wxQueryNewPaletteEvent* self)
{
	return self->GetPaletteRealized()?1:0;
}

extern "C" WXEXPORT
void wxQueryNewPaletteEvent_SetPaletteRealized(wxQueryNewPaletteEvent* self, dbit realized)
{
	self->SetPaletteRealized(realized);
}
