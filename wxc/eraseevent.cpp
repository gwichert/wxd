//-----------------------------------------------------------------------------
// wxD - eraseevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - eraseevent.cxx
// 
// The wxEraseEvent proxy interface.
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
wxEraseEvent* wxEraseEvent_ctor(wxEventType type)
{
    return new wxEraseEvent(type);
}

extern "C" WXEXPORT
wxDC* wxEraseEvent_GetDC(wxEraseEvent* self)
{
	return self->GetDC();
}
