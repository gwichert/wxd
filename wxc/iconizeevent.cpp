//-----------------------------------------------------------------------------
// wxD - iconizeevent.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - iconizeevent.cxx
// 
// The wxIconizeEvent proxy interface.
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
wxIconizeEvent* wxIconizeEvent_ctor(int winid, bool iconized)
{
    return new wxIconizeEvent(winid,iconized);
}

extern "C" WXEXPORT
bool wxIconizeEvent_Iconized(wxIconizeEvent* self)
{
	return self->Iconized()?1:0;
}
