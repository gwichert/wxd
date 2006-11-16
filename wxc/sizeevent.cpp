//-----------------------------------------------------------------------------
// wxD - sizeevent.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - sizeevent.cxx
// 
// The wxSizeEvent proxy interface.
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
wxSizeEvent* wxSizeEvent_ctor()
{
    return new wxSizeEvent();
}

extern "C" WXEXPORT
void wxSizeEvent_GetSize(wxSizeEvent* self, wxSize* size)
{
    *size=self->GetSize();
}

