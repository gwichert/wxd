//-----------------------------------------------------------------------------
// wxD - syscolourchangedevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - syscolourchangedevent.cxx
// 
// The wxSysColourChangedEvent proxy interface.
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
wxSysColourChangedEvent* wxSysColourChangedEvent_ctor()
{
    return new wxSysColourChangedEvent();
}

