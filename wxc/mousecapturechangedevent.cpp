//-----------------------------------------------------------------------------
// wxD - mousecapturechangedevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - mousecapturechangedevent.cxx
// 
// The wxMouseCaptureChangedEvent proxy interface.
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
wxMouseCaptureChangedEvent* wxMouseCaptureChangedEvent_ctor(wxEventType type)
{
    return new wxMouseCaptureChangedEvent(type);
}

extern "C" WXEXPORT
wxWindow* wxMouseCaptureChangedEvent_GetCapturedWindow(wxMouseCaptureChangedEvent* self)
{
	return self->GetCapturedWindow();
}
