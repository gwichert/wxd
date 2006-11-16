//-----------------------------------------------------------------------------
// wxD - contextmenuevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - contextmenuevent.cxx
// 
// The wxContextMenuEvent proxy interface.
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
wxContextMenuEvent* wxContextMenuEvent_ctor(wxEventType type,wxWindowID winid,const wxPoint* pt)
{
    return new wxContextMenuEvent(type,winid,*pt);
}

extern "C" WXEXPORT
void wxContextMenuEvent_GetPosition(wxContextMenuEvent* self, wxPoint* inp)
{
	*inp = self->GetPosition();
}

extern "C" WXEXPORT
void wxContextMenuEvent_SetPosition(wxContextMenuEvent* self, wxPoint* inp)
{
	self->SetPosition(*inp);
}
