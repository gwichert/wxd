//-----------------------------------------------------------------------------
// wxD - mouseevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - mouseevent.cxx
//
// The wxMouseEvent proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMouseEvent* wxMouseEvent_ctor(wxEventType mouseType)
{
    return new wxMouseEvent(mouseType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_IsButton(wxMouseEvent* self)
{
    return self->IsButton()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ButtonDown(wxMouseEvent* self)
{
    return self->ButtonDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ButtonDown2(wxMouseEvent* self, int button)
{
    return self->ButtonDown(button)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ButtonDClick(wxMouseEvent* self, int but)
{
    return self->ButtonDClick(but)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ButtonUp(wxMouseEvent* self, int but)
{
    return self->ButtonUp(but)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_Button(wxMouseEvent* self, int but)
{
    return self->Button(but)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ButtonIsDown(wxMouseEvent* self, int but)
{
#if wxABI_VERSION < 20900
    return self->ButtonIsDown(but)?1:0;
#else
    return self->ButtonIsDown((wxMouseButton) but)?1:0;
#endif
}

extern "C" WXEXPORT
int wxMouseEvent_GetButton(wxMouseEvent* self)
{
    return self->GetButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ControlDown(wxMouseEvent* self)
{
    return self->ControlDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_MetaDown(wxMouseEvent* self)
{
    return self->MetaDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_AltDown(wxMouseEvent* self)
{
    return self->AltDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_ShiftDown(wxMouseEvent* self)
{
    return self->ShiftDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_LeftDown(wxMouseEvent* self)
{
    return self->LeftDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_MiddleDown(wxMouseEvent* self)
{
    return self->MiddleDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_RightDown(wxMouseEvent* self)
{
    return self->RightDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_LeftUp(wxMouseEvent* self)
{
    return self->LeftUp()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_MiddleUp(wxMouseEvent* self)
{
    return self->MiddleUp()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_RightUp(wxMouseEvent* self)
{
    return self->RightUp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_LeftDClick(wxMouseEvent* self)
{
    return self->LeftDClick()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_MiddleDClick(wxMouseEvent* self)
{
    return self->MiddleDClick()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_RightDClick(wxMouseEvent* self)
{
    return self->RightDClick()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_LeftIsDown(wxMouseEvent* self)
{
    return self->LeftIsDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_MiddleIsDown(wxMouseEvent* self)
{
    return self->MiddleIsDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_RightIsDown(wxMouseEvent* self)
{
    return self->RightIsDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_Dragging(wxMouseEvent* self)
{
    return self->Dragging()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_Moving(wxMouseEvent* self)
{
    return self->Moving()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_Entering(wxMouseEvent* self)
{
    return self->Entering()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxMouseEvent_Leaving(wxMouseEvent* self)
{
    return self->Leaving()?1:0;
}

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
void wxMouseEvent_GetPosition(wxMouseEvent* self, wxPoint* pos)
{
    *pos = self->GetPosition();
}

extern "C" WXEXPORT
void wxMouseEvent_LogicalPosition(wxMouseEvent* self, wxDC* dc, wxPoint* pos)
{
    *pos = self->GetLogicalPosition(*dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMouseEvent_GetWheelRotation(wxMouseEvent* self)
{
    return self->GetWheelRotation();
}

extern "C" WXEXPORT
int wxMouseEvent_GetWheelDelta(wxMouseEvent* self)
{
    return self->GetWheelDelta();
}

extern "C" WXEXPORT
int wxMouseEvent_GetLinesPerAction(wxMouseEvent* self)
{
    return self->GetLinesPerAction();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMouseEvent_IsPageScroll(wxMouseEvent* self)
{
    return self->IsPageScroll()?1:0;
}

//-----------------------------------------------------------------------------

