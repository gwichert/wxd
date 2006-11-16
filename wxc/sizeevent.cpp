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
wxSizeEvent* wxSizeEvent_ctorSize(const wxSize* sz,int winfd)
{
    return new wxSizeEvent(*sz,winfd);
}

extern "C" WXEXPORT
wxSizeEvent* wxSizeEvent_ctorRect(const wxRect* rect,int winfd)
{
    return new wxSizeEvent(*rect,winfd);
}


extern "C" WXEXPORT
void wxSizeEvent_GetSize(wxSizeEvent* self, wxSize* size)
{
    *size=self->GetSize();
}

extern "C" WXEXPORT
void wxSizeEvent_GetRect(wxSizeEvent* self, wxRect* rect)
{
    *rect=self->GetRect();
}

extern "C" WXEXPORT
void wxSizeEvent_SetRect(wxSizeEvent* self, wxRect* rect)
{
    self->SetRect(*rect);
}

