//-----------------------------------------------------------------------------
// wx.NET - frame.cxx
//
// The wxFrame proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Frame : public wxFrame
{
public:
    DECLARE_OBJECTDELETED(_Frame)
    
#include "panel.inc"
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFrame* wxFrame_ctor()
{
    return new _Frame();
}

extern "C" WXEXPORT
bool wxFrame_Create(wxFrame* self, wxWindow* parent, int id, const char* title, const wxPoint* pos, const wxSize* size, unsigned int style, const char* name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    return self->Create(parent, id, wxString(title, wxConvUTF8), *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}


//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFrame_ShowFullScreen(wxFrame *self, bool show, unsigned int style) 
{
    return self->ShowFullScreen(show, style)?1:0;
}

extern "C" WXEXPORT
bool wxFrame_IsFullScreen(wxFrame* self)
{
    return self->IsFullScreen()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStatusBar* wxFrame_CreateStatusBar(wxFrame* self, int number, unsigned int style, wxWindowID id, const char* name)
{
    return self->CreateStatusBar(number, style, id, wxString(name, wxConvUTF8));
}

extern "C" WXEXPORT
wxStatusBar* wxFrame_GetStatusBar(wxFrame* self)
{
    return self->GetStatusBar();
}

extern "C" WXEXPORT
void wxFrame_SetStatusBar(wxFrame* self, wxStatusBar* statusbar)
{
    self->SetStatusBar(statusbar);
}

extern "C" WXEXPORT
void wxFrame_SetStatusBarPane(wxFrame* self, int n)
{
    self->SetStatusBarPane(n);
}

extern "C" WXEXPORT
int wxFrame_GetStatusBarPane(wxFrame* self)
{
    return self->GetStatusBarPane();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_SendSizeEvent(wxFrame* self)
{
    self->SendSizeEvent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_SetIcon(wxFrame* self, const wxIcon* icon)
{
    self->SetIcon(*icon);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_SetMenuBar(wxFrame* self, wxMenuBar* menuBar)
{
    self->SetMenuBar(menuBar);
}

extern "C" WXEXPORT
wxMenuBar* wxFrame_GetMenuBar(wxFrame* self)
{
    return self->GetMenuBar();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_SetStatusText(wxFrame* self, const char* text, int number)
{
    self->SetStatusText(wxString(text, wxConvUTF8), number);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBar* wxFrame_CreateToolBar(wxFrame* self, unsigned int style, wxWindowID id, const char* name)
{
    if (name == NULL)
        name = "toolBar";

    return self->CreateToolBar(style, id, wxString(name, wxConvUTF8));
}

extern "C" WXEXPORT
wxToolBar* wxFrame_GetToolBar(wxFrame* self)
{
    return self->GetToolBar();
}

extern "C" WXEXPORT
void wxFrame_SetToolBar(wxFrame* self, wxToolBar* toolbar)
{
    self->SetToolBar(toolbar);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_Maximize(wxFrame* self, bool iconize)
{
    self->Maximize(iconize);
}

extern "C" WXEXPORT
bool wxFrame_IsMaximized(wxFrame* self)
{
    return self->IsMaximized()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_Iconize(wxFrame* self, bool iconize)
{
    self->Iconize(iconize);
}

extern "C" WXEXPORT
bool wxFrame_IsIconized(wxFrame* self)
{
    return self->IsIconized()?1:0;
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
bool wxFrame_SetShape(wxFrame* self, wxRegion* region)
{
    return self->SetShape(region);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrame_SetStatusWidths(wxFrame* self, int n, int* widths)
{
    self->SetStatusWidths(n, widths);
}

//-----------------------------------------------------------------------------

extern "C"WXEXPORT
void wxFrame_GetClientAreaOrigin(wxFrame* self, wxPoint* pt)
{
	*pt=self->GetClientAreaOrigin();
}

