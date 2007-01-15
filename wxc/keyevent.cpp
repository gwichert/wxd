//-----------------------------------------------------------------------------
// wxD - keyevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - keyevent.cxx
// 
// The wxKeyEvent proxy interface.
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
wxKeyEvent* wxKeyEvent_ctor(wxEventType type)
{
    return new wxKeyEvent(type);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxKeyEvent_ControlDown(wxKeyEvent* self)
{
    return self->ControlDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxKeyEvent_ShiftDown(wxKeyEvent* self)
{
    return self->ShiftDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxKeyEvent_AltDown(wxKeyEvent* self)
{
    return self->AltDown()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxKeyEvent_MetaDown(wxKeyEvent* self)
{
    return self->MetaDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned int wxKeyEvent_GetRawKeyCode(wxKeyEvent* self)
{
    return self->GetRawKeyCode();
}

extern "C" WXEXPORT
int wxKeyEvent_GetKeyCode(wxKeyEvent* self)
{
    return self->GetKeyCode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned int wxKeyEvent_GetRawKeyFlags(wxKeyEvent* self)
{
    return self->GetRawKeyFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxKeyEvent_HasModifiers(wxKeyEvent* self)
{
    return self->HasModifiers()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxKeyEvent_GetPosition(wxKeyEvent* self, wxPoint* pt)
{
    *pt = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxKeyEvent_GetX(wxKeyEvent* self)
{
    return self->GetX();
}

extern "C" WXEXPORT
int wxKeyEvent_GetY(wxKeyEvent* self)
{
    return self->GetY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxKeyEvent_CmdDown(wxKeyEvent* self)
{
	return self->CmdDown()?1:0;
}

