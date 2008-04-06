//-----------------------------------------------------------------------------
// wxD - notifyevent.cpp
// (C) 2005 bero <berobero@users.sourceforge.net>
// 
// The wxNotifyEvent proxy interface.
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxNotifyEvent* wxNotifyEvent_ctor(wxEventType commandType, int winid)
{
    return new wxNotifyEvent(commandType, winid);
}

extern "C" WXEXPORT
void wxNotifyEvent_Veto(wxNotifyEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxNotifyEvent_Allow(wxNotifyEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
wxc_bool wxNotifyEvent_IsAllowed(wxNotifyEvent* self)
{
    return (wxc_bool)self->IsAllowed();
}

