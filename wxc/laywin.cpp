//-----------------------------------------------------------------------------
// wxD - laywin.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - laywin.cxx
// 
// The wxSashLayoutWindow proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/laywin.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// wxSashLayoutWindow

class _SashLayoutWindow : public wxSashLayoutWindow
{
public:
    DECLARE_OBJECTDELETED(_SashLayoutWindow)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSashLayoutWindow* wxSashLayoutWindow_ctor()
{
	return new _SashLayoutWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxSashLayoutWindow_Create(wxSashLayoutWindow* self, wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;
		
	if (name.data==NULL)
		name = dstr("sashlayoutwindow",sizeof("sashlayoutwindow")-1);
		
	return self->Create(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxLayoutAlignment wxSashLayoutWindow_GetAlignment(wxSashLayoutWindow* self)
{
	return self->GetAlignment();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashLayoutWindow_SetAlignment(wxSashLayoutWindow* self, wxLayoutAlignment align)
{
	self->SetAlignment(align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxLayoutOrientation wxSashLayoutWindow_GetOrientation(wxSashLayoutWindow* self)
{
	return self->GetOrientation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashLayoutWindow_SetOrientation(wxSashLayoutWindow* self, wxLayoutOrientation orient)
{
	self->SetOrientation(orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSashLayoutWindow_SetDefaultSize(wxSashLayoutWindow* self, const wxSize* size)
{
	self->SetDefaultSize(*size);
}

//-----------------------------------------------------------------------------
// wxLayoutAlgorithm

extern "C" WXEXPORT
wxLayoutAlgorithm* wxLayoutAlgorithm_ctor()
{
	return new wxLayoutAlgorithm();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLayoutAlgorithm_LayoutMDIFrame(wxLayoutAlgorithm* self, wxMDIParentFrame* frame, wxRect* rect)
{
	return self->LayoutMDIFrame(frame, rect)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLayoutAlgorithm_LayoutFrame(wxLayoutAlgorithm* self, wxFrame* frame, wxWindow* mainWindow)
{
	return self->LayoutFrame(frame, mainWindow)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLayoutAlgorithm_LayoutWindow(wxLayoutAlgorithm* self, wxWindow* frame, wxWindow* mainWindow)
{
	return self->LayoutWindow(frame, mainWindow)?1:0;
}

//-----------------------------------------------------------------------------
// wxQueryLayoutInfoEvent

extern "C" WXEXPORT
wxQueryLayoutInfoEvent* wxQueryLayoutInfoEvent_ctor(wxWindowID id)
{
	return new wxQueryLayoutInfoEvent(id);
} 

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_SetRequestedLength(wxQueryLayoutInfoEvent* self, int length)
{
	self->SetRequestedLength(length);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxQueryLayoutInfoEvent_GetRequestedLength(wxQueryLayoutInfoEvent* self)
{
	return self->GetRequestedLength();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_SetFlags(wxQueryLayoutInfoEvent* self, int flags)
{
	self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxQueryLayoutInfoEvent_GetFlags(wxQueryLayoutInfoEvent* self)
{
	return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_SetSize(wxQueryLayoutInfoEvent* self, const wxSize* size)
{
	self->SetSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_GetSize(wxQueryLayoutInfoEvent* self, wxSize* size)
{
	*size = self->GetSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_SetOrientation(wxQueryLayoutInfoEvent* self, wxLayoutOrientation orient)
{
	self->SetOrientation(orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxLayoutOrientation wxQueryLayoutInfoEvent_GetOrientation(wxQueryLayoutInfoEvent* self)
{
	return self->GetOrientation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxQueryLayoutInfoEvent_SetAlignment(wxQueryLayoutInfoEvent* self, wxLayoutAlignment align)
{
	self->SetAlignment(align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxLayoutAlignment wxQueryLayoutInfoEvent_GetAlignment(wxQueryLayoutInfoEvent* self)
{
	return self->GetAlignment();
}

//-----------------------------------------------------------------------------
// wxCalculateLayoutEvent

extern "C" WXEXPORT
wxCalculateLayoutEvent* wxCalculateLayoutEvent_ctor(wxWindowID id)
{
	return new wxCalculateLayoutEvent(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalculateLayoutEvent_SetFlags(wxCalculateLayoutEvent* self, int flags)
{
	self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxCalculateLayoutEvent_GetFlags(wxCalculateLayoutEvent* self)
{
	return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalculateLayoutEvent_SetRect(wxCalculateLayoutEvent* self, const wxRect* rect)
{
	self->SetRect(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalculateLayoutEvent_GetRect(wxCalculateLayoutEvent* self, wxRect* rect)
{
	*rect = self->GetRect();
}

