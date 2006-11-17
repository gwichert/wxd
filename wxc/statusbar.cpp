//-----------------------------------------------------------------------------
// wxD - statusbar.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - statusbar.cxx
// 
// The wxStatusBar proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

class _StatusBar : public wxStatusBar
{
public:
    DECLARE_OBJECTDELETED(_StatusBar)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStatusBar* wxStatusBar_ctor()
{
    return new _StatusBar();
}

extern "C" WXEXPORT
dbit wxStatusBar_Create(wxStatusBar* self, wxWindow* parent, wxWindowID id, unsigned int style, dstr name)
{
    if (name.data==NULL)
        name = dstr("statusBar",sizeof("statusBar")-1);

    return self->Create(parent, id, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_SetFieldsCount(wxStatusBar* self, int number, int *widths) 
{
    self->SetFieldsCount(number, widths);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxStatusBar_GetFieldRect(wxStatusBar* self, int i, wxRect* rect)
{
    return self->GetFieldRect(i, *rect)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStatusBar_GetBorderY(wxStatusBar* self)
{
    return self->GetBorderY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxStatusBar_GetStatusText(wxStatusBar* self, int number)
{
    return dstr_ret(self->GetStatusText(number).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStatusBar_GetBorderX(wxStatusBar* self)
{
    return self->GetBorderX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_SetStatusText(wxStatusBar* self, dstr text, int number)
{
    self->SetStatusText(wxString(text.data, wxConvUTF8, text.length), number);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_SetStatusWidths(wxStatusBar* self, int n, int* widths_field)
{
    self->SetStatusWidths(n, widths_field);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStatusBar_GetFieldsCount(wxStatusBar* self)
{
	return self->GetFieldsCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_PopStatusText(wxStatusBar* self, int field)
{
	self->PopStatusText(field);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_PushStatusText(wxStatusBar* self, dstr xstring, int field)
{
	self->PushStatusText(wxString(xstring.data, wxConvUTF8, xstring.length), field);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_SetMinHeight(wxStatusBar* self, int height)
{
	self->SetMinHeight(height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStatusBar_SetStatusStyles(wxStatusBar* self, int n, int styles[])
{
	self->SetStatusStyles(n, styles);
}

