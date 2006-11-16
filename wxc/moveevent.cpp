//-----------------------------------------------------------------------------
// wxD - MoveEvent.cs
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - MoveEvent.cs
//
// The wxMoveEvent wrapper class.
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
wxMoveEvent* wxMoveEvent_ctor()
{
    return new wxMoveEvent();
}

extern "C" WXEXPORT
void wxMoveEvent_GetPosition(wxMoveEvent* self, wxPoint* point)
{
    *point=self->GetPosition();
}
