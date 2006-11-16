//-----------------------------------------------------------------------------
// wx.NET - maximizeevent.cxx
// 
// The wxMaximizeEvent proxy interface.
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
wxMaximizeEvent* wxMaximizeEvent_ctor(int id)
{
    return new wxMaximizeEvent(id);
}
