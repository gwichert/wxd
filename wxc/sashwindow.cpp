//-----------------------------------------------------------------------------
// wxD - sashwindow.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - sashwindow.cxx
// 
// The wxSashWindow proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/sashwin.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// wxSashEdge

extern "C" WXEXPORT
wxSashEdge* wxSashEdge_ctor()
{
	return new wxSashEdge();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashEdge_dtor(wxSashEdge* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSashEdge_m_show(wxSashEdge* self)
{
	return self->m_show?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSashEdge_m_border(wxSashEdge* self)
{
	return self->m_border?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashEdge_m_margin(wxSashEdge* self)
{
	return self->m_margin;
}

//-----------------------------------------------------------------------------
// wxSashWindow

class _SashWindow : public wxSashWindow
{
public:
    DECLARE_OBJECTDELETED(_SashWindow)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSashWindow* wxSashWindow_ctor()
{
	return new _SashWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSashWindow_Create(wxSashWindow* self, wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, int style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;
		
	if (name.data==NULL)
		name = dstr("sashwindow");
		
	return self->Create(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetSashVisible(wxSashWindow* self, wxSashEdgePosition edge, dbit sash)
{
	self->SetSashVisible(edge, sash);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSashWindow_GetSashVisible(wxSashWindow* self, wxSashEdgePosition edge)
{
	return self->GetSashVisible(edge)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetSashBorder(wxSashWindow* self, wxSashEdgePosition edge, dbit border)
{
	self->SetSashBorder(edge, border);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSashWindow_HasBorder(wxSashWindow* self, wxSashEdgePosition edge)
{
	return self->HasBorder(edge)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetEdgeMargin(wxSashWindow* self, wxSashEdgePosition edge)
{
	return self->GetEdgeMargin(edge);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetDefaultBorderSize(wxSashWindow* self, int with)
{
	self->SetDefaultBorderSize(with);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetDefaultBorderSize(wxSashWindow* self)
{
	return self->GetDefaultBorderSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetExtraBorderSize(wxSashWindow* self, int width)
{
	self->SetExtraBorderSize(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetExtraBorderSize(wxSashWindow* self)
{
	return self->GetExtraBorderSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetMinimumSizeX(wxSashWindow* self, int min)
{
	self->SetMinimumSizeX(min);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetMinimumSizeY(wxSashWindow* self, int min)
{
	self->SetMinimumSizeY(min);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetMinimumSizeX(wxSashWindow* self)
{
	return self->GetMinimumSizeX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetMinimumSizeY(wxSashWindow* self)
{
	return self->GetMinimumSizeY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetMaximumSizeX(wxSashWindow* self, int max)
{
	self->SetMaximumSizeX(max);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashWindow_SetMaximumSizeY(wxSashWindow* self, int max)
{
	self->SetMaximumSizeY(max);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetMaximumSizeX(wxSashWindow* self)
{
	return self->GetMaximumSizeX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSashWindow_GetMaximumSizeY(wxSashWindow* self)
{
	return self->GetMaximumSizeY();
}

//-----------------------------------------------------------------------------
// wxSashEvent

extern "C" WXEXPORT
wxSashEvent* wxSashEvent_ctor(int id, wxSashEdgePosition edge)
{
	return new wxSashEvent(id, edge);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashEvent_SetEdge(wxSashEvent* self, wxSashEdgePosition edge)
{
	self->SetEdge(edge);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSashEdgePosition* wxSashEvent_GetEdge(wxSashEvent* self)
{
	return new wxSashEdgePosition(self->GetEdge());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashEvent_SetDragRect(wxSashEvent* self, wxRect* rect)
{
	self->SetDragRect(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashEvent_GetDragRect(wxSashEvent* self, wxRect* rect)
{
	*rect = self->GetDragRect();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashEvent_SetDragStatus(wxSashEvent* self, wxSashDragStatus status)
{
	self->SetDragStatus(status);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSashDragStatus wxSashEvent_GetDragStatus(wxSashEvent* self)
{
	return self->GetDragStatus();
}


extern "C" WXEXPORT int wxEvent_EVT_SASH_DRAGGED()			{ return wxEVT_SASH_DRAGGED; }
