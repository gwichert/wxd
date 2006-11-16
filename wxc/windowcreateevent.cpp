//-----------------------------------------------------------------------------
// wxD - windowcreateevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - windowcreateevent.cxx
// 
// The wxWindowCreateEvent proxy interface.
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
wxWindowCreateEvent* wxWindowCreateEvent_ctor(wxWindow* win)
{
    return new wxWindowCreateEvent(win);
}

extern "C" WXEXPORT
wxWindow* wxWindowCreateEvent_GetWindow(wxWindowCreateEvent* self)
{
	return self->GetWindow();
}
