//-----------------------------------------------------------------------------
// wxD - scrolledwindow.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - scrolledwindow.cxx
//
// The wxScrolledWindow proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/scrolwin.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ScrolledWindow : public wxScrolledWindow
{
public:
	_ScrolledWindow(wxWindow* parent, wxWindowID id, const wxPoint& pos,
					const wxSize& size, long style, const wxString& name)
		: wxScrolledWindow(parent, id, pos, size, style, name) { }

    DECLARE_OBJECTDELETED(_ScrolledWindow)
    
#include "panel.inc"
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxScrolledWindow* wxScrollWnd_ctor(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("scrolled");

	return new _ScrolledWindow(parent, id, *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_PrepareDC(wxScrolledWindow* self, wxDC* dc)
{
	self->PrepareDC(*dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_SetScrollbars(wxScrolledWindow* self, int pixelsPerUnitX, int pixelsPerUnitY,
							   int noUnitsX, int noUnitsY, int xPos, int yPos, wxc_bool noRefresh)
{
	self->SetScrollbars(pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, xPos, yPos, noRefresh);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_GetViewStart(wxScrolledWindow* self, int* x, int* y)
{
    self->GetViewStart(x, y);
}

extern "C" WXEXPORT
void wxScrollWnd_GetScrollPixelsPerUnit(wxScrolledWindow* self, int* xUnit, int* yUnit)
{
    self->GetScrollPixelsPerUnit(xUnit, yUnit);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_CalcScrolledPosition(wxScrolledWindow* self, int x, int y, int* xx, int* yy)
{
	self->CalcScrolledPosition(x, y, xx, yy);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_CalcUnscrolledPosition(wxScrolledWindow* self, int x, int y, int* xx, int* yy)
{
	self->CalcUnscrolledPosition(x, y, xx, yy);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_GetVirtualSize(wxScrolledWindow* self, int* x, int* y)
{
	self->GetVirtualSize(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_Scroll(wxScrolledWindow* self, int x, int y)
{
	self->Scroll(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_SetScrollRate(wxScrolledWindow* self, int xstep, int ystep)
{
	self->SetScrollRate(xstep, ystep);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollWnd_SetTargetWindow(wxScrolledWindow* self, wxWindow* window)
{
	self->SetTargetWindow(window);
}
